import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf/ui/cart/cart_screen.dart';
import 'package:surf/ui/cart/cart_wm.dart';

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

@mustCallSuper
CartWidgetModel _createCartWm(BuildContext context) {
  return CartWidgetModel(
    dependencies: const WidgetModelDependencies(),
    navigator: Navigator.of(context),
  );
}
