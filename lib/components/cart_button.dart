import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:grocery_app/provider/cart/cart_provider.dart';
import 'package:grocery_app/screens/main/cart/cart_screen.dart';
import 'package:grocery_app/utils/util_function.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';
import 'custom_text.dart';

class CartButtonWidget extends StatelessWidget {
  const CartButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: ((context, value, child) {
      return badges.Badge(
        position: badges.BadgePosition.topEnd(top: 0, end: 3),
        showBadge: true,
        badgeStyle: const badges.BadgeStyle(
          badgeColor: AppColors.lightGreen,
        ),
        badgeContent: CustomText(
          text: value.getCartTotalItemCount.toString(),
          color: AppColors.kWhite,
        ),
        child: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              UtilFunctions.navigateTo(context, const CartScreen());
            }),
      );
    }));
  }
}
