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
        onPressed: () {},
      ),
    );
  }

  String getTotal() {
    return NumberFormat.simpleCurrency().format(quantity * unitPrice);
  }
}
