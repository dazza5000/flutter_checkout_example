
import 'dart:convert';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;

import 'package:checkoutexample/checkout/checkout_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:stripe/stripe.dart';

const double unitPrice = 7.77;

class ShoppingCartView extends StatefulWidget {
  ShoppingCartView();

  @override
  _ShoppingCartViewState createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends State<ShoppingCartView> {
  int quantity = 1;
  Stripe stripe;
  static const _host = 'api.stripe.com';
  static const _version = '2019-05-16';
  String _apiKey = "pk_test_KRyEUvbRPX8pp1arS1UKX9Id00Z0P1hEAG";
  final HttpsCallable callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'createPaymentIntent')
    ..timeout = const Duration(seconds: 30);

  @override
  void initState() {
    super.initState();
    stripe = Stripe("pk_test_KRyEUvbRPX8pp1arS1UKX9Id00Z0P1hEAG");
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      decoration: BoxDecoration(border: Border.all()),
      width: 600,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Shopping cart",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Container(height: 8.0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Pizza",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .apply(fontWeightDelta: 2)),
                        Image.network(
                          "https://media.timeout.com/images/103315998/image.jpg",
                          height: 100,
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Quantity",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .apply(fontWeightDelta: 2)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MaterialButton(
                                child: Text("-"),
                                onPressed: () {
                                  setState(() {
                                    quantity--;

                                    if (quantity < 0) {
                                      quantity = 0;
                                    }
                                  });
                                }),
                            Text("$quantity"),
                            MaterialButton(
                              child: Text("+"),
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text("Unit Price",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .apply(fontWeightDelta: 2)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("\$$unitPrice"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(height: 8.0,),
              Text("Order Summary", style: Theme.of(context).textTheme.headline6),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text("Subtotal"), Text("${getTotal()}")],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Estimated Total"
                    "\n(before tax/shipping)",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .apply(fontWeightDelta: 2),
                  ),
                  Text("${getTotal()}",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .apply(fontWeightDelta: 2))
                ],
              ),
              Container(height: 8.0,),
              Center(child: getPlaceYourOrderWidget())
            ]),
      ),
    );
  }

  Widget getPlaceYourOrderWidget() {
    return Container(
      width: 500,
      child: RaisedButton(
        child: Text("Place your order"),
        onPressed: () async {
//          retrieve("777").then((value) {
//            print("the response is: $value");
//          });
//        stripe.paymentIntent.create(777, "usd").then((value) {
//          print("This is the payment intent: $value");
//        });

          final HttpsCallableResult result = await callable.call();
          print("the data from the callable is: $result");
        },
      ),
    );
  }

  Future<PaymentIntent> retrieve(String paymentIntentId) async {
    final map = await get(['payment_intents', paymentIntentId]);
    return PaymentIntent.fromJson(map);
  }

  /// Makes a get request to the Stripe API
  Future<Map<String, dynamic>> get(
      final List<String> pathSegments, {
        String idempotencyKey,
      }) async {
    final uri = createUri(pathSegments);
    final headers = createHeader(idempotencyKey: idempotencyKey);
    final httpClientRequest = await http.get(uri, headers: headers);

    return processResponse(httpClientRequest);
  }

  String getTotal() {
    return NumberFormat.simpleCurrency().format(quantity * unitPrice);
  }

  Map<String, String> createHeader({String idempotencyKey}) {
    final headers = <String, String>{
      'Stripe-Version': _version,
      'Content-Type': 'application/x-www-form-urlencoded',
      HttpHeaders.authorizationHeader: "Bearer $_apiKey"
    };
    if (idempotencyKey != null) headers['Idempotency-Key'] = idempotencyKey;
    return headers;
  }



  Uri createUri(List<String> pathSegements) {
    pathSegements.insert(0, 'v1');
    final uri = Uri(
        scheme: 'https',
        host: _host,
        pathSegments: pathSegements,
        userInfo: '$_apiKey:');
    return uri;
  }

  Map<String, dynamic> processResponse(Response response) {
    final responseStatusCode = response.statusCode;

    Map<String, dynamic> map;
    try {
      map = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      // Throwing later.
    }
    if (responseStatusCode != 200) {
      if (map == null || map['error'] == null) {
        throw InvalidRequestException(
            'The status code returned was $responseStatusCode but no error was provided.');
      }
      final error = map['error'] as Map;
      switch (error['type'].toString()) {
        case 'invalid_request_error':
          throw InvalidRequestException(error['message'].toString());
          break;
        default:
          throw UnknownTypeException(
              'The status code returned was $responseStatusCode but the error type is unknown.');
      }
    }
    if (map == null) {
      throw InvalidRequestException(
          'The JSON returned was unparsable (${response.body}).');
    }
    return map;
  }
}

/// Exceptions thrown by Stripe
abstract class StripeException implements Exception {
  final String message;

  StripeException(this.message);
}

/// Invalid request errors arise when your request has invalid parameters.
class InvalidRequestException extends StripeException {
  InvalidRequestException(String message) : super(message);

  @override
  String toString() => 'Invalid request: $message.';
}

/// For all API error responses where the type is unknown or not provided.
class UnknownTypeException extends StripeException {
  UnknownTypeException(String message) : super(message);

  @override
  String toString() => 'Invalid type: $message.';
}
