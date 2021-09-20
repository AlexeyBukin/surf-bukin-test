import 'package:flutter/material.dart';

abstract class ProfileRepository {
  Future<String> getName();

  Future<String> getBodyShapesInfo();

  Future<ImageProvider> getProfileImageProvider();

  Future<String> getShippingAddress();

  Future<String> getEmail();

  Future<String> getZipCode();
}

class TestProfileRepository implements ProfileRepository {
  @override
  Future<String> getBodyShapesInfo() {
    return Future.value('90 60 90');
  }

  @override
  Future<String> getName() {
    return Future.value('Наталья Иванова');
  }

  @override
  Future<ImageProvider> getProfileImageProvider() {
    const testUrl =
        'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8d29tYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80';
    return Future.value(const NetworkImage(testUrl));
  }

  @override
  Future<String> getShippingAddress() {
    return Future.value('город Владимир, проспект Мира, дом 69, квартира 420');
  }

  @override
  Future<String> getEmail() {
    return Future.value('natalia.ivanova@gmail.com');
  }

  @override
  Future<String> getZipCode() {
    return Future.value('234123');
  }
}
