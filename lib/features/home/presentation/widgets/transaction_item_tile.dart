import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_wallet/core/sizeconfig.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';
import 'package:mini_wallet/core/utils/constants.dart';
import 'package:mini_wallet/features/home/domain/entities/transaction_entity.dart';

class TransactionItemTile extends StatelessWidget {
  const TransactionItemTile({
    super.key,
    required this.transactionEntity,
  });
  final TransactionEntity transactionEntity;
  @override
  Widget build(BuildContext context) {
    // final dateFormat = DateFormat('dd/MMM/yy-h:mma');
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.screenHeight * 0.01,
      ),
      decoration: BoxDecoration(
        color: AppColorsLight.white,
        borderRadius: BorderRadius.circular(defaultRadius),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            // spreadRadius: 0.2,
            blurRadius: 5,
            color: AppColorsLight.black.withOpacity(
              0.2,
            ),
          )
        ],
      ),
      padding: const EdgeInsets.all(defaultSpacing / 4),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
              color: transactionEntity.type == "deposit"
                  ? AppColorsLight.primaryDark
                  : AppColorsLight.accent,
              borderRadius: BorderRadius.circular(defaultRadius)),
          padding: const EdgeInsets.all(defaultSpacing / 2),
          child: SvgPicture.asset(
            transactionEntity.type == "deposit"
                ? "assets/svg/deposit.svg"
                : "assets/svg/withdraw.svg",
            color: AppColorsLight.black,
            fit: BoxFit.fill,
          ),
        ),
        title: Text(
          transactionEntity.destinationOrSource,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          transactionEntity.destinationOrSourceAccount,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColorsLight.fontDark, fontWeight: FontWeight.w500),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                transactionEntity.type == "deposit"
                    ? "\$${transactionEntity.amount}"
                    : "-\$${transactionEntity.amount}",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColorsLight.accent,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            Expanded(
              child: Text(
                dateFormat.format(transactionEntity.date.toDate()).toString(),
                // DateTime.parse('MM/dd/yyyy HH:mm:ss').toString(),
                // (transactionEntity.date.toDate().toIso8601String())
                //     .replaceAll("T", " ")
                //     .substring(0, 16)
                //     .toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
