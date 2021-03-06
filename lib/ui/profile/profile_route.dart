import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf/interactor/profile/profile_repository.dart';
import 'package:surf/ui/profile/profile_screen.dart';
import 'package:surf/ui/profile/profile_wm.dart';

class ProfileScreenRoute extends MaterialPageRoute<void> {
  static const String name = 'profile';

  ProfileScreenRoute([RouteSettings? settings])
      : super(
          builder: (ctx) => const ProfileScreen(
            widgetModelBuilder: _createProfileWm,
          ),
          settings: settings,
        );
}

ProfileWidgetModel _createProfileWm(BuildContext context) {
  return ProfileWidgetModel(
    dependencies: const WidgetModelDependencies(),
    navigator: Navigator.of(context),
    repository: TestProfileRepository(),
  );
}
