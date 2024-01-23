import 'package:flutter/material.dart';
import 'package:mini_wallet/features/auth/presentation/screens/forgot_password_screen.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ForgotPasswordScreen(),
          ),
        );
      },
      child: const Text(
        "ForgetPassword?",
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
