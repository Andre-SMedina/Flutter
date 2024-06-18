import 'package:flutter/material.dart';

class PackageDetailsNavigation extends StatelessWidget {
  final String name;
  const PackageDetailsNavigation({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Package Details Navigation'),
      ),
    );
  }
}
