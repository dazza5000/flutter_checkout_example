import 'package:json_annotation/json_annotation.dart';
import 'Address.dart';

part 'Customer.g.dart';

@JsonSerializable(explicitToJson: true)
class Customer {

  Customer(this.email, this.description, this.name, this.phone, this.address);

  String email;
  String description;
  String name;
  String phone;
  Address address;

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
