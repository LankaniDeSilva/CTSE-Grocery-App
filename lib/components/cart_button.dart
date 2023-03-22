import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'custom_text.dart';

class CartButtonWidget extends StatelessWidget {
  const CartButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 3),
      showBadge: true,
      badgeStyle: const badges.BadgeStyle(
        badgeColor: AppColors.lightGreen,
      ),
      badgeContent: const CustomText(
        text: "2",
        color: AppColors.kWhite,
      ),
      child: IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
    );
  }
}
