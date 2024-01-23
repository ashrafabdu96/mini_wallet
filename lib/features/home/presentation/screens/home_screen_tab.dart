import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/core/sizeconfig.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';
import 'package:mini_wallet/features/home/presentation/manager/my_blocs/header_bloc/header_bloc.dart';
import 'package:mini_wallet/features/home/presentation/widgets/transaction_widgets/totals_section.dart';
import 'package:mini_wallet/features/home/presentation/widgets/transaction_widgets/transaction_form.dart';
import 'package:mini_wallet/features/home/presentation/widgets/transaction_widgets/transactions_list_items.dart';

class WalletHomeScreenTab extends StatelessWidget {
  const WalletHomeScreenTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.screenWidth * 0.03,
        vertical: context.screenWidth * 0.03,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //totals section
              SizedBox(
                height: context.screenHeight * 0.24,
                width: context.screenWidth,
                // color: AppColorsLight.secondaryLight,
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    return TotalsSection(
                      height: constraint.maxHeight,
                      width: constraint.maxWidth,
                    );
                  },
                ),
              ),
              //services section
              // SizedBox(
              //   height: context.screenHeight * 0.2,
              //   child: GridView(
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 3, childAspectRatio: 2),
              //     children: [
              //       ...List.generate(
              //           5,
              //           (index) => Container(
              //                 // width: 50,
              //                 margin:
              //                     const EdgeInsets.symmetric(horizontal: 10),
              //                 child: SvgPicture.asset(
              //                   'assets/svg/withdraw.svg',
              //                   // width: ,
              //                 ),
              //               )),
              //     ],
              //   ),
              // ),
              //recent transactions and bottom sheet
              RichText(
                // textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Recent Transactions                           ",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColorsLight.black.withOpacity(0.7),
                      ),

                  ///show bottom sheet
                  children: [
                    WidgetSpan(
                        baseline: TextBaseline.ideographic,
                        child: TextButton(
                          child: Text(
                            'See All',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          onPressed: () {
                            showBottomSheet(
                                // enableDrag: bool.fromEnvironment('name'),
                                constraints: BoxConstraints(
                                  maxHeight: context.screenHeight * 0.6,
                                  minHeight: context.screenHeight * 0.2,
                                ),
                                context: context,
                                builder: (context) {
                                  return Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                          top: 25.0,
                                          left: 10,
                                          right: 10,
                                        ),
                                        // color: Colors.tealAccent,
                                        child: const CustomScrollView(
                                          slivers: [
                                            TransactionsListItems(),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                        ))
                  ],
                ),
                // textWidthBasis: ,
              ),

              ///transactions list
              const Expanded(
                child: CustomScrollView(
                  slivers: [
                    TransactionsListItems(),
                  ],
                ),
              ),
            ],
          ),
          //FloatingActionButton
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: AppColorsLight.primaryDark.withOpacity(1),
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.noHeader,
                  body: const TransactionForm(),
                  btnOkOnPress: () {
                    //to refresh the totals
                    BlocProvider.of<HeaderBloc>(context).getHeaderInfo();
                  },
                  btnOkColor: AppColorsLight.primaryDark.withOpacity(1),
                  btnOkText: 'Close',
                ).show();
                // displaySnackBar(context);
              },
              child: const Icon(
                Icons.add,
                color: AppColorsLight.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
