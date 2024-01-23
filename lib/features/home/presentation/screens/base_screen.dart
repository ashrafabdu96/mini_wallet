import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';
import 'package:mini_wallet/core/utils/constants.dart';
import 'package:mini_wallet/core/utils/shared_ui/app_bar.dart';
import 'package:mini_wallet/dependency_injection.dart';
import 'package:mini_wallet/features/home/presentation/manager/my_blocs/header_bloc/header_bloc.dart';
import 'package:mini_wallet/features/home/presentation/manager/my_blocs/new_try_transaction_bloc.dart';
import 'package:mini_wallet/features/home/presentation/screens/home_screen_tab.dart';
import 'package:mini_wallet/features/home/presentation/screens/summary_screen_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key, required this.msg}) : super(key: key);
  final String msg;

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;
  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<NewTryTransactionBloc>(),
          ),
          BlocProvider(
            create: (_) => sl<HeaderBloc>(),
          ),
        ],
        child: SafeArea(
          child: Scaffold(
            appBar: buildSharedAppBar(context),
            backgroundColor: AppColorsLight.background,
            body: buildTabContent(currentIndex),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (tappedIndex) {
                setState(() {
                  currentIndex = tappedIndex;
                });
              },
              currentIndex: currentIndex,
              items: _buildTabs(),
              selectedItemColor: AppColorsLight.secondaryDark,
              unselectedItemColor: AppColorsLight.fontLight,
            ),
          ),
        ));
  }

  Widget buildTabContent(index) {
    switch (index) {
      case 0:
        return const WalletHomeScreenTab();
      case 1:
        return const ChartScreenTab();
      default:
        return const WalletHomeScreenTab();
    }
  }

  List<BottomNavigationBarItem> _buildTabs() => List.generate(
        tabIconsUrl.length,
        (index) => BottomNavigationBarItem(
          icon: SvgPicture.asset(
            tabIconsUrl[index],
            color: AppColorsLight.fontDark,
            allowDrawingOutsideViewBox: true,
          ),
          label: tabsLabel[index],
        ),
      );
}
