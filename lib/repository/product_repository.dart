import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/utils/assets_constants.dart';
import 'package:logger/logger.dart';

import '../models/objects.dart';

class ProductRepository {

  //-- create the product collection
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  
    //-----------save Product function---
  Future<void> saveProduct(
    BuildContext context,
    String productName,
    String description,
    String price,
  ) async {
    try {
      //-getting an unique document ID
      String docid = products.doc().id;

      //-saving the producy data in cloud firestore
      await products.doc(docid).set({
        "productId": docid,
        "productName": productName,
        "description": description,
        "price": double.parse(price),
        "image": “”,
      });
    } catch (e) {
     Logger().e(e.toString())
    }

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
