import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:final_project/core/helper/snack_bar_helper.dart';
import 'package:final_project/core/resources/app_button.dart';
import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/core/resources/app_icons.dart';
import 'package:final_project/core/resources/app_images.dart';
import 'package:final_project/features/Rating/rating_screen.dart';
import 'package:final_project/features/details/cubit/details_cubit.dart';
import 'package:final_project/features/details/widgets/circle_icon.dart';
import 'package:final_project/features/details/widgets/details_shimmer.dart';
import 'package:final_project/features/details/widgets/stock.dart';
import 'package:final_project/features/details/widgets/products_carousal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatelessWidget {
  final int id;

  final List<String> images = [
    AppImages.shape2,
    AppImages.shape1,
    AppImages.shape3,
  ];

  DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit()..getProductDetails(id: id),
      child: Scaffold(
        backgroundColor: Colors.white,

        body: SingleChildScrollView(
          child: BlocConsumer<DetailsCubit, DetailsState>(
            listener: (context, state) {
              print("===========$state==========");
              if (state is DetailsFailure) {
                SnackBarHelper.show(
                  context: context,
                  message: state.errMsg,
                  type: AnimatedSnackBarType.error,
                );
              }
            },
            builder: (context, state) {
              if (state is DetailsLoading) {
                return DetailsShimmer();
              }
              if (state is DetailsSuccess) {
                final double priceBeforeDiscount =
                    state.productDetails.price /
                    (1 - state.productDetails.discountPercentage / 100);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFF9FAFB), Color(0xFFF3F4F6)],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ProductsCarousal(
                            imageUrls: state.productDetails.images,
                            autoPlay: state.productDetails.images.length > 1,
                            ratio: 1.1,
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 16,
                          child: CircleIcon(
                            icon: AppIcons.arrowBack,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Positioned(
                          top: 40,
                          right: 16,
                          child: CircleIcon(
                            icon: AppIcons.heartFill,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  state.productDetails.title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                "\$${priceBeforeDiscount.toStringAsFixed(2)}",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: AppColors.hintColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.hintColor,
                                  decorationThickness: 1.3,
                                  decorationStyle: TextDecorationStyle.solid
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => RatingScreen(
                                        reviews: state.productDetails.reviews,
                                        rating : state.productDetails.rating
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AppIcons.star),
                                    const SizedBox(width: 6),
                                    Text(
                                      state.productDetails.rating.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "(${state.productDetails.reviews.length} Reviews)",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff7D7A7A),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 12,
                                      color: Color(0xff7D7A7A),
                                    ),
                                  ],
                                ),
                              ),

                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF26682),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      "${state.productDetails.discountPercentage}%",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "\$${state.productDetails.price}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          Stock(text: state.productDetails.availabilityStatus),
                          const SizedBox(height: 15),
                          Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            maxLines: 4,
                            state.productDetails.description,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff9B9999),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Stock",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),

                          Container(
                            width: 44,
                            height: 44,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFCFCDCD),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              state.productDetails.stock.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        ),

        bottomNavigationBar: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            if (state is DetailsSuccess) {
              final priceAfter = state.productDetails.price;
              final discount = state.productDetails.discountPercentage;
              final double priceBefore = priceAfter / (1 - discount / 100);

              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _price(
                      discount: discount,
                      priceBefore: priceBefore,
                      priceAfter: priceAfter,
                    ),
                    const SizedBox(height: 16),
                    _actionButtons(
                      availabilityStatus:
                          state.productDetails.availabilityStatus,
                    ),
                  ],
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

Widget _price({
  required double discount,
  required double priceBefore,
  required double priceAfter,
}) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xffF26682),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          "$discount% OFF",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        "\$$priceAfter",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(width: 8),
      Text(
        "\$${priceBefore.toStringAsFixed(2)}",

        style: const TextStyle(
          decoration: TextDecoration.lineThrough,
          decorationColor: AppColors.hintColor,
          color: AppColors.hintColor,
        ),
      ),
    ],
  );
}

Widget _actionButtons({required String availabilityStatus}) {
  return SizedBox(
    height: 56,
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: AppButton(
            onPressed: availabilityStatus == "Out of Stock" ? null : () {},
            color: availabilityStatus != "Out of Stock"
                ? AppColors.mainColor
                : Colors.grey.shade400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (availabilityStatus != "Out of Stock")
                  SvgPicture.asset(AppIcons.bag, color: Colors.white),
                if (availabilityStatus != "Out of Stock")
                  const SizedBox(width: 8),
                Text(
                  availabilityStatus == "Out of Stock"
                      ? "OUT OF STOCK"
                      : "Buy Now",
                  style: TextStyle(
                    color: availabilityStatus != "Out of Stock"
                        ? Colors.white
                        : Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: AppButton(
            onPressed: () {},
            color: const Color(0xffFAFAFA),
            child: SvgPicture.asset(AppIcons.cart),
          ),
        ),
      ],
    ),
  );
}
