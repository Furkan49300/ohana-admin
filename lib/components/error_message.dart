import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    super.key,
    required this.errorMessage,
  });

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return errorMessage == ''
        ? SizedBox.shrink()
        : Text(
            errorMessage!,
            style: TextStyle(color: Colors.red),
          );
  }
}
