import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_wallet/core/utils/messages.dart';
import 'package:mini_wallet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mini_wallet/features/home/presentation/screens/base_screen.dart';

import '../../../../core/utils/app_colors/pallete.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BaseScreen(
                msg: state.user.toString(),
              ),
            ),
          );
        } else if (state is AuthErrorState) {
          showSnackBar(state.errorMessage, context);
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingGoogleSignInState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                BlocProvider.of<AuthCubit>(context).signInWithGoogle();
              },
              child: RichText(
                // textAlign: TextAlign.start,
                text: TextSpan(
                    text: "Continue with Google",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        baseline: TextBaseline.ideographic,
                        child: SvgPicture.asset(
                          "assets/svg/google.svg",
                          width: width * 0.08,
                          color: AppColorsLight.gradient1,
                          fit: BoxFit.contain,
                        ),
                      )
                    ]),
              ),
            ),
          ],
        );
      },
    );
  }
}
