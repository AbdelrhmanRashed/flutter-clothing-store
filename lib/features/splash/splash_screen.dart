import 'package:Store/core/helper/cache_helper.dart';
import 'package:Store/core/resources/app_json.dart';
import 'package:Store/features/auth/login/view/login_screen.dart';
import 'package:Store/features/home_navigation/view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () async {
      final token = await CacheHelper.getToken();

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => token.isEmpty ? LoginScreen() : HomeNav(),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(child: Center(child: Lottie.asset(AppJson.shopping))),
    );
  }
}
