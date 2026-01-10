import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double rating;
  final double iconSize;

  const Rating({
    super.key,
    required this.rating,
    this.iconSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 32,
          ),
        ),

        const SizedBox(width: 10),

        Row(
          children: List.generate(5, (index) {
            IconData icon;

            if (index + 1 <= rating) {
              icon = Icons.star;
            } else if (index + 0.5 <= rating) {
              icon = Icons.star_half;
            } else {
              icon = Icons.star_border;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Icon(
                icon,
                color: Colors.amber,
                size: iconSize,
              ),
            );
          }),
        ),
      ],
    );
  }
}
