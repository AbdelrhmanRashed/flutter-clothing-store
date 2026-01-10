import 'package:flutter/material.dart';

class Stock extends StatelessWidget {
  final String text;
  const Stock({super.key, required this.text});


  @override
  Widget build(BuildContext context) {
    Color stockColor = text == "In Stock"
        ? Color(0xff3D9264)
        : text == "Low Stock"
        ? Color(0xFFF59E0B)
        : Color(0xFFB91C1C);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: stockColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
