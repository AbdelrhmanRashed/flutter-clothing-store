import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/features/products/products_screen.dart';
import 'package:flutter/material.dart';

class CategoriesTabs extends StatefulWidget {
  final List<String> categories;

  const CategoriesTabs({super.key, required this.categories});

  @override
  State<CategoriesTabs> createState() => _CategoriesTabsState();
}

class _CategoriesTabsState extends State<CategoriesTabs> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final categories = ['All', ...widget.categories];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          final isSelected = selectedIndex == index;

          return ChoiceChip(
            label: Text(categories[index]),
            selected: isSelected,
            showCheckmark: false,
            onSelected: (_) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ProductsScreen(category: categories[index]),
                ),
              );
              setState(() {
                selectedIndex = index;
              });
            },
            selectedColor: AppColors.mainColor,
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : AppColors.secondColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          );
        },
      ),
    );
  }
}
