import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/theme/colors.dart';
import 'package:librarychuv/presentation/theme/text.dart';

/// страница библиотек на карте
class RecommendPage extends StatelessWidget {
  const RecommendPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: AppColor.fon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
