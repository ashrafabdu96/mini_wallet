import 'package:flutter/material.dart';
import 'package:mini_wallet/core/sizeconfig.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';

class TotalBalanceWidget extends StatelessWidget {
  const TotalBalanceWidget({
    super.key,
    required this.total,
  });
  final String total;
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // SizedBox(
        //   height: context.screenHeight * 0.01,
        // ),
        Text(
          total,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: context.screenHeight * 0.001,
        ),
        Text(
          "Total Balance",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColorsLight.fontLight,
              ),
        ),
        SizedBox(
          height: context.screenHeight * 0.03,
        ),
      ],
    );
  }
}
