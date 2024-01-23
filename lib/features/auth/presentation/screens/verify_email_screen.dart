import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_wallet/core/utils/messages.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/custom_button.dart';
import 'package:mini_wallet/features/home/presentation/screens/splash_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  Timer? _timer;
  bool canResendEmail = false;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      _timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) _timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(
        const Duration(seconds: 3),
      );
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const SplashScreen()
      : Scaffold(
          appBar: AppBar(
            title: const Text("verifyEmail"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  "The email has been sent check your inbox",
                ),
                GradiantButton(
                  title: "Resend email",
                  width: 220,
                  height: 50,
                  onPress: () {
                    canResendEmail ? sendVerificationEmail() : null;
                  },
                ),
                GradiantButton(
                  title: "Cancel",
                  width: 220,
                  height: 50,
                  onPress: () {
                    FirebaseAuth.instance.signOut();
                    // canResendEmail ? sendVerificationEmail() : null;
                  },
                ),
              ],
            ),
          ),
        );
}
