
import 'package:final_project/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCounterButton(
          icon: Icons.remove,
          onTap: () {
            if (itemCount > 1) setState(() => itemCount--);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "$itemCount",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.secondColor,
            ),
          ),
        ),
        _buildCounterButton(
          icon: Icons.add,
          onTap: () => setState(() => itemCount++),
        ),
      ],
    );
  }

  Widget _buildCounterButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFE6E6E6)),
        ),
        child: Icon(
          icon,
          size: 18,
          color: AppColors.secondColor,
        ),
      ),
    );
  }
}