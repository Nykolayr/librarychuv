import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUploader extends StatefulWidget {
  const PhotoUploader({super.key});

  @override
  PhotoUploaderState createState() => PhotoUploaderState();
}

class PhotoUploaderState extends State<PhotoUploader> {
  XFile? _image;

  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Uploader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text('Выберите фото')
                : Image.file(File(_image!.path)),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Выбрать фото'),
            ),
          ],
        ),
      ),
    );
  }
}


