import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/core/sizeconfig.dart';
import 'package:mini_wallet/core/utils/constants.dart';
import 'package:mini_wallet/dependency_injection.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/custom_button.dart';
import 'package:mini_wallet/features/home/domain/use_cases/transactions_query_usecase.dart';
import 'package:mini_wallet/features/home/presentation/manager/transaction_cubit/transaction_query_cubit.dart';
import 'package:mini_wallet/features/home/presentation/widgets/summary_widgets/date_button_picker.dart';
import 'package:mini_wallet/features/home/presentation/widgets/summary_widgets/transaction_summary_table.dart';
import 'package:mini_wallet/features/home/presentation/widgets/summary_widgets/transaction_type_list.dart';

class ChartScreenTab extends StatefulWidget {
  const ChartScreenTab({Key? key}) : super(key: key);

  @override
  State<ChartScreenTab> createState() => _ChartScreenTabState();
}

class _ChartScreenTabState extends State<ChartScreenTab> {
  DateTime? toDate;
  DateTime? fromDate;
  TextEditingController toDateController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  GlobalKey<TransactionTypeWidgetState> transactionType =
      GlobalKey<TransactionTypeWidgetState>();

  String getKey(String? k) {
    return k ?? "withdraw";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TransactionQueryCubit>()
        ..getTransactionQuery(
            transactionsQueryParameters: TransactionsQueryParameters(
          startDate: fromDate ?? DateTime.now(),
          endDate: toDate ?? DateTime.now(),
          type: transactionType.currentState?.type ?? "withdraw",
        )),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.03,
          vertical: context.screenWidth * 0.03,
        ),
        child: Column(
          children: [
            SizedBox(
              height: context.screenHeight * 0.3,
              width: context.screenWidth,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: LayoutBuilder(builder: (context, constraint) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DateButtonPicker(
                            fromDate: fromDateController,
                            toDate: toDateController,
                            isToDate: false,
                            height: constraint.maxHeight * 0.14,
                            width: constraint.minWidth,
                            title: 'From',
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: fromDate ?? DateTime.now(),
                                lastDate: DateTime(2050),
                                firstDate: DateTime(2000),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    fromDate = value;
                                    fromDateController.text =
                                        dateFormat.format(value).toString();
                                  });
                                }
                              });
                            },
                          ),
                          DateButtonPicker(
                            fromDate: fromDateController,
                            toDate: toDateController,
                            isToDate: true,
                            height: constraint.maxHeight * 0.14,
                            width: constraint.minWidth,
                            title: 'To',
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: toDate ?? DateTime.now(),
                                lastDate: DateTime(2050),
                                firstDate: DateTime(2000),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    toDate = value;
                                    toDateController.text =
                                        dateFormat.format(value).toString();
                                  });
                                }
                              });
                            },
                          ),
                          SizedBox(
                            height: constraint.maxHeight * 0.05,
                          ),
                          TransactionTypeWidget(
                            key: transactionType,
                          ),
                          GradiantButton(
                            title: 'Search',
                            width: constraint.minWidth * 0.3,
                            height: constraint.maxHeight * 0.15,
                            onPress: () {
                              BlocProvider.of<TransactionQueryCubit>(context)
                                  .getTransactionQuery(
                                transactionsQueryParameters:
                                    TransactionsQueryParameters(
                                  startDate: fromDate ?? DateTime.now(),
                                  endDate: toDate ?? DateTime.now(),
                                  type: transactionType.currentState?.type ??
                                      "withdraw",
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(
              height: context.screenHeight * 0.02,
            ),
            const Expanded(child: TransactionSummaryTable())
          ],
        ),

        // child: BlocBuilder<NewTryTransactionBloc, NewTryTransactionState>(
        //   builder: (context, state) {
        //     // List<FlSpot>? spots = [];
        //     if (state is TransactionLoadSuccess) {
        //       // BlocProvider.of<NewTryTransactionBloc>(context)
        //       //     .generateFlSpots(state)
        //       //     .then((value) {
        //       //   spots = value;
        //       // });
        //       return FutureBuilder<List<FlSpot>>(
        //           future: BlocProvider.of<NewTryTransactionBloc>(context)
        //               .generateFlSpots(state),
        //           builder: (context, snapshot) {
        //             return SizedBox(
        //               height: context.screenHeight * 0.4,
        //               width: context.screenWidth,
        //               child: LineChart(
        //                 LineChartData(
        //                   borderData: FlBorderData(
        //                     show: true,
        //                   ),
        //                   titlesData: FlTitlesData(show: true),
        //                   lineBarsData: [
        //                     LineChartBarData(
        //                       spots: snapshot.data,
        //                       isCurved: false,
        //                       barWidth: 2.5,
        //                       color: AppColorsLight.accent,
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             );
        //           });
        //     }
        //     return const Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),
      ),
    );
  }
}
