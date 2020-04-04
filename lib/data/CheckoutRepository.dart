import 'dart:convert';

import 'package:checkout/model/AttachPayment.dart';
import 'package:checkout/model/CreditCard.dart';
import 'package:checkout/model/Customer.dart';
import 'package:checkout/model/Subscription.dart';
import 'package:http/http.dart' as http;

import 'Network.dart';

class Checkout {

  static String baseUrl = "https://us-central1-liftai-f22ba.cloudfunctions.net";

  Future<http.Response> createCustomer(Customer customer) async {
    http.Client client = Network().getHttpClient();
    http.Response response = await client
        .post('$baseUrl/createCustomer', body: jsonEncode(customer));

    return response;
  }

  Future<http.Response> createPaymentMethod(CreditCard card) async {
    http.Client client = Network().getHttpClient();
    http.Response response = await client
        .post('$baseUrl/createPaymentMethod', body: jsonEncode(card));

    return response;
  }

  Future<http.Response> attachPaymentToCustomer(String paymentId, String customerId) async {
    http.Client client = Network().getHttpClient();

    http.Response response = await client
        .post('$baseUrl/attachPaymentToCustomer', body: jsonEncode(AttachPayment(paymentId, customerId)));

    return response;
  }

  Future<http.Response> createSubscription(String customerId, int quantity) async {
    http.Client client = Network().getHttpClient();

    http.Response response = await client
        .post('$baseUrl/createSubscription', body: jsonEncode(Subscription(customerId, quantity)));

    return response;
  }

}

