import 'dart:developer';

import 'package:app/components/custom_painter.dart';
import 'package:app/components/uv_scale.dart';

import 'package:app/models/uv_model.dart';
import 'package:app/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class UVIndexScreen extends StatefulWidget {
  const UVIndexScreen({super.key});

  @override
  State<UVIndexScreen> createState() => _UVIndexScreenState();
}

class _UVIndexScreenState extends State<UVIndexScreen> {
  String location = 'Gongabu, Kathmandu';
  double uv = 5.0;
  int selectedIndex = -1; // Initialize with no selection

  Future<void> _getLocationAndUVIndex() async {
    try {
      LocationPermission locattionpermission;
      final permission = Permission.location;

      if (await permission.isDenied) {
        await permission.request();
      }
      locattionpermission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      WeatherData model = await WeatherService()
          .fetchCurrentWeather(position.latitude, position.longitude);

      setState(() {
        uv = model.current.uv;
        location = "${model.location.name},${model.location.country}";
        updateSelectedUVRange(); // Update selected UV range
      });
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
      'top': 'Minimal Danger from Sun\'s UV Rays',
      'body':
          'Wear UV-blocking sunglasses to protect your eyes, and of course, to look good.\nApply sunscreen with an SPF of 15–20 to protect your skin from UV rays.',
      'spf': '15'
    },
    {
      'range': '3-6',
      'label': 'Moderate',
      'color': const Color.fromARGB(255, 192, 179, 40),
      'top': 'Moderate Risk of Harm from Sun Exposure',
      'body':
          'Wear UV-blocking sunglasses and apply sunscreen with an SPF of at least 30.',
      'spf': '30'
    },
    {
      'range': '6-8',
      'label': 'High',
      'color': const Color(0xFFF95901),
      'top': 'Moderate Risk of Harm from Unprotected Sun Exposure',
      'body':
          'Generously apply broad-spectrum SPF 30+ sunscreen every 2 hours, even on cloudy days, and after swimming or sweating.',
      'spf': '30+'
    },
    {
      'range': '8-10',
      'label': 'Very High',
      'color': const Color(0xFFC8224B),
      'top': 'High Risk of Harm from Unprotected Sun Exposure',
      'body':
          'Seek shade, cover up, wear a hat and sunglasses, and use sunscreen with SPF 50.',
      'spf': '50'
    },
    {
      'range': '10+',
      'label': 'Extreme',
      'color': const Color(0xFF6D4ACC),
      'top': 'Very High Risk of Harm from Unprotected Sun Exposure',
      'body':
          'Apply sunscreen with an SPF of 50+, reapply frequently, and wear UV-blocking sunglasses and protective clothing.',
      'spf': '50+'
    },
  ];

  // Update the selected index based on the UV value
  void updateSelectedUVRange() {
    if (uv < 3) {
      selectedIndex = 0;
    } else if (uv >= 3 && uv < 6) {
      selectedIndex = 1;
    } else if (uv >= 6 && uv < 8) {
      selectedIndex = 2;
    } else if (uv >= 8 && uv < 10) {
      selectedIndex = 3;
    } else {
      selectedIndex = 4;
    }
  }

  // Get specific properties based on the selected index
  Color getSunColor() {
    return selectedIndex != -1
        ? uvScaleData[selectedIndex]['color']
        : Colors.yellow;
  }

  String getSPF() {
    return selectedIndex != -1 ? uvScaleData[selectedIndex]['spf'] : 'N/A';
  }

  String getBody() {
    return selectedIndex != -1
        ? uvScaleData[selectedIndex]['body']
        : 'No information available';
  }

  String getDescription() {
    return selectedIndex != -1
        ? uvScaleData[selectedIndex]['top']
        : 'No description available';
  }

  Color getBodyTextColor() {
    return selectedIndex != -1
        ? uvScaleData[selectedIndex]['color']
        : Colors.black;
  }

  Color getGradientYellowColor() {
    return selectedIndex != -1
        ? uvScaleData[selectedIndex]['color']
        : Colors.yellow.withOpacity(6);
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
                  colors: [getGradientYellowColor(), const Color(0xFFA16DC8)],
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
                isSelected: index == selectedIndex,
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
                  width: 200,
                  child: Text(
                    getDescription(),
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
                    const Icon(
                      Icons.location_pin,
                      color: Color(0xff77D1B6),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      location,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 13,
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
