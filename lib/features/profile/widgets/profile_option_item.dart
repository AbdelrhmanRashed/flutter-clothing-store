import 'package:Store/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileOptionItem extends StatelessWidget {
  final String icon;
  final String title;
  final GestureTapCallback? callback;

  const ProfileOptionItem({
    super.key,
    required this.icon,
    required this.title,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          icon,
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
        onTap: callback,
      ),
    );
  }
}
