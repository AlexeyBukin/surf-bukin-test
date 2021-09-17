import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'cart_wm.dart';

class CartScreen extends CoreMwwmWidget<CartWidgetModel> {
  const CartScreen({
    Key? key,
    required WidgetModelBuilder<CartWidgetModel> widgetModelBuilder,
  }) : super(
    key: key,
    widgetModelBuilder: widgetModelBuilder,
  );

  @override
  WidgetState<CoreMwwmWidget<CartWidgetModel>, CartWidgetModel>
  createWidgetState() => _CartScreenState();
}

class _CartScreenState extends WidgetState<CartScreen, CartWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Screen'),
      ),
      body: StreamBuilder<List<String>>(
        stream: Stream.value(wm.products),
        initialData: const [],
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...?snapshot.data?.map((e) => Text(e))
              ],
            ),
          );
        },
      ),
    );
  }
}