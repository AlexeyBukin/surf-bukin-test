import 'package:flutter/material.dart';

class ProfileInfo {

  String name;
  String bodyShapes;
  ImageProvider profileImageProvider;
  String shippingAddress;

  ProfileInfo({
    required this.name,
    required this.bodyShapes,
    required this.profileImageProvider,
    required this.shippingAddress,
  });
}