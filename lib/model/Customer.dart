import 'package:json_annotation/json_annotation.dart';
import 'Address.dart';

part 'Customer.g.dart';

@JsonSerializable(explicitToJson: true)
class Customer {

  String email;
  String description;
  String name;
  String phone;
  Address address;
  // ignore: non_constant_identifier_names
  String payment_method;

  Customer(this.email, this.description, this.name, this.phone, this.address, this.payment_method);

  setPaymentMethod(String paymentMethod) {
    payment_method = paymentMethod;
  }

  setEmail(String email) {
    this.email = email;
  }

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
