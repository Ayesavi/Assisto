import 'package:assisto/core/theme/theme.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class EnterProfileDetailWidgetConstants {
  static const List<String> questions = [
    "What's your name?",
    "What's your gender?",
    "What's your date of birth?",
  ];

  static const successText = 'Success!';
  static const profileSucessFullyCreated =
      'Congratulations! Your profile has been successfully created';

  // List of gender options
  static const List<String> genderOptions = [
    'Male',
    'Female',
    'Other',
  ];
}

class EnterProfileDetailWidget extends StatefulWidget {
  final Function(Map<String, String>) onFinish;

  const EnterProfileDetailWidget({super.key, required this.onFinish});

  @override
  _EnterProfileDetailWidgetState createState() =>
      _EnterProfileDetailWidgetState();
}

class _EnterProfileDetailWidgetState extends State<EnterProfileDetailWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _currentQuestionIndex = 0;
  final Map<String, String> _userDetails = {};
  late final TextEditingController _dobController;
  String? _selectedGender;
  bool isSuccess = false;

  @override
  void initState() {
    super.initState();
    _dobController = TextEditingController();
  }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  // Function to validate the input field
  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null; // Return null if the input is valid
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
      setState(() {
        _userDetails[EnterProfileDetailWidgetConstants
                .questions[_currentQuestionIndex]] =
            "${picked.day}/${picked.month}/${picked.year}";
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _handleNext(String answer) {
    _userDetails[EnterProfileDetailWidgetConstants
            .questions[_currentQuestionIndex]] =
        _currentQuestionIndex == 1 ? _selectedGender ?? '' : answer;
    if (_currentQuestionIndex <
        EnterProfileDetailWidgetConstants.questions.length - 1) {
    } else {
      // All questions answered
      if (_formKey.currentState!.validate()) {
        // Validate the form
        widget.onFinish(_userDetails);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 20),
        child: Column(
          children: [
            Expanded(
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
                  child: !isSuccess
                      ? Form(
                          key: _formKey, // Assign the form key
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (_currentQuestionIndex != 0)
                                BackButton(
                                  onPressed: () {
                                    if (_currentQuestionIndex > 0) {
                                      setState(() {
                                        _currentQuestionIndex--;
                                      });
                                    }
                                  },
                                ),
                              Text(
                                EnterProfileDetailWidgetConstants
                                    .questions[_currentQuestionIndex],
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              _currentQuestionIndex == 1
                                  ? DropdownButtonFormField<String>(
                                      value: _selectedGender,
                                      decoration: InputDecoration(
                                        hintText: 'Select gender',
                                        labelText: 'Gender',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      items: EnterProfileDetailWidgetConstants
                                          .genderOptions
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
                                          _handleNext(value);
                                        }
                                      },
                                      validator:
                                          _validateInput, // Add validator
                                    )
                                  : _currentQuestionIndex == 2
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller: _dobController,
                                                keyboardType:
                                                    TextInputType.datetime,
                                                inputFormatters: [
                                                  DateInputFormatter()
                                                ],
                                                maxLength: 10,

                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  hintText: 'DD/MM/YYYY',
                                                  labelText: 'Date of Birth',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  _userDetails[
                                                      EnterProfileDetailWidgetConstants
                                                              .questions[
                                                          _currentQuestionIndex]] = value;
                                                },
                                                validator:
                                                    validateDate, // Add validator
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                  Icons.calendar_today),
                                              onPressed: () =>
                                                  _selectDate(context),
                                            ),
                                          ],
                                        )
                                      : TextFormField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          initialValue: _userDetails[
                                              EnterProfileDetailWidgetConstants
                                                      .questions[
                                                  _currentQuestionIndex]],

                                          decoration: InputDecoration(
                                            hintText: 'Ex Tom Cruise',
                                            labelText: 'Full Name',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onChanged: _handleNext,
                                          onFieldSubmitted: (s) {
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                _currentQuestionIndex < 2) {
                                              setState(() {
                                                _currentQuestionIndex++;
                                              });
                                            }
                                          },
                                          validator:
                                              _validateInput, // Add validator
                                        ),
                              const SizedBox(height: 20.0),
                              AppFilledButton(
                                onTap: () {
                                  if (_formKey.currentState!.validate() &&
                                      _currentQuestionIndex ==
                                          EnterProfileDetailWidgetConstants
                                                  .questions.length -
                                              1) {
                                    setState(() {
                                      isSuccess = true;
                                    });
                                    widget.onFinish.call(_userDetails);
                                  } else {
                                    if (_formKey.currentState!.validate() &&
                                        _currentQuestionIndex < 2) {
                                      setState(() {
                                        _currentQuestionIndex++;
                                      });
                                    }
                                  }
                                },
                                label: _currentQuestionIndex ==
                                        EnterProfileDetailWidgetConstants
                                                .questions.length -
                                            1
                                    ? 'Finish'
                                    : 'Next',
                              ),
                            ],
                          ),
                        )
                      : const SuccessScreen()),
            ),
          ],
        ),
      ),
    );
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

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Adjust duration as needed
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.graphics.successCheckMark,
              height: 100, // Initial height of the SVG picture
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            const TitleLarge(
              text: EnterProfileDetailWidgetConstants.successText,
              weight: FontWeight.bold,
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            BodyLarge(
              color: Theme.of(context).colorScheme.outline.tone(60),
              text: EnterProfileDetailWidgetConstants.profileSucessFullyCreated,
              maxLines: 2,
              align: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            AppFilledButton(label: 'Continue')
          ],
        ),
      ),
    );
  }
}
