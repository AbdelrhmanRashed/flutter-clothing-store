import 'package:final_project/core/helper/cache_helper.dart';
import 'package:final_project/core/resources/app_json.dart';
import 'package:final_project/features/auth/login/view/login_screen.dart';
import 'package:final_project/features/home_navigation/view.dart';
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
    Future.delayed(Duration(seconds: 4), () async {
      CacheHelper.getToken().then((value) {
        // if (mounted) {
        //   if (value.isEmpty) {
        //     Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(builder: (context) => LoginScreen()),
        //     );
        //   } else {
        //     Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(builder: (context) => HomeNav()),
        //     );
        //   }

        Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeNav()));

      });
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
