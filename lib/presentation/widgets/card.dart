import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

class RoundedCardWidget extends StatelessWidget {
  final Widget child;
  final Widget? subChild;
  final bool isFix;
  final String pathImage;
  const RoundedCardWidget(
      {required this.child,
      this.subChild,
      this.isFix = true,
      super.key,
      this.pathImage = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuery.size.width - 20,
      height: isFix ? 240 : null,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: AppDif.borderRadius10,
        boxShadow: [
          BoxShadow(
            color: AppColor.blackText.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                if (pathImage.isNotEmpty)
                  ClipRRect(
                    borderRadius: AppDif.borderRadius10,
                    child: Image.asset(
                      pathImage,
                      width: context.mediaQuery.size.width - 20,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: isFix ? 15 : 10, horizontal: 10),
                  child: child,
                ),
              ],
            ),
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
