import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? validatorMessage;

  const BuildTextField({
    required this.controller,
    required this.labelText,
    this.validatorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        validator: validatorMessage != null
            ? (value) {
                if (value == null || value.isEmpty) {
                  return validatorMessage;
                }
                return null;
              }
            : null,
      ),
    );
  }
}
