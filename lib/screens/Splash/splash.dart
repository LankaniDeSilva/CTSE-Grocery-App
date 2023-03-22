import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/provider/auth/user_provider.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_constants.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).initializeUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
                child: Image.asset(
              AssetsConstants.logo,
              width: 300,
            )),
            const SizedBox(height: 30.0),
            FadeInUp(
              child: const CustomText(
                text: 'Shop Your Daily \nNecessary',
                textAlign: TextAlign.center,
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
