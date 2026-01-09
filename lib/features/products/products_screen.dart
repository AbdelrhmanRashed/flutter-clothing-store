import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:final_project/core/helper/snack_bar_helper.dart';
import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/core/resources/app_loader.dart';
import 'package:final_project/features/home/cubit/products_cubit/products_cubit.dart';
import 'package:final_project/features/products/cubit/products_category_cubit.dart';
import 'package:final_project/features/products/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  final String category;

  const ProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsCategoryCubit()..getProductsCategory(category: category),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            category,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.secondColor,
            ),
          ),
        ),
        body: BlocConsumer<ProductsCategoryCubit, ProductsCategoryState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is ProductsCategoryFailure) {
              SnackBarHelper.show(
                context: context,
                message: state.errMsg,
                type: AnimatedSnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            if (state is ProductsCategoryLoading) {
              return AppLoader();
            }
            if (state is ProductsCategorySuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  itemCount: state.productsList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      image: state.productsList[index].thumbnail,
                      title: state.productsList[index].title,
                      price: state.productsList[index].price.toString(),
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
