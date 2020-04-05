import 'package:json_annotation/json_annotation.dart';
import 'Address.dart';

part 'SubscriptionRequest.g.dart';

@JsonSerializable(explicitToJson: true)
class SubscriptionRequest {

  String email;
  String description;
  String name;
  String phone;
  Address address;
  // ignore: non_constant_identifier_names
  String payment_method;
  int quantity;

  SubscriptionRequest(this.email, this.description, this.name, this.phone, this.address, this.payment_method, this.quantity);

  setPaymentMethod(String paymentMethod) {
    payment_method = paymentMethod;
  }

  setEmail(String email) {
    this.email = email;
  }

  setQuantity(int quantity) {
    this.quantity = quantity;
  }

  factory SubscriptionRequest.fromJson(Map<String, dynamic> json) => _$SubscriptionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionRequestToJson(this);
}
