import 'package:flutter/material.dart';
import 'package:grocery_app/repository/product_repository.dart';
import 'package:logger/logger.dart';

import '../../models/objects.dart';

class ProductProvider extends ChangeNotifier {
  //------initialize the product model list
  List<ProductModel> _products = [];

  //-----getter for product list
  List<ProductModel> get products => _products;

  //-----product controller instance
  final  _productRepository = ProductRepository();

  //---------loader state
  bool _isLoading = false;

  //----get loading state
  bool get loading => _isLoading;

  //-----change loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //-----fetch products function
  Future<void> fetchProducts() async {
    try {
      //------start the loader
      setLoading(true);

      //----start fetching products
      _products = await _productRepository.getProducts();
      Logger().w(_products.length);

      notifyListeners();

      //-----stop loading
      setLoading(false);
    } catch (e) {
      Logger().e(e);
      setLoading(false);
    }
  }
}