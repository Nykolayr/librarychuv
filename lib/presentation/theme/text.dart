import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

class AppText {
  static TextStyle captionText36Com = GoogleFonts.cormorant(
    color: AppColor.redMain,
    fontWeight: FontWeight.w700,
    fontSize: 36,
  );
  static TextStyle text24rCom = GoogleFonts.cormorant(
    color: AppColor.redMain,
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );
  static TextStyle text14bCom = GoogleFonts.cormorant(
    color: AppColor.blackText,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle text16gCom = GoogleFonts.cormorant(
    color: AppColor.greyText2,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
  static TextStyle text12gCom = GoogleFonts.cormorant(
    color: AppColor.greyText2,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static TextStyle button16w = GoogleFonts.roboto(
    color: AppColor.white,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static TextStyle button16r = GoogleFonts.roboto(
    color: AppColor.redMain,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static TextStyle button16grey = GoogleFonts.roboto(
    color: AppColor.greyText,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static TextStyle textHint16 = GoogleFonts.roboto(
    color: AppColor.greyText,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static TextStyle text16r = GoogleFonts.roboto(
    color: AppColor.redMain,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static TextStyle text14b = GoogleFonts.roboto(
    color: AppColor.blackText,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle text12b = GoogleFonts.roboto(
    color: AppColor.blackText,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static TextStyle text12g = GoogleFonts.roboto(
    color: AppColor.greyText2,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static TextStyle text12r = GoogleFonts.roboto(
    color: AppColor.redMain,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  static TextStyle text10r = GoogleFonts.roboto(
    color: AppColor.redMain,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
  static TextStyle text9r = GoogleFonts.roboto(
    color: AppColor.redMain,
    fontWeight: FontWeight.w500,
    fontSize: 9,
  );
  static TextStyle textMed14r = GoogleFonts.roboto(
    color: AppColor.redMain,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static TextStyle text14r = GoogleFonts.roboto(
    color: AppColor.redMain,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle captionText14r = GoogleFonts.roboto(
    color: AppColor.redMain,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static TextStyle captionText14b = GoogleFonts.roboto(
    color: AppColor.blackText,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static TextStyle text14g = GoogleFonts.roboto(
    color: AppColor.greyText3,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle text14bsmall = GoogleFonts.roboto(
    color: AppColor.blackText,
    fontWeight: FontWeight.w300,
    fontSize: 14,
  );

  /// устанавливает подчеркивание под текстом на удаление от текста
  static Widget textUnder(String text, {isSearch = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
      child: Column(
        children: [
          Text(
            text,
            style: AppText.text12r,
          ),
          const Gap(1),
          Dash(
            direction: Axis.horizontal,
            length: isSearch ? 150 : 60,
            dashLength: 4,
            dashColor: AppColor.redMain,
          )
        ],
      ),
    );
  }
}
