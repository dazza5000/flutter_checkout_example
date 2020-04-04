import 'package:checkoutexample/data/CardRepository.dart';
import 'package:checkoutexample/data/CustomerRepository.dart';
import 'package:checkoutexample/data/EmailProvider.dart';
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
  MaskedTextController cardNumberController = MaskedTextController(mask: '0000 0000 0000 0000');
  MaskedTextController expirationController = MaskedTextController(mask: '00/00');
  MaskedTextController securityCodeController = MaskedTextController(mask: '000');

  CustomerRepository customerRepository = CustomerRepository();
  CardRepository cardRepository = CardRepository();
  EmailProvider emailProvider = MockEmailProvider();

  @override
  void initState() {
    super.initState();
    securityCodeController.addListener(() {
      if (!_formKey.currentState.validate()) {
        return;
      }

      Address address = Address(
          addressLine1Controller.text,
          addressLine2Controller.text,
          cityController.text,
          stateController.text);
      Customer customer = Customer(
          "",
          companyController.text,
          firstNameController.text + " " + lastNameController.text,
          "",
          address,
          "");
      customerRepository.saveCustomer(customer);

      // validate credit card
      var yearString = expirationController.text.substring(3, 5);

      if (yearString.length < 2) {
        return;
      }

      int expirationMonth = int.parse(expirationController.text.substring(0, 2));
      int expirationYear = int.parse(yearString);

      CreditCard card = CreditCard(cardNumberController.text.replaceAll(' ', ''), expirationMonth, expirationYear, securityCodeController.text);

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
              ShoppingCartView(customerRepository, cardRepository, emailProvider)
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

class MaskedTextController extends TextEditingController {
  MaskedTextController({String text, this.mask, Map<String, RegExp> translator})
      : super(text: text) {
    this.translator = translator ?? MaskedTextController.getDefaultTranslator();

    addListener(() {
      final String previous = _lastUpdatedText;
      if (this.beforeChange(previous, this.text)) {
        updateText(this.text);
        this.afterChange(previous, this.text);
      } else {
        updateText(_lastUpdatedText);
      }
    });

    updateText(this.text);
  }

  String mask;

  Map<String, RegExp> translator;

  Function afterChange = (String previous, String next) {};
  Function beforeChange = (String previous, String next) {
    return true;
  };

  String _lastUpdatedText = '';

  void updateText(String text) {
    if (text != null) {
      this.text = _applyMask(mask, text);
    } else {
      this.text = '';
    }

    _lastUpdatedText = this.text;
  }

  void moveCursorToEnd() {
    final String text = _lastUpdatedText;
    selection =
        TextSelection.fromPosition(TextPosition(offset: (text ?? '').length));
  }

  @override
  set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      moveCursorToEnd();
    }
  }

  static Map<String, RegExp> getDefaultTranslator() {
    return <String, RegExp>{
      'A': RegExp(r'[A-Za-z]'),
      '0': RegExp(r'[0-9]'),
      '@': RegExp(r'[A-Za-z0-9]'),
      '*': RegExp(r'.*')
    };
  }

  String _applyMask(String mask, String value) {
    String result = '';

    int maskCharIndex = 0;
    int valueCharIndex = 0;

    while (true) {
      // if mask is ended, break.
      if (maskCharIndex == mask.length) {
        break;
      }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      final String maskChar = mask[maskCharIndex];
      final String valueChar = value[valueCharIndex];

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (translator.containsKey(maskChar)) {
        if (translator[maskChar].hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}

class MockEmailProvider extends EmailProvider {

  @override
  String getEmail() {
    return "darran7777777@gmail.com";
  }
}
