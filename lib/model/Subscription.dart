import 'package:json_annotation/json_annotation.dart';

part 'Subscription.g.dart';

@JsonSerializable()
class Subscription {
  String customerId;
  int quantity;

  Subscription(this.customerId, this.quantity);

  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}