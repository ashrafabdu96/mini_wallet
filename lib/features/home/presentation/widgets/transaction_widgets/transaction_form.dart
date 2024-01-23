import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/core/helpers/enums.dart';
import 'package:mini_wallet/core/sizeconfig.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';
import 'package:mini_wallet/core/utils/messages.dart';
import 'package:mini_wallet/core/utils/shared_ui/custom_text_form.dart';
import 'package:mini_wallet/dependency_injection.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/custom_button.dart';
import 'package:mini_wallet/features/home/presentation/manager/transaction_cubit/transactions_cubit.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  String? type;
  bool isDeposit = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TransactionsCubit>(),
      child: Builder(builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.screenHeight * 0.02,
            horizontal: context.screenWidth * 0.05,
          ),
          child: Form(
            key: BlocProvider.of<TransactionsCubit>(context).formKey,
            child: Column(
              children: [
                DropdownButton(
                  hint: const Text("Transaction Type"),
                  value: type ?? "Withdraw",
                  items: const [
                    DropdownMenuItem(
                      value: "Deposit",
                      child: Text("Deposit"),
                    ),
                    DropdownMenuItem(
                      value: "Withdraw",
                      child: Text("Withdraw"),
                    ),
                  ],
                  onChanged: (onChanged) {
                    type = onChanged;
                    setState(
                      () {
                        isDeposit = onChanged == "Deposit" ? true : false;
                      },
                    );
                  },
                ),
                CustomTextFormField(
                  width: context.screenWidth,
                  controller:
                      BlocProvider.of<TransactionsCubit>(context).amount,
                  height: context.screenHeight,
                  hintText: 'enter the amount',
                ),
                CustomTextFormField(
                  width: context.screenWidth,
                  controller:
                      BlocProvider.of<TransactionsCubit>(context).destOrSource,
                  height: context.screenHeight,
                  hintText: isDeposit ? 'Source' : "Destination",
                ),
                CustomTextFormField(
                  width: context.screenWidth,
                  controller: BlocProvider.of<TransactionsCubit>(context)
                      .destOrSourceAccount,
                  height: context.screenHeight,
                  hintText:
                      isDeposit ? 'Source Account' : "Destination Account",
                ),
                BlocConsumer<TransactionsCubit, TransactionsState>(
                  listener: (context, state) {
                    if (isDeposit) {
                      if (state.depositStatus == RequestStatus.success) {
                        showSnackBar("success ", context);
                      }
                      if (state.depositStatus == RequestStatus.error) {
                        showSnackBar(state.depositMessage.toString(), context);
                      }
                    } else {
                      if (state.withdrawStatus == RequestStatus.success) {
                        showSnackBar("success ", context);
                      }
                      if (state.withdrawStatus == RequestStatus.error) {
                        if (kDebugMode) {
                          print(state.withdrawMessage.toString());
                        }
                        showSnackBar(state.withdrawMessage.toString(), context);
                      }
                    }
                  },
                  builder: (context, state) {
                    if (isDeposit) {
                      if (state.depositStatus == RequestStatus.loading) {
                        return const Center(
                          child: CupertinoActivityIndicator(
                            color: AppColorsLight.accent,
                            radius: 10,
                          ),
                        );
                      }
                    } else {
                      if (state.withdrawStatus == RequestStatus.loading) {
                        return const Center(
                          child: CupertinoActivityIndicator(
                            color: AppColorsLight.accent,
                            radius: 10,
                          ),
                        );
                      }
                    }
                    return GradiantButton(
                      title: isDeposit ? "Deposit" : "WithDraw",
                      width: context.screenWidth * 0.5,
                      height: context.screenHeight * 0.05,
                      onPress: () async {
                        try {
                          isDeposit
                              ? await BlocProvider.of<TransactionsCubit>(
                                      context)
                                  .deposit()
                              : await BlocProvider.of<TransactionsCubit>(
                                      context)
                                  .withdraw();
                        } finally {
                          // ScaffoldMessenger.of(context).clearSnackBars();
                          // Navigator.of(context).pop();
                        }
                      },
                    );
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
