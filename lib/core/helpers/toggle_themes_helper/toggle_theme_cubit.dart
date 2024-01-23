import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/core/helpers/toggle_themes_helper/cash_theme.dart';
import 'package:mini_wallet/core/utils/custom_theme.dart';

part 'toggle_theme_state.dart';

class ToggleThemeCubit extends Cubit<ToggleThemeState> {
  ToggleThemeCubit() : super(ToggleThemeInitialState());

  bool isDark = false;

  changeTheme() async {
    if (isDark) {
      isDark = false;
      await CashTheme.cashTheme(isDark);
      emit(ToggleThemeLightState());
    } else {
      isDark = true;
      await CashTheme.cashTheme(isDark);
      emit(ToggleThemeDarkState());
    }
  }

  ThemeData toggleTheme() {
    if (isDark || CashTheme.getTheme()) {
      return buildCustomDarkTheme();
    } else {
      return buildCustomLightTheme();
    }
  }
}
