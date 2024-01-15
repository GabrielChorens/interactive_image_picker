import 'dart:io';

import 'package:flutter/material.dart';
import 'package:interactive_image_picker/interactive_image_picker.dart';

void main() {
  runApp(
    const MaterialApp(
      home: InteractiveImagePickerExample(),
    ),
  );
}

class InteractiveImagePickerExample extends StatefulWidget {
  const InteractiveImagePickerExample({super.key});

  @override
  State<InteractiveImagePickerExample> createState() =>
      _InteractiveImagePickerExampleState();
}

class _InteractiveImagePickerExampleState
    extends State<InteractiveImagePickerExample> {
  final ValueNotifier<File?> imageFile = ValueNotifier<File?>(null);
  final ValueNotifier<File?> imageFile2 = ValueNotifier<File?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive image picker example'),
      ),
      body: Column(
        children: [
          Center(
            child: InteractiveImagePicker.circular(
              imageFileController: imageFile,
              placeholder: const Center(
                child: Text('No image selected'),
              ),
              width: 200,
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: InteractiveImagePicker(
              imageFileController: imageFile2,
              placeholder: const Center(
                child: Icon(Icons.image, size: 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
