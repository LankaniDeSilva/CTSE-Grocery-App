import 'package:flutter/material.dart';
import 'package:grocery_app/provider/auth/login_provider.dart';
import 'package:grocery_app/screens/auth/signup_screen.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/custom_textfield.dart';
import '../../provider/auth/auth_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_constants.dart';
import '../../utils/util_function.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          width: size.width,
          child: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 52.0),
                  const CustomText(
                    text: "Login",
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 41),
                  Image.asset(
                    AssetsConstants.logo,
                    width: 202.26,
                    height: 138.0,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextField(
                    hintText: "Email",
                    controller:
                        Provider.of<LoginProvider>(context).emailController,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    isObscure: true,
                    hintText: "Password",
                    controller:
                        Provider.of<LoginProvider>(context).passwordController,
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => UtilFunctions.navigateTo(
                          context, const SignupScreen()),
                      child: const CustomText(
                        text: "Do not have an account?",
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  CustomButton(
                    onTap: () {
                      Provider.of<LoginProvider>(context, listen: false)
                          .startLogin(context);
                    },
                    text: 'Login',
                  ),
                  const SizedBox(height: 18),
                  const CustomText(
                    text: "or",
                    fontSize: 14,
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .googleAuth();
                    },
                    text: 'Signin with google',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
