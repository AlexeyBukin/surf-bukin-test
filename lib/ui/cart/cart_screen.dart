import 'package:encore_annotations/encore_annotations.dart';
import 'package:flutter/material.dart';
import 'package:surf/domain/cart.dart';
import 'package:surf/ui/cart/cart_wm.dart';
import 'package:surf/ui/drawer/drawer.dart';
import 'package:surf/ui/profile/profile_screen.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

@Screen(
  specification: 'lmao',
  design: 'design_link',
  from: [
    CartScreen,
  ],
  to: [
    ProfileScreen,
  ],
  dialogs: [],
)
class CartScreen extends CoreMwwmWidget<CartWidgetModel> {
  const CartScreen({
    required WidgetModelBuilder<CartWidgetModel> widgetModelBuilder,
    Key? key,
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
        title: const Text('Корзина'),
      ),
      drawer: const SportShopDrawer(),
      body: StreamedStateBuilder(
        streamedState: wm.streamedState,
        builder: buildBody,
      ),
    );
  }

  Widget buildBody(BuildContext context, CartScreenInfoState cartState) {
    final info = cartState.cartInfo;
    return (info == null)
        ? buildBodyLoadingState(context)
        : buildBodyReadyState(
            context: context,
            info: info,
          );
  }

  Widget buildBodyLoadingState(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildBodyReadyState({
    required BuildContext context,
    required CartInfo info,
  }) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              ...info.products
                  .map((product) => Text(product.product.price.toString()))
                  .toList(),
            ],
          ),
        ),
        buildBottomRow(context),
      ],
    );
  }

  Widget buildBottomRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          const Expanded(
            child: Text('Сумма'),
          ),
          ElevatedButton(
            child: Text('Купить'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
