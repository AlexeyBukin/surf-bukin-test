import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surf/domain/product.dart';
import 'package:surf/interactor/gallery/gallery_interactor.dart';
import 'package:surf/interactor/gallery/gallery_repository.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

class GalleryWidgetModel extends WidgetModel {

  static const portionSize = 10;

  final NavigatorState navigator;
  final GalleryRepository repository;
  final GalleryInteractor interactor;

  GalleryWidgetModel({
    required WidgetModelDependencies dependencies,
    required this.navigator,
    required this.repository,
  }) : interactor = GalleryInteractor(repository), super(dependencies);

  // TODO make streamed state
  List<Product> products = [];
  int portionsLoaded = 0;

  @override
  void onLoad() {
    super.onLoad();
    unawaited(_loadProducts());
  }

  Future<void> _loadProducts() async {
    products = await interactor.getProductsPortion(portionNum: portionsLoaded, portionSize: portionSize);
    portionsLoaded++;
  }
}
