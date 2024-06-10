import 'dart:io';

import 'package:flutter/material.dart';

class BuildImagePicker extends StatelessWidget {
  const BuildImagePicker({
    super.key,
    required this.imageFile,
    required this.onTap,
    required this.labelText,
  });

  final File? imageFile;
  final VoidCallback onTap;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: imageFile != null
              ? Image.file(imageFile!, fit: BoxFit.cover)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(labelText),
                      const Icon(Icons.add_photo_alternate),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
