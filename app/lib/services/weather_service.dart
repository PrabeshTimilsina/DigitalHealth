import 'dart:developer';

import 'package:app/models/uv_model.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class WeatherService {
  final String apiKey = 'f12f0376c2e5457ba12103322240709';
  final String baseUrl = 'http://api.weatherapi.com/v1';
  final Dio _dio = Dio();

  Future<WeatherData> fetchCurrentWeather(double lat, double lng) async {
    final url = '$baseUrl/current.json';
    final queryParameters = {
      'key': apiKey,
      'q': '$lat,$lng',
    };

    try {
      final response = await _dio.get(url, queryParameters: queryParameters);

      // Parse the response data and map it to WeatherData
      if (response.statusCode == 200) {
        return WeatherData.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Error occurred: ${e}');
    }
  }
}
