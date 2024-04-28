import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditTextFieldWidget extends ConsumerWidget {
  final String hintText;
  final String labelText;
  final TextEditingController textEditingController;
  final TextInputType? type;
  final Future<void> Function(String) onSave;
  final String? Function(String?)? validator;

  const EditTextFieldWidget({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.textEditingController,
    this.type,
    required this.onSave,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActionVisibleNotifier =
        ValueNotifier(textEditingController.text.isEmpty);
    final progressNotifier = ValueNotifier(false);
    final GlobalKey<FormState> formKey =
        GlobalKey<FormState>(); // Create GlobalKey here

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder(
            valueListenable: isActionVisibleNotifier,
            builder: (BuildContext context, bool value, Widget? child) {
              return TextFormField(
                controller: textEditingController,
                keyboardType: type,
                readOnly: textEditingController.text.isNotEmpty && !value,
                decoration: InputDecoration(
                  hintText: hintText,
                  labelText: labelText,
                  errorText: validator != null && !value
                      ? validator!(textEditingController.text)
                      : null,
                  suffixIcon: TextButton(
                    child: const Text("Edit"),
                    onPressed: () {
                      isActionVisibleNotifier.value = true;
                    },
                  ),
                ),
                validator: validator, // Adding a simple validation here
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: isActionVisibleNotifier,
            builder: (BuildContext context, bool value, Widget? child) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: value
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          key: const ValueKey(true),
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  try {
                                    progressNotifier.value = true;
                                    await onSave(textEditingController.text);
                                    progressNotifier.value = false;
                                    isActionVisibleNotifier.value = false;
                                  } catch (e) {
                                    progressNotifier.value = false;
                                  }
                                }
                              },
                              child: ValueListenableBuilder(
                                valueListenable: progressNotifier,
                                builder: (BuildContext context, dynamic value,
                                    Widget? child) {
                                  return progressNotifier.value
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text('Save'),
                                            const SizedBox(width: 10),
                                            SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: CupertinoActivityIndicator(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer,
                                              ),
                                            ),
                                          ],
                                        ) // Show progress row if in progress
                                      : const Text('Save');
                                },
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                isActionVisibleNotifier.value = false;
                              },
                              child: const Text("Cancel"),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              );
            },
          ),
        ],
      ),
    );
  }
}