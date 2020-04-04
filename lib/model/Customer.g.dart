// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    json['email'] as String,
    json['description'] as String,
    json['name'] as String,
    json['phone'] as String,
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    json['payment_method'] as String,
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'email': instance.email,
      'description': instance.description,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address?.toJson(),
      'payment_method': instance.payment_method,
    };
