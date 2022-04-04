import 'dart:math';
import 'package:flutter/material.dart';

const int primarycolor = 0xffd1ad17;

const String appName = 'Alpha Fruit Zone';

BoxDecoration decoration(double boderradius) => BoxDecoration(
    borderRadius: BorderRadius.circular(boderradius),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
          color: Colors.grey.withOpacity(.7),
          offset: const Offset(3, 2),
          blurRadius: 1)
    ]);

List<DrawerItems> drawerButtons = [
  DrawerItems(icon: Icons.favorite, title: 'My Cart'),
  DrawerItems(icon: Icons.shopping_bag, title: 'My Orders'),
  DrawerItems(icon: Icons.logout, title: 'Logout')
];

class DrawerItems {
  IconData icon;
  String title;

  DrawerItems({required this.icon, required this.title});
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
