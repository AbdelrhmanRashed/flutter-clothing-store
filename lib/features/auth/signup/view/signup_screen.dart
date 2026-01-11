import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:final_project/core/helper/snack_bar_helper.dart';
import 'package:final_project/core/helper/validators.dart';
import 'package:final_project/core/resources/app_button.dart';
import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/core/resources/app_loader.dart';
import 'package:final_project/features/auth/login/view/login_screen.dart';
import 'package:final_project/features/auth/signup/cubit/signup_cubit.dart';
import 'package:final_project/features/auth/widgets/app_field.dart';
import 'package:final_project/features/auth/widgets/custom_password_field.dart';
import 'package:final_project/features/home_navigation/view.dart';
import 'package:final_project/widgets/banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is SignupFailure) {
              SnackBarHelper.show(
                context: context,
                message: state.errMsg,
                type: AnimatedSnackBarType.error,
              );
            }

            if (state is SignupSuccess) {

              SnackBarHelper.show(
                context: context,
                message: "Sign Up Successfully",
                type: AnimatedSnackBarType.success,
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomeNav()),
                    (route) => false,
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<SignupCubit>();

            if (state is SignupLoading) {
              return AppLoader();
            }

            return SafeArea(
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
                              hint: "Username",
                              label: "UserName",
                              validator: Validators.username,
                              controller: userNameController,
                            ),
                            const SizedBox(height: 12),
                            AppField(
                              hint: "First Name",
                              label: "First Name",
                              validator: Validators.firstName,
                              controller: firstNameController,
                            ),
                            const SizedBox(height: 12),
                            AppField(
                              hint: "Last Name",
                              label: "Last Name",
                              validator: Validators.lastName,
                              controller: lastNameController,
                            ),
                            const SizedBox(height: 12),
                            CustomPasswordField(
                              hint: "**********",
                              label: "Password",
                              validator: Validators.password,
                              controller: passwordController,
                            ),
                            const SizedBox(height: 12),
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
                            cubit.signUp(
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              username: userNameController.text.trim(),
                              password: passwordController.text.trim(),
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
            );
          },
        ),
      ),
    );
  }
}
