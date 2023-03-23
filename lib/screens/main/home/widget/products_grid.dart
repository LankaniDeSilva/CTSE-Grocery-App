import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/utils/assets_constants.dart';
import 'package:grocery_app/utils/util_function.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../components/custom_text.dart';
import '../../../../models/objects.dart';
import '../../../../provider/cart/cart_provider.dart';
import '../../../../provider/product/product_provider.dart';
import '../../../product_details/product_details.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ProductProvider>(
        builder: (context, value, child) {
          return value.loading
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  itemCount: value.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 44.0,
                    crossAxisSpacing: 19.0,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return ProductTile(
                      productModel: value.products[index],
                    );
                  });
        },
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //---set the selected product model before navigating to the product details screen
        Provider.of<ProductProvider>(context, listen: false)
            .setProduct(productModel);

        // //------clear the product counter before go to the details screen
        Provider.of<CartProvider>(context, listen: false).clearCounter();

        //----------navigate to product details screen
        UtilFunctions.navigateTo(context, const ProductDetails());
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: NetworkImage(
              productModel.image,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<ProductProvider>(
              builder: (context, value, child) {
                return InkWell(
                  onTap: () {
                    value.initAddtoFavourite(productModel, context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 8.0, right: 8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: value.favproducts.contains(productModel)
                          ? AppColors.kRed
                          : AppColors.kWhite,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(AssetsConstants.favouriteIcon),
                  ),
                );
              },
            ),
            Container(
              height: 38.0,
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              decoration: BoxDecoration(
                color: AppColors.lightGreen.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: productModel.productName,
                    fontSize: 15,
                    color: AppColors.kWhite,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: "Rs.${productModel.price}",
                    fontSize: 15,
                    color: AppColors.kBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
