import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// общий класс для кнопок приложения
class ButtonSelf extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final bool isWhite;
  final String pathImage;
  const ButtonSelf(
      {required this.text,
      required this.width,
      required this.height,
      required this.onPressed,
      this.isWhite = false,
      this.pathImage = '',
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: isWhite ? AppColor.white : AppColor.redMain,
              borderRadius: AppDif.borderRadius10,
              border: AppDif.borderButton),
          child: Row(
              mainAxisAlignment: pathImage.isEmpty
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                Text(text,
                    style: isWhite ? AppText.button16r : AppText.button16w),
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
  static ButtonPink buttonPink(
      {required void Function() onPressed, required String text}) {
    return ButtonPink(
      text: text,
      onPressed: onPressed,
      width: 138,
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
