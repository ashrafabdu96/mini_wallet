import 'package:firebase_core/firebase_core.dart';
import 'package:mini_wallet/core/helpers/toggle_themes_helper/toggle_theme_cubit.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';
import 'package:mini_wallet/dependency_injection.dart';
import 'package:mini_wallet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mini_wallet/features/auth/presentation/screens/main_screen.dart';
import 'package:mini_wallet/features/home/presentation/manager/user_info_cubit.dart';
import 'package:mini_wallet/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);



  ///injection
  await init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColorsLight.background,
    systemNavigationBarDividerColor: Colors.black,
  ));
  runApp(const MyApp());
}

final navigateKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<ToggleThemeCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<UserInfoCubit>()..getUserInfo(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<ToggleThemeCubit, ToggleThemeState>(
            builder: (context, state) {
              return MaterialApp(
                // scaffoldMessengerKey: messengerKey,
                navigatorKey: navigateKey,
                debugShowCheckedModeBanner: false,
                // orientation: Orientation.landscape,

                title: 'Flutter Demo',
                theme: BlocProvider.of<ToggleThemeCubit>(context).toggleTheme(),
                home: const SafeArea(
                  // child: ProfileSettingsScreen(),
                  child: MainScreen(),
                ),
                // home: const AuthUi(),
              );
            },
          );
        },
      ),
    );
  }
}

///switch button to change the theme
// Switch(
// value: BlocProvider.of<ToggleThemeCubit>(context).isDark,
// onChanged: (value) {
// BlocProvider.of<ToggleThemeCubit>(context)
//     .changeTheme();
// }),
