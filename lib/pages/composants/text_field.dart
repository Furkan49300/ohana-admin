import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? validatorMessage;

  const BuildTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validatorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        ),
        maxLines: null,
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
