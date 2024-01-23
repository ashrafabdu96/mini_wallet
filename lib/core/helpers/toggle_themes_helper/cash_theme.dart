import 'package:mini_wallet/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashTheme {
  static Future<void> cashTheme(bool isDark) async {
    await sl<SharedPreferences>().setBool("isDark", isDark);
  }

  static bool getTheme() {
    return sl<SharedPreferences>().getBool("isDark") ?? false;
  }
}
