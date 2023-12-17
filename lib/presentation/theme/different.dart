import 'package:flutter/material.dart';
import 'package:librarychuv/presentation/theme/colors.dart';

class AppDif {
  static const Divider divider = Divider(color: AppColor.greyText, height: 1);
  static const Radius radius20 = Radius.circular(20);
  static const Radius radius10 = Radius.circular(10);
  static const BorderRadius borderRadius20 = BorderRadius.all(radius20);
  static const BorderRadius borderRadius10 = BorderRadius.all(radius10);
  static Border borderButton = Border.all(color: AppColor.redMain, width: 1.0);

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
      hintStyle: const TextStyle(color: AppColor.greyText),
      hintText: hint,
      fillColor: AppColor.redMain,
    );
  }

  static OutlineInputBorder getOutlineBorder({Color color = AppColor.white}) {
    return OutlineInputBorder(
      borderRadius: AppDif.borderRadius20,
      borderSide: BorderSide(
        width: 1,
        style: BorderStyle.solid,
        color: color,
      ),
    );
  }
}
