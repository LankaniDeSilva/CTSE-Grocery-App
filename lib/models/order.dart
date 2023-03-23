part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel {
  final String id;
  UserModel userModel;
  double total;
  List<CartItemModel> items;
  String orderState;

  OrderModel({
    required this.id,
    required this.userModel,
    required this.total,
    required this.items,
    required this.orderState,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

}