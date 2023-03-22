import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/screens/main/home/widget/products_grid.dart';
import 'package:grocery_app/services/auth_services.dart';
import 'package:grocery_app/utils/assets_constants.dart';

import '../../../components/cart_button.dart';
import '../../../components/custom_text.dart';
import '../../../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(AssetsConstants.menuIcon),
                  Row(
                    children: [
                      const CartButtonWidget(),
                      IconButton(onPressed: (){
                        AuthenticationService().signoutUser();
                      }, icon: const Icon(Icons.logout))
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const CustomText(
                text: "OnlinePola",
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              const SizedBox(height: 41.0),
              const ProductGrid()
            ],
          ),
        ),
      ),
    );
  }
}
