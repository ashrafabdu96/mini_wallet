import 'package:flutter/material.dart';

extension MediaQueryDataExtension on BuildContext {
  MediaQueryData get mediaQueryData => MediaQuery.of(this);

  double get screenWidth =>
      isLandscape ? screenHeight : mediaQueryData.size.width;
  double get screenHeight =>
      isLandscape ? screenWidth : mediaQueryData.size.height;
  double get devicePixelRatio => mediaQueryData.devicePixelRatio;
  EdgeInsets get padding => mediaQueryData.padding;
  EdgeInsets get viewInsets => mediaQueryData.viewInsets;
  bool get isLandscape => mediaQueryData.orientation == Orientation.landscape;
  bool get isPortrait => mediaQueryData.orientation == Orientation.portrait;
}
