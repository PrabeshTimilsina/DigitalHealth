import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, right: 60, bottom: 10),
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
                icon: const Icon(Icons.home, color: Colors.black),
                onPressed: () {
                  context.go('/');
                },
              ),
              IconButton(
                icon: const Icon(Icons.camera, color: Colors.black),
                onPressed: () {
                  context.go('/camera');
                },
              ),
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  context.go('/report');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
