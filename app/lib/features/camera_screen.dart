import 'dart:io';
import 'package:app/models/prediction_model.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _selectedImage;
  Prediction? _prediction;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _pickImageFromCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _selectedImage != null
              ? Image.file(
                  _selectedImage!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
              : const Center(
                  child: Text("No image selected."),
                ),
          if (_prediction != null)
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Text(
                  'Cancer Detection Result: ${_prediction!.result}',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                        color: Color(0xFFA06CC8), size: 36),
                    onPressed: () {
                      context.go('/'); // Navigate back
                    },
                  ),
                  ElevatedButton(
                    onPressed: _pickImageFromCamera,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xFFA06CC8), // Background color of the button
                      // Icon color
                      shape: const CircleBorder(), // Circular shape
                      minimumSize: const Size(60,
                          60), // Circle diameter (width, height should be the same)
                      padding: EdgeInsets.zero, // Remove default padding
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 30, // Adjust icon size if needed
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: _pickImageFromGallery,
                    icon: const Icon(Icons.photo_library),
                    iconSize: 36,
                    color: const Color(0xFFA06CC8),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;

    setState(() {
      _selectedImage = File(returnedImage.path);
    });

    // Get prediction after selecting an image
    if (_selectedImage != null) {
      try {
        final prediction = await _apiService.predict(_selectedImage!);
        setState(() {
          _prediction = prediction;
        });
      } catch (e) {
        // Handle errors
        print('Error getting prediction: $e');
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    setState(() {
      _selectedImage = File(returnedImage.path);
    });

    // Get prediction after selecting an image
    if (_selectedImage != null) {
      try {
        final prediction = await _apiService.predict(_selectedImage!);
        setState(() {
          _prediction = prediction;
        });
      } catch (e) {
        // Handle errors
        print('Error getting prediction: $e');
      }
    }
  }
}
