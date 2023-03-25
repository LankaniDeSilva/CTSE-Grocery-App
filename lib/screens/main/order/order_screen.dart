import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_text.dart';
import '../../../provider/auth/user_provider.dart';
import '../../../provider/order/order_provider.dart';
import '../../../utils/app_colors.dart';
import 'widget/order_tile.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Consumer<UserProvider>(builder: (context, value, child) {
        return SafeArea(
          child: Column(
            children: [
              const Center(
                child: CustomText(
                  text: "Orders",
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Consumer<OrderProvider>(
                  builder: (context, value, child) {
                    return value.orders.isEmpty
                        ? const Center(child: CustomText(text: "No orders"))
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return OrderTile(
                                index: index + 1,
                                model: value.orders[index],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 20,
                            ),
                            itemCount: value.orders.length,
                          );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
