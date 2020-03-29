import 'package:checkoutexample/model/Address.dart';
import 'package:checkoutexample/model/Customer.dart';
import 'package:checkoutexample/shopping_cart/shopping_cart_view.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController securityCodeController = TextEditingController();

  Customer customer;

  @override
  void initState() {
    super.initState();
    securityCodeController.addListener(() {
      Address address = Address(addressLine1Controller.text, addressLine2Controller.text, cityController.text, stateController.text);
      Customer customer = Customer("darran.kelinske@gmail.com", "", firstNameController.text + lastNameController.text, "5126937499", address);
      setState(() {
        print("Setting customer to:" +customer.toJson().toString());
        this.customer = customer;
      });
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
              Container(
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
              ShoppingCartView(customer)
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
            child: Row(children: <Widget>[
              Container(
                width: 250,
                child: TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "First name",
                  ),
                ),
              ),
              Container(
                width: 250,
                child: TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Last name",
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
              child: TextField(
                controller: addressLine1Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Address line 1",
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
            children: <Widget>[
              Container(
                width: 300,
                child: TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "City",
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
                child: TextField(
                  controller: zipController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "ZIP Code",
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
            children: <Widget>[
              Container(
                width: 250,
                child: TextField(
                  controller: cardNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Card number",
                  ),
                ),
              ),
              Container(
                width: 100,
                child: TextField(
                  controller: expirationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "MM/YY",
                  ),
                ),
              ),
              Container(
                width: 150,
                child: TextField(
                  controller: securityCodeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Security Code",
                  ),
                ),
              ),
            ],
          )
        ]);
  }
}
