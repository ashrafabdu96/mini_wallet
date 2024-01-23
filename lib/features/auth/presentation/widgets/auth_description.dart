import 'package:flutter/material.dart';

class AuthDescription extends StatelessWidget {
  const AuthDescription({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(text),
    );
  }
}
