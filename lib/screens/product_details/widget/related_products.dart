import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_text.dart';
import '../../../models/objects.dart';
import '../../../provider/cart/cart_provider.dart';
import '../../../provider/product/product_provider.dart';
import '../../../utils/app_colors.dart';

class RelatedProductTile extends StatelessWidget {
  const RelatedProductTile({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //---set the selected product model before navigating to the product details screen
        Provider.of<ProductProvider>(context, listen: false)
            .setProduct(productModel);

        //------clear the product counter before go to the details screen
        Provider.of<CartProvider>(context, listen: false).clearCounter();
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: NetworkImage(
              productModel.image,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 24.0,
              padding: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: AppColors.kWhite.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40,
                    child: CustomText(
                      text: productModel.productName,
                      fontSize: 11,
                      // color: AppColors.kWhite,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CustomText(
                    text: "Rs.${productModel.price}0",
                    fontSize: 10,
                    color: AppColors.kBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
