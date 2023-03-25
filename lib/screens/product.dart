import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ctse_grocery_app/services/authentication.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference _productRef =
      FirebaseFirestore.instance.collection('productlist');
  List<Product> _product = [];

  @override
  void initState() {
    super.initState();
    _productRef.snapshots().listen((snapshot) {
      setState(() {
        _product =
            snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: ListView.builder(
        itemCount: _product.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_product[index].productName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Product Description: ${_product[index].productDescription}'),
                Text('Quantity: ${_product[index].productQuentity}'),
                Text('Price: ${_product[index].price}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _productRef.doc(_product[index].id).delete();
              },
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductForm(
                          productRef: _productRef, product: _product[index])));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductForm(productRef: _productRef)),
          );
        },
      ),
    );
  }
}

class ProductForm extends StatefulWidget {
  final CollectionReference productRef;
  final Product? product;

  ProductForm({required this.productRef, this.product});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _productQuentityController = TextEditingController();
  final _priceController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _titleController.text = widget.product!.productName;
      _descriptionController.text = widget.product!.productDescription;
      _productQuentityController.text = widget.product!.productQuentity;
      _priceController.text = widget.product!.price;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _productQuentityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Product')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter product name'; //prodt name hint
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Product Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter product description'; //description hint
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productQuentityController,
                decoration: InputDecoration(labelText: 'Product Quntity'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter product quntity'; //product quntity hint
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the price'; //price hint
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: _isSubmitting
                    ? CircularProgressIndicator()
                    : Text('Save Product'),
                onPressed: _isSubmitting
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isSubmitting = true;
                          });

                          Product product = Product(
                            productName: _titleController.text,
                            productDescription: _descriptionController.text,
                            productQuentity: _productQuentityController.text,
                            price: _priceController.text,
                          );
                          try {
                            await widget.productRef.add(product.toMap());
                            Navigator.pop(context);
                          } catch (e) {
                            print('Error saving product: $e');
                            setState(() {
                              _isSubmitting = false;
                            });
                          }
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Product class
class Product {
  final String id;
  final String productName;
  final String productDescription;
  final String productQuentity;
  final String price;

  Product({
    required this.productName,
    required this.productDescription,
    required this.productQuentity,
    required this.price,
    this.id = '',
  });

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    return Product(
      id: snapshot.id,
      productName: snapshot['productName'],
      productDescription: snapshot['productDescription'],
      productQuentity: snapshot['productQuentity'],
      price: snapshot['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productDescription': productDescription,
      'productQuentity': productQuentity,
      'price': price,
    };
  }
}
