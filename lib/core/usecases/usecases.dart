// import 'package:flutter/material.dart';
//
import 'package:dartz/dartz.dart';
import 'package:mini_wallet/core/errors/failure.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}

// extension MediaQueryDataExtension on BuildContext {
//   MediaQueryData get mediaQueryData => MediaQuery.of(this);
//
//   double get screenWidth =>
//       isLandscape ? screenHeight : mediaQueryData.size.width;
//   double get screenHeight =>
//       isLandscape ? screenWidth : mediaQueryData.size.height;
//   double get devicePixelRatio => mediaQueryData.devicePixelRatio;
//   EdgeInsets get padding => mediaQueryData.padding;
//   EdgeInsets get viewInsets => mediaQueryData.viewInsets;
//   bool get isLandscape => mediaQueryData.orientation == Orientation.landscape;
//   bool get isPortrait => mediaQueryData.orientation == Orientation.portrait;
// }
// // FormData.;
