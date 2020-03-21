import 'package:checkoutexample/shopping_cart/shopping_cart_view.dart';
import 'package:flutter/material.dart';

class CheckoutView extends StatefulWidget {
  CheckoutView();

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
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
              ShoppingCartView()
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "First name",
                  ),
                ),
              ),
              Container(
                width: 250,
                child: TextField(
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
            child: Row(children: <Widget>[
              Container(
                width: 500,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Address line 1",
                  ),
                ),
              ),
            ]),
          ),
          Row(
            children: <Widget>[
              Container(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "City",
                  ),
                ),
              ),
              Container(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "State",
                  ),
                ),
              ),
              Container(
                width: 100,
                child: TextField(
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Card number",
                  ),
                ),
              ),
              Container(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "MM/YY",
                  ),
                ),
              ),
              Container(
                width: 150,
                child: TextField(
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
