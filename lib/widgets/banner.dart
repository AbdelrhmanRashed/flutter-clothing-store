import 'package:Store/core/resources/app_colors.dart';
import 'package:Store/core/resources/app_images.dart';
import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppColors.mainColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Get Winter Discount\n20% Off\nFor Children",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Image.asset(AppImages.cardImage, fit: BoxFit.fitHeight),
          ],
        ),
      ),
    );
  }
}
