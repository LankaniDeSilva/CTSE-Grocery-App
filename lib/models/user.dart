part of "objects.dart";

@JsonSerializable()
class UserModel {
  String name;
  String email;
  String uid;
  @JsonKey(defaultValue: "")
  String img;
  @JsonKey(defaultValue: "")
  String token;

  UserModel(this.uid, this.name, this.email, this.img, this.token);
  //-------bind json data to user model
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  //--------convert user model into json object
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}