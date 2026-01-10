import 'package:final_project/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserHeaderShimmer extends StatelessWidget {
  const UserHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerColor,
      highlightColor: AppColors.highLightColor,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 10,
                color: Colors.white,
              ),
              const SizedBox(height: 6),
              Container(
                width: 80,
                height: 12,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
