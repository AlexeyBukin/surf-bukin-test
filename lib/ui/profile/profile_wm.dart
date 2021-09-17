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
  final ProfileRepository repository;

  StreamedState<ProfileScreenInfoState> streamedState =
      StreamedState(ProfileScreenInfoState());

  @override
  void onLoad() {
    // unawaited
    loadInfo();
    super.onLoad();
  }

  Future<void> loadInfo() async {
    Future name = repository.getName();
    Future address = repository.getShippingAddress();
    Future shapes = repository.getBodyShapesInfo();
    Future image = repository.getProfileImageProvider();
    streamedState.accept(ProfileScreenInfoState(
        profileInfo: ProfileInfo(
      name: await name,
      profileImageProvider: await image,
      bodyShapes: await shapes,
      shippingAddress: await address,
    )));
  }
}

class ProfileScreenInfoState {
  ProfileInfo? profileInfo;

  ProfileScreenInfoState({this.profileInfo});
}
