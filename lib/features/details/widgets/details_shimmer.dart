import 'package:Store/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailsShimmer extends StatelessWidget {
  const DetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image
        Shimmer.fromColors(
          baseColor: AppColors.shimmerColor,
          highlightColor: AppColors.highLightColor,
          child: Container(
            height: 350,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Title
        Shimmer.fromColors(
          baseColor: AppColors.shimmerColor,
          highlightColor: AppColors.highLightColor,
          child: Container(
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 8),

        // Price
        Shimmer.fromColors(
          baseColor: AppColors.shimmerColor,
          highlightColor: AppColors.highLightColor,
          child: Container(
            height: 16,
            width: 120,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
