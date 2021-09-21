import 'dart:math';

import 'package:flutter/material.dart';
import 'package:surf/ui/cart/cart_route.dart';
import 'package:surf/ui/gallery/gallery_route.dart';
import 'package:surf/ui/profile/profile_route.dart';

class SportShopDrawer extends StatelessWidget {
  const SportShopDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(randomCatchPhrase()),
            ),
          ),
          const _SportShopDrawerItem(
            routeName: GalleryScreenRoute.name,
            title: 'Галерея',
          ),
          const _SportShopDrawerItem(
            routeName: ProfileScreenRoute.name,
            title: 'Профиль',
          ),
          const _SportShopDrawerItem(
            routeName: CartScreenRoute.name,
            title: 'Корзина',
          ),
        ],
      ),
    );
  }

  String randomCatchPhrase() {
    final phrases = [
      'Заценим скидочки?',
      'Поищем любимый цвет?',
      'Новое поступление!',
      'Корзина резиновая!',
      'Время покупать!',
    ];
    final n = Random().nextInt(phrases.length);
    return phrases[n];
  }
}

class _SportShopDrawerItem extends StatelessWidget {
  final String routeName;
  final String title;

  const _SportShopDrawerItem({
    required this.routeName,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final isActive = ModalRoute.of(context)?.settings.name == routeName;
    return ListTile(
      onTap: isActive
          ? null
          : () => navigator..pop()..pushReplacementNamed(routeName),
      selected: isActive,
      title: Text(title),
    );
  }
}
