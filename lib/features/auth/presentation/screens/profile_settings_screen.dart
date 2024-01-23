import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_wallet/core/sizeconfig.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';
import 'package:mini_wallet/core/utils/constants.dart';
import 'package:mini_wallet/core/utils/shared_ui/app_bar.dart';
import 'package:mini_wallet/tester.dart';

// import '../../../../core/utils/app_colors/pallete.dart';

showProfile(BuildContext context, {required String imageUrl}) {
  var x = AwesomeDialog(
    width: context.screenWidth * 0.8,
    dialogType: DialogType.noHeader,
    context: context,
    body: Padding(
      padding: const EdgeInsets.all(defaultSpacing),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.5),
              radius: 50,
              backgroundImage: buildImage(imageUrl),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          height: context.screenHeight * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Choose Image',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              ListTile(
                                onTap: () {
                                  ImageHelper.pickMedia(
                                      context: context, isGallery: true);
                                  Navigator.pop(context);
                                },
                                leading: const Icon(
                                  Icons.image,
                                  color: AppColorsLight.black,
                                ),
                                title: const Text(
                                  'From Gallery',
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  ImageHelper.pickMedia(
                                    isGallery: false,
                                    context: context,
                                  );
                                  Navigator.pop(context);
                                },
                                leading: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColorsLight.black,
                                ),
                                title: const Text(
                                  'From Camera',
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                icon: const Icon(
                  Icons.camera_alt_outlined,
                ),
                color: Colors.white,
              ),
            ),
            // Spacer(),
            Text(
              FirebaseAuth.instance.currentUser!.displayName.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    ),
  ).show();
}
