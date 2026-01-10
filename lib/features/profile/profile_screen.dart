import 'package:final_project/core/helper/cache_helper.dart';
import 'package:final_project/core/resources/app_icons.dart';
import 'package:final_project/core/resources/app_images.dart';
import 'package:final_project/features/auth/login/view/login_screen.dart';
import 'package:final_project/features/profile/widgets/Profile_option_item.dart';
import 'package:final_project/features/profile/widgets/sign_out_dialog.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: 99,
              height: 99,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey,
              ),
              child: Image.asset(AppImages.userImage),
            ),
            const SizedBox(height: 16),
            Text(
              "John William",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 28),
            ProfileOptionItem(icon: AppIcons.user, title: "Profile"),
            const SizedBox(height: 16),
            ProfileOptionItem(icon: AppIcons.setting, title: "Setting"),
            const SizedBox(height: 16),
            ProfileOptionItem(icon: AppIcons.contact, title: "Contact"),
            const SizedBox(height: 16),
            ProfileOptionItem(icon: AppIcons.share, title: "Share"),
            const SizedBox(height: 16),
            ProfileOptionItem(icon: AppIcons.help, title: "Help"),
            const SizedBox(height: 30),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const SignOutDialog(),
                );
              },
              splashColor: Colors.red.shade100,
              highlightColor: Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
