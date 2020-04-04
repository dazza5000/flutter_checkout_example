// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AttachPayment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachPayment _$AttachPaymentFromJson(Map<String, dynamic> json) {
  return AttachPayment(
    json['paymentId'] as String,
    json['customerId'] as String,
  );
}

Map<String, dynamic> _$AttachPaymentToJson(AttachPayment instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'customerId': instance.customerId,
    };
