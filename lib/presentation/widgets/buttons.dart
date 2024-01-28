import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// общий класс для кнопок приложения
class ButtonSelf extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final bool isWhite;
  final String pathImage;
  final bool isTransporant;
  const ButtonSelf(
      {required this.text,
      required this.width,
      required this.height,
      required this.onPressed,
      this.isWhite = false,
      this.isTransporant = false,
      this.pathImage = '',
      super.key});

  @override
  Widget build(BuildContext context) {
    Color color = AppColor.redMain;
    Color textColor = AppColor.white;
    if (isTransporant) {
      color = Colors.transparent;
      textColor = AppColor.blackText;
    } else if (isWhite) {
      color = AppColor.white;
      textColor = AppColor.redMain;
    }
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: color,
              borderRadius: AppDif.borderRadius10,
              border: AppDif.borderButton),
          child: Row(
              mainAxisAlignment: pathImage.isEmpty
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                Text(text, style: AppText.button16r.copyWith(color: textColor)),
                if (pathImage.isNotEmpty)
                  SvgPicture.asset(pathImage, height: 17),
              ])),
    );
  }
}

/// общий класс для розовых кнопок приложения
class ButtonPink extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const ButtonPink(
      {required this.text,
      required this.width,
      required this.height,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: AppColor.pink,
          borderRadius: AppDif.borderRadius5,
        ),
        child: Center(
          child: Text(text, style: AppText.text10r),
        ),
      ),
    );
  }
}

/// класс с прессетами кнопок приложения
class Buttons {
  /// кнопка розовая
  static ButtonPink buttonPink({
    required void Function() onPressed,
    required String text,
    required double width,
    bool isWide = false,
  }) {
    return ButtonPink(
      text: text,
      onPressed: onPressed,
      width: width,
      height: 28,
    );
  }

  /// кнопка входа в приложение
  static Widget buttonFullWitImage({
    required void Function() onPressed,
    required String text,
    required String pathImage,
    bool isPadding = true,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isPadding ? 10 : 0),
      child: ButtonSelf(
        text: text,
        onPressed: onPressed,
        width: double.infinity,
        height: 43,
        pathImage: pathImage,
      ),
    );
  }

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

/// общий класс для розовых кнопок приложения
class ButtonRow extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final bool isTransporant;

  const ButtonRow(
      {required this.text,
      this.height = 30,
      required this.onPressed,
      this.isTransporant = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        height: height,
        decoration: BoxDecoration(
          color: isTransporant ? Colors.transparent : AppColor.redMain,
          borderRadius: AppDif.borderRadius20,
        ),
        child: Center(
          child: Text(text,
              style: AppText.textMed14r.copyWith(
                  fontSize: 13,
                  color: isTransporant ? AppColor.greyText : AppColor.white)),
        ),
      ),
    );
  }
}
