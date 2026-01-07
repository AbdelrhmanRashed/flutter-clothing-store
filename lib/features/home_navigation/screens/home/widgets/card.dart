import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/core/resources/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;

  const CustomCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 126,
      decoration: BoxDecoration(
        color: Color(0xffF8F7F7),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Image.asset(image, fit: BoxFit.contain, width: 126),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColors.secondColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "\$$price",
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            ],

          ),
          Positioned(
            top: 8,
            right: 8,
            child: HeartIcon()
          ),
        ],
      ),
    );
  }
}

class HeartIcon extends StatefulWidget {
  const HeartIcon({super.key});

  @override
  State<HeartIcon> createState() => _HeartIconState();
}

class _HeartIconState extends State<HeartIcon> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      child: isFavorite
          ? SvgPicture.asset(AppIcons.heartFill)
          : SvgPicture.asset(AppIcons.heart),
    );
  }
}
