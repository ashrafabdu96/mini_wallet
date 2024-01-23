import 'package:get_it/get_it.dart';
import 'package:mini_wallet/core/helpers/network_info.dart';
import 'package:mini_wallet/core/helpers/toggle_themes_helper/toggle_theme_cubit.dart';
import 'package:mini_wallet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mini_wallet/features/home/data/remote/data_sources/remote_data_source.dart';
import 'package:mini_wallet/features/home/data/repositories/wallet_transaction_repository_impl.dart';
import 'package:mini_wallet/features/home/domain/repositories/base_wallet_transaction_repository.dart';
import 'package:mini_wallet/features/home/domain/use_cases/deposit_usecase.dart';
import 'package:mini_wallet/features/home/domain/use_cases/get_total_usecase.dart';
import 'package:mini_wallet/features/home/domain/use_cases/get_user_info_usecase.dart';
import 'package:mini_wallet/features/home/domain/use_cases/transactions_query_usecase.dart';
import 'package:mini_wallet/features/home/domain/use_cases/try_get_all_transactions_usecase.dart';
import 'package:mini_wallet/features/home/domain/use_cases/withdraw_usecase.dart';
import 'package:mini_wallet/features/home/presentation/manager/my_blocs/header_bloc/header_bloc.dart';
import 'package:mini_wallet/features/home/presentation/manager/my_blocs/new_try_transaction_bloc.dart';
import 'package:mini_wallet/features/home/presentation/manager/transaction_cubit/transaction_query_cubit.dart';
import 'package:mini_wallet/features/home/presentation/manager/transaction_cubit/transactions_cubit.dart';
import 'package:mini_wallet/features/home/presentation/manager/user_info_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

// flutter build apk --debug --no-shrink --no-obfuscate --split-debug-info=/G:\flutterprojects\2023learn\firebase_learning\build\app/app_debug --dart-define=FLUTTER_BUILD_NAME=moneyapp --dart-define=FLUTTER_BUILD_NUMBER=1.0 -Xlint:unchecked

final sl = GetIt.instance;
Future<void> init() async {
  ///******wallet transactions
  //cubits
  sl.registerFactory(
    () => UserInfoCubit(
      getUSerInfoUseCase: sl(),
      // transactionCubit: sl<TransactionsCubit>(),
    ),
  );
  sl.registerFactory(
    () => TransactionQueryCubit(
      transactionsQueryUsecase: sl(),
      // transactionCubit: sl<TransactionsCubit>(),
    ),
  );
  sl.registerFactory(
    () => HeaderBloc(
      getTotalUseCase: sl(),
      // transactionCubit: sl<TransactionsCubit>(),
    ),
  );
  sl.registerFactory(
    () => NewTryTransactionBloc(
      tryGetAllTransactionsUsecase: sl(),
      // transactionsQueryUsecase: sl(),
    ),
  );
  sl.registerFactory(
    () => TransactionsCubit(
      depositUseCase: sl(),
      withdrawUseCase: sl(),
      // getAllTransactionsUsecase: sl(),
    ),
  );
//usecases
  sl.registerLazySingleton(
    () => GetUSerInfoUseCase(
      baseWalletTransactionRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => TransactionsQueryUsecase(
      baseWalletTransactionRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetTotalUseCase(
      baseWalletTransactionRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => TryGetAllTransactionsUsecase(
      baseWalletTransactionRepository: sl(),
    ),
  );

  // sl.registerLazySingleton(
  //   () => GetAllTransactionsUsecase(
  //     baseWalletTransactionRepository: sl(),
  //   ),
  // );
  sl.registerLazySingleton(
    () => DepositUseCase(
      baseWalletTransactionRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => WithdrawUseCase(
      baseWalletTransactionRepository: sl(),
    ),
  );
  // Repositories
  sl.registerLazySingleton<BaseWalletTransactionRepository>(
    () => WalletTransactionRepositoryImpl(
      networkInfo: sl(),
      remoteDataSourceImpl: sl(),
    ),
  );
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(),
  );

  ///theme cubit
  sl.registerFactory(() => AuthCubit());
  sl.registerFactory(() => ToggleThemeCubit());

  ///*************************external

  // sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  // sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
}
