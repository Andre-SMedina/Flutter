import 'package:flutter/material.dart';

class BoxCard extends StatelessWidget {
  final Widget boxContent;
  const BoxCard({super.key, required this.boxContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[3],
        borderRadius: BorderRadius.circular(10),
        // color: Theme.of(context).cardColor,
        color: Colors.white24,
      ),
      padding: const EdgeInsets.all(16),
      child: boxContent,
    );
  }
}
