import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:final_project/core/helper/snack_bar_helper.dart';
import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/core/resources/app_icons.dart';
import 'package:final_project/core/resources/app_json.dart';
import 'package:final_project/core/resources/app_loader.dart';
import 'package:final_project/features/products/widgets/card.dart';
import 'package:final_project/features/products/widgets/products_grid_shimmer.dart';
import 'package:final_project/features/search/cubit/search_cubit.dart';
import 'package:final_project/widgets/search_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../details/details_screen.dart';

class SearchScreen extends StatelessWidget {
  final String query;
  final bool isFromBottomNav;

  const SearchScreen({
    super.key,
    required this.query,
    this.isFromBottomNav = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..getSearchResults(query: query),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (!isFromBottomNav)
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: SvgPicture.asset(AppIcons.arrowBack),
                          ),
                        if (!isFromBottomNav) const SizedBox(width: 12),
                        Expanded(
                          child: SearchFormField(
                            autofocus: true,
                            initialValue: query,
                            onChanged: (value) => context
                                .read<SearchCubit>()
                                .getSearchResults(query: value),
                          ),
                        ),
                      ],
                    ),

                    BlocConsumer<SearchCubit, SearchState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is SearchFailure) {
                          SnackBarHelper.show(
                            context: context,
                            message: state.errMsg,
                            type: AnimatedSnackBarType.error,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is SearchEmpty) {
                          return Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(AppJson.emptySearch, width: 300),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "No Results Found",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        if (state is SearchLoading) {
                          return Expanded(child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: ProductsGridShimmer(),
                          ));
                        }
                        if (state is SearchSuccess) {
                          return Expanded(
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Results for ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff817F7F),
                                          ),
                                        ),
                                        Text(
                                          "“ ${context.watch<SearchCubit>().currentQuery} “",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${state.productsList.length} Results Found',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: GridView.builder(
                                    itemCount: state.productsList.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
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
                                                  DetailsScreen(
                                                    id: state
                                                        .productsList[index]
                                                        .id,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: ProductCard(
                                          image: state
                                              .productsList[index]
                                              .thumbnail,
                                          title:
                                              state.productsList[index].title,
                                          price: state.productsList[index].price
                                              .toString(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
