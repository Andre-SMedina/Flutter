import 'package:flutter/material.dart';

class Stars extends StatefulWidget {
  const Stars({super.key});

  @override
  State<Stars> createState() => _StarsState();
}

class _StarsState extends State<Stars> {
  bool star1 = false;
  bool star2 = true;
  bool star3 = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            visualDensity: VisualDensity.compact,
            iconSize: 15,
            onPressed: () {
              setState(() {
                if (star1) {
                  star1 = !star1;
                  star2 = true;
                  star3 = true;
                } else {
                  star2 = true;
                  star3 = true;
                }
              });
            },
            icon: (star1)
                ? const Icon(
                    Icons.star_border,
                  )
                : const Icon(
                    Icons.star,
                  )),
        IconButton(
            visualDensity: VisualDensity.compact,
            iconSize: 15,
            onPressed: () {
              setState(() {
                if (star2) {
                  star1 = false;
                  star2 = !star2;
                  star3 = true;
                } else {
                  star1 = false;
                  star3 = true;
                }
              });
            },
            icon: (star2)
                ? const Icon(
                    Icons.star_border,
                  )
                : const Icon(
                    Icons.star,
                  )),
        IconButton(
            visualDensity: VisualDensity.compact,
            iconSize: 15,
            onPressed: () {
              setState(() {
                if (star3) {
                  star1 = false;
                  star2 = false;
                  star3 = !star3;
                } else {
                  star1 = false;
                  star2 = false;
                }
              });
            },
            icon: (star3)
                ? const Icon(
                    Icons.star_border,
                  )
                : const Icon(
                    Icons.star,
                  )),
      ],
    );
  }
}
