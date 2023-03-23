import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/back_btn.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text.dart';
import '../../../provider/cart/cart_provider.dart';
import '../../../provider/order/order_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';
import 'widget/card_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                BackBtn(),
                CustomText(
                  text: "Cart",
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 28),
                Icon(
                  Icons.abc,
                  color: AppColors.kWhite,
                )
              ],
            ),
            Expanded(
              child: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return value.cartItemList.isEmpty
                      ? const CustomText(text: "No Cart Items")
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            return CartCardTile(
                                model: value.cartItemList[index]);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 20,
                              ),
                          itemCount: value.cartItemList.length);
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 270,
        width: SizeConfig.getWidth(context),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        color: AppColors.kWhite,
        child: Consumer<CartProvider>(
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CartPriceRow(
                  text: 'Total Item Count',
                  amount: value.getCartTotalItemCount.toString(),
                ),
                const CartPriceRow(
                  text: 'Tax',
                  amount: 'Rs.0.00',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: 'Total',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: 'Rs.${value.getCartTotal}',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Place Order',
                  isLoading: Provider.of<OrderProvider>(context).loading,
                  onTap: () {
                    Provider.of<OrderProvider>(context, listen: false)
                        .createOrder(context);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CartPriceRow extends StatelessWidget {
  const CartPriceRow({super.key, required this.text, required this.amount});

  final String text;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: text,
            fontSize: 14,
          ),
          CustomText(
            text: 'Rs.$amount.00',
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
