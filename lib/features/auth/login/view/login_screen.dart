import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:final_project/core/helper/snack_bar_helper.dart';
import 'package:final_project/core/helper/validators.dart';
import 'package:final_project/core/resources/app_button.dart';
import 'package:final_project/core/resources/app_colors.dart';
import 'package:final_project/core/resources/app_loader.dart';
import 'package:final_project/features/auth/login/cubit/login_cubit.dart';
import 'package:final_project/features/auth/signup/view/signup_screen.dart';
import 'package:final_project/features/auth/widgets/app_field.dart';
import 'package:final_project/features/auth/widgets/custom_check_box.dart';
import 'package:final_project/features/auth/widgets/custom_password_field.dart';
import 'package:final_project/features/home_navigation/view.dart';
import 'package:final_project/widgets/banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController checkController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is LoginFailure) {
              SnackBarHelper.show(
                context: context,
                message: state.errMsg,
                type: AnimatedSnackBarType.error,
              );
            }
            if (state is LoginSuccess) {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => HomeNav()));

              SnackBarHelper.show(
                context: context,
                message: "Logged in successfully",
                type: AnimatedSnackBarType.success,
              );

            }
          },
          builder: (context, state) {
            final cubit = context.read<LoginCubit>();

            if (state is LoginLoading) {
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
                              controller: userNameController,
                              hint: "Username",
                              label: "Username",
                              validator: Validators.username,
                            ),
                            const SizedBox(height: 22),
                            CustomPasswordField(
                              controller: passwordController,
                              hint: "Enter your password",
                              label: "Password",
                              validator: Validators.password,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomCheckBox(
                                value: cubit.rememberMe,
                                onChanged: cubit.toggleRememberMe,
                              ),

                              Text(
                                "Remember me",
                                style: TextStyle(
                                  color: AppColors.secondColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Forget password?",
                            style: TextStyle(
                              color: AppColors.secondColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.secondColor,
                              decorationThickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      AppButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.login(
                              username: userNameController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                          }
                        },
                        color: AppColors.mainColor,
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.hintColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up",
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
