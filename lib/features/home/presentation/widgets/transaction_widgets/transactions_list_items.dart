import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/core/sizeconfig.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';
import 'package:mini_wallet/core/utils/shared_ui/shimmer_loading.dart';
import 'package:mini_wallet/dependency_injection.dart';
import 'package:mini_wallet/features/home/domain/entities/transaction_entity.dart';
import 'package:mini_wallet/features/home/presentation/manager/my_blocs/new_try_transaction_bloc.dart';
import 'package:mini_wallet/features/home/presentation/widgets/transaction_item_tile.dart';

class TransactionsListItems extends StatelessWidget {
  const TransactionsListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: BlocBuilder<NewTryTransactionBloc, NewTryTransactionState>(
        bloc: sl<NewTryTransactionBloc>()..add(const GetAllTransactionsEvent()),
        buildWhen: (previous, current) {
          return previous != current;
        },
        builder: (context, state) {
          if (state is TransactionLoadInProgress) {
            if (kDebugMode) {
              print(state);
            }
            return const TransactionsListLoading();
          } else if (state is TransactionLoadSuccess) {
            if (kDebugMode) {
              print(state);
            }
            return StreamBuilder<List<TransactionEntity>>(
              initialData: const [],
              stream: state.transactions,
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CupertinoActivityIndicator(
                        color: AppColorsLight.accent,
                        radius: 10,
                      ),
                    ),
                  );
                }
                return SliverPrototypeExtentList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return TransactionItemTile(
                        transactionEntity: snapShot.data![index],
                      );
                    },
                    childCount: snapShot.data!.length,
                  ),
                  prototypeItem: SizedBox(
                    height: context.screenHeight * 0.1,
                  ),
                );
              },
            );
          } else if (state is TransactionLoadFailure) {
            if (kDebugMode) {
              print(state);
            }
            return SliverToBoxAdapter(
              child: Center(
                child: Text(state.message),
              ),
            );
          }

          return const SliverToBoxAdapter();
        },
      ),
      padding: EdgeInsets.only(bottom: context.screenHeight * 0.05),
    );
  }
}

class TransactionsListLoading extends StatelessWidget {
  const TransactionsListLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 5,
        (context, index) => ListTile(
          leading: ShimmerContainer(
            height: context.screenHeight * 0.06,
            width: context.screenWidth * 0.11,
          ),
          title: ShimmerContainer(
            height: context.screenHeight * 0.01,
            // width: context.screenWidth * 0.0,
          ),
          subtitle: ShimmerContainer(
            height: context.screenHeight * 0.01,
            // width: context.screenWidth * 0.0,
          ),
        ),
      ),
    );
  }
}
