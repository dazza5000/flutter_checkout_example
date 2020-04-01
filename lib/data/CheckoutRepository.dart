import 'dart:convert';

import 'package:checkoutexample/model/CreditCard.dart';
import 'package:checkoutexample/model/Customer.dart';
import 'package:http/http.dart' as http;

import 'Network.dart';

class Checkout {

  static String baseUrl = "https://us-central1-liftai-f22ba.cloudfunctions.net/";

  Future<http.Response> createCustomer(Customer customer) async {
    http.Client client = Network.getHttpClient();
    http.Response response = await client
        .post('$baseUrl/createCustomer', body: jsonEncode(customer));

    return response;
  }

  Future<http.Response> createCard(CreditCard card) async {
    http.Client client = Network.getHttpClient();
    http.Response response = await client
        .post('$baseUrl/createPaymentMethod', body: jsonEncode(card));

    return response;
  }
}