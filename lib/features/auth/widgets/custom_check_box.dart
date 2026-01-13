import 'package:Store/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      checkColor: Colors.white,
      activeColor: AppColors.mainColor,
      side: BorderSide(color: AppColors.mainColor),
      onChanged: (val) => onChanged(val!),
    );
  }
}
