import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/features/products/products_screen.dart';
import 'package:final_project/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xffF8F7F7),
      borderRadius: BorderRadius.circular(14),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.06),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ProductsScreen(category: category.name),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFEDEEEF), Color(0xFFDCDCDC)],
                ),
                image: category.image.isNotEmpty
                    ? DecorationImage(
                  image: NetworkImage(category.image),
                  fit: BoxFit.contain,
                )
                    : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                category.name.replaceAll('-', ' '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.secondColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
