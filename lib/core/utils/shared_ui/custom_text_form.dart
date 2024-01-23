import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.width,
    required this.height,
    required this.hintText,
    this.prefixIcon,
    required this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.label,
  });

  final double width;
  final double height;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final Widget? label;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: width * 0.8,
      // height: height,
      child: TextFormField(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        onTap: onTap,

        validator: (value) {
          if (value!.isEmpty) {
            return "the field can not be empty";
          } else {
            return null;
          }
        },
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
            // contentPadding: EdgeInsets.all(0),
            label: label,
            suffixIcon: suffixIcon,
            hintText: hintText,
            prefixIcon: Icon(
              prefixIcon,
            )),
      ),
    );
  }
}
