import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tenantapp/helpers/constant.dart';
import 'package:tenantapp/models/user.dart';
import 'package:tenantapp/common/Constants.dart';


class App {
  static String? _currentUserNo;

  static bool get isInDebugMode {
    // Assume you're in production mode
    bool inDebugMode = false;

    // Assert expressions are only evaluated during development. They are ignored
    // in production. Therefore, this code only sets `inDebugMode` to true
    // in a development environment.
    assert(inDebugMode = true);

    return inDebugMode;
  }

  static Future<void> reportError(dynamic error, dynamic stackTrace) async {
    // Print the exception to the console
    print('Caught error: $error');
    if (isInDebugMode) {
      // Print the full stacktrace in debug mode
      print(stackTrace);
      return;
    } else {
      // Send the Exception and Stacktrace to Sentry in Production mode
      print(stackTrace);
    }
  }

  static void ShowSnackBar(SnackBar snackBar, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  App();

  static void internetLookUp(BuildContext context) {
    try {
      InternetAddress.lookup('google.co.in').catchError((e) {
        App.ShowSnackBar(SnackBar(
          content: Text('No internet connection.'),
          backgroundColor: Colors.redAccent,
        ), context);
      });
    } catch (_) {
      App.ShowSnackBar(SnackBar(
        content: Text('No internet connection.'),
        backgroundColor: Colors.redAccent,
      ), context);
    }
  }

  static Widget avatar(Map<String, dynamic> user,
      {File? image, double radius = 22.5}) {
    if (image == null) {
      return (user[PHOTO_URL] ?? '').isNotEmpty
          ? CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(user[PHOTO_URL]),
          radius: radius)
          : CircleAvatar(
        foregroundColor: Colors.white,
        child: Text(getInitials(App.getNickname(user))),
        radius: radius,
      );
    }
    return CircleAvatar(
        backgroundImage: Image.file(image).image, radius: radius);
  }

  static Widget avatarUser(User user,
      {File? image, double radius = 22.5}) {
    if (image == null) {
      return (user.photoURL ?? '').isNotEmpty
          ? CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(user.photoURL!),
          radius: radius)
          : CircleAvatar(
        foregroundColor: Colors.white,
        child: Text(getInitials(user.displayName!)),
        radius: radius,
      );
    }
    return CircleAvatar(
        backgroundImage: Image.file(image).image, radius: radius);
  }

  static Widget avatarIcon(IconData iconData, {double radius = 22.5}) {
    return CircleAvatar(
      foregroundColor: Colors.white,
      child: Icon(iconData),
      radius: radius,
    );
  }


  static Widget getAlertIcon(
      {IconData? iconData, String? imageUrl, double radius = 22.5}) {
    if (imageUrl != null) {
      return avatarByUrlAndName("", photoUrl: imageUrl);
    } else {
      return avatarIcon(iconData!);
    }
  }

  static Widget avatarByUrlAndName(String displayName,
      {String? photoUrl, File? image, double radius = 22.5}) {
    if (image == null) {
      return (photoUrl ?? '').isNotEmpty
          ? CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(photoUrl!),
          radius: radius)
          : CircleAvatar(
        foregroundColor: Colors.white,
        child: Text(getInitials(displayName)),
        radius: radius,
      );
    }
    return CircleAvatar(
        backgroundImage: Image.file(image).image, radius: radius);
  }

  static String getNickname(Map<String, dynamic> user) => user[DISPLAY_NAME];

  static String getInitials(String name) {
    try {
      List<String> names =
      name.trim().replaceAll(RegExp(r'[\W]'), '').toUpperCase().split(' ');
      names.retainWhere((s) => s.trim().isNotEmpty);
      if (names.length >= 2)
        return names.elementAt(0)[0] + names.elementAt(1)[0];
      else if (names.elementAt(0).length >= 2)
        return names.elementAt(0).substring(0, 2);
      else
        return names.elementAt(0)[0];
    } catch (e) {
      return '?';
    }
  }

  static String getCurrentUserNo() {
    return _currentUserNo ?? "";
  }

  static void setCurrentUserNo(String userNo) {
    _currentUserNo = userNo;
  }
}
