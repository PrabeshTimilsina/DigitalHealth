import 'package:flutter/material.dart';

class UVIndexScreen extends StatelessWidget {
  const UVIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.amber.shade300, Colors.purple.shade200],
              ),
            ),
          ),
          const Positioned(
            top: 130,
            right: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'UV',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '10',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Be Protected from Sun',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 5,
            child: Container(
              height: 500,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
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

class UVScale extends StatelessWidget {
  const UVScale({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UVScaleItem('1-2', 'Low', false),
        UVScaleItem('3-5', 'Medium', false),
        UVScaleItem('6-7', 'High', false),
        UVScaleItem('8-10', 'Very High', true),
        UVScaleItem('11+', 'Extreme', false),
      ],
    );
  }
}

class UVScaleItem extends StatelessWidget {
  final String range;
  final String label;
  final bool isSelected;

  UVScaleItem(this.range, this.label, this.isSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.purple : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            range,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
