import 'package:flutter/material.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';

class DateButtonPicker extends StatelessWidget {
  const DateButtonPicker(
      {Key? key,
      required this.height,
      required this.width,
      this.onTap,
      required this.title,
      required this.toDate,
      required this.fromDate,
      required this.isToDate})
      : super(key: key);
  final double height;
  final double width;
  final void Function()? onTap;
  final String title;
  final TextEditingController toDate;
  final TextEditingController fromDate;
  final bool isToDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: height,
        width: width,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              width: width * 0.23,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Border.all(color: AppColorsLight.black),
                color: AppColorsLight.background,
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: InkWell(
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(title),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.date_range_outlined),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: width * 0.05,
            ),
            SizedBox(
                width: width * 0.5,
                child: Center(
                  child: TextFormField(
                    controller: isToDate ? toDate : fromDate,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      filled: false, // contentPadding: EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.only(
                        top: 5,
                        left: 6,
                        right: 4,
                      ),
                      hintText: isToDate ? 'To' : 'From',
                    ),
                    // initialValue: (isToDate ? toDate.text : fromDate.text) ??
                    //     DateTime.now().toString(),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
