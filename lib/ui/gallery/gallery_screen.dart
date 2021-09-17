import 'package:flutter/material.dart';
import 'package:surf/ui/drawer/drawer.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'gallery_wm.dart';

class GalleryScreen extends CoreMwwmWidget<GalleryWidgetModel> {
  const GalleryScreen({
    Key? key,
    required WidgetModelBuilder<GalleryWidgetModel> widgetModelBuilder,
  }) : super(
    key: key,
    widgetModelBuilder: widgetModelBuilder,
  );

  @override
  WidgetState<CoreMwwmWidget<GalleryWidgetModel>, GalleryWidgetModel>
  createWidgetState() => _GalleryScreenState();
}

class _GalleryScreenState extends WidgetState<GalleryScreen, GalleryWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Галерея'),
      ),
      drawer: const SportShopDrawer(),
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