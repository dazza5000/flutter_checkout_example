import 'package:json_annotation/json_annotation.dart';

part 'AttachPayment.g.dart';

@JsonSerializable()
class AttachPayment {
  String paymentId;
  String customerId;

  AttachPayment(this.paymentId, this.customerId);

  factory AttachPayment.fromJson(Map<String, dynamic> json) => _$AttachPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$AttachPaymentToJson(this);
}