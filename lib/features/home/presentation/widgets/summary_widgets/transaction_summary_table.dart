import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/core/sizeconfig.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';
import 'package:mini_wallet/core/utils/constants.dart';
import 'package:mini_wallet/core/utils/shared_ui/shimmer_loading.dart';
import 'package:mini_wallet/features/home/domain/entities/transaction_entity.dart';
import 'package:mini_wallet/features/home/presentation/manager/transaction_cubit/transaction_query_cubit.dart';

class TransactionSummaryTable extends StatelessWidget {
  const TransactionSummaryTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<TransactionQueryCubit, TransactionQueryState>(
          builder: (context, state) {
            print("-----> $state");
            if (state is TransactionQuerySuccessState) {
              // state.
              List<TransactionEntity> transactions = state.transactionsQuery;
              double totalAmount = transactions.fold(
                0,
                (previousValue, element) => previousValue + element.amount,
              );
              return DataTable(
                onSelectAll: (value) {},
                headingTextStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColorsLight.white),
                clipBehavior: Clip.antiAlias,
                border: TableBorder.all(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColorsLight.black,
                  width: 2.0,
                ),
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => AppColorsLight.primaryDark.withOpacity(1)),
                dataRowColor: MaterialStateColor.resolveWith(
                    (states) => AppColorsLight.white),
                dividerThickness: 2.0,
                dataTextStyle: const TextStyle(
                    color: AppColorsLight.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                columnSpacing: 8.0,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('Date'),
                    tooltip: 'The date of the transaction',
                  ),
                  DataColumn(
                    label: Text('Transaction Type'),
                    tooltip: 'The type of the transaction',
                  ),
                  DataColumn(
                    label: Text('Source'),
                    tooltip: 'The source of the transaction',
                  ),
                  DataColumn(
                    label: Text('Source Account'),
                    tooltip: 'The account used for the transaction',
                  ),
                  DataColumn(
                    label: Text('Amount'),
                    tooltip: 'The amount of the transaction',
                  ),
                ],
                rows: transactions.map((transaction) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            dateFormat
                                .format(transaction.date.toDate())
                                .toString(),
                          ),
                        ),
                      ),
                      DataCell(Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(transaction.type),
                      )),
                      DataCell(Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(transaction.destinationOrSource),
                      )),
                      DataCell(Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(transaction.destinationOrSourceAccount),
                      )),
                      DataCell(Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(transaction.amount.toString()),
                      )),
                    ],
                  );
                }).toList()
                  ..add(
                    DataRow(
                      cells: <DataCell>[
                        const DataCell(SizedBox()),
                        const DataCell(SizedBox()),
                        const DataCell(SizedBox()),
                        const DataCell(SizedBox()),
                        DataCell(Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: AppColorsLight.primaryDark.withOpacity(1),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Text(
                            'Total: ${totalAmount.toString()}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        )),
                      ],
                    ),
                  ),
              );
            } else if (state is TransactionQueryFailure) {
              return Center(
                child: Text(state.message.toString()),
              );
            } else {
              return ShimmerContainer(
                height: context.screenHeight * 0.4,
                width: context.screenWidth,
              );
            }
          },
        ),
      ),
    );
  }
}
