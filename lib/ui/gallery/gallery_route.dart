import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'gallery_screen.dart';
import 'gallery_wm.dart';

class GalleryScreenRoute extends MaterialPageRoute<void> {

  static const String name = 'gallery';

  GalleryScreenRoute()
      : super(
          builder: (ctx) => const GalleryScreen(
            widgetModelBuilder: _createGalleryWm,
          ),
        );
}

GalleryWidgetModel _createGalleryWm(BuildContext context) {
  return GalleryWidgetModel(
    dependencies: const WidgetModelDependencies(),
    navigator: Navigator.of(context),
  );
}