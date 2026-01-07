import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/features/auth/widgets/app_field.dart';
import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    super.key,
    required this.hint,
    this.suffixIcon,
    required this.label,
    this.controller,
    this.validator,
  });
  final String hint;
  final Widget? suffixIcon;
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return AppField(
      controller: widget.controller,
      hint: widget.hint,
      label: widget.label,
      obscureText: isHidden,
      validator: widget.validator,
      suffixIcon: IconButton(
        icon: Icon(
          color: AppColors.secondColor,
          isHidden
              ? Icons.visibility_off_outlined
              : Icons.remove_red_eye_outlined,
        ),
        onPressed: () {
          setState(() {
            isHidden = !isHidden;
          });
        },
      ),
    );
  }
}
