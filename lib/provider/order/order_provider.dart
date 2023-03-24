import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/repository/order_repository.dart';
import 'package:grocery_app/utils/util_function.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../models/objects.dart';
import '../../screens/main/cart/cart_screen.dart';
import '../../screens/main_screen.dart';
import '../auth/user_provider.dart';
import '../cart/cart_provider.dart';

class OrderProvider extends ChangeNotifier {
  final _orderReository = OrderRepository();

  //---------loader state
  bool _isLoading = false;

  //----get loading state
  bool get loading => _isLoading;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //------start creating the order
  Future<void> createOrder(BuildContext context) async {
    try {
      //----get cart items
      List<CartItemModel> items =
          Provider.of<CartProvider>(context, listen: false).cartItemList;

      //----get cart total
      double total =
          Provider.of<CartProvider>(context, listen: false).getCartTotal;

      //----get cart items
      UserModel user =
          Provider.of<UserProvider>(context, listen: false).userModel;

      //----first check wheather cart item list is not empty
      if (items.isNotEmpty) {
        //------start the loader
        setLoading(true);

        //-call the create order function
        await _orderReository.saveOrder(user, total, items).then((value) {
          //-stop the loader
          setLoading(false);

          //-clear the cart after created
          Provider.of<CartProvider>(context, listen: false).clearCart();

          //--show a dialog box when the order is successfully created
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return DialogBoxContainer(
                onTap: () {
                  //---start fetching orders before going to order list
                  fetchOrders(user.uid);
                  UtilFunctions.navigate(context, const MainScreen());
                },
              );
            },
          );
        });
      } else {
        AnimatedSnackBar.material(
          "You must add some items to cart",
          type: AnimatedSnackBarType.error,
        ).show(context);
        notifyListeners();
      }
    } catch (e) {
      setLoading(false);
      Logger().e(e);
    }
  }

  //-fetching orders
  //------ order list
  List<OrderModel> _orders = [];

  //-----getter for order list
  List<OrderModel> get orders => _orders;

  //-start fetching order
  Future<void> fetchOrders(String uid) async {
    try {
      //-start the loader
      setLoading(true);

      _orders = await _orderReository.fetchOrders(uid);
      notifyListeners();

      //-stop the loader
      setLoading(false);
    } catch (e) {
      Logger().e(e);
      //-stop the loader
      setLoading(false);
    }
  }

  //REMOVE ORDER
  Future<void> removeOrder(String orderid, BuildContext context, String uid) async {
    try {
      await _orderReository.deleteOrder(orderid, context);
      fetchOrders(uid);
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }
}
