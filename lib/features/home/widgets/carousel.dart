import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/widgets/banner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key, required this.count});
  final int count;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.count,
          itemBuilder: (context, itemIndex, pageViewIndex) =>
           CustomBanner(),

          options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 1,
            aspectRatio: 2.2,
            initialPage: 0,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),

        const SizedBox(height: 12),

        AnimatedSmoothIndicator(
          activeIndex: currentIndex,
          count: widget.count,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: AppColors.mainColor,
          ),
        ),
      ],
    );
  }
}
