import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/features/categories/cubit/categories_cubit.dart';
import 'package:final_project/features/categories/widgets/category_item.dart';
import 'package:final_project/features/products/products_screen.dart';
import 'package:final_project/features/products/widgets/products_grid_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {

  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit()..getCategories(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Categories",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.secondColor,
            ),
          ),
        ),
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoading) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ProductsGridShimmer(),
              );
            }

            if (state is CategoriesSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.categories.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(

                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductsScreen(
                                    category: state.categories[index].name),
                          ),
                        );
                      },
                      child: CategoryItem(category: state.categories[index]),
                    );
                  },
                ),
              );
            }


            return SizedBox();
          },
        ),
      ),
    );
  }
}

