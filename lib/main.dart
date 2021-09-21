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
      debugShowCheckedModeBanner: false,
      title: myAppName,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case GalleryScreenRoute.name: return GalleryScreenRoute(settings);
          case CartScreenRoute.name: return CartScreenRoute(settings);
          case ProfileScreenRoute.name: return ProfileScreenRoute(settings);
        }
      },
      // initialRoute: GalleryScreenRoute.name,
      initialRoute: ProfileScreenRoute.name,
    );
  }
}
