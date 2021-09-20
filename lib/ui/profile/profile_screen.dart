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
      key: wm.scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Профиль'),
        // getting rid of shadow
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [buildSettingsAction(context)],
      ),
      drawer: const SportShopDrawer(),
      body: StreamedStateBuilder(
        streamedState: wm.streamedState,
        builder: buildProfile,
      ),
    );
  }

  Widget buildSettingsAction(context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GestureDetector(onTap: () {}, child: const Icon(Icons.settings)),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          buildBodyHead(context: context, info: info),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: buildBodyDatafields(context: context, info: info),
          ),
        ],
      ),
    );
  }

  Widget buildBodyHead({
    required BuildContext context,
    required ProfileInfo info,
  }) {
    final Color imageFilterColor = Theme.of(context).primaryColor;
    const photoSize = 70.0;
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Column(
              children: [
                ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                      Colors.black38, BlendMode.luminosity),
                  child: ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(imageFilterColor, BlendMode.color),
                    child: Image(image: info.profileImageProvider),
                  ),
                ),
                // TODO find better solution
                Container(
                  height: photoSize,
                ),
              ],
            ),
            const PhysicalModel(
              elevation: 2.0,
              shape: BoxShape.circle,
              color: Colors.white,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: photoSize + 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: CircleAvatar(
                foregroundImage: info.profileImageProvider,
                maxRadius: photoSize,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(info.name.toUpperCase(),
              style: const TextStyle(fontSize: 24)),
        ),
      ],
    );
  }

  Widget buildBodyDatafields({
    required BuildContext context,
    required ProfileInfo info,
  }) {
    return Column(
      children: [
        ProfileDatafield(
          title: 'Имя',
          value: info.name,
        ),
        const Divider(),
        ProfileDatafield(
          title: 'Электронная Почта',
          value: info.email,
        ),
        const Divider(),
        ProfileDatafield(
          title: 'Адрес',
          value: info.shippingAddress,
        ),
        const Divider(),
        ProfileDatafield(
          title: 'Почтовый Индекс',
          value: info.zipCode,
        ),
        const Divider(),
        ProfileDatafield(
          title: 'Размеры Одежды',
          value: info.bodyShapes,
        ),
      ],
    );
  }
}

class ProfileDatafield extends StatelessWidget {
  final String title;
  final String value;

  // final void Function() onEdit;

  const ProfileDatafield({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {},
      ),
    );
  }
}
