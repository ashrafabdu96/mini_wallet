import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/core/utils/shared_ui/custom_text_form.dart';
import 'package:mini_wallet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/auth_description.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/auth_image.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/custom_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.height;
    final double height =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.05,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Reset Password",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const AuthImage(),
                  const AuthDescription(
                    text: "Enter the new password",
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    width: width,
                    height: height,
                    hintText: "Enter Your Email",
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              state.errorMessage.toString(),
                            ),
                          ),
                        );
                      } else if (state is AuthSuccessState) {
                        BlocProvider.of<AuthCubit>(context).close();
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return GradiantButton(
                          height: height * 0.05,
                          width: width * 0.6,
                          title: "Reset Password",
                          onPress: () {
                            if (formKey.currentState!.validate()) {}
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
