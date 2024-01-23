import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// import 'package:firebase_learning/features/home/tester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/core/sizeconfig.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';
import 'package:mini_wallet/core/utils/shared_ui/shimmer_loading.dart';
import 'package:mini_wallet/features/auth/presentation/screens/login_screen.dart';
import 'package:mini_wallet/features/auth/presentation/screens/profile_settings_screen.dart';
import 'package:mini_wallet/features/home/presentation/manager/user_info_cubit.dart';

PreferredSizeWidget? buildSharedAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 45,
    leadingWidth: 52,
    backgroundColor: AppColorsLight.background,
    elevation: 0.0,
    leading: BlocBuilder<UserInfoCubit, UserInfoState>(
      builder: (context, state) {
        if (state is UserInfoSuccess) {
          return CircleAvatar(
            backgroundColor: AppColorsLight.background,
            backgroundImage: buildImage(
              state.userInfoEntity.userImage.toString(),
            ),
            onBackgroundImageError: (exception, stackTrace) => const Icon(
              Icons.person,
              color: AppColorsLight.black,
            ),
            child: InkWell(
              onTap: () {
                showProfile(
                  context,
                  imageUrl: state.userInfoEntity.userImage.toString(),
                );
              },
            ),
          );
        } else if (state is UserInfoLoading) {
          return const ShimmerContainer(
            height: 30,
            width: 60,
          );
        } else {
          return CircleAvatar(
            backgroundColor: AppColorsLight.background,
            backgroundImage: const AssetImage(
              "assets/images/person.png",
            ),
            onBackgroundImageError: (exception, stackTrace) => const Icon(
              Icons.person,
              color: AppColorsLight.black,
            ),
            child: InkWell(
              onTap: () {
                showProfile(context, imageUrl: "assets/images/person.png");
              },
            ),
          );
        }
      },
    ),
    actions: [
      SizedBox(
        width: context.screenWidth * 0.02,
      ),
      IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () {
          FirebaseAuth.instance.signOut().then(
            (value) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            },
          );
        },
      ),
      // CircleAvatar(
      //   backgroundColor: AppColorsLight.background,
      //   backgroundImage: NetworkImage(
      //     FirebaseAuth.instance.currentUser!.photoURL.toString(),
      //   ),
      //   onBackgroundImageError: (exception, stackTrace) => const Icon(
      //     Icons.person,
      //     color: AppColorsLight.black,
      //   ),
      // ),
    ],
  );
}

ImageProvider<Object> buildImage(String imageUrl) {
  if (imageUrl.contains('assets')) {
    if (kDebugMode) {
      print("yes has asset");
    }
    return AssetImage(imageUrl);
  } else {
    if (kDebugMode) {
      print("no has asset");
    }

    return NetworkImage(imageUrl);
  }
}
