import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../components/custom_text.dart';
import '../../../../models/objects.dart';
import '../../../../provider/cart/cart_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/size_config.dart';

class CartCardTile extends StatefulWidget {
  const CartCardTile({super.key, required this.model});

  final CartItemModel model;

  @override
  State<CartCardTile> createState() => _CartCardTileState();
}

class _CartCardTileState extends State<CartCardTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      height: 90,
      padding: const EdgeInsets.all(10),
      width: SizeConfig.getWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.kWhite,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 20,
            color: AppColors.kAsh.withOpacity(0.4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.model.model.image,
                  width: 70,
                  height: 70,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: widget.model.model.productName,
                    fontSize: 14,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () =>
                              Provider.of<CartProvider>(context, listen: false)
                                  .increaseCartItemCount(widget.model.model),
                          child: const Icon(Icons.add)),
                      const SizedBox(width: 15),
                      CustomText(
                        text: widget.model.qty.toString(),
                        fontSize: 14,
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                          onTap: () =>
                              Provider.of<CartProvider>(context, listen: false)
                                  .decreaseCartItemCount(
                                      widget.model.model, context),
                          child: const Icon(Icons.remove)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => Provider.of<CartProvider>(context, listen: false)
                    .removeCartItem(widget.model.model.productId, context),
                child: const Icon(
                  Icons.close,
                  color: AppColors.kRed,
                ),
              ),
              CustomText(
                text: 'Rs.${widget.model.subTotal}0',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )
            ],
          )
        ],
      ),
    );
  }
}