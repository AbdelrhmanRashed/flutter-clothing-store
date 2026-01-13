import 'package:carousel_slider/carousel_slider.dart';
import 'package:Store/core/resources/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({
    super.key,
    required this.count,

    this.showIndicators = true,
    this.autoPlay = false,
    required this.ratio,
    required this.items,
  });
  final List<Widget> items;
  final bool showIndicators;
  final int count;
  final bool autoPlay;
  final double ratio;

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
              widget.items[itemIndex],

          options: CarouselOptions(
            autoPlay: widget.autoPlay,
            enlargeCenterPage: true,
            viewportFraction: 1,
            aspectRatio: widget.ratio,
            padEnds: false,
            initialPage: 0,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),

        if (widget.showIndicators) const SizedBox(height: 12),
        if (widget.showIndicators)
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
