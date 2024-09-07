import 'dart:developer';
import 'dart:io';
import 'package:app/models/textextraction_model.dart';
import 'package:app/models/uv_model.dart';
import 'package:dio/dio.dart';
import 'package:app/models/prediction_model.dart';

class ApiService {
  ApiService();
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.14:5000'));

  Future<Prediction?> predict(File image) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path),
      });

      final response = await _dio.post('/predict', data: formData);

      if (response.statusCode == 200) {
        return Prediction.fromJson(response.data);
      } else {
        throw Exception('Failed to get prediction');
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }

  Future<MedicalReport?> extractText(File image) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path),
      });

      final response = await _dio.post('/extracttext', data: formData);

      if (response.statusCode == 200) {
        return MedicalReport.fromJson(response.data);
      } else {
        throw Exception('Failed to extract text');
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }
}
