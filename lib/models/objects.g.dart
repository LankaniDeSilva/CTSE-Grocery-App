// GENERATED CODE - DO NOT MODIFY BY HAND

part of objects;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['uid'] as String,
      json['name'] as String,
      json['email'] as String,
      json['img'] as String? ?? '',
      json['token'] as String? ?? '',
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'uid': instance.uid,
      'img': instance.img,
      'token': instance.token,
    };

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['productId'] as String,
      json['productName'] as String,
      json['description'] as String,
      (json['price'] as num).toDouble(),
      json['image'] as String,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'description': instance.desc,
      'price': instance.price,
      'image': instance.image,
    };

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      cartId: json['cartId'] as String,
      qty: json['qty'] as int,
      subTotal: (json['subTotal'] as num).toDouble(),
      model: ProductModel.fromJson(json['model'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'cartId': instance.cartId,
      'qty': instance.qty,
      'subTotal': instance.subTotal,
      'model': instance.model.toJson(),
    };

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String,
      userModel: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      total: (json['total'] as num).toDouble(),
      items: (json['item'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderState: json['orderState'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.userModel.toJson(),
      'total': instance.total,
      'item': instance.items.map((e) => e.toJson()).toList(),
      'orderState': instance.orderState,
    };
