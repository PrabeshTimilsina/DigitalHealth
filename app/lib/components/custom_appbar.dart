import 'package:app/features/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomScaffoldNavbar extends StatelessWidget {
  final Widget navigationShell;
  const CustomScaffoldNavbar({required this.navigationShell, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();

    // Check if the current route should hide the bottom navigation bar
    final shouldShowBottomNavBar = ![
      '/camera', // Add paths where the bottom nav bar should be hidden
      // Add other routes where the bottom nav bar should be hidden
    ].contains(currentLocation);

    return Scaffold(
      body: Stack(
        children: [
          navigationShell,
          if (shouldShowBottomNavBar)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavBar(), // Your custom BottomNavBar
            ),
        ],
      ),
    );
  }
}
