import 'package:flutter/material.dart';

class ProducerDetailsNavigation extends StatelessWidget {
  final String name;
  const ProducerDetailsNavigation({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Producer Details Navigation'),
      ),
    );
  }
}
