// import 'package:firebase_learning/core/utils/app_colors/pallete.dart';
import 'package:flutter/material.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';

class GradiantButton extends StatelessWidget {
  const GradiantButton(
      {Key? key,
      required this.title,
      this.onPress,
      required this.width,
      required this.height})
      : super(key: key);
  final String title;
  final void Function()? onPress;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColorsLight.primaryDark,
          boxShadow: const [
            BoxShadow(
                color: AppColorsLight.fontDark,
                blurRadius: 4,
                blurStyle: BlurStyle.inner),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColorsLight.white,
            ),
          ),
        ),
      ),
    );
  }
}
