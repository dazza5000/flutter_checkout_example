import 'package:checkoutexample/checkout/checkout_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const double unitPrice = 7.77;

class ShoppingCartView extends StatefulWidget {
  ShoppingCartView();

  @override
  _ShoppingCartViewState createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends State<ShoppingCartView> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shopping Cart")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Shopping cart",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Divider(),
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
                                    .subtitle2
                                    .apply(fontWeightDelta: 2)),
                            Image.network(
                              "https://media.timeout.com/images/103315998/image.jpg",
                              height:100,
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
                                    .subtitle2
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
                                    .subtitle2
                                    .apply(fontWeightDelta: 2)),
                            Text("\$$unitPrice"),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Order Summary",
                      style: Theme.of(context).textTheme.headline6),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Subtotal"),
                      Text("${getTotal()}")
                    ],
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
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: RaisedButton(
                      child: Text("Checkout now"),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CheckoutView()),);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String getTotal() {
    return NumberFormat.simpleCurrency().format(quantity * unitPrice);
  }
}
