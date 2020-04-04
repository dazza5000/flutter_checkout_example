import 'dart:convert';

import 'package:checkoutexample/data/CardRepository.dart';
import 'package:checkoutexample/data/CheckoutRepository.dart';
import 'package:checkoutexample/data/CustomerRepository.dart';
import 'package:checkoutexample/data/EmailProvider.dart';
import 'package:checkoutexample/model/Customer.dart';
import 'package:checkoutexample/model/Subscription.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const double unitPrice = 7.77;

class ShoppingCartView extends StatefulWidget {
  final CustomerRepository customerRepository;
  final CardRepository cardRepository;
  final EmailProvider emailProvider;

  ShoppingCartView(this.customerRepository, this.cardRepository, this.emailProvider);

  @override
  _ShoppingCartViewState createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends State<ShoppingCartView> {
  int quantity = 1;

  _ShoppingCartViewState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Shopping cart",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          width: 600,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 8.0,
                  ),
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

                                        if (quantity < 1) {
                                          quantity = 1;
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
                            Text("Monthly Rate",
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
                  Container(
                    height: 8.0,
                  ),
                  Text("Order Summary",
                      style: Theme.of(context).textTheme.headline6),
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
                        "Estimated Monthly Subscription"
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
                  Container(
                    height: 8.0,
                  ),
                  Center(child: getPlaceYourOrderWidget())
                ]),
          ),
        ),
      ],
    );
  }

  Widget getPlaceYourOrderWidget() {
    return Container(
      width: 500,
      child: RaisedButton(
        child: Text("Place your order"),
        onPressed: () async {

          if (CustomerRepository().getCustomer() == null || CardRepository().getCard() == null) {
            _alertUser("", "Invalid payment details.");
            return;
          }

          print("place order was pressed");

          var response = await Checkout()
              .createPaymentMethod(widget.cardRepository.getCard());

          String paymentMethodId;

          // TODO: Abstract / Handle some of this on the repository / data layer

          if (response.statusCode == 200) {
            paymentMethodId = json.decode(response.body)['id'];
          } else {
            _alertUser("", "Unable to create order. Please check payment details.");
          }

          print("Payment method id is: $paymentMethodId");

          Customer customer = widget.customerRepository.getCustomer();
          customer.setEmail(widget.emailProvider.getEmail());
          customer.setPaymentMethod(paymentMethodId);

          print(customer.toJson());

          response = await Checkout().createCustomer(customer);
          var customerId;
          if (response.statusCode == 200) {
            customerId = json.decode(response.body)['id'];
          } else {
            _alertUser("", "Unable to create order. Please check payment details.");
          }

          print("The customer id is: $customerId");


          response = await Checkout().createSubscription(customerId, quantity);
          var subscriptionId;
          if (response.statusCode == 200) {
            subscriptionId = json.decode(response.body)['id'];
          } else {
            _alertUser("", "Unable to create order. Please check payment details.");
          }

          print("The subscription id is: $subscriptionId");
          _alertUser("", "Order successful. Please check your e-mail for order confirmation");



        },
      ),
    );
  }

  String getTotal() {
    return NumberFormat.simpleCurrency().format(quantity * unitPrice);
  }

  Future<void> _alertUser(String title, String alertText)async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(alertText),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
