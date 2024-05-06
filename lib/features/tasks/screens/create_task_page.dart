// ignore_for_file: unused_field

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/theme/theme.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/profile/controllers/address_page_controller/address_page_controller.dart';
import 'package:assisto/features/tasks/controllers/task_page_controller.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/show_menu_bottomsheet.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/typing_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TaskCreationPage extends ConsumerStatefulWidget {
  const TaskCreationPage({super.key});

  @override
  _TaskCreationPageState createState() => _TaskCreationPageState();
}

class _TaskCreationPageState extends ConsumerState<TaskCreationPage> {
  final TextEditingController _tagController = TextEditingController();
  late final ValueNotifier<List<String>> _chips;
  late final ValueNotifier<bool> _progressNotifier;
  late final ValueNotifier<Map<String, bool>> _showOptionNotifier;
  late final TextEditingController _selectedDateTimeController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _chips = ValueNotifier<List<String>>([]);
    _progressNotifier = ValueNotifier<bool>(false);
    _selectedDateTimeController = TextEditingController();
    _showOptionNotifier = ValueNotifier<Map<String, bool>>({
      'age': false,
      'gender': false,
      'deadline': false,
      'location': false,
      'budget': false,
      'documents': false,
    });
  }

  @override
  void dispose() {
    _chips.dispose();
    _progressNotifier.dispose();
    _showOptionNotifier.dispose();
    super.dispose();
  }

  int? _budget;
  String? _ageGroup;
  Gender? _gender;
  int? _locationId;
  String _title = '';
  String _description = '';
  DateTime? _deadline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () {}, child: const Text('Help')),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleMedium(
                text: 'Task Title',
                weight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              const Padding(padding: kWidgetMinVerticalPadding),
              TextFormField(
                onChanged: (v) {
                  _title = v;
                },
                decoration: InputDecoration(
                  hintText: 'Groceries Shopping',
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              kWidgetMinVerticalGap,
              BodyLarge(
                text:
                    'Give an appropriate title to the task, it must clarify purpose in minimum words',
                color: Theme.of(context).colorScheme.onBackground,
                maxLines: 2,
              ),
              kWidgetVerticalGap,
              TitleMedium(
                text: 'Description',
                weight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              kWidgetMinVerticalGap,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      TypingTextField(
                        maxLines: 6,
                        hintText:
                            'Buy me given groceries from the nearest store. \n \n 1. Milk \n 2. 2 Kg Tomatoes ',
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onChanged: (e) {
                          _description = e;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      Positioned(
                          bottom: 20,
                          right: 10,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  showMenuBottomSheet(context, params: [
                                    MenuBottomSheetParam(
                                      icon: Icons.timer_outlined,
                                      onPress: () {
                                        _showOptionNotifier.value = {
                                          ..._showOptionNotifier.value,
                                          'deadline': true
                                        };
                                        Navigator.pop(context);
                                      },
                                      label: 'Set Deadline',
                                    ),
                                    MenuBottomSheetParam(
                                      icon: Icons.date_range,
                                      onPress: () {
                                        _showOptionNotifier.value = {
                                          ..._showOptionNotifier.value,
                                          'age': true
                                        };
                                        Navigator.pop(context);
                                      },
                                      label: 'Add Age Group Filter',
                                    ),
                                    MenuBottomSheetParam(
                                      icon: Icons.male,
                                      onPress: () {
                                        _showOptionNotifier.value = {
                                          ..._showOptionNotifier.value,
                                          'gender': true
                                        };
                                        Navigator.pop(context);
                                      },
                                      label: 'Apply Gender Filter',
                                    ),
                                    MenuBottomSheetParam(
                                      icon: Icons.location_on_outlined,
                                      onPress: () {
                                        _showOptionNotifier.value = {
                                          ..._showOptionNotifier.value,
                                          'location': true
                                        };
                                        Navigator.pop(context);
                                      },
                                      label: 'Attach Location',
                                    ),
                                    MenuBottomSheetParam(
                                      icon: Icons.payments_outlined,
                                      onPress: () {
                                        _showOptionNotifier.value = {
                                          ..._showOptionNotifier.value,
                                          'budget': true
                                        };
                                        Navigator.pop(context);
                                      },
                                      label: 'Set Budget',
                                    ),
                                    MenuBottomSheetParam(
                                      icon: Icons.work_outline,
                                      onPress: () {
                                        _showOptionNotifier.value = {
                                          ..._showOptionNotifier.value,
                                          'documents': true
                                        };
                                        Navigator.pop(context);
                                      },
                                      label: 'Attach Documents',
                                    ),
                                  ]);
                                },
                                icon: Transform.rotate(
                                    angle: 0,
                                    child: const Icon(Icons.menu_rounded)),
                              )
                            ],
                          ))
                    ],
                  ),
                  kWidgetMinVerticalGap,
                  const BodyLarge(
                      maxLines: 3,
                      text:
                          'It must clearly specify the task in simple and short words, avoid using aronyms')
                ],
              ),
              kWidgetVerticalGap,
              TitleMedium(
                text: 'Tags',
                weight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              kWidgetMinVerticalGap,
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    borderRadius: BorderRadius.circular(12)),
                child: _buildChipsInput(context: context, label: 'Tag'),
              ),
              kWidgetMinVerticalGap,
              const BodyLarge(
                  maxLines: 3,
                  text:
                      'Tags are used for searching a mapping tasks, add suitable tasks or ask Assisto AI to do it.'),
              ValueListenableBuilder(
                valueListenable: _showOptionNotifier,
                builder: (BuildContext context, options, Widget? child) {
                  final isGenderVisible = options['gender'] ?? false;
                  final isAgeVisible = options['age'] ?? false;
                  final isLocationVisible = options['location'] ?? false;
                  final isBudgetVisible = options['budget'] ?? false;
                  final isDocumentsVisible = options['documents'] ?? false;
                  final isDeadlineVisible = options['deadline'] ?? false;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      kWidgetVerticalGap,
                      if (isDeadlineVisible) ...[
                        _buildDeadline(context),
                        kWidgetVerticalGap
                      ],
                      if (isAgeVisible) ...[
                        _buildAge(context),
                        kWidgetVerticalGap
                      ],
                      if (isBudgetVisible) ...[
                        _buildBudget(context),
                        kWidgetVerticalGap
                      ],
                      if (isLocationVisible) ...[
                        _buildLocation(context),
                        kWidgetVerticalGap
                      ],
                      if (isGenderVisible) _buildGender(context),
                    ],
                  );
                },
              ),
              kWidgetVerticalGap,
              AppFilledButton(
                label: 'Create Task',
                asyncTap: () async {
                  try {
                    await ref
                        .read(taskPageControllerProvider.notifier)
                        .createTask(getTaskModel());
                    Navigator.pop(context);
                  } catch (e) {
                    if (context.mounted) {
                      showSnackBar(context, appErrorHandler(e).message);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  TaskModel getTaskModel() {
    if ((_formKey.currentState?.validate() ?? false) &&
        _chips.value.length > 4) {
      return TaskModel.partial(
          tags: _chips.value,
          title: _title,
          description: _description,
          deadline: _deadline,
          addressId: _locationId,
          gender: _gender,
          ageGroup: _ageGroup,
          expectedPrice: _budget);
    }
    if (_chips.value.length < 5) {
      throw const AppException('Add atleast 5 tags');
    }
    throw const AppException('Enter data fields appropriately');
  }

  Widget _buildChipsInput({
    required BuildContext context,
    required String label,
  }) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: _chips,
      builder: (context, chips, _) {
        return Wrap(
          spacing: 8.0,
          children: [
            ...chips.map(
              (tag) => Chip(
                side: BorderSide.none,
                deleteIconColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary.tone(80),
                label: Text(
                  tag,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold),
                ),
                onDeleted: () {
                  _removeChip(tag);
                },
              ),
            ),
            SizedBox(
              width: 150,
              child: TextField(
                controller: _tagController,
                onChanged: (value) {
                  if (value.trimLeft().isNotEmpty &&
                      value.trimLeft().contains(' ')) {
                    _addChip(value.trimLeft());
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Add $label',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addChip(String tag) {
    if (tag.isNotEmpty) {
      final List<String> updatedChips = List<String>.from(_chips.value);
      updatedChips.add(tag);
      _chips.value = updatedChips;
      _tagController.clear();
    }
  }

  void _removeChip(String tag) {
    final List<String> updatedChips = List<String>.from(_chips.value);
    updatedChips.remove(tag);
    _chips.value = updatedChips;
  }

  Widget _buildAge(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleMedium(
          text: 'Age Group',
          weight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
        kWidgetMinVerticalGap,
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 5,
                inputFormatters: [AgeGroupInputFormatter()],
                onChanged: (value) {
                  _ageGroup = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Age Group',
                  border: InputBorder.none,
                  counterText: '',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _showOptionNotifier.value = {
                        ..._showOptionNotifier.value,
                        'age': false
                      };
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ],
          ),
        ),
        kWidgetMinVerticalGap,
        BodyLarge(
          text: 'Enter the age group for this task',
          color: Theme.of(context).colorScheme.onBackground,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildGender(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleMedium(
          text: 'Gender',
          weight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
        kWidgetMinVerticalGap,
        Container(
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDropdown<String>(
                items: const ['Male', 'Female', 'Other', 'Any Gender'],
                onChanged: (value) {
                  switch (value) {
                    case 'Male':
                      _gender = Gender.male;
                      break;
                    case 'Female':
                      _gender = Gender.female;

                      break;

                    case 'Other':
                      _gender = Gender.other;

                      break;
                    case 'Any Gender':
                      _gender = Gender.any;

                      break;
                  }
                },
                decoration: CustomDropdownDecoration(
                    closedFillColor: Colors.transparent,
                    expandedFillColor:
                        Theme.of(context).colorScheme.onInverseSurface
                    //   hintText: 'Select Gender',
                    //   border: InputBorder.none,
                    // suffixIcon:
                    ),
              ),
            ],
          ),
        ),
        kWidgetMinVerticalGap,
        BodyLarge(
          text: 'Select the gender for this task',
          color: Theme.of(context).colorScheme.onBackground,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildDeadline(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleMedium(
          text: 'Deadline',
          weight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
        kWidgetMinVerticalGap,
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                readOnly: true,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  if (pickedDate != null) {
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
                      _selectedDateTimeController.text =
                          DateFormat('dd MMM yyyy hh:mm a')
                              .format(pickedDateTime);
                    }
                  }
                },
                controller: _selectedDateTimeController,
                decoration: InputDecoration(
                  hintText: 'Select Deadline',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {
                      _showOptionNotifier.value = {
                        ..._showOptionNotifier.value,
                        'deadline': false
                      };
                      _deadline = null;
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ],
          ),
        ),
        kWidgetMinVerticalGap,
        BodyLarge(
          text: 'Select the deadline for this task',
          color: Theme.of(context).colorScheme.onBackground,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildLocation(BuildContext context) {
    return Builder(builder: (context) {
      final state = ref.watch(addressPageControllerProvider);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleMedium(
            text: 'Location',
            weight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
          kWidgetMinVerticalGap,
          Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onInverseSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state.when(data: (data) {
                  return Stack(
                    children: [
                      CustomDropdown<AddressModel>(
                        items: data,
                        onChanged: (value) {
                          _locationId = value.id;
                        },
                        decoration: CustomDropdownDecoration(
                            closedFillColor: Colors.transparent,
                            expandedFillColor:
                                Theme.of(context).colorScheme.onInverseSurface),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            _showOptionNotifier.value = {
                              ..._showOptionNotifier.value,
                              'location': false
                            };
                            _locationId = null;
                          },
                          icon: CircleAvatar(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .onInverseSurface,
                              child: const Icon(Icons.clear)),
                        ),
                      )
                    ],
                  );
                }, error: (e) {
                  return const Text(
                      'An error Occurred while fetching addresses');
                }, loading: () {
                  return const CircularProgressIndicator();
                })
              ],
            ),
          ),
          kWidgetMinVerticalGap,
          BodyLarge(
            text:
                'Select the location for this task, So that only users under 50 kms of location can do this.',
            color: Theme.of(context).colorScheme.onBackground,
            maxLines: 4,
          ),
        ],
      );
    });
  }

  Widget _buildBudget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleMedium(
          text: 'Budget',
          weight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
        kWidgetMinVerticalGap,
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _budget = int.tryParse(value);
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: 'Enter Budget Maximum',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {
                      _showOptionNotifier.value = {
                        ..._showOptionNotifier.value,
                        'budget': false
                      };
                      _budget = null;
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ],
          ),
        ),
        kWidgetMinVerticalGap,
        BodyLarge(
          text: 'Enter the maximum budget for this task',
          color: Theme.of(context).colorScheme.onBackground,
          maxLines: 2,
        ),
      ],
    );
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