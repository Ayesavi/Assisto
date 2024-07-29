import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/services/app_functions.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/auth/screens/fill_user_details_page.dart';
import 'package:assisto/features/home/repositories/categories_repository.dart';
import 'package:assisto/features/profile/controllers/address_page_controller/address_page_controller.dart';
import 'package:assisto/features/tasks/controllers/task_page_controller.dart';
import 'package:assisto/features/tasks/widgets/create_task_using_ai_bottomsheet.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/typing_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateTaskPage extends ConsumerStatefulWidget {
  final TaskModel? editTaskModel;

  const CreateTaskPage({super.key, this.editTaskModel});

  @override
  _TaskCreationPageState createState() => _TaskCreationPageState();
}

class _TaskCreationPageState extends ConsumerState<CreateTaskPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final List<String> _tags = [];
  final _tagController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _budgetController = TextEditingController();
  final _ageGroupController = TextEditingController();
  final _deadlineController = TextEditingController();
  Gender? _gender;
  int? _locationId;
  DateTime? _deadline;
  bool showAdvancedOptions = false;

  @override
  void initState() {
    super.initState();
    if (widget.editTaskModel != null) {
      // Initialize controllers with existing task data if in edit mode
      _titleController.text = widget.editTaskModel!.title;
      _descriptionController.text = widget.editTaskModel!.description;
      _budgetController.text =
          widget.editTaskModel!.expectedPrice?.toString() ?? '';

      _deadlineController.text = widget.editTaskModel?.deadline != null
          ? DateFormat('dd MMM yyyy hh:mm a')
              .format(widget.editTaskModel!.deadline!)
          : '';

      _tags.addAll(widget.editTaskModel!.tags);
      _ageGroupController.text = widget.editTaskModel?.ageGroup ?? '';
    }
  }

  @override
  void dispose() {
    _tagController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  TaskModel getTaskModel() {
    if ((_formKey.currentState?.validate() ?? false) && _tags.length > 4) {
      if (widget.editTaskModel != null) {
        return TaskModel(
            owner: widget.editTaskModel!.owner,
            tags: _tags,
            id: widget.editTaskModel!.id,
            bid: widget.editTaskModel!.bid,
            address: widget.editTaskModel!.address,
            status: widget.editTaskModel!.status,
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            deadline: _deadline,
            addressId: _locationId,
            gender: _gender ?? Gender.any,
            ageGroup: _ageGroupController.text.trim().isEmpty
                ? null
                : _ageGroupController.text.trim(),
            expectedPrice: _budgetController.text.trim().isEmpty
                ? null
                : int.tryParse(_budgetController.text));
      } else {
        return TaskModel.partial(
            tags: _tags,
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            deadline: _deadline,
            addressId: _locationId,
            gender: _gender,
            ageGroup: _ageGroupController.text.trim().isEmpty
                ? null
                : _ageGroupController.text.trim(),
            expectedPrice: _budgetController.text.trim().isEmpty
                ? null
                : int.tryParse(_budgetController.text));
      }
    }
    if (_tags.length < 5) {
      throw const AppException('Add atleast 5 tags');
    }
    throw const AppException('Enter data fields appropriately');
  }

  _askAIAndCreateAssistDraft(String prompt) async {
    try {
      final assist = await AppFunctions.instance.createAssistUsingAI(prompt);
      _titleController.text = assist.title;
      _descriptionController.text = assist.description;
      _tags.addAll(assist.tags);
      _budgetController.text = assist.expectedPrice?.toString() ?? '';

      if (assist.deadline != null) {
        _deadline = assist.deadline;
      }

      if (assist.ageGroup != null) {
        _ageGroupController.text = assist.ageGroup!;
      }

      _gender = assist.gender;

      setState(() {});
    } catch (e) {
      Navigator.pop(context);
      throw const AppException(
          'Cant create assist at the moment please try again later!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final analytics = AppAnalytics.instance;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Assisto AI',
        child: Assets.images.ai.image(width: 20, height: 30),
        onPressed: () async {
          showCreateTaskUsingAIBottomSheet(context,
              controller: TextEditingController(), onTextEntered: (v) async {
            try {
              await _askAIAndCreateAssistDraft(v);
              Navigator.pop(context);
            } catch (e) {
              if (context.mounted) {
                showSnackBar(context, appErrorHandler(e).message);
              }
            }
          });
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppFilledButton(
          asyncTap: () async {
            if (_formKey.currentState!.validate()) {
              try {
                if (widget.editTaskModel != null) {
                  analytics.logEvent(
                      name: AnalyticsEvent.createTask.updateTaskEvent);
                  await ref
                      .read(taskPageControllerProvider.notifier)
                      .updateTask(getTaskModel());
                } else {
                  analytics.logEvent(
                      name: AnalyticsEvent.createTask.createTaskEvent);
                  await ref
                      .read(taskPageControllerProvider.notifier)
                      .createTask(getTaskModel());
                }
                if (context.mounted) {
                  FeedPageRoute().pushReplacement(context);
                }
              } catch (e) {
                if (context.mounted) {
                  showSnackBar(context, appErrorHandler(e).message);
                }
              }
            }
          },
          label:
              widget.editTaskModel != null ? 'Update Assist' : 'Create Assist',
        ),
      ),
      appBar: AppBar(
        title: Text(
            widget.editTaskModel != null ? 'Update Assist' : 'Create Assist'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
                onPressed: () async {
                  if (!await launchUrl(
                      Uri.parse('https://assisto.ayesavi.in/help.html'),
                      mode: LaunchMode.inAppWebView)) {
                    throw Exception('Could not launch url');
                  }
                },
                child: const Text('Help')),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              ReusableTextField(
                controller: _titleController,
                label: 'Title',
                hint: 'Groceries Shopping',
                description: 'Please enter the title of the task',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  // Save the title value
                  // This example assumes a TaskModel class with a title property
                  // widget.editTaskModel?.title = value!;
                },
              ),
              TypingTextField(
                hintText:
                    'Buy me given groceries from the nearest store. \n \n 1. Milk \n 2. 2 Kg Tomatoes ',
                controller: _descriptionController,
                // label: 'Description',
                maxLines: 5,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16.0),
                )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              Text(
                'Please enter a brief description of the task',
                style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SelectableTagList(
                  onChanged: (value) {
                    _tags.addAll(value);
                  },
                  isRow: true,
                  tags: FakeCategoriesRepository()
                      .categories
                      .map((e) => e.label)
                      .toList(),
                  selectedTags: const [],
                ),
              ),
              ReusableTextField(
                controller: _tagController,
                label: 'Tags',
                description:
                    'Enter tags and click the add button to add them to the list',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_tagController.text.isNotEmpty) {
                      setState(() {
                        _tags.add(_tagController.text);
                        _tagController.clear();
                      });
                    }
                  },
                ),
              ),
              Wrap(
                spacing: 8.0,
                children: _tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    onDeleted: () {
                      setState(() {
                        _tags.remove(tag);
                      });
                    },
                  );
                }).toList(),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showAdvancedOptions) ...[
                      kWidgetVerticalGap,
                      ReusableTextField(
                        controller: _budgetController,
                        label: 'Budget (Optional)',
                        description: 'Enter the maximum budget for this assist',
                        keyboardType: TextInputType.number,
                        formatters: [FilteringTextInputFormatter.digitsOnly],
                        onSaved: (value) {
                          // Save the deadline value
                          // widget.editTaskModel?.deadline = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomDropdown(
                        hintText: 'Select a Gender (Optional)',
                        decoration: CustomDropdownDecoration(
                            closedBorderRadius: BorderRadius.circular(12),
                            expandedFillColor:
                                Theme.of(context).colorScheme.onInverseSurface,
                            closedFillColor:
                                Theme.of(context).colorScheme.onInverseSurface),
                        items: Gender.values
                            .map((e) => e.name.capitalize)
                            .toList(),
                        onChanged: (p0) {
                          final map = {
                            'Male': Gender.male,
                            'Female': Gender.female,
                            'Other': Gender.other,
                            'Any': Gender.any,
                          };
                          if (p0 != null) {
                            _gender = map[p0]!;
                          }
                        },
                      ),
                      kWidgetMinVerticalGap,
                      Text(
                        'Select the gender for this assist',
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 16),
                      ReusableTextField(
                        controller: _ageGroupController,
                        label: 'Age Group (Optional)',
                        length: 5,
                        description: 'Enter the age group for this assist',
                        keyboardType: TextInputType.number,
                        formatters: [AgeGroupInputFormatter()],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          // Check if value is null or not exactly 5 characters long
                          if (value.length != 5) {
                            return 'Age group must be 5 characters long';
                          }

                          // Regular expression to check if value is in the format "22-25"
                          RegExp regExp = RegExp(r'^\d{2}-\d{2}$');
                          if (!regExp.hasMatch(value)) {
                            return 'Age group must be in the format "22-25"';
                          }

                          return null; // If all checks pass, return null
                        },
                        onSaved: (value) {
                          // Save the deadline value
                          // widget.editTaskModel?.deadline = value;
                        },
                      ),
                      _buildLocation(context),
                      ReusableTextField(
                        controller: _deadlineController,
                        onPress: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                          );
                          if (pickedDate != null && context.mounted) {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              final pickedDateTime = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                pickedDate.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                              _deadline = pickedDate;
                              _deadlineController.text =
                                  DateFormat('dd MMM yyyy hh:mm a')
                                      .format(pickedDateTime);
                            }
                          }
                        },
                        label: 'Deadline (Optional)',
                        description: 'Enter the deadline for the assist',
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          return null;
                        },
                        onSaved: (value) {
                          // Save the deadline value
                          // widget.editTaskModel?.deadline = value;
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
              TextButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(12))),
                onPressed: () {
                  setState(() {
                    showAdvancedOptions = !showAdvancedOptions;
                  });
                },
                child: Text(!showAdvancedOptions
                    ? 'Show Advanced Options'
                    : 'Hide Advanced Option'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocation(BuildContext context) {
    return Builder(builder: (context) {
      final state = ref.watch(addressPageControllerProvider);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kWidgetMinVerticalGap,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.when(data: (data) {
                return CustomDropdown<AddressModel>(
                  hintText: 'Select address (Optional)',
                  items: data,
                  onChanged: (value) {
                    _locationId = value?.id;
                  },
                  decoration: CustomDropdownDecoration(
                      closedFillColor: Colors.transparent,
                      expandedFillColor:
                          Theme.of(context).colorScheme.onInverseSurface),
                );
              }, error: (e) {
                return const SizedBox.shrink();
              }, loading: () {
                return const SizedBox.shrink();
              }),
              const SizedBox(height: 4.0),
              Text(
                'Select the location for this assist, So that only users under 50 kms of location can do this.',
                style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      );
    });
  }
}

class AgeGroupInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var newText = newValue.text;

    // Handle delete
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var dateText = _addDashIfNeeded(newText);
    return newValue.copyWith(
      text: dateText,
      selection: TextSelection.collapsed(
        offset: dateText.length,
      ),
    );
  }

  String _addDashIfNeeded(String text) {
    text = text.replaceAll('-', '');
    if (text.length > 2 && !text.contains('-')) {
      // Add dash after the first two characters
      text = '${text.substring(0, 2)}-${text.substring(2)}';
    }
    return text;
  }
}

class ReusableTextField extends StatelessWidget {
  final String label;
  final String? hint;

  final String description;
  final List<TextInputFormatter> formatters;
  final int maxLines;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final VoidCallback? onPress;
  final bool readOnly;
  final int? length;
  const ReusableTextField({
    super.key,
    this.formatters = const [],
    required this.label,
    required this.description,
    this.readOnly = false,
    this.hint,
    this.maxLines = 1,
    this.length,
    this.controller,
    this.onPress,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            maxLength: length,
            readOnly: readOnly,
            onTap: onPress,
            inputFormatters: formatters,
            controller: controller,
            decoration: InputDecoration(
                labelText: label,
                suffixIcon: suffixIcon,
                counterText: '',
                hintText: hint),
            maxLines: maxLines,
            keyboardType: keyboardType,
            validator: validator,
            onSaved: onSaved,
          ),
          const SizedBox(height: 4.0),
          Text(
            description,
            style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
