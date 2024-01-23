import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/core/errors/failure.dart';
import 'package:mini_wallet/core/helpers/enums.dart';
import 'package:mini_wallet/features/home/domain/entities/deposit_entity.dart';
import 'package:mini_wallet/features/home/domain/entities/withdraw_entity.dart';
import 'package:mini_wallet/features/home/domain/use_cases/deposit_usecase.dart';
import 'package:mini_wallet/features/home/domain/use_cases/withdraw_usecase.dart';

import '../../../domain/entities/transaction_entity.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController amount = TextEditingController();
  TextEditingController destOrSource = TextEditingController();
  TextEditingController destOrSourceAccount = TextEditingController();
  final DepositUseCase depositUseCase;
  final WithdrawUseCase withdrawUseCase;
  // final GetAllTransactionsUsecase getAllTransactionsUsecase;
  TransactionsCubit({
    // required this.getAllTransactionsUsecase,
    required this.withdrawUseCase,
    required this.depositUseCase,
  }) : super(const TransactionsState());
  Future<void> deposit() async {
    if (formKey.currentState!.validate()) {
      DepositEntity depositEntity = DepositEntity(
        sourceAccount: destOrSourceAccount.text.toString(),
        amount: double.parse(amount.text.toString()),
        userId: FirebaseAuth.instance.currentUser!.uid.toString(),
        source: destOrSource.text.toString(),
      );
      emit(state.copyWith(depositStatus: RequestStatus.loading));
      final result = await depositUseCase(params: depositEntity);
      mapTransactionToState(result, true);
    } else {
      if (kDebugMode) {
        print('not Valid');
      }
    }
  }

  Future<void> withdraw() async {
    if (formKey.currentState!.validate()) {
      WithdrawEntity withdrawEntity = WithdrawEntity(
        destinationAccount: destOrSourceAccount.text.toString(),
        amount: double.parse(amount.text.toString()),
        userId: FirebaseAuth.instance.currentUser!.uid.toString(),
        destination: destOrSource.text.toString(),
      );
      emit(state.copyWith(withdrawStatus: RequestStatus.loading));
      final result = await withdrawUseCase(params: withdrawEntity);
      mapTransactionToState(result, false);
    } else {
      if (kDebugMode) {
        print('not Valid');
      }
    }
  }

  mapTransactionToState(Either<Failure, Unit> either, bool isDeposit) {
    either.fold(
      (l) => emit(
        isDeposit
            ? state.copyWith(
                depositStatus: RequestStatus.error,
                depositMessage: l.failureMessage,
              )
            : state.copyWith(
                withdrawStatus: RequestStatus.error,
                withdrawMessage: l.failureMessage,
              ),
      ),
      (r) => emit(
        isDeposit
            ? state.copyWith(
                // depositMessage: "success",
                depositStatus: RequestStatus.success,
              )
            : state.copyWith(
                // depositMessage: "success",
                withdrawStatus: RequestStatus.success,
              ),
      ),
    );
  }

  @override
  Future<Function> close() async {
    super.close();
    return () {
      if (kDebugMode) {
        print('closed');
      }
    };
  }
}
