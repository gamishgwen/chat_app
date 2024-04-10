import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;



  void _pickedImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white30,
            foregroundImage:
                _pickedImageFile != null ? FileImage(_pickedImageFile!) : null),
        TextButton.icon(
            onPressed: _pickedImage,
            icon: Icon(Icons.camera_alt),
            label: Text(
              'Add Image',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ))
      ],
    );
  }
}
