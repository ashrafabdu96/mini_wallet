import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/core/sizeconfig.dart';
import 'package:mini_wallet/core/utils/shared_ui/shimmer_loading.dart';
import 'package:mini_wallet/features/home/presentation/manager/my_blocs/header_bloc/header_bloc.dart';
import 'package:mini_wallet/features/home/presentation/widgets/income_expense_row.dart';
import 'package:mini_wallet/features/home/presentation/widgets/total_balance_widget.dart';

class TotalsSection extends StatelessWidget {
  const TotalsSection({Key? key, required this.height, required this.width})
      : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HeaderBloc>(context).getHeaderInfo();
    if (kDebugMode) {
      print("built=========>");
    }
    return BlocBuilder<HeaderBloc, HeaderState>(
      // bloc: ,
      builder: (context, state) {
        if (state is HeaderSuccessState) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              IncomeExpenseRow(
                expenseTotal: state.headerEntity.totalWithdrawals ?? 0.0,
                incomeTotal: state.headerEntity.totalDeposits ?? 0.0,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  TotalBalanceWidget(
                    total: "\$${state.headerEntity.balance ?? 0.0}",
                  ),
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<HeaderBloc>(context).getHeaderInfo();
                      },
                      icon: const Icon(Icons.refresh))
                ],
              ),
            ],
          );
        } else if (state is HeaderFailureState) {
          return Center(child: Text(state.message));
        } else {
          return const TotalsSectionLoading();
        }
      },
    );
  }
}

class TotalsSectionLoading extends StatelessWidget {
  const TotalsSectionLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: ShimmerContainer(
                  height: context.screenHeight * 0.1,
                  width: context.screenWidth * 0.5,
                ),
              ),
              SizedBox(
                width: context.screenWidth * 0.05,
              ),
              // Spacer(),
              Expanded(
                child: ShimmerContainer(
                  height: context.screenHeight * 0.1,
                  width: context.screenWidth * 0.5,
                ),
              ),
            ],
          ),
          SizedBox(
            height: context.screenHeight * 0.01,
          ),
          ShimmerContainer(
            height: context.screenHeight * 0.1,
            width: context.screenWidth * 0.5,
          ),
        ],
      ),
    );
  }
}
