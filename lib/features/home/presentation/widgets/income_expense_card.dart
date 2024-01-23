import 'package:flutter/material.dart';
import 'package:mini_wallet/core/sizeconfig.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';
import 'package:mini_wallet/core/utils/constants.dart';

class IncomeExpenseCard extends StatelessWidget {
  const IncomeExpenseCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    this.color,
  });
  final String title;
  final String amount;
  final IconData icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * 0.4,
      padding: EdgeInsets.all(context.screenWidth * 0.02),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            // spreadRadius: 0.2,
            blurRadius: 5,
            color: title == "Income"
                ? AppColorsLight.primaryDark
                : AppColorsLight.accent,
          )
        ],
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColorsLight.white,
                      letterSpacing: 1),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  amount,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColorsLight.white,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(
            icon,
            color: AppColorsLight.white,
          ),
        ],
      ),
    );
  }
}
