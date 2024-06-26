import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/typing_textfield.dart';
import 'package:flutter/material.dart';

class CreateTaskUsingAIBottomSheet extends StatelessWidget {
  final Future<void> Function(String key) onTextEntered;
  final TextEditingController controller;
  const CreateTaskUsingAIBottomSheet(
      {super.key, required this.onTextEntered, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            title: TitleMedium(
              text: 'Magic Assist',
              weight: FontWeight.bold,
            ),
            subtitle:
                Text('Let Assisto AI create an assist for you using prompt'),
          ),
          const SizedBox(height: 16),
          TypingTextField(
            autofocus: true,
            hintText: 'I need someone to buy groceries for me 1ltr milk...',
            // autofocus: true,
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Enter Prompt',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          AppFilledButton(
            asyncTap: () async {
              await onTextEntered(controller.text);
            },
            label: ('Generate Assist'),
          ),
        ],
      ),
    );
  }
}

void showCreateTaskUsingAIBottomSheet(
  BuildContext context, {
  required TextEditingController controller,
  required Future<void> Function(String) onTextEntered,
}) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 10,
        ),
        child: CreateTaskUsingAIBottomSheet(
          controller: controller,
          onTextEntered: onTextEntered,
        ),
      );
    },
  );
}
