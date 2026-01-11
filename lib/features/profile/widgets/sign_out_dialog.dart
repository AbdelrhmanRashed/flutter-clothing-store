import 'package:final_project/core/helper/cache_helper.dart';
import 'package:final_project/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

import '../../auth/login/view/login_screen.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xffFBCFCF),
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xffED1010), width: 5),
            ),
            child: Icon(Icons.priority_high, color: Colors.red, size: 30),
          ),
          SizedBox(height: 20),
          Text(
            "Logout?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Are you sure you want to logout?",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.hintColor, fontSize: 16),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                CacheHelper.deleteUser();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffED1010),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Yes, Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xffD7D7D7)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "No, Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.secondColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
