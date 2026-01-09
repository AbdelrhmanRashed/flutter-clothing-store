import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/core/resources/app_icons.dart';
import 'package:final_project/core/resources/app_images.dart';
import 'package:final_project/core/resources/app_loader.dart';
import 'package:final_project/features/home/cubit/categories/categories_cubit.dart';
import 'package:final_project/features/home/cubit/products_cubit/products_cubit.dart';
import 'package:final_project/features/home/widgets/card.dart';
import 'package:final_project/features/home/widgets/carousel.dart';
import 'package:final_project/features/products/products_screen.dart';
import 'package:final_project/widgets/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  final List<String> images = [
    AppImages.shape3,
    AppImages.shape2,
    AppImages.shape1,
  ];
  final List<String> titles = ["Watch", "Nike Shoes", "LG TV"];
  final List<String> prices = ["40", "430", "330"];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesCubit>(
          create: (context) => CategoriesCubit()..getCategories(),
        ),
        BlocProvider<ProductsCubit>(
          create: (context) => ProductsCubit()..getProducts(limit: 12),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey,
                        ),
                        child: Image.asset(AppImages.userImage),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello!",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            "John William",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        alignment: AlignmentDirectional.center,
                        width: 48,
                        height: 48,
                        padding: EdgeInsetsGeometry.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xffF8F7F7),
                        ),
                        child: SvgPicture.asset(AppIcons.notification),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF8F7F7),

                      prefixIcon: Container(
                        width: 24,
                        height: 24,
                        padding: EdgeInsets.all(14),
                        child: SvgPicture.asset(AppIcons.search),
                      ),

                      hintText: "Search Here",
                      hintStyle: TextStyle(color: AppColors.hintColor),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: AppColors.mainColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Carousel(count: 4),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    child: BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, state) {
                        if (state is CategoriesLoading) {
                          return AppLoader();
                        }
                        if (state is CategoriesSuccess) {
                          return CategoriesTabs(
                            categories: state.categoriesList,
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Featured",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductsScreen(category: "beauty"),
                            ),
                          );
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 152,
                    child: BlocBuilder<ProductsCubit, ProductsState>(
                      builder: (context, state) {
                        print(state);
                        if (state is ProductsLoading) {
                          return AppLoader();
                        }
                        if (state is ProductsSuccess) {
                          return ListView.separated(
                            itemBuilder: (context, index) => CustomCard(
                              image: state.productsList[index].thumbnail,
                              title: state.productsList[index].title,
                              price: state.productsList[index].price.toString(),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 16),
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Most Popular",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductsScreen(category: "fragrances"),
                            ),
                          );
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 152,
                    child: BlocBuilder<ProductsCubit, ProductsState>(
                      builder: (context, state) {
                        print(state);
                        if (state is ProductsLoading) {
                          return AppLoader();
                        }
                        if (state is ProductsSuccess) {
                          return ListView.separated(
                            itemBuilder: (context, index) => CustomCard(
                              image: state.productsList[index + 6].thumbnail,
                              title: state.productsList[index + 6].title,
                              price: state.productsList[index + 6].price
                                  .toString(),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 16),
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
