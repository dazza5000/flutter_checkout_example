import 'package:json_annotation/json_annotation.dart';

part 'CreditCard.g.dart';

@JsonSerializable()
class CreditCard {

  CreditCard(this.number, this.exp_month, this.exp_year, this.cvc);

  String number;
  // ignore: non_constant_identifier_names
  int exp_month;
  // ignore: non_constant_identifier_names
  int exp_year;
  String cvc;

  factory CreditCard.fromJson(Map<String, dynamic> json) => _$CreditCardFromJson(json);
  Map<String, dynamic> toJson() => _$CreditCardFromJson(this);
}