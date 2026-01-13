import 'package:Store/core/resources/app_json.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(AppJson.loader));
  }
}
