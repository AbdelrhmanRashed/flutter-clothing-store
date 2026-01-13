import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:Store/core/helper/snack_bar_helper.dart';
import 'package:Store/core/resources/app_colors.dart';
import 'package:Store/core/resources/app_loader.dart';
import 'package:Store/features/details/details_screen.dart';
import 'package:Store/features/products/cubit/products_cubit.dart';
import 'package:Store/features/products/widgets/card.dart';
import 'package:Store/features/products/widgets/products_grid_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  final String category;

  const ProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit()..getProducts(category: category),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            category.replaceAll("-", " "),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.secondColor,
            ),
          ),
        ),
        body: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is ProductsFailure) {
              SnackBarHelper.show(
                context: context,
                message: state.errMsg,
                type: AnimatedSnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            if (state is ProductsLoading) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: const ProductsGridShimmer(),
              );
            }
            if (state is ProductsSuccess) {
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(id: state.productsList[index].id),
                          ),
                        );
                      },
                      child: ProductCard(
                        image: state.productsList[index].thumbnail,
                        title: state.productsList[index].title,
                        price: state.productsList[index].price.toString(),
                      ),
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
