import 'package:json_annotation/json_annotation.dart';

part 'Address.g.dart';

@JsonSerializable()
class Address {

  Address(this.line1, this.line2, this.city, this.state);

  String line1;
  String line2;
  String city;
  String state;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}