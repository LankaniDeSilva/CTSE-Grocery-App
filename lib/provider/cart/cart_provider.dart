import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../models/objects.dart';

class CartProvider extends ChangeNotifier {
  //-------product counter section
  //------counter
  int _counter = 1;

  //-----get counter
  int get counter => _counter;

  //------increase counter
  void increaseCounter() {
    _counter++;
    notifyListeners();
  }

  //------decrease counter
  void decreaseCounter() {
    if (_counter != 1) {
      _counter--;
    }
    notifyListeners();
  }

  //------clear counter for one
  void clearCounter() {
    _counter = 1;
    notifyListeners();
  }

  //----add to cart
  //--------cart item list
  List<CartItemModel> _cartItemList = [];

  //--------get for cart list
  List<CartItemModel> get cartItemList => _cartItemList;

  //---------initaiate add to cart functionality
  void addToCart(ProductModel productModel, BuildContext context) {
    //--first check wheather adding item is already int the cart list
    if (_cartItemList
        .any((element) => element.cartId == productModel.productId)) {
      increaseCartItemCount(productModel);

      calSubtotal(productModel);

      //------show the snackbar
      AnimatedSnackBar.material(
        "Increase Product Amount",
        type: AnimatedSnackBarType.info,
      ).show(context);
    } else {
      //-if not existing adding into the cart
      _cartItemList.add(CartItemModel(
        cartId: productModel.productId,
        qty: _counter,
        subTotal: _counter * productModel.price,
        model: productModel,
      ));

      //-clear counter state after adding product to the cart
      clearCounter();
      //------show the snackbar
      AnimatedSnackBar.material(
        "Added to the cart",
        type: AnimatedSnackBarType.success,
      ).show(context);
    }

    Logger().w(cartItemList.length);

    notifyListeners();
  }

  //-cal subtotal
  void calSubtotal(ProductModel productModel) {
    _cartItemList
        .singleWhere((element) => element.cartId == productModel.productId)
        .subTotal = _cartItemList
            .singleWhere((element) => element.cartId == productModel.productId)
            .qty *
        productModel.price;

    notifyListeners();
  }

  //----increase the cart item count
  void increaseCartItemCount(ProductModel productModel) {
    //----if exists increase the product qty of the existing item
    _cartItemList
        .singleWhere((element) => element.cartId == productModel.productId)
        .qty++;

    //--- cal and update the subtotal
    calSubtotal(productModel);
    notifyListeners();
  }

  //----decrease the cart item count
  void decreaseCartItemCount(ProductModel productModel, BuildContext context) {
    //---when decreasing qty if the qty is 1, remove product from the cart
    if (_cartItemList
            .singleWhere((element) => element.cartId == productModel.productId)
            .qty ==
        1) {
      //-----remove the product from the cart
      removeCartItem(productModel.productId, context);
    } else {
      //----if exists increase the product qty of the existing item
      _cartItemList
          .singleWhere((element) => element.cartId == productModel.productId)
          .qty--;

      //--- cal and update the subtotal
      calSubtotal(productModel);
    }

    notifyListeners();
  }

  //-remove cart
  void removeCartItem(String productId, BuildContext context) {
    _cartItemList.removeWhere((element) => element.cartId == productId);
    AnimatedSnackBar.material(
      "Remove from the cart",
      type: AnimatedSnackBarType.error,
    ).show(context);
    notifyListeners();
  }

  //------------get cart items total price
  double get getCartTotal {
    double temp = 0;

    //-read the cart items list and get the sum of subtotal values as the cart total
    //and return it
    for (var i = 0; i < _cartItemList.length; i++) {
      temp += _cartItemList[i].subTotal;
    }
    return temp;
  }

  //------------get cart items total price
  int get getCartTotalItemCount {
    int temp = 0;

    //-read the cart items list and get the sum of qty values as the cart item
    //and return it
    for (var i = 0; i < _cartItemList.length; i++) {
      temp += _cartItemList[i].qty;
    }
    return temp;
  }

  //-clear cart
  void clearCart() {
    _cartItemList.clear();
  }
}
