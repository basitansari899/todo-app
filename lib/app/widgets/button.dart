import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/app/constants/app_size_constants.dart';
import 'package:todoapp/app/theme/colors.dart';
import 'package:todoapp/app/theme/theme.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    this.buttonColor,
    this.textColor = XColors.black,
    required this.title,
    required this.onPress,
    this.width = 60,
    this.height = 50,
    this.loading = false,
    this.icon,
  });

  final bool loading;
  final String title;
  final Icon? icon;
  final double height;
  final double width;

  final VoidCallback onPress;

  final Color textColor;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor ?? XColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: Get.textTheme.bodyText1SemiBold?.copyWith(color: textColor)),
                    if (icon != null) ...[
                      gapW8,
                      Icon(icon!.icon, color: textColor, size: 18),
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}
