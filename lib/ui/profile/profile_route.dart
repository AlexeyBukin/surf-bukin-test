import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf/repository/profile_repository.dart';
import 'package:surf/ui/profile/profile_wm.dart';

import 'profile_screen.dart';

class ProfileScreenRoute extends MaterialPageRoute<void> {
  static const String name = 'profile';

  ProfileScreenRoute()
      : super(
          builder: (ctx) => const ProfileScreen(
            widgetModelBuilder: _createProfileWm,
          ),
        );
}

ProfileWidgetModel _createProfileWm(BuildContext context) {
  return ProfileWidgetModel(
    dependencies: const WidgetModelDependencies(),
    navigator: Navigator.of(context),
    repository: TestProfileRepository(),
  );
}
