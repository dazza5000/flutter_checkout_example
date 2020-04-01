import 'dart:math';

import 'package:checkoutexample/data/CardRepository.dart';
import 'package:checkoutexample/data/CustomerRepository.dart';
import 'package:checkoutexample/model/Address.dart';
import 'package:checkoutexample/model/CreditCard.dart';
import 'package:checkoutexample/model/Customer.dart';
import 'package:checkoutexample/shopping_cart/shopping_cart_view.dart';
import 'package:flutter/material.dart';

final String firstName = "First name";
final String lastName = "Last name";
final addressLine1 = "Address Line 1";
final city = "City";
final zipCode = "Zip Code";
final creditCardNumber = "Card Number";
final expirationDate = "MMYY";
final securityCode = "Security Code";

class CheckoutView extends StatefulWidget {
  CheckoutView();

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {

  final _formKey = GlobalKey<FormState>();

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var companyController = TextEditingController();
  var addressLine1Controller = TextEditingController();
  var addressLine2Controller = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var zipController = TextEditingController();
  var cardNumberController = TextEditingController();
  var expirationController = TextEditingController();
  TextEditingController securityCodeController = TextEditingController();

  CustomerRepository customerRepository = CustomerRepository();
  CardRepository cardRepository = CardRepository();

  @override
  void initState() {
    super.initState();
    securityCodeController.addListener(() {
      if (_formKey.currentState.validate()) {
        return;
      }
      Address address = Address(
          addressLine1Controller.text,
          addressLine2Controller.text,
          cityController.text,
          stateController.text);
      Customer customer = Customer(
          "darran7777777@gmail.com",
          companyController.text,
          firstNameController.text + " " + lastNameController.text,
          "",
          address);
      customerRepository.saveCustomer(customer);

      CreditCard card = CreditCard();

      cardRepository.saveCard(card);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Secure Checkout")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Container(
                  width: 600,
                  child: Column(
                    children: <Widget>[
                      getNameWidget(),
                      Container(
                        height: 16.0,
                      ),
                      getAddressWidget(),
                      Container(
                        height: 16.0,
                      ),
                      getCreditCardWidget(),
                    ],
                  ),
                ),
              ),
              ShoppingCartView(customerRepository, cardRepository)
            ],
          ),
        ));
  }

  Column getNameWidget() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text("Full Name", style: Theme.of(context).textTheme.headline6),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 250,
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return '$firstName must not be empty.';
                        }
                        return null;
                      },
                      controller: firstNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: firstName,
                      ),
                    ),
                  ),
                  Container(
                    width: 250,
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return '$lastName must not be empty.';
                        }
                        return null;
                      },
                      controller: lastNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: lastName,
                      ),
                    ),
                  )
                ]),
          ),
          Container(
            width: 500,
            child: TextField(
              controller: companyController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Company (Optional)",
              ),
            ),
          )
        ]);
  }

  Column getAddressWidget() {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Shipping Address",
                style: Theme.of(context).textTheme.headline6),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: 500,
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return '$addressLine1 not be empty.';
                  }
                  return null;
                },
                controller: addressLine1Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: addressLine1,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: 500,
              child: TextField(
                controller: addressLine2Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Address line 2",
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 300,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return '$city must not be empty.';
                    }
                    return null;
                  },
                  controller: cityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: city,
                  ),
                ),
              ),
              Container(
                width: 100,
                child: TextField(
                  controller: stateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "State",
                  ),
                ),
              ),
              Container(
                width: 100,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return '$zipCode must not be empty.';
                    }
                    return null;
                  },
                  controller: zipController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: zipCode,
                  ),
                ),
              ),
            ],
          )
        ]);
  }

  Column getCreditCardWidget() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Card Information",
                style: Theme.of(context).textTheme.headline6),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 250,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return '$creditCardNumber must not be empty.';
                    }
                    return null;
                  },
                  controller: cardNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: creditCardNumber,
                  ),
                ),
              ),
              Container(
                width: 100,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return '$expirationDate must not be empty.';
                    }
                    return null;
                  },
                  controller: expirationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: expirationDate,
                  ),
                ),
              ),
              Container(
                width: 150,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return '$securityCode must not be empty.';
                    }
                    return null;
                  },
                  controller: securityCodeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: securityCode,
                  ),
                ),
              ),
            ],
          )
        ]);
  }
}
