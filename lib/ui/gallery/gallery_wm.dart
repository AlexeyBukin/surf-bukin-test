import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

class GalleryWidgetModel extends WidgetModel {

  final NavigatorState navigator;

  GalleryWidgetModel({
    required WidgetModelDependencies dependencies,
    required this.navigator,
  }) : super(dependencies);

  // TODO remove
  List<String> products = [];

  @override
  void onLoad() {
    // TODO add logic
    super.onLoad();
  }
}
