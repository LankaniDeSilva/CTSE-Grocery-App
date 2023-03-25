part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class FeedbackModel {
  final String id;
  @JsonKey(name: "user")
  UserModel userModel;
  String subject;
  String message;
  String? reply;

  FeedbackModel({required this.id, required this.userModel, required this.subject, required this.message, this.reply});

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => _$FeedbackModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackModelToJson(this);
}