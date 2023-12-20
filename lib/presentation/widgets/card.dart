import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/theme/colors.dart';
import 'package:librarychuv/presentation/theme/different.dart';

class RoundedCardWidget extends StatelessWidget {
  final Widget child;
  final Widget? subChild;

  const RoundedCardWidget({required this.child, this.subChild, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      width: double.infinity,
      height: 240,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: AppDif.borderRadius10,
        boxShadow: [
          BoxShadow(
            color: AppColor.blackText.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: child,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: context.mediaQuerySize.width - 20,
              alignment: Alignment.bottomCenter,
              height: 30,
              color: subChild != null ? AppColor.white : Colors.transparent,
              child: subChild ?? const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
