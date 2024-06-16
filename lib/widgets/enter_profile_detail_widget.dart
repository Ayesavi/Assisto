import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/utils/debouncer.dart';
import 'package:assisto/core/utils/utils.dart';
import 'package:assisto/features/home/screens/select_categories_page.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/profie_details_form/profile_details_form_builder.dart';
import 'package:assisto/widgets/profie_details_form/profile_details_form_controller.dart';
import 'package:assisto/widgets/profie_details_form/profile_form_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterProfileDetailWidgetConstants {
  static const nameQueText = "What's your name?";
  static const genderText = "What's your gender?";
  static const dobText = "What's your date of birth?";
  static const phoneText = "How can we contact you?";
  static const emailText = "What is your email?";
  static const successText = 'Success!';
  static const profileSucessFullyCreated =
      'Congratulations! Your profile has been successfully created';

  // List of gender options
  static const List<String> genderOptions = [
    'male',
    'female',
    'other',
  ];
}

class EnterProfileDetailWidget extends ConsumerStatefulWidget {
  final Function(Map<String, dynamic>) onFinish;
  final Map<String, dynamic> userDetails;
  const EnterProfileDetailWidget(
      {super.key, required this.onFinish, this.userDetails = const {}});

  @override
  // ignore: library_private_types_in_public_api
  _EnterProfileDetailWidgetState createState() =>
      _EnterProfileDetailWidgetState();
}

class _EnterProfileDetailWidgetState
    extends ConsumerState<EnterProfileDetailWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late int _currentQuestionIndex;
  Map<String, dynamic> _userDetails = {};
  bool isInitialized = false;
  late final TextEditingController _dobController;
  late final TextEditingController _phoneController;
  late final ProfileFormController _formController;

  String? _selectedGender;
  bool isSuccess = false;
  late final List<ProfileFormParams> differentiatedList;
  @override
  void initState() {
    super.initState();
    _dobController = TextEditingController();
    _phoneController = TextEditingController();
    _currentQuestionIndex = 0;
  }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  String getPhoneNumber(context) {
    String phoneNumber = '91${_phoneController.text.trim()}';

    // Regular expression to match a phone number with country code
    RegExp phoneRegex = RegExp(r'^\d{10,12}$');

    if (phoneRegex.hasMatch(phoneNumber)) {
      // Phone number is valid
      return phoneNumber;
    } else {
      throw const AppException('Invalid Phone Number');
    }
  }

  List<ProfileFormParams> getParams() {
    return [
      ProfileFormParams(key: 'name', builder: _nameBuilder),
      ProfileFormParams(key: 'gender', builder: _genderBuilder),
      ProfileFormParams(key: 'dob', builder: _dobBuilder),
      ProfileFormParams(key: 'tags', builder: _tagsBuilder),
    ];
  }

  // Function to validate the input field
  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null; // Return null if the input is valid
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    // Regular expression to match a valid phone number format
    // This example assumes a simple format of 10 digits without any special characters
    // Modify the regular expression according to your specific requirements
    RegExp phoneRegExp = RegExp(r'^[0-9]{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    return null; // Return null if the phone number is valid
  }

  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }
    try {
      // Parse the entered date string
      final List<String> dateParts = value.split('/');
      final int day = int.parse(dateParts[0]);
      final int month = int.parse(dateParts[1]);
      final int year = int.parse(dateParts[2]);

      // Check if the entered date is valid
      final DateTime enteredDate = DateTime(year, month, day);
      final DateTime today = DateTime.now();
      if (enteredDate.isAfter(today)) {
        return 'Date must be before today';
      }
    } catch (e) {
      // Return error if parsing fails
      return 'Invalid date format';
    }
    return null; // Return null if the date is valid
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _userDetails['dob'] = "${picked.day}/${picked.month}/${picked.year}";
      _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    return state.when(authControllerInitial: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }, authenticated: (model) {
      Future.delayed(const Duration(milliseconds: 200), () {
        const HomeRoute().go(context);
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }, unAuthenticated: () {
      return const CircularProgressIndicator();
    }, inCompleteProfile: (userDetails, isPhoneVerified, isEmailVerified) {
      if (!isInitialized) {
        _userDetails = {...userDetails};
        _selectedGender = userDetails.containsKey('gender')
            ? userDetails['gender']
            : 'female';
        if (userDetails.containsKey('dob')) {
          _dobController.text = (_userDetails['dob']);
        }
        differentiatedList = mapDifferentiator(getParams(), _userDetails);
        _formController = ProfileFormController(differentiatedList);
        isInitialized = true;
      }
      return ProfileFormBuilder(formKey: _formKey, controller: _formController);
    });
  }

  List<ProfileFormParams> mapDifferentiator(
      List<ProfileFormParams> map1, Map<String, dynamic> map2) {
    // Create an empty map to store the differentiated entries
    List<ProfileFormParams> list = [];

    // Iterate over the entries of the first map
    for (var item in map1) {
      // Check if the key is present in the second map and its associated value is not an empty string or null
      if (!map2.containsKey(item.key) ||
          (map2[item.key] == null || map2[item.key] == '')) {
        // Add the entry to the differentiated map if the conditions are met
        list.add(item);
      }
    }

    return list;
  }

  Widget _tagsBuilder(BuildContext context) {
    return SelectCategoriesPage(
      onBack: _showBackButton('tags')
          ? () {
              _formController.prev();
            }
          : null,
      onCategorySelected: (categories) async {
        try {
          await ref.read(authControllerProvider.notifier).updateProfile(
              UserModel(
                  id: '',
                  tags: categories.map((e) => e.label).toList(),
                  name: _userDetails['name'],
                  avatarUrl: _userDetails['avatar_url'],
                  gender: _selectedGender!,
                  age: calculateAgeFromString(_userDetails['dob']),
                  dob: _userDetails['dob']));
          return;
        } catch (e) {
          if (context.mounted) {
            showSnackBar(context, appErrorHandler(e).message);
          }
        }
      },
    );
  }

  Widget _nameBuilder(BuildContext context) {
    return _profileDetailCard(
      key: 'name',
      question: EnterProfileDetailWidgetConstants.nameQueText,
      buttonLabel: 'Continue',
      onNext: () {
        _formController.next();
      },
      builder: (context) {
        return TextFormField(
          initialValue: _userDetails['name'],

          decoration: InputDecoration(
            hintText: 'Ex Tom Cruise',
            labelText: 'Full Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onChanged: (value) {
            if (_formKey.currentState!.validate()) {
              _userDetails['name'] = value;
            }
          },
          onFieldSubmitted: (s) {
            if (_formKey.currentState!.validate() &&
                _currentQuestionIndex < 2) {}
          },
          validator: _validateInput, // Add validator
        );
      },
    );
  }

  Widget _genderBuilder(BuildContext context) {
    return _profileDetailCard(
        key: 'gender',
        question: EnterProfileDetailWidgetConstants.genderText,
        buttonLabel: 'Continue',
        onNext: () {
          _formController.next();
        },
        builder: (context) {
          return DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: InputDecoration(
              hintText: 'Select gender',
              labelText: 'Gender',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            items: EnterProfileDetailWidgetConstants.genderOptions
                .map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _selectedGender = value;
              });
              if (value != null) {
                _userDetails['gender'] = value;
              }
            },
            validator: _validateInput, // Add validator
          );
        });
  }

  Widget _dobBuilder(BuildContext context) {
    return _profileDetailCard(
        key: 'dob',
        question: EnterProfileDetailWidgetConstants.dobText,
        buttonLabel: 'Continue',
        onNext: () {
          _formController.next();
        },
        builder: (context) {
          final bouncer = Debouncer(delay: const Duration(milliseconds: 800));
          return Row(
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [DateInputFormatter()],
                  maxLength: 10,
                  controller: _dobController,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: 'DD/MM/YYYY',
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (value) {
                    _userDetails['dob'] = value;
                    bouncer.call(() {
                      _formKey.currentState?.validate();
                    });
                  },
                  validator: validateDate, // Add validator
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
              ),
            ],
          );
        });
  }

  Widget _profileDetailCard(
      {required String key,
      required String question,
      required String buttonLabel,
      required VoidCallback onNext,
      required Widget Function(BuildContext context) builder}) {
    final showBackButton = _showBackButton(key);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showBackButton)
                      BackButton(
                        onPressed: () {
                          _formController.prev();
                        },
                      ),
                    Text(
                      question,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    builder(context),
                    const SizedBox(height: 20.0),
                    AppFilledButton(
                      asyncTap: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          onNext();
                        }
                      },
                      label: buttonLabel,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _showBackButton(String key) {
    final index =
        differentiatedList.indexWhere((element) => element.key == key);
    return index > 0;
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    // Handle delete
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var dateText = _addSlashIfNeeded(newText);
    return newValue.copyWith(
      text: dateText,
      selection: TextSelection.collapsed(
        offset: dateText.length,
      ),
    );
  }

  String _addSlashIfNeeded(String text) {
    text = text.replaceAll('/', '');
    if (text.length > 2 && !text.contains('/')) {
      // Add slash after day and month
      text =
          '${text.substring(0, 2)}/${text.substring(2, text.length > 4 ? 4 : text.length)}${text.length > 4 ? '/${text.substring(4, text.length)}' : ''}';
    }
    return text;
  }
}
