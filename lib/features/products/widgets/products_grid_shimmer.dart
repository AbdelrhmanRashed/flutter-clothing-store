import 'package:Store/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductsGridShimmer extends StatelessWidget {
  const ProductsGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: AppColors.shimmerColor,
          highlightColor: AppColors.highLightColor,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // image
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // title
                Container(
                  height: 12,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 6),

                // price
                Container(height: 12, width: 60, color: Colors.white),
              ],
            ),
          ),
        );
      },
    );
  }
}
