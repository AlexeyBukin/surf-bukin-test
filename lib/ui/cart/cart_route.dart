import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf/ui/cart/cart_wm.dart';

import 'cart_screen.dart';

class CartScreenRoute extends MaterialPageRoute<void> {
  static const String name = 'cart';

  CartScreenRoute([RouteSettings? settings])
      : super(
          builder: (ctx) => const CartScreen(
            widgetModelBuilder: _createCartWm,
          ),
          settings: settings,
        );
}

CartWidgetModel _createCartWm(BuildContext context) {
  return CartWidgetModel(
    dependencies: const WidgetModelDependencies(),
    navigator: Navigator.of(context),
  );
}
