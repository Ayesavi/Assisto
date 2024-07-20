import 'package:flutter/material.dart';

class ProfileFormField extends StatelessWidget {
  final bool readOnly;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String label;
  final String hintText;

  const ProfileFormField({
    super.key,
    this.readOnly = false,
    this.controller,
    this.validator,
    required this.label,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          readOnly: readOnly,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            labelText: label,
            filled: false,
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
