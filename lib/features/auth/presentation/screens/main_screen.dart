import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_wallet/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:mini_wallet/features/auth/presentation/screens/verify_email_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return const VerifyEmailScreen();
          } else {
            return const SignupScreen();
          }
        });
  }
}
