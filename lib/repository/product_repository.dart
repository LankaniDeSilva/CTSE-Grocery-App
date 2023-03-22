import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/utils/assets_constants.dart';
import 'package:logger/logger.dart';

import '../models/objects.dart';

class ProductRepository {
  //------Firebase auth instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  //-- create the product collection
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  //----------fetch products
  Future<List<ProductModel>> getProducts() async {
    try {
      //----------query for fetching all the products list
      QuerySnapshot snapshot = await products.get();

      //----------product list
      List<ProductModel> productList = [];

      //----------mapping fetch data to product model and store in product list
      for (var element in snapshot.docs) {
        //-----mapping to single product model
        ProductModel model =
            ProductModel.fromJson(element.data() as Map<String, dynamic>);

        if (model.image.isEmpty) {
          model.image = AssetsConstants.dummyVegetable;
        }

        //-----adding to the list
        productList.add(model);
      }

      return productList;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
