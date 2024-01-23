import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors/app_colors_light.dart';

class SignOrLogin extends StatelessWidget {
  const SignOrLogin({
    super.key,
    required this.textOne,
    required this.textTwo,
    this.onTap,
  });
  final String textOne;
  final String textTwo;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: ,
      children: [
        Text(textOne),
        InkWell(
          onTap: onTap,
          child: Text(
            textTwo,
            style: const TextStyle(
              color: AppColorsLight.primaryDark,
            ),
          ),
        ),
      ],
    );
  }
}
