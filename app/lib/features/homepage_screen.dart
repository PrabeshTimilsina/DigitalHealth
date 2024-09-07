import 'dart:developer';

import 'package:app/components/custom_painter.dart';
import 'package:app/components/uv_scale.dart';

import 'package:app/models/uv_model.dart';
import 'package:app/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UVIndexScreen extends StatefulWidget {
  const UVIndexScreen({super.key});

  @override
  State<UVIndexScreen> createState() => _UVIndexScreenState();
}

class _UVIndexScreenState extends State<UVIndexScreen> {
  String location = 'Gongabu, Kathmandu';
  double uv = 5.0;

  Future<void> _getLocationAndUVIndex() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      WeatherData model = await WeatherService()
          .fetchCurrentWeather(position.latitude, position.longitude);

      setState(() {
        uv = model.current.uv;
        location = "${model.location.name}\n${model.location.country}";
      });
      updateSelectedUVRange();
    } catch (e) {
      log("Error getting location: $e");
    }
  }

  // Updated UV scale data with specific colors, body, and top text for each range
  final List<Map<String, dynamic>> uvScaleData = [
    {
      'range': '0-3',
      'label': 'Low',
      'color': const Color(0xFF299501),
      'isSelected': false,
      'top': 'Minimal Danger from Sun\'s UV Rays',
      'body':
          'Wear UV-blocking sunglasses to protect your eyes, and of course, to look good.\nApply sunscreen with an SPF of 15–20 to protect your skin from UV rays.',
      'spf': '15'
    },
    {
      'range': '3-6',
      'label': 'Moderate',
      'color': const Color(0xFFFEED21),
      'isSelected': false,
      'top': 'Moderate Risk of Harm from Sun Exposure',
      'body':
          'Wear UV-blocking sunglasses and apply sunscreen with an SPF of at least 30.',
      'spf': '30'
    },
    {
      'range': '6-8',
      'label': 'High',
      'color': const Color(0xFFF95901),
      'isSelected': false,
      'top': 'Moderate Risk of Harm from Unprotected Sun Exposure',
      'body':
          'Generously apply broad-spectrum SPF 30+ sunscreen every 2 hours, even on cloudy days, and after swimming or sweating. Watch out for bright surfaces, like sand, water, and snow, which reflect UV and increase exposure.',
      'spf': '30+'
    },
    {
      'range': '8-10',
      'label': 'Very High',
      'color': const Color(0xFFC8224B),
      'isSelected': false,
      'top': 'High Risk of Harm from Unprotected Sun Exposure',
      'body':
          'Try to avoid the sun between 11 a.m. and 4 p.m. Otherwise, seek shade, cover up, wear a hat and sunglasses, and use sunscreen with SPF 50.',
      'spf': '50'
    },
    {
      'range': '10+',
      'label': 'Extreme',
      'color': const Color(0xFF6D4ACC),
      'isSelected': false,
      'top': 'Very High Risk of Harm from Unprotected Sun Exposure',
      'body':
          'Apply sunscreen with an SPF of 50+, reapply frequently, and wear UV-blocking sunglasses, a wide-brimmed hat to protect the face and neck, and protective clothing to cover exposed skin.',
      'spf': '50+'
    },
  ];

  // Method to update the 'isSelected' property based on the UV index
  void updateSelectedUVRange() {
    for (var item in uvScaleData) {
      final range = item['range'];
      if (range == '0-3' && uv < 3) {
        item['isSelected'] = true;
      } else if (range == '3-6' && uv >= 3 && uv < 6) {
        item['isSelected'] = true;
      } else if (range == '6-8' && uv >= 6 && uv < 8) {
        item['isSelected'] = true;
      } else if (range == '8-10' && uv >= 8 && uv < 10) {
        item['isSelected'] = true;
      } else if (range == '10+' && uv >= 10) {
        item['isSelected'] = true;
      } else {
        item['isSelected'] = false;
      }
    }
  }

  // Method to map UV index to colors
  Color getSunColor() {
    var selectedItem =
        uvScaleData.firstWhere((item) => true == item['isSelected']);
    return selectedItem['color'];
  }

  String getSPF() {
    var selectedItem =
        uvScaleData.firstWhere((item) => true == item['isSelected']);
    return selectedItem['spf'];
  }

  String getBody() {
    var selectedItem =
        uvScaleData.firstWhere((item) => true == item['isSelected']);
    return selectedItem['body'];
  }

  String getDescription() {
    var selectedItem =
        uvScaleData.firstWhere((item) => true == item['isSelected']);
    return selectedItem['top'];
  }

  Color getbodyText() {
    var selectedItem =
        uvScaleData.firstWhere((item) => true == item['isSelected']);
    return selectedItem['color'];
  }

  Color getGradientYellowColor() {
    var selectedItem =
        uvScaleData.firstWhere((item) => true == item['isSelected']);
    return selectedItem['color'].withOpacity(0.6); // Adjust opacity if needed
  }

  @override
  void initState() {
    super.initState();
    _getLocationAndUVIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [getGradientYellowColor(), Colors.purple],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.5),
              painter: CustomShapePainter(),
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.only(
                left: 20,
                right: MediaQuery.of(context).size.width * 0.62,
                top: MediaQuery.of(context).size.height * 0.15),
            itemCount: uvScaleData.length,
            itemBuilder: (context, index) {
              final item = uvScaleData[index];
              return UVScaleItem(
                range: item['range'],
                label: item['label'],
                isSelected: item['isSelected'],
                color: item['color'],
              );
            },
          ),
          Positioned(
            top: 130,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Icon(
                    Icons.sunny,
                    size: 40,
                    color: getSunColor(),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '$uv',
                      style: const TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'UV',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    getDescription().toString(),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.location_pin),
                    Text(
                      location,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 120,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, top: 12, bottom: 16, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SPF  ${getSPF()}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          getBody(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
