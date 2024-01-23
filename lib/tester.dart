import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_wallet/features/home/presentation/manager/user_info_cubit.dart';
import 'package:path/path.dart';

class Tester extends StatefulWidget {
  const Tester({Key? key}) : super(key: key);

  @override
  State<Tester> createState() => _TesterState();
}

class _TesterState extends State<Tester> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/logo.png'),
        ElevatedButton(
          onPressed: () {
            // ImageHelper.pickMedia(isGallery: true);
          },
          child: const Text(
            "gallery",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // ImageHelper.pickMedia(isGallery: false);
          },
          child: const Text(
            "camera",
          ),
        ),
      ],
    );
  }
}

// await _displayPickImageDialog(context!,
// (double? maxWidth, double? maxHeight, int? quality) async {
// try {
// final XFile? pickedFile = await _picker.pickImage(
// source: source,
// maxWidth: maxWidth,
// maxHeight: maxHeight,
// imageQuality: quality,
// );
// setState(() {
// _setImageFileListFromFile(pickedFile);
// });
// } catch (e) {
// setState(() {
// _pickImageError = e;
// });
// }
// });
///*************
class ImageHelper {
  static Future<File?> pickMedia({
    required bool isGallery,
    required BuildContext context,
  }) async {
    File? imageFile;
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final ImagePicker picker = ImagePicker();

    final source = isGallery ? ImageSource.gallery : ImageSource.camera;
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: source,
      );

      if (pickedFile != null) {
        imageFile = File(pickedFile!.path);
        final imageName = basename(imageFile.path);
        final usersImagesRef =
            FirebaseStorage.instance.ref('usersImages/$imageName');
        final fireStoreUploadedImage = await usersImagesRef.putFile(imageFile);
        await FirebaseAuth.instance.currentUser!
            .updatePhotoURL(await usersImagesRef.getDownloadURL());
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'userImage': await usersImagesRef.getDownloadURL()});
      }
      // print(imageFile?.path);
      return imageFile;
    } catch (e) {
      if (kDebugMode) {
        print("تحميل الصوره $e");
      }
    } finally {
      BlocProvider.of<UserInfoCubit>(context).getUserInfo();
    }
    return null;
  }
}
