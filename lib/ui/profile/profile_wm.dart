import 'package:flutter/material.dart';
import 'package:surf/domain/profile.dart';
import 'package:surf/repository/profile_repository.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

class ProfileWidgetModel extends WidgetModel {
  ProfileWidgetModel({
    required WidgetModelDependencies dependencies,
    required this.navigator,
    required this.repository,
  }) : super(dependencies);

  final NavigatorState navigator;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ProfileRepository repository;

  late StreamedState<ProfileScreenInfoState> streamedState;

  @override
  void onLoad() {
    streamedState =
        StreamedState(ProfileScreenInfoState());
    // unawaited
    loadInfo();
    super.onLoad();
  }

  Future<void> loadInfo() async {
    final name = repository.getName();
    final address = repository.getShippingAddress();
    final shapes = repository.getBodyShapesInfo();
    final image = repository.getProfileImageProvider();
    final email = repository.getEmail();
    final zipCode = repository.getZipCode();
    streamedState.accept(
      ProfileScreenInfoState(
        profileInfo: ProfileInfo(
          name: await name,
          profileImageProvider: await image,
          bodyShapes: await shapes,
          shippingAddress: await address,
          email: await email,
          zipCode: await zipCode,
        ),
      ),
    );
  }
}

class ProfileScreenInfoState {
  ProfileInfo? profileInfo;

  ProfileScreenInfoState({
    this.profileInfo,
  });
}
