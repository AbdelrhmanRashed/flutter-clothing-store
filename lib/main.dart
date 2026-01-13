import 'package:Store/core/network/dio_helper.dart';
import 'package:Store/features/auth/login/view/login_screen.dart';
import 'package:Store/features/cart/cubit/cart_cubit.dart';
import 'package:Store/features/home/home_screen.dart';
import 'package:Store/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  DioHelper.initDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(fontFamily: "Poppins"),
        home: SplashScreen(),
      ),
    );
  }
}
