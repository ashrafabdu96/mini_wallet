import 'package:flutter/material.dart';
import 'package:mini_wallet/core/sizeconfig.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';
import 'package:mini_wallet/features/home/presentation/widgets/income_expense_card.dart';

class IncomeExpenseRow extends StatelessWidget {
  const IncomeExpenseRow(
      {Key? key, required this.expenseTotal, required this.incomeTotal})
      : super(key: key);
  final double expenseTotal;
  final double incomeTotal;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: IncomeExpenseCard(
            color: AppColorsLight.primaryDark,
            title: "Income",
            icon: Icons.arrow_upward,
            amount: "\$ ${incomeTotal.toString()}",
          ),
        ),
        SizedBox(
          width: context.screenWidth * 0.03,
        ),
        Expanded(
          child: IncomeExpenseCard(
            color: AppColorsLight.accent,
            title: "Expense",
            icon: Icons.arrow_downward,
            amount: "-" "\$ ${expenseTotal.toString()}",
          ),
        ),
      ],
    );
  }
}
