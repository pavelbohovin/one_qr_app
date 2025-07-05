import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

void main() {
  runApp(const OneQRApp());
}

class OneQRApp extends StatelessWidget {
  const OneQRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One QR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const QRImagePage(),
    );
  }
}

class QRImagePage extends StatefulWidget {
  const QRImagePage({super.key});

  @override
  State<QRImagePage> createState() => _QRImagePageState();
}

class _QRImagePageState extends State<QRImagePage> {
  File? _imageFile;
  static const String _imagePathKey = 'last_qr_image_path';

  @override
  void initState() {
    super.initState();
    _loadLastImage();
  }

  Future<void> _loadLastImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(_imagePathKey);
    if (path != null && File(path).existsSync()) {
      setState(() {
        _imageFile = File(path);
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_imagePathKey, pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _imageFile != null
            ? Image.file(_imageFile!, width: 600, height: 800, fit: BoxFit.contain)
            : const Text('No QR image selected.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: const Icon(Icons.upload),
        tooltip: 'Upload QR Image',
      ),
    );
  }
}
