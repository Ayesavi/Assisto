import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaskCreationPage extends StatelessWidget {
  const TaskCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            _buildChipsInput(
              context: context,
              label: 'Tags',
              onChipsChanged: (tags) {},
            ),
            const SizedBox(height: 20.0),
            _buildAgeGroupInput(
              context: context,
              label: 'Age Group',
              onAgeGroupChanged: (ageGroup) {},
            ),
            const SizedBox(height: 20.0),
            _buildDropDown(
              context: context,
              label: 'Gender',
              items: ['Male', 'Female', 'Other'],
              onItemSelected: (gender) {},
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Location (optional)'),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Expected Price (optional)'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              onChanged: (value) {
                final price = double.tryParse(value);
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Submit logic here
              },
              child: const Text('Create Task'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChipsInput({
    required BuildContext context,
    required String label,
    required Function(List<String>) onChipsChanged,
  }) {
    final TextEditingController controller = TextEditingController();
    List<String> chips = [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          children: [
            ...chips.map(
              (tag) => Chip(
                label: Text(tag),
                onDeleted: () {
                  chips.remove(tag);
                  onChipsChanged(chips);
                },
              ),
            ),
            SizedBox(
              width: 150.0,
              child: TextField(
                controller: controller,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    chips.add(value);
                    onChipsChanged(chips);
                    controller.clear();
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Add $label',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAgeGroupInput({
    required BuildContext context,
    required String label,
    required Function(String) onAgeGroupChanged,
  }) {
    final TextEditingController controller = TextEditingController();
    String? formattedAgeGroup;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          controller: controller,
          maxLength: 5,
          onChanged: (value) {
            String formattedValue = '';
            if (value.length >= 2) {
              formattedValue = '${value.substring(0, 2)}-';
              if (value.length >= 4) {
                formattedValue += value.substring(2, 4);
              }
            }
            formattedAgeGroup = formattedValue;
            // controller.value = const TextEditingValue(
            //     // text: formattedValue,
            //     // selection: TextSelection.collapsed(offset: formattedValue.length),
            //     );
            // onAgeGroupChanged(formattedAgeGroup!);
          },
          decoration: const InputDecoration(
            labelText: 'Age Group',
            counterText: '',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            AgeGroupInputFormatter(), 
          ],
        ),
      ],
    );
  }

  Widget _buildDropDown({
    required BuildContext context,
    required String label,
    required List<String> items,
    required Function(String) onItemSelected,
  }) {
    String? selectedItem;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        DropdownButtonFormField<String>(
          value: selectedItem,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {
            selectedItem = value;
            onItemSelected(value!);
          },
          decoration: InputDecoration(
            hintText: 'Select $label',
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          ),
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
