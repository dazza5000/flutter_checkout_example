// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubscriptionRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionRequest _$SubscriptionRequestFromJson(Map<String, dynamic> json) {
  return SubscriptionRequest(
    json['email'] as String,
    json['description'] as String,
    json['name'] as String,
    json['phone'] as String,
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    json['payment_method'] as String,
    json['quantity'] as int,
  );
}

Map<String, dynamic> _$SubscriptionRequestToJson(
        SubscriptionRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'description': instance.description,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address?.toJson(),
      'payment_method': instance.payment_method,
      'quantity': instance.quantity,
    };
