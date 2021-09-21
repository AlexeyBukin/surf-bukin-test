import 'package:flutter/material.dart';
import 'package:surf/domain/cart.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

class CartWidgetModel extends WidgetModel {

  final NavigatorState navigator;
  late StreamedState<CartScreenInfoState> streamedState;

  CartWidgetModel({
    required WidgetModelDependencies dependencies,
    required this.navigator,
  }) : super(dependencies);

  @override
  void onLoad() {
    streamedState = StreamedState(const CartScreenInfoState());
    super.onLoad();
  }
}


@immutable
class CartScreenInfoState {
  final CartInfo? cartInfo;

  const CartScreenInfoState({
    this.cartInfo,
  });
}
