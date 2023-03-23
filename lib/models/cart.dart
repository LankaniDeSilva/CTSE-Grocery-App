part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class CartItemModel {
  final String cartId;
  int qty;
  double subTotal;
  final ProductModel model;

  CartItemModel({
    required this.cartId,
    required this.qty,
    required this.subTotal,
    required this.model,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}