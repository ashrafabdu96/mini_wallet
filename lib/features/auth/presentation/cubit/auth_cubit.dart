import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mini_wallet/features/auth/presentation/screens/login_screen.dart';
import 'package:mini_wallet/features/auth/presentation/screens/sign_up_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitialState());

  signUp(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      emit(const AuthLoadingState());

      ///create user with email and password
      final auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await auth.user!.updateDisplayName(userName);
      final User? user = FirebaseAuth.instance.currentUser;

      await user!.reload();

      ///add user info to firestore with add a wallet for the user
      // await FirebaseFirestore.instance.collection("users").doc(user.uid).
      // set({
      //   "id": user.uid,
      //   "name": userName,
      //   "email": email,
      //   "createdAt": Timestamp.now(),
      // }).then((value) async {
      //   await FirebaseFirestore.instance
      //       .collection("users")
      //       .doc(user.uid)
      //       .collection("wallet")
      //       .doc(user!.uid)
      //       .set({"balance": 0, "currency": "YER", "walletStatus": "initial"});
      // });
      DocumentReference userRef =
          FirebaseFirestore.instance.collection("users").doc(user.uid);
      // String userId = userRef.id;
      await userRef.set({
        "name": userName,
        "phone": "738990995",
        "email": email,
        "dateCreated": Timestamp.now(),
        "userImage": "assets/images/person.png",
      });

      ///add wallet to user
      DocumentReference walletRef = userRef.collection("wallet").doc(user.uid);
      // String walletId = walletRef.id;
      await walletRef.set(
        {
          "balance": 0.0,
          "currency": "USD",
          "totalDeposits": 0.0,
          "totalWithdrawals": 0.0,
          "dateCreated": Timestamp.now(),
        },
      );

      ///*************************
      emit(const AuthSuccessState());
    } on FirebaseException catch (e) {
      emit(AuthErrorState(errorMessage: e.message.toString()));
    }
  }

  login({
    required String email,
    required String password,
  }) async {
    try {
      emit(const AuthLoadingState());
      final auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(AuthSuccessState(user: auth.user));
    } on FirebaseException catch (e) {
      emit(AuthErrorState(errorMessage: e.message.toString()));
    }
  }

  goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  goToSignup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SignupScreen(),
      ),
    );
  }

  forgotPassword({required String email}) async {
    try {
      emit(const AuthLoadingState());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(const AuthSuccessState());
    } on FirebaseException catch (e) {
      emit(AuthErrorState(errorMessage: e.message.toString()));
    }
  }

  signInWithGoogle() async {
    try {
      emit(const AuthLoadingGoogleSignInState());
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final googleUserIsSignedIn = GoogleSignIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      // GoogleSignInAccount googleSignInAccount;

      ///add user ifo to firestore
      if (user != null) {
        ///add user info to firestore with add a wallet for the user
        // var x =        userCredential.additionalUserInfo!.isNewUser;
        if (
            // !await googleUserIsSignedIn.isSignedIn()
            userCredential.additionalUserInfo!.isNewUser) {
          DocumentReference userRef =
              FirebaseFirestore.instance.collection("users").doc(user.uid);
          // add user info to firestore
          await userRef.set({
            "id": user.uid,
            "name": user.displayName,
            "email": user.email,
            "createdAt": Timestamp.now(),
            "userImage": "assets/images/person.png",
          });

          ///add wallet to user
          DocumentReference walletRef =
              userRef.collection("wallet").doc(user.uid);
          // String walletId = walletRef.id;
          await walletRef.set(
            {
              "balance": 0.0,
              "currency": "USD",
              "totalDeposits": 0.0,
              "totalWithdrawals": 0.0,
              "dateCreated": Timestamp.now(),
            },
          );
        }
        emit(AuthSuccessState(user: user));
      }

      ///*************************
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(errorMessage: e.message.toString()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }
}
