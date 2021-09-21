import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf/ui/gallery/gallery_screen.dart';
import 'package:surf/ui/gallery/gallery_wm.dart';

class GalleryScreenRoute extends MaterialPageRoute<void> {
  static const String name = 'gallery';

  GalleryScreenRoute([RouteSettings? settings])
      : super(
          builder: (ctx) => const GalleryScreen(
            widgetModelBuilder: _createGalleryWm,
          ),
          settings: settings,
        );
}

GalleryWidgetModel _createGalleryWm(BuildContext context) {
  return GalleryWidgetModel(
    dependencies: const WidgetModelDependencies(),
    navigator: Navigator.of(context),
  );
}
