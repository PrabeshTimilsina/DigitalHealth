import 'dart:io';
import 'dart:math'; // For generating random predictions
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class Prediction {
  final String result;
  Prediction({required this.result});
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _selectedImage;
  Prediction? _prediction;

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
              bottom: 0, // Stick to the bottom
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: _prediction!.result == 'Benign'
                          ? Colors.green.withOpacity(0.2)
                          : Colors.red.withOpacity(0.2),
                      child: Icon(
                        _prediction!.result == 'Benign'
                            ? Icons.check
                            : Icons.close,
                        color: _prediction!.result == 'Benign'
                            ? Colors.green
                            : Colors.red,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _prediction!.result == 'Benign'
                          ? 'No Warning: Benign Lesion Detected'
                          : 'Warning: Possible Skin Cancer Detected',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _prediction!.result == 'Benign'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _prediction!.result == 'Benign'
                          ? const Text(
                              'Good news! No signs of skin cancer were detected in your recent analysis. ',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            )
                          : const Text(
                              'Please consult a dermatologist as soon as possible for further diagnosis and treatment. Early detection improves outcomes, so don’t delay in seeking medical advice.',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _prediction = null;
                        _selectedImage = null;
                        setState(() {});
                        context.go('/'); // Navigate back to home
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA06CC8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                      ),
                      child: const Text('Continue',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          if (_prediction ==
              null) // Display the bottom buttons only if no prediction is made
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
                        context.go('/'); // Navigate back to home
                      },
                    ),
                    ElevatedButton(
                      onPressed: _pickImageFromCamera,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA06CC8),
                        shape: const CircleBorder(),
                        minimumSize: const Size(60, 60),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 30,
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

    // Simulate a dummy prediction
    _simulateDummyPrediction();
  }

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    setState(() {
      _selectedImage = File(returnedImage.path);
    });

    // Simulate a dummy prediction
    _simulateDummyPrediction();
  }

  // Method to simulate dummy prediction
  void _simulateDummyPrediction() {
    final random = Random();
    final result = random.nextBool() ? 'Benign' : 'Malignant';

    setState(() {
      _prediction = Prediction(result: result);
    });
  }
}
