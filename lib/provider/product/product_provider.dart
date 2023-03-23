import 'package:animated_snack_bar/animated_snack_bar.dart';
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
  final _productRepository = ProductRepository();

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

  //--------add to favourite
  //------initialize the favourite product list
  final List<ProductModel> _favproducts = [];

  //-----getter for product list
  List<ProductModel> get favproducts => _favproducts;

  void initAddtoFavourite(ProductModel model, BuildContext context) {
    //-------check wheather favourite list already has the object
    if (favproducts.contains(model)) {
      //--remove favourite from the list
      _favproducts.remove(model);
      //---------show snackbar
      AnimatedSnackBar.material(
        "Removed from favourite !",
        type: AnimatedSnackBarType.error,
      ).show(context);
      notifyListeners();
    } else {
      //--adding click favourite to the list
      _favproducts.add(model);
      AnimatedSnackBar.material(
        "Added to favourite !",
        type: AnimatedSnackBarType.success,
      ).show(context);
      notifyListeners();
    }
  }

  //------------Product details screen
  //------------Store the selected product model
  late ProductModel _productModel;
  //--------get selected product
  ProductModel get productModel => _productModel;

  //-------set product model when click from the product card
  void setProduct(ProductModel model) {
    _productModel = model;
    notifyListeners();
  }

  //-----getter for related product list
  List<ProductModel> get relatedProducts {
    List<ProductModel> temp = [];
    //----------filter the product list
    //---------remove the already selected product
    for (var i = 0; i < _products.length; i++) {
      if (_products[i].productId != _productModel.productId) {
        temp.add(_products[i]);
      }
    }
    return temp;
  }
}
