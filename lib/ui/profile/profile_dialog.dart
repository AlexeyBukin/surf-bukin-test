import 'package:flutter/material.dart';

class ProfileDialog extends StatelessWidget {
  late final controller = TextEditingController(text: defaultValue);
  final String defaultValue;
  final String title;

  ProfileDialog({
    Key? key,
    required this.title,
    required this.defaultValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Отменить'),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(controller.text),
                  child: const Text('Сохранить'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileDialogProxy extends StatefulWidget {
  final Widget child;

  const ProfileDialogProxy({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<ProfileDialogProxy> createState() => ProfileDialogProxyState();
}

class ProfileDialogProxyState extends State<ProfileDialogProxy> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<String?> showProfileDialog({
    required String title,
    required String defaultValue,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProfileDialog(
          defaultValue: defaultValue,
          title: title,
        );
      },
    );
  }
}
