import 'package:flutter/material.dart';
import 'package:grocery_app/screens/product_details/product_details.dart';
import 'package:provider/provider.dart';

import '../../../../components/custom_text.dart';
import '../../../../models/objects.dart';
import '../../../../provider/order/order_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/util_function.dart';

class OrderTile extends StatefulWidget {
  const OrderTile({
    super.key,
    required this.index,
    required this.model,
  });

  final int index;
  final OrderModel model;

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //----------navigate to product details screen
        UtilFunctions.navigateTo(context, const ProductDetails());
      },
      child: Container(
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
                    widget.model.items.first.model.image,
                    width: 70,
                    height: 70,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Order No ${widget.index}',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text:
                          "${widget.model.items.first.model.productName} x ${widget.model.items.first.model.price}",
                      fontSize: 15,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      AlertDialog alert = AlertDialog(
                        title: const Text("Do you need an urgent order?"),
                        actions: [
                          ElevatedButton(
                            onPressed: (() => Provider.of<OrderProvider>(
                                    context,
                                    listen: false)
                                .updateOrder(widget.model.id, context, widget.model.userModel.uid)),
                            child: const Text("Urgent Order"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                        ],
                      );

                      // show the dialog
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          });
                    },
                    child: CustomText(
                      text: widget.model.orderState,
                      color: AppColors.kWhite,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomText(
                  text: 'Total Rs.${widget.model.total}0',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                InkWell(
                  onTap: () => Provider.of<OrderProvider>(context,
                          listen: false)
                      .removeOrder(
                          widget.model.id, context, widget.model.userModel.uid),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.kRed,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
