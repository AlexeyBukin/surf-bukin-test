import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:surf/domain/profile.dart';
import 'package:surf/ui/drawer/drawer.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Профиль'),
        // getting rid of shadow
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: const SportShopDrawer(),
      body: StreamedStateBuilder(
        streamedState: wm.streamedState,
        builder: buildProfile,
      ),
    );
  }

  Widget buildProfile(BuildContext context, ProfileScreenInfoState state) {
    final info = state.profileInfo;
    return (info == null)
        ? buildBodyLoadingState(context)
        : buildBodyReadyState(
            context: context,
            info: info,
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
    final Color imageFilterColor = Theme.of(context).primaryColor;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(imageFilterColor, BlendMode.darken),
          child: Image(image: info.profileImageProvider),
        ),
        SingleChildScrollView(
          child: PhysicalModel(
            elevation: 20,
            shadowColor: Colors.red,
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            child: Column(
              children: [
                CircleAvatar(
                  foregroundImage: info.profileImageProvider,
                  maxRadius: 50,
                  minRadius: 20,
                ),
                Text(info.name),
                Text(info.bodyShapes),
                Text(info.shippingAddress),
              ],
            ),
          ),
        ),
      ],
    );
    return Center(
      child: Column(children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Column(
              children: [
                ColorFiltered(
                  colorFilter:
                      ColorFilter.mode(imageFilterColor, BlendMode.darken),
                  child: Image(image: info.profileImageProvider),
                ),
                PhysicalModel(
                  color: Colors.teal,
                  elevation: 100,
                  shadowColor: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(width: 100, height: 100),
                )
                // Material(
                //   elevation: 100,
                //   child: Container(
                //     height: 60,
                //   ),
                // ),
              ],
            ),
            CircleAvatar(
              foregroundImage: info.profileImageProvider,
              maxRadius: 50,
              minRadius: 20,
            ),
          ],
        ),
      ]),
    );
  }
}
