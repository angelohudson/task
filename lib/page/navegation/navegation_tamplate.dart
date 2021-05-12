import 'package:flutter/material.dart';

class NavegationItemTamplate {
  NavegationItemTamplate({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;
}

enum DrawerIndex {
  HOME,
  CALENDARIO,
}
