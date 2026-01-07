import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/core/resources/app_icons.dart';
import 'package:final_project/core/resources/app_images.dart';
import 'package:final_project/features/home_navigation/screens/home/widgets/card.dart';
import 'package:final_project/features/home_navigation/screens/home/widgets/carousel.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
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
                      "Featured",
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
                  height: 152,
                  child: ListView.separated(
                    itemBuilder: (context, index) => CustomCard(
                      image: images[index],
                      title: titles[index],
                      price: prices[index],
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 16),
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
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
                  child: ListView.separated(
                    itemBuilder: (context, index) => CustomCard(
                      image: images[index],
                      title: titles[index],
                      price: prices[index],
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 16),
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
