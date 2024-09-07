import 'package:app/components/custom_painter.dart';
import 'package:app/components/uv_scale.dart';
import 'package:flutter/material.dart';

class UVIndexScreen extends StatefulWidget {
  const UVIndexScreen({super.key});

  @override
  State<UVIndexScreen> createState() => _UVIndexScreenState();
}

class _UVIndexScreenState extends State<UVIndexScreen> {
  double uv = 10;
  String location = 'Gongabu, Kathmandu';

  final List<Map<String, dynamic>> uvScaleData = [
    {'range': '1-2', 'label': 'Low', 'isSelected': false},
    {'range': '2-5', 'label': 'Medium', 'isSelected': false},
    {'range': '5-7', 'label': 'High', 'isSelected': false},
    {'range': '7-10', 'label': 'Very High', 'isSelected': false},
    {'range': '10+', 'label': 'Extreme', 'isSelected': false},
  ];

  @override
  void initState() {
    super.initState();
    updateSelectedUVRange();
  }

  // Method to update the 'isSelected' property based on the UV index
  void updateSelectedUVRange() {
    for (var item in uvScaleData) {
      final range = item['range'];
      if (range == '1-2' && uv < 2) {
        item['isSelected'] = true;
      } else if (range == '2-5' && uv >= 2 && uv < 5) {
        item['isSelected'] = true;
      } else if (range == '5-7' && uv >= 5 && uv < 7) {
        item['isSelected'] = true;
      } else if (range == '7-10' && uv >= 7 && uv < 10) {
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
    if (uv <= 2) return Colors.green;
    if (uv <= 5) return Colors.yellow;
    if (uv <= 7) return Colors.orange;
    if (uv <= 10) return Colors.red;
    return Colors.purple;
  }

  Color getGradientYellowColor() {
    if (uv <= 2) return Colors.green.shade300;
    if (uv <= 5) return Colors.yellow.shade300;
    if (uv <= 7) return Colors.orange.shade300;
    if (uv <= 10) return Colors.red.shade300;
    return Colors.purple.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
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
                item['range'],
                item['label'],
                item['isSelected'],
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
                Icon(
                  Icons.sunny,
                  size: 40,
                  color: getSunColor(),
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
                const Text(
                  'Be Protected from Sun',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.purple),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart_outlined, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, color: Colors.black),
            label: '',
          ),
        ],
        currentIndex: 0,
        backgroundColor: Colors.white,
      ),
    );
  }
}
