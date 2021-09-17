import 'package:flutter/material.dart';
import 'package:surf/domain/profile.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'profile_wm.dart';

class ProfileScreen extends CoreMwwmWidget<ProfileWidgetModel> {
  const ProfileScreen({
    Key? key,
    required WidgetModelBuilder<ProfileWidgetModel> widgetModelBuilder,
  }) : super(
          key: key,
          widgetModelBuilder: widgetModelBuilder,
        );

  @override
  WidgetState<CoreMwwmWidget<ProfileWidgetModel>, ProfileWidgetModel>
      createWidgetState() => _ProfileScreenState();
}

class _ProfileScreenState
    extends WidgetState<ProfileScreen, ProfileWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
      ),
      body: StreamedStateBuilder(
        streamedState: wm.streamedState,
        builder: buildProfile,
      ),
    );
  }

  Widget buildProfile(BuildContext context, ProfileScreenInfoState state) {
    final info = state.profileInfo;
    return Scaffold(
      body: (info == null)
          ? buildBodyLoadingState(context)
          : buildBodyReadyState(
              context: context,
              info: info,
            ),
    );
  }

  Widget buildBodyLoadingState(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildBodyReadyState({
    required BuildContext context,
    required ProfileInfo info,
  }) {
    return Center(
      child: Column(children: [
        Image(image: info.profileImageProvider),
        Text(info.name),
        Text(info.bodyShapes),
        Text(info.shippingAddress),
      ]),
    );
  }
}
