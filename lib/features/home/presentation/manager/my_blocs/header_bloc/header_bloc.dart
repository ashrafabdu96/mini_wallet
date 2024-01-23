import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/features/home/domain/entities/header_entity.dart';
// import 'package:firebase_learning/features/home/domain/use_cases/get_all_transactions_usecase.dart';
import 'package:mini_wallet/features/home/domain/use_cases/get_total_usecase.dart';
import 'package:mini_wallet/features/home/domain/use_cases/try_get_all_transactions_usecase.dart';

part 'header_event.dart';
part 'header_state.dart';

class HeaderBloc extends Cubit<HeaderState> {
  final GetTotalUseCase _getTotalUseCase;
  // final TransactionsCubit transactionCubit;
  // late StreamSubscription transactionStreamSubscription;
  HeaderBloc({
    // required this.transactionCubit,
    required GetTotalUseCase getTotalUseCase,
  })  : _getTotalUseCase = getTotalUseCase,
        super(const HeaderInitialState()) {
    // transactionStreamSubscription = transactionMonitor();
  }

  // StreamSubscription<TransactionsState> transactionMonitor() {
  //   return transactionCubit.stream.listen((transactionState) {
  //     if (transactionState.withdrawStatus == RequestStatus.none) {
  //       getHeaderInfo();
  //     }
  //     if (transactionState.depositStatus == RequestStatus.none ||
  //         transactionState.copyWith().depositStatus == RequestStatus.success) {
  //       getHeaderInfo();
  //     }
  //   });
  // }

  Future<void> getHeaderInfo() async {
    emit(const HeaderLoadingState());
    final result = await _getTotalUseCase(params: const NoParameters());

    result.fold(
      (l) => emit(HeaderFailureState(message: l.failureMessage.toString())),
      (r) {
        if (kDebugMode) {
          print('-----------------');
        }
        if (kDebugMode) {
          print('--------$r---------');
        }
        if (kDebugMode) {
          print('-----------------');
        }
        return emit(HeaderSuccessState(headerEntity: r));
      },
    );
  }

  @override
  Future<void> close() {
    // getHeaderInfo();
    return super.close();
  }
}
