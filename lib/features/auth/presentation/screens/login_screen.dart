import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/core/utils/messages.dart';
import 'package:mini_wallet/core/utils/shared_ui/custom_text_form.dart';
import 'package:mini_wallet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/auth_description.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/auth_image.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/custom_button.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/forgot_password_button.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/google_button.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/sign_or_login.dart';
import 'package:mini_wallet/features/home/presentation/screens/base_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("built");
    }
    final double width =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.height;
    final double height =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKeyLogin,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const AuthImage(),
                  const AuthDescription(
                    text: "Login With Your Email And Password",
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    width: width,
                    height: height,
                    hintText: "Enter Your Email",
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    width: width,
                    height: height,
                    hintText: "Enter Your Password",
                    prefixIcon: Icons.password,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthErrorState) {
                        showSnackBar(state.errorMessage, context);
                      } else if (state is AuthSuccessState) {
                        // BlocProvider.of<AuthCubit>(context).close();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BaseScreen(
                              msg: state.user.toString(),
                            ),
                          ),
                        );
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
                          title: 'Login',
                          onPress: () {
                            if (formKeyLogin.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).login(
                                password: passwordController.text,
                                email: emailController.text,
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
                  const ForgotPasswordButton(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SignOrLogin(
                    textOne: "don't have an account? ",
                    textTwo: "Signup",
                    onTap: () {
                      BlocProvider.of<AuthCubit>(context).goToSignup(context);
                    },
                  ),
                  GoogleButton(width: width),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
