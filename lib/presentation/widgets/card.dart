import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

class RoundedCardWidget extends StatelessWidget {
  final Widget child;
  final Widget? subChild;
  final bool isFix;

  const RoundedCardWidget(
      {required this.child, this.subChild, this.isFix = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: isFix ? 15 : 10, horizontal: 10),
      width: double.infinity,
      height: isFix ? 240 : null,
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
