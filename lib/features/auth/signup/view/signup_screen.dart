import 'package:final_project/core/helper/validators.dart';
import 'package:final_project/core/resources/app_button.dart';
import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/features/auth/login/view/login_screen.dart';
import 'package:final_project/features/auth/widgets/app_field.dart';
import 'package:final_project/features/auth/widgets/custom_password_field.dart';
import 'package:final_project/widgets/banner.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(34.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomBanner(),
                const SizedBox(height: 32),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppField(
                        hint: "user@gmail.com",
                        label: "Email",
                        validator: Validators.email,
                        controller: emailController,
                      ),
                      const SizedBox(height: 16),
                      CustomPasswordField(
                        hint: "**********",
                        label: "Password",
                        validator: Validators.password,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 16),
                      CustomPasswordField(
                        hint: "***********",
                        label: "Confirm Password",
                        controller: confirmPasswordController,

                        validator: (value) {
                          return Validators.confirmPassword(
                            value,
                            passwordController.text,
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                AppButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  },
                  color: AppColors.mainColor,
                  child: Text(
                    "Create Account",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.hintColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.secondColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.secondColor,
                          decorationThickness: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
