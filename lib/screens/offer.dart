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
  CollectionReference _offerRef =
      FirebaseFirestore.instance.collection('offerlist');
  List<Offer> _offer = [];

  @override
  void initState() {
    super.initState();
    _offerRef.snapshots().listen((snapshot) {
      setState(() {
        _offer =
            snapshot.docs.map((doc) => Offer.fromSnapshot(doc)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offer List')),
      body: ListView.builder(
        itemCount: _offer.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_offer[index].offerName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Offer Description: ${_offer[index].offerDescription}'),
                Text('Quantity: ${_offer[index].offerQuentity}'),
                Text('Price: ${_offer[index].price}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _offerRef.doc(_offer[index].id).delete();
              },
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OfferForm(
                          offerRef: _offerRef, offer: _offer[index])));
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
                builder: (context) => OfferForm(offerRef: _offerRef)),
          );
        },
      ),
    );
  }
}

class OfferForm extends StatefulWidget {
  final CollectionReference offerRef;
  final Offer? offer;

  OfferForm({required this.offerRef, this.offer});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<OfferForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _productQuentityController = TextEditingController();
  final _priceController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.offer != null) {
      _titleController.text = widget.offer!.offerName;
      _descriptionController.text = widget.offer!.offerDescription;
      _productQuentityController.text = widget.offer!.offerQuentity;
      _priceController.text = widget.offer!.price;
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
      appBar: AppBar(title: Text('New Offer')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Offer Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter offer name'; //prodt name hint
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'offer Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter offer description'; //description hint
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productQuentityController,
                decoration: InputDecoration(labelText: 'Offer Quntity'),
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
                    : Text('Save offer'),
                onPressed: _isSubmitting
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isSubmitting = true;
                          });

                          Offer offer = Offer(
                            offerName: _titleController.text,
                            offerDescription: _descriptionController.text,
                            offerQuentity: _productQuentityController.text,
                            price: _priceController.text,
                          );
                          try {
                            await widget.offerRef.add(offer.toMap());
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
class Offer {
  final String id;
  final String offerName;
  final String offerDescription;
  final String offerQuentity;
  final String price;

  Offer({
    required this.offerName,
    required this.offerDescription,
    required this.offerQuentity,
    required this.price,
    this.id = '',
  });

  factory Offer.fromSnapshot(DocumentSnapshot snapshot) {
    return Offer(
      id: snapshot.id,
      offerName: snapshot['offerName'],
      offerDescription: snapshot['offerDescription'],
      offerQuentity: snapshot['offerQuentity'],
      price: snapshot['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'offerName': offerName,
      'offerDescription': offerDescription,
      'offerQuentity': offerQuentity,
      'price': price,
    };
  }
}
