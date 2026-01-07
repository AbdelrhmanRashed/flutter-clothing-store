import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';


class SnackBarHelper {
  static void show({
    required BuildContext context,
    required String message,
    required AnimatedSnackBarType type,
  }) {
    AnimatedSnackBar.material(
      message,
      duration: Duration(seconds: 3),
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      type: type,
    ).show(context);
  }
}