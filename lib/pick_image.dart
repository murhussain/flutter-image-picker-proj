import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerExample extends StatefulWidget {
  const ImagePickerExample({Key? key}) : super(key: key);

  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File? _imageFile;
  final _picker = ImagePicker();

  final TextEditingController pathController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.photo_camera),
                onPressed: () async => _pickImageFromCamera(),
                tooltip: 'Shoot picture',
              ),
              IconButton(
                icon: const Icon(Icons.photo),
                onPressed: () async => _pickImageFromGallery(),
                tooltip: 'Pick from gallery',
              ),
            ],
          ),
          if (_imageFile == null)
            const Text('Please select image')
          else
            // Image.file(_imageFile!),
            // Text(_imageFile.toString())
            TextField(
              controller: pathController,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: IconButton(
                  onPressed: () async {
                    File? posLong = await _pickImageFromGallery1();
                    setState(() {
                      pathController.text = posLong.toString();
                    });
                  },
                  icon: const Icon(Icons.photo_camera),
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }

  

  Future<File?> _pickImageFromGallery1() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
    return _imageFile;
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
    // print("ITS ME: $_imageFile");
  }
}
