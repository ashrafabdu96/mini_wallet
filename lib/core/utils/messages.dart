import 'package:flutter/material.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';

final messengerKey = GlobalKey<ScaffoldMessengerState>();
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> x = x;
showSnackBar(String? text, BuildContext context, {Color? bkColor}) async {
  if (text == null) return;
  final snackBar = SnackBar(
    content: Text(
      text,
      style: const TextStyle(color: AppColorsLight.white),
    ),
    action: SnackBarAction(
      label: "close",
      onPressed: () {
        x.close();
      },
    ),
    backgroundColor: bkColor ?? Colors.red,
  );
  ScaffoldMessenger.of(context).clearSnackBars();
  x = ScaffoldMessenger.of(context).showSnackBar(snackBar);

  // messengerKey.currentState!
  //   ..removeCurrentSnackBar()
  //   ..showSnackBar(snackBar);
}
