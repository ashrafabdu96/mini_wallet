import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_wallet/core/sizeconfig.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';
import 'package:mini_wallet/features/home/presentation/screens/base_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // bool isSplashScreen = true;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const BaseScreen(
            msg: '',
          ),
        ),
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorsLight.background,
      height: context.screenHeight,
      width: context.screenWidth,
      child: Center(
        child: SvgPicture.asset(
          'assets/svg/wallet.svg',
          color: AppColorsLight.primaryDark,
          width: context.screenWidth * 0.35,
        ),
      ),
    );
  }
}
