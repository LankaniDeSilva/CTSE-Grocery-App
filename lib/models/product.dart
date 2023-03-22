part of 'objects.dart';

@JsonSerializable()
class ProductModel {
  final String productId;
  final String productName;
  @JsonKey(name: 'description')
  final String desc;
  final double price;
  String image;

  ProductModel(
    this.productId,
    this.productName,
    this.desc,
    this.price,
    this.image);

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
