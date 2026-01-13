import 'package:Store/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterWidget({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildButton(Icons.remove, onDecrement),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        buildButton(Icons.add, onIncrement),
      ],
    );
  }

  Widget buildButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 16, color: AppColors.secondColor),
      ),
    );
  }
}
