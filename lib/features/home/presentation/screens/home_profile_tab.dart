import 'package:flutter/material.dart';

class HomeProfileTab extends StatefulWidget {
  const HomeProfileTab({Key? key}) : super(key: key);

  @override
  State<HomeProfileTab> createState() => _HomeProfileTabState();
}

class _HomeProfileTabState extends State<HomeProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: () => print(''), child: Text('')),
        const Center(
          child: Text("profile"),
        ),
      ],
    );
  }
}
//What are the differences between the Offstage Widget and Opacity?
//What does the deferred keyword do in Dart?
//What is PreferredSized?
// How to communicate with Android/ iOS code with Flutter
// What is the ??= operator for?
// How to communicate with Android/ iOS code with Flutter
// What is the ??= operator for?
// What is the difference between a package and a plugin
// What is a “mounted” Widget
