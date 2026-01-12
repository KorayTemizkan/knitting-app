import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AiView extends StatefulWidget {
  const AiView({super.key});

  @override
  State<AiView> createState() => _AiViewState();
}

class _AiViewState extends State<AiView> {
  final TextEditingController _questionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Yapay Zekaya Sor'),

      body: Column(
        children: [
          TextField(
            controller: _questionController,
            decoration: InputDecoration(
              labelText: 'Sorunu yaz',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),

          if (_selectedImage != null)
            Image.file(_selectedImage!, height: 200, fit: BoxFit.cover),

          ElevatedButton(
            onPressed: () {
              _pickImage();
            },
            child: Text('Görsel seç'),
          ),

          ElevatedButton(onPressed: () {}, child: Text('Gönder')),
        ],
      ),
    );
  }
}
