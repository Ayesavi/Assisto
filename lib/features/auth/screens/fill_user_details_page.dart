import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/utils/date_input_formatter.dart';
import 'package:assisto/features/home/repositories/categories_repository.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:flutter/material.dart';

class UserDetailsForm extends StatefulWidget {
  final Map<String, dynamic> userMap;

  final Function(Map<String, dynamic>) onSubmit;

  const UserDetailsForm(
      {super.key, required this.userMap, required this.onSubmit});

  @override
  _UserDetailsFormState createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  final _upiIdFormKey = GlobalKey<FormState>();
  final _dobFormKey = GlobalKey<FormState>();
  final _descriptionFormKey = GlobalKey<FormState>();
  final _nameFormKey = GlobalKey<FormState>();

  late final Map<String, GlobalKey<FormState>> _formKeyMap;

  late final Map<String, dynamic> _userDetails;

  int _currentStep = 0;

  late final List<Map<String, dynamic>> fields;

  @override
  void initState() {
    _initializeFields();
    _formKeyMap = {
      'upi_id': _upiIdFormKey,
      'dob': _dobFormKey,
      'description': _descriptionFormKey,
      'full_name': _nameFormKey,
    };
    super.initState();
  }

  _initializeFields() {
    fields = [
      if (!widget.userMap.containsKey('full_name'))
        {
          'label': "What's your name?",
          'key': 'full_name',
          'widget': _buildNameField()
        },
      if (!widget.userMap.containsKey('tags'))
        {
          'label': 'Select some tags that interest you',
          'key': 'tags',
          'widget': _buildTagsField()
        },
      if (!widget.userMap.containsKey('dob'))
        {
          'label': "What's your date of birth",
          'key': 'dob',
          'widget': _buildDOBField()
        },
      if (!widget.userMap.containsKey('upi_id'))
        {
          'label': "What's your UPI id?",
          'key': 'upi_id',
          'widget': _buildUPIField()
        },
      if (!widget.userMap.containsKey('description'))
        {
          'label': 'Tell us about yourself in short',
          'key': 'description',
          'widget': _builddescriptionField()
        },
      if (!widget.userMap.containsKey('gender'))
        {
          'label': "What's your gender?",
          'key': 'gender',
          'widget': _buildGenderField()
        },
    ];
    _userDetails = {...widget.userMap};
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _currentStep,
      onStepContinue: _nextStep,
      onStepCancel: _previousStep,
      type: StepperType.vertical,
      onStepTapped: (v) {
        setState(() {
          _currentStep = v;
        });
      },
      steps: fields
          .map((field) => Step(
                title: Text(field['label'] as String),
                content: field['widget'] as Widget,
                isActive: true,
                state: StepState.indexed,
              ))
          .toList(),
    );
  }

  Widget _buildDOBField() {
    return Form(
      key: _dobFormKey,
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Date of Birth',
            hintText: '10-08-2004',
            counterText: ''),
        keyboardType: TextInputType.datetime,
        inputFormatters: [DateInputFormatter()],
        maxLength: 10,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your date of birth';
          }
          return null;
        },
        onSaved: (value) {
          _userDetails['dob'] = value!;
        },
      ),
    );
  }

  Widget _buildUPIField() {
    return Form(
      key: _upiIdFormKey,
      child: TextFormField(
        decoration: const InputDecoration(labelText: 'UPI ID'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your UPI ID';
          }
          return null;
        },
        onSaved: (value) {
          _userDetails['upi_id'] = value ?? '';
        },
      ),
    );
  }

  Widget _builddescriptionField() {
    return Form(
      key: _descriptionFormKey,
      child: TextFormField(
        maxLines: 4,
        decoration: const InputDecoration(labelText: 'description'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your description';
          }
          return null;
        },
        onSaved: (value) {
          _userDetails['description'] = value!;
        },
      ),
    );
  }

  Widget _buildNameField() {
    return Form(
      key: _nameFormKey,
      child: TextFormField(
        decoration: const InputDecoration(labelText: 'Name'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your name';
          }
          return null;
        },
        onSaved: (value) {
          _userDetails['full_name'] = value!;
        },
      ),
    );
  }

  Widget _buildTagsField() {
    final tags =
        FakeCategoriesRepository().categories.map((e) => e.label).toList();
    return SelectableTagList(
      selectedTags: const ['tags1'],
      tags: tags,
      onChanged: (value) {
        _userDetails['tags'] = value;
      },
    );
  }

  Widget _buildGenderField() {
    return CustomDropdown(
        items: const ['Male', 'Female', 'Any'],
        onChanged: (gndr) {
          _userDetails['gender'] ??= gndr?.toLowerCase();
        });
  }

  bool _validateField() {
    if (!['gender', 'tags'].contains(fields[_currentStep]['key'])) {
      final formKey = _formKeyMap[fields[_currentStep]['key']];
      return formKey!.currentState!.validate();
    }
    return true;
  }

  void _saveField() {
    if (!['gender', 'tags'].contains(fields[_currentStep]['key'])) {
      final formKey = _formKeyMap[fields[_currentStep]['key']];
      return formKey!.currentState!.save();
    }
  }

  void _nextStep() {
    if (_validateField()) {
      _saveField();
      if (_currentStep < fields.length - 1) {
        setState(() {
          _currentStep += 1;
        });
      } else {
        if (_userDetails.containsKey('tags')
            ? (_userDetails['tags'].length >= 5)
            : true) {
          widget.onSubmit(_userDetails);
        } else {
          showSnackBar(context, 'Select at least 5 tags');
        }
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }
}

class SelectableTagList extends StatefulWidget {
  final List<String> tags;
  final List<String> selectedTags;
  final ValueChanged<List<String>>? onChanged;
  final bool isRow;

  const SelectableTagList({
    super.key,
    required this.tags,
    this.onChanged,
    this.isRow = false,
    required this.selectedTags,
  });

  @override
  State<SelectableTagList> createState() => _SelectableTagListState();
}

class _SelectableTagListState extends State<SelectableTagList> {
  final _selectedTags = <String>{};

  @override
  void initState() {
    super.initState();
    _selectedTags.addAll(widget.selectedTags);
  }

  @override
  Widget build(BuildContext context) {
    final widgets = widget.tags.map((tag) {
      final isSelected = _selectedTags.contains(tag);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ChoiceChip(
          label: Text(tag.capitalize),
          selected: isSelected,
          showCheckmark: false,
          backgroundColor: isSelected ? Theme.of(context).primaryColor : null,
          selectedColor:
              isSelected ? Theme.of(context).colorScheme.inversePrimary : null,
          onSelected: (value) => setState(() {
            if (isSelected) {
              _selectedTags.remove(tag);
            } else {
              _selectedTags.add(tag);
            }

            widget.onChanged?.call(_selectedTags.toList());
          }),
        ),
      );
    }).toList();

    return widget.isRow
        ? Row(
            children: [...widgets],
          )
        : Wrap(
            children: [...widgets],
          );
  }
}
