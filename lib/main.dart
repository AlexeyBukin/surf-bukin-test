import 'package:flutter/material.dart';
import 'package:surf/ui/cart/cart_route.dart';
import 'package:surf/ui/gallery/gallery_route.dart';
import 'package:surf/ui/profile/profile_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  static const String myAppName = 'SportShop Demo';

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: myAppName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case GalleryScreenRoute.name: return GalleryScreenRoute();
          case CartScreenRoute.name: return CartScreenRoute();
          case ProfileScreenRoute.name: return ProfileScreenRoute();
        }
      },
      // initialRoute: GalleryScreenRoute.name,
      initialRoute: ProfileScreenRoute.name,
    );
  }
}
