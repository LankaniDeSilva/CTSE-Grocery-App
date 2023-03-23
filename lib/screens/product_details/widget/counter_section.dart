import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_text.dart';
import '../../../provider/cart/cart_provider.dart';
import '../../../utils/app_colors.dart';

class CounterSection extends StatelessWidget {
  const CounterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.ashBorder,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Consumer<CartProvider>(
        builder: (context, value, child) {
          return Row(
            children: [
              InkWell(
                  onTap: () => value.increaseCounter(),
                  child: const Icon(Icons.add)),
              const SizedBox(width: 15),
              CustomText(
                text: value.counter.toString(),
                fontSize: 14,
              ),
              const SizedBox(width: 15),
              InkWell(
                  onTap: () => value.decreaseCounter(),
                  child: const Icon(Icons.remove)),
            ],
          );
        },
      ),
    );
  }
}