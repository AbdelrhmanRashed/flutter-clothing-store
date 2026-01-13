import 'package:Store/core/resources/app_colors.dart';
import 'package:Store/core/resources/app_icons.dart';
import 'package:Store/core/resources/app_images.dart';
import 'package:Store/core/resources/app_loader.dart';
import 'package:Store/features/categories/categories_screen.dart';
import 'package:Store/features/details/details_screen.dart';
import 'package:Store/features/categories/cubit/categories_cubit.dart';
import 'package:Store/features/home/widgets/card.dart';
import 'package:Store/features/home/widgets/carousel.dart';
import 'package:Store/features/home/widgets/products_shimmer.dart';
import 'package:Store/features/home/widgets/section_title.dart';
import 'package:Store/features/home/widgets/user_header_shimmer.dart';
import 'package:Store/features/products/cubit/products_cubit.dart';
import 'package:Store/features/products/products_screen.dart';
import 'package:Store/features/search/search_screen.dart';
import 'package:Store/widgets/banner.dart';
import 'package:Store/features/categories/widgets/categories_tabs.dart';
import 'package:Store/widgets/search_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../auth/auth_cubit/auth_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> banners = [
    CustomBanner(),
    CustomBanner(),
    CustomBanner(),
    CustomBanner(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CategoriesCubit()..getCategories()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthUserLoading) {
                        return UserHeaderShimmer();
                      }
                      if (state is AuthUserLoaded) {
                        return Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey,
                              ),
                              child: Image.network(state.user?.image ?? ""),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Hello!",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "${state.user?.firstName} ${state.user?.lastName}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              width: 48,
                              height: 48,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xffF8F7F7),
                              ),
                              child: SvgPicture.asset(AppIcons.notification),
                            ),
                          ],
                        );
                      }
                      return Row(
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
                              const Text(
                                "Hello!",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "user",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            width: 48,
                            height: 48,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xffF8F7F7),
                            ),
                            child: SvgPicture.asset(AppIcons.notification),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  SearchFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchScreen(query: value),
                          ),
                        );
                      }
                    },
                    autofocus: false,
                  ),
                  const SizedBox(height: 22),
                  Carousel(items: banners, ratio: 2.2, count: 4),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CategoriesScreen(),
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
                    height: 160,
                    child: BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, state) {
                        if (state is CategoriesLoading) {
                          return ProductsShimmer();
                        }
                        if (state is CategoriesSuccess) {
                          return CategoriesTabs(categories: state.categories);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SectionTitle(
                    title: "Featured",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductsScreen(category: "mens-watches"),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  BlocProvider(
                    create: (_) =>
                        ProductsCubit()..getProducts(category: "mens-watches"),
                    child: SizedBox(
                      height: 152,
                      child: BlocBuilder<ProductsCubit, ProductsState>(
                        builder: (context, state) {
                          if (state is ProductsLoading) {
                            return const ProductsShimmer();
                          }
                          if (state is ProductsSuccess) {
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.productsList.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        id: state.productsList[index].id,
                                      ),
                                    ),
                                  );
                                },
                                child: CustomCard(
                                  image: state.productsList[index].thumbnail,
                                  title: state.productsList[index].title,
                                  price: state.productsList[index].price
                                      .toString(),
                                ),
                              ),
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 16),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SectionTitle(
                    title: "Most Popular",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductsScreen(category: "fragrances"),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  BlocProvider(
                    create: (_) =>
                        ProductsCubit()..getProducts(category: "fragrances"),
                    child: SizedBox(
                      height: 152,
                      child: BlocBuilder<ProductsCubit, ProductsState>(
                        builder: (context, state) {
                          if (state is ProductsLoading) {
                            return const ProductsShimmer();
                          }
                          if (state is ProductsSuccess) {
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.productsList.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        id: state.productsList[index].id,
                                      ),
                                    ),
                                  );
                                },
                                child: CustomCard(
                                  image: state.productsList[index].thumbnail,
                                  title: state.productsList[index].title,
                                  price: state.productsList[index].price
                                      .toString(),
                                ),
                              ),
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 16),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
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
