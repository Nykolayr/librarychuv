import 'package:flutter/material.dart';
import 'package:librarychuv/presentation/theme/colors.dart';
import 'package:librarychuv/presentation/theme/different.dart';
import 'package:librarychuv/presentation/theme/text.dart';

/// общий класс для кнопок приложения
class ButtonSelf extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final bool isWhite;
  const ButtonSelf(
      {required this.text,
      required this.width,
      required this.height,
      required this.onPressed,
      this.isWhite = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: isWhite ? AppColor.white : AppColor.redMain,
            borderRadius: AppDif.borderRadius10,
            border: AppDif.borderButton),
        child: Center(
          child: Text(text,
              style: isWhite ? AppText.button16r : AppText.button16w),
        ),
      ),
    );
  }
}

/// класс с прессетами кнопок приложения
class Buttons {
  /// кнопка входа в приложение
  static ButtonSelf buttonFull(
      {required void Function() onPressed, required String text}) {
    return ButtonSelf(
      text: text,
      onPressed: onPressed,
      width: double.infinity,
      height: 40,
    );
  }

  static ButtonSelf buttonOut(
      {required void Function() onPressed, required String text}) {
    return ButtonSelf(
      text: text,
      onPressed: onPressed,
      width: double.infinity,
      height: 40,
      isWhite: true,
    );
  }
}
