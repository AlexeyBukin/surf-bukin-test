import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

class GalleryWidgetModel extends WidgetModel {
  GalleryWidgetModel({
    required WidgetModelDependencies dependencies,
    required this.navigator,
  }) : super(dependencies);

  final NavigatorState navigator;

  // TODO remove
  List<String> products = [];

  @override
  void onLoad() {
    // TODO add logic
    super.onLoad();
  }
}
