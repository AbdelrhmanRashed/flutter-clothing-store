import 'package:final_project/features/categories/widgets/category_item.dart';
import 'package:final_project/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoriesTabs extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategoriesTabs({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,

      itemBuilder: (context, index) =>
          SizedBox(width: 120,child: CategoryItem(category: categories[index])),
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      itemCount: 4,
    );
  }
}
