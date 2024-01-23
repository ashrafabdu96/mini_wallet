part of 'toggle_theme_cubit.dart';

abstract class ToggleThemeState extends Equatable {
  @override
  List<Object> get props => [];
  const ToggleThemeState();
}

class ToggleThemeInitialState extends ToggleThemeState {}

class ToggleThemeDarkState extends ToggleThemeState {}

class ToggleThemeLightState extends ToggleThemeState {}
