import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0; // Track the selected index

  // Update selected index and navigate to the corresponding page
  void _onItemTapped(int index, String route) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, right: 60, bottom: 20),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: _selectedIndex == 0 ? Colors.purple : Colors.black,
                ),
                onPressed: () {
                  _onItemTapped(0, '/');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.control_camera_outlined,
                  color: _selectedIndex == 1 ? Colors.purple : Colors.black,
                ),
                onPressed: () {
                  _onItemTapped(1, '/camera');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: _selectedIndex == 2 ? Colors.purple : Colors.black,
                ),
                onPressed: () {
                  _onItemTapped(2, '/report');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
