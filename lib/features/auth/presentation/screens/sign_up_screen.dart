import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/core/utils/messages.dart';
import 'package:mini_wallet/core/utils/shared_ui/custom_text_form.dart';
import 'package:mini_wallet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/auth_description.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/auth_image.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/custom_button.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/google_button.dart';
import 'package:mini_wallet/features/auth/presentation/widgets/sign_or_login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  GlobalKey<FormState> formKeySignup = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    userNameController.dispose();
    passwordController.dispose();

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
              key: formKeySignup,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "SignUp",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const AuthImage(),
                  const AuthDescription(
                    text: "Sign up With Your Email And Password",
                  ),
                  CustomTextFormField(
                    controller: userNameController,
                    width: width,
                    height: height,
                    hintText: "Enter Your name",
                    prefixIcon: Icons.person,
                    keyboardType: TextInputType.text,
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
                        // showDialog(
                        //     context: context,
                        //     builder: (context) => const BaghdadAreasDropdown());
                        // AwesomeDialog(
                        //   width: 70,
                        //   dialogType: DialogType.noHeader,
                        //   context: context,
                        //   body: const BaghdadAreasDropdown(),
                        // ).show();
                        showSnackBar("Check Your Email To Verify", context);
                        BlocProvider.of<AuthCubit>(context).goToLogin(context);
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
                          title: 'Signup',
                          onPress: () {
                            if (formKeySignup.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).signUp(
                                userName: userNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
                  SignOrLogin(
                    textOne: "Already have an account? ",
                    textTwo: "login",
                    onTap: () {
                      BlocProvider.of<AuthCubit>(context).goToLogin(context);
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
