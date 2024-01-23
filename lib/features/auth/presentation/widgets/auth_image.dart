import 'package:flutter/material.dart';
import 'package:mini_wallet/core/sizeconfig.dart';

class AuthImage extends StatelessWidget {
  const AuthImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logo.png",
      height: context.screenHeight * 0.3,
      width: context.screenWidth * 0.8,
    );
  }
}
