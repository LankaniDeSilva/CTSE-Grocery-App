import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  final String text;
  final Function() onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 259.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          // -----loading icon inside the button
          child: isLoading
              ? const SpinKitRotatingCircle(
                  color: Colors.white,
                  size: 40.0,
                )
              : CustomText(
                  text: text,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kWhite,
                ),
        ),
      ),
    );
  }
}
