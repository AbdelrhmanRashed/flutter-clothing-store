import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class ProductsCarousal extends StatefulWidget {
  const ProductsCarousal({
    super.key,
    required this.imageUrls,
    this.autoPlay = false,
    required this.ratio,

  });

  final List<String> imageUrls;
  final bool autoPlay;
  final double ratio;

  @override
  State<ProductsCarousal> createState() => _ProductsCarousalState();
}

class _ProductsCarousalState extends State<ProductsCarousal> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: widget.imageUrls.length,

          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(widget.imageUrls[index], fit: BoxFit.cover),
            );
          },
          options: CarouselOptions(
            autoPlay: widget.autoPlay,
            viewportFraction: 1,
            enlargeCenterPage: false,
            aspectRatio: widget.ratio,
            padEnds: false,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),

        Positioned(
          bottom: 12,
          child: AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            count: widget.imageUrls.length,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.grey,
              dotColor: Colors.black12,
            ),
          ),
        ),
      ],
    );
  }
}
