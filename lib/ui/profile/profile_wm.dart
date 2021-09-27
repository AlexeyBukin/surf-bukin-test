import 'package:flutter/material.dart';
import 'package:surf/domain/profile.dart';
import 'package:surf/interactor/profile/profile_interactor.dart';
import 'package:surf/interactor/profile/profile_repository.dart';
import 'package:surf/ui/profile/profile_dialog.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

class ProfileWidgetModel extends WidgetModel {

  final profileScreenTitle = 'Профиль';
  final nameFieldTitle = 'Имя';
  final emailFieldTitle = 'Электронная Почта';
  final addressFieldTitle = 'Адрес';
  final zipCodeFieldTitle = 'Почтовый Индекс';
  final bodyShapesFieldTitle = 'Размеры Одежды';

  final NavigatorState navigator;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ProfileDialogProxyState> dialogKey =
      GlobalKey<ProfileDialogProxyState>();
  final ProfileRepository repository;
  final ProfileInteractor interactor;
  late ProfileInfo profileInfo;
  late StreamedState<ProfileScreenInfoState> streamedState;

  ProfileWidgetModel({
    required WidgetModelDependencies dependencies,
    required this.navigator,
    required this.repository,
  }) : interactor = ProfileInteractor(repository), super(dependencies);

  @override
  void onLoad() {
    streamedState = StreamedState(const ProfileScreenInfoState());
    // unawaited
    _loadInfo();
    super.onLoad();
  }

  void openZipCodeDialog() => _openDialog(
      getter: profileInfo.zipCode,
      setter: (zipCode) => profileInfo..zipCode = zipCode,
      title: zipCodeFieldTitle,
    );

  void openAddressDialog() => _openDialog(
      getter: profileInfo.shippingAddress,
      setter: (address) => profileInfo..shippingAddress = address,
      title: addressFieldTitle,
    );

  void openBodyShapesDialog() => _openDialog(
      getter: profileInfo.bodyShapes,
      setter: (shapes) => profileInfo..bodyShapes = shapes,
      title: bodyShapesFieldTitle,
    );

  void openNameDialog() => _openDialog(
    getter: profileInfo.name,
    setter: (name) => profileInfo..name = name,
    title: nameFieldTitle,
  );

  void openEmailDialog() => _openDialog(
    getter: profileInfo.email,
    setter: (email) => profileInfo..email = email,
    title: emailFieldTitle,
  );

  Future<void> _openDialog({
    required String getter,
    required ProfileInfo? Function(String) setter,
    required String title,
  }) async {
    final newValue =  await dialogKey.currentState?.showProfileDialog(
      title: title,
      defaultValue: getter,
    );
    if (newValue != null && newValue != getter) {
      await streamedState.accept(
        ProfileScreenInfoState(
          profileInfo: setter(newValue),
        ),
      );
    }
  }

  Future<void> _loadInfo() async {
    await streamedState.accept(
      ProfileScreenInfoState(
        profileInfo: await interactor.loadProfileInfo(),
      ),
    );
  }
}

@immutable
class ProfileScreenInfoState {
  final ProfileInfo? profileInfo;

  const ProfileScreenInfoState({
    this.profileInfo,
  });
}
