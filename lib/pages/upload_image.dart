import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  final Function(String) onImageUploaded;

  const UploadImage({super.key, required this.onImageUploaded});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  String? imageUrl;
  final ImagePicker _imagePicker = ImagePicker();
  bool isloading = false;

  pickImage() async {
    if (kIsWeb) {
      XFile? res = await _imagePicker.pickImage(source: ImageSource.gallery);

      if (res != null) {
        uploadToFirebase(res);
      }
    }
  }

  uploadToFirebase(XFile image) async {
    setState(() {
      isloading = true;
    });
    try {
      Reference sr = FirebaseStorage.instance
          .ref()
          .child('articles/${DateTime.now().millisecondsSinceEpoch}.png');

      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        final metadata = SettableMetadata(contentType: 'image/png');
        await sr.putData(bytes, metadata).whenComplete(
            () => {Fluttertoast.showToast(msg: 'Image enregistrée')});
      }

      imageUrl = await sr.getDownloadURL();
      widget.onImageUploaded(imageUrl!);
    } catch (e) {
      print('Error occurred $e');
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Center(
          child: TextButton(
            onPressed: () {
              pickImage();
            },
            child: Row(
              children: [
                Icon(
                  Icons.add_photo_alternate,
                  color: Colors.black,
                ),
                Text(
                  "Ajouter une image",
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
        ),
        if (isloading)
          SpinKitThreeBounce(
            color: Colors.black,
            size: 20,
          ),
      ],
    );
  }
}
