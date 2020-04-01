// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CreditCard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCard _$CreditCardFromJson(Map<String, dynamic> json) {
  return CreditCard(
    json['number'] as String,
    json['exp_month'] as int,
    json['exp_year'] as int,
    json['cvc'] as String,
  );
}

Map<String, dynamic> _$CreditCardToJson(CreditCard instance) =>
    <String, dynamic>{
      'number': instance.number,
      'exp_month': instance.exp_month,
      'exp_year': instance.exp_year,
      'cvc': instance.cvc,
    };
