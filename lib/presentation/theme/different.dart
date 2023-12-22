import 'package:flutter/material.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

class AppDif {
  static const Divider divider = Divider(color: AppColor.greyText, height: 1);
  static const Radius radius20 = Radius.circular(20);
  static const Radius radius10 = Radius.circular(10);
  static const Radius radius5 = Radius.circular(5);
  static const BorderRadius borderRadius20 = BorderRadius.all(radius20);
  static const BorderRadius borderRadius10 = BorderRadius.all(radius10);
  static const BorderRadius borderRadius5 = BorderRadius.all(radius5);
  static Border borderButton = Border.all(color: AppColor.redMain, width: 1.0);
  static Border borderSearcch = Border.all(color: AppColor.stroke, width: 1.0);
  static BoxBorder borderCarusel =
      Border.all(color: AppColor.stroke, width: 1.0);
  static BoxShadow boxShadowCarusel = BoxShadow(
    color: AppColor.greyText.withOpacity(0.1),
    spreadRadius: 0,
    blurRadius: 35,
    offset: const Offset(0, 4),
  );

  /// общий для всех textField
  static InputDecoration getInputDecoration({required String hint}) {
    return InputDecoration(
      errorStyle: const TextStyle(fontSize: 10, height: 0.3),
      border: getOutlineBorder(),
      focusedBorder: getOutlineBorder(),
      enabledBorder: getOutlineBorder(),
      disabledBorder: getOutlineBorder(),
      errorBorder: getOutlineBorder(color: AppColor.redMain),
      focusedErrorBorder: getOutlineBorder(color: AppColor.redMain),
      filled: true,
      hintStyle: AppText.textHint16,
      hintText: hint,
      fillColor: AppColor.white,
    );
  }

  static OutlineInputBorder getOutlineBorder(
      {Color color = AppColor.greyText}) {
    return OutlineInputBorder(
      borderRadius: AppDif.borderRadius10,
      borderSide: BorderSide(
        width: 1,
        style: BorderStyle.solid,
        color: color,
      ),
    );
  }

  static BoxDecoration getBoxDecoration({bool isWhite = true}) => BoxDecoration(
        color: isWhite ? AppColor.white : AppColor.fon,
        borderRadius: AppDif.borderRadius10,
        boxShadow: [
          BoxShadow(
            color: AppColor.blackText.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      );
}
