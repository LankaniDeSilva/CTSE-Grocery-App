import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../models/objects.dart';

class OrderRepository {
  //-- create the product collection
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  //----------fetch products
  Future<List<OrderModel>> fetchOrders(String uid) async {
    try {
      //----------query for fetching all the order list according to the user id
      QuerySnapshot snapshot =
          await orders.where("user.uid", isEqualTo: uid).get();

      //----------product list
      List<OrderModel> orderList = [];

      //----------mapping fetch data to product model and store in product list
      for (var element in snapshot.docs) {
        Logger().w(element.data() as Map<String, dynamic>);
        //-----mapping to single order model
        OrderModel model =
            OrderModel.fromJson(element.data() as Map<String, dynamic>);
        Logger().w(model);
        //-----adding to the list
        orderList.add(model);
      }

      return orderList;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  //------------Sign up user in firestore cloud
  Future<void> saveOrder(
      UserModel user, double total, List<CartItemModel> items) async {
    //-getting an unique document ID
    String docid = orders.doc().id;

    //-----temparory item list
    var list = [];

    //-----read the cart items list and add items to a dynamic list
    //--because we can only store dynamic type arrays in firestore
    for (var i = 0; i < items.length; i++) {
      list.add(items[i].toJson());
    }
    return orders
        .doc(docid).set({
          'id': docid,
          'user': user.toJson(),
          'total': total,
          'item': list,
          'orderState': 'pending'
        })
        .then((value) => Logger().i("Order data Added"))
        .catchError((error) => Logger().e("Failed to add order: $error"));
  }

  Future<void>? deleteOrder(String orderid, BuildContext context) {
    try {
      Logger().e(orderid);
      return orders.doc(orderid).delete().then((_) {
        AnimatedSnackBar.material(
          "Order deleted successfully",
          type: AnimatedSnackBarType.success,
        ).show(context);
        
      // ignore: invalid_return_type_for_catch_error
      }).catchError((error) => Logger().e(error));
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}

