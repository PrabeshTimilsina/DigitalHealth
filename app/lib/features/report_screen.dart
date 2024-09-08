import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:app/models/textextraction_model.dart';
import 'package:app/services/api_service.dart';
import 'package:app/services/image_picker_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanning_effect/scanning_effect.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ApiService _apiService = ApiService();
  File? _selectedImage;
  bool _isImageSelected = false;
  bool _isTextExtracted = false;
  MedicalReport? _textExtraction;
  Future<void> _handleImageSelection() async {
    final permission = Permission.location;

    if (await permission.isDenied) {
      await permission.request();
    }
    final imagePath = await ImagePickerService.pickImage();
    if (imagePath != null) {
      setState(() {
        _selectedImage = File(imagePath);
        _isImageSelected = !_isImageSelected;
      });
      log("33");
      final textExtraction = await _apiService.extractText(_selectedImage!);
      setState(() {
        _isTextExtracted = !_isTextExtracted;
        _textExtraction = textExtraction;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isImageSelected
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isImageSelected = false;
                    _isTextExtracted = false;
                  });
                },
                icon: const Icon(Icons.arrow_back))
            : SizedBox(),
        backgroundColor: Colors.transparent,
        title: const Text(
          'Report Summary',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Colors.grey.shade300,
      body: _isTextExtracted
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Image.file(
                        _selectedImage!,
                        height: 200,
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.48,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Summary",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 8,
                                        top: 16,
                                        bottom: 16),
                                    child: Text(
                                      '${_textExtraction!.summarizeText.summary}',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              "Key Findings",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 8,
                                        top: 16,
                                        bottom: 16),
                                    child: Text(
                                        _textExtraction!.summarizeText.findings,
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isImageSelected
                      ? Center(
                          child: Container(
                            margin: const EdgeInsets.all(64),
                            padding: const EdgeInsets.all(8),
                            height: 250,
                            child: ScanningEffect(
                              scanningHeightOffset: 0.6,
                              delay: const Duration(milliseconds: 0),
                              duration: const Duration(seconds: 2),
                              scanningColor: const Color(0xFFA16DC8),
                              borderLineColor: const Color(0xFFA16DC8),
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Image.file(
                                  _selectedImage!,
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      : DottedBorder(
                          radius: const Radius.circular(12),
                          color: const Color(0xFFA16DC8),
                          strokeWidth: 1,
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () {
                                  _handleImageSelection();
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/medical-report 1.png',
                                    ),
                                    const Text('Click to upload your report'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
