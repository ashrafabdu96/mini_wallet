// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_learning/core/errors/failure.dart';
// import 'package:firebase_learning/core/usecases/usecases.dart';
// import 'package:firebase_learning/features/home/domain/entities/transaction_entity.dart';
// import 'package:firebase_learning/features/home/domain/repositories/base_wallet_transaction_repository.dart';
//
// class GetAllTransactionsUsecase
//     extends BaseUseCase<List<TransactionEntity>, NoParameters> {
//   final BaseWalletTransactionRepository baseWalletTransactionRepository;
//
//   GetAllTransactionsUsecase({required this.baseWalletTransactionRepository});
//   @override
//   Future<Either<Failure, List<TransactionEntity>>> call(
//       {required NoParameters params}) async {
//     return await baseWalletTransactionRepository.getAllTransactions();
//   }
// }
//
// class NoParameters extends Equatable {
//   const NoParameters();
//   @override
//   List<Object?> get props => [];
// }
