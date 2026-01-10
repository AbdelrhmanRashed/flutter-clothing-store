import 'package:final_project/core/network/dio_helper.dart';
import 'package:final_project/features/Rating/rating_screen.dart';
import 'package:final_project/features/auth/login/view/login_screen.dart';
import 'package:final_project/features/details/details_screen.dart';
import 'package:final_project/features/home_navigation/view.dart';
import 'package:final_project/features/products/products_screen.dart';
import 'package:final_project/features/search/search_screen.dart';
import 'package:final_project/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  DioHelper.initDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: "Poppins"),
      home: HomeNav(),
    );
  }
}
