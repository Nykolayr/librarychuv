import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// строчка с точкой вначале
class LinesWithDot extends StatelessWidget {
  final String text;
  final bool isTitle;
  final bool isRed;
  const LinesWithDot(
      {required this.text, this.isTitle = false, this.isRed = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(Icons.circle,
              size: 6, color: isRed ? AppColor.redMain : AppColor.blackText),
          const Gap(10),
          Expanded(
            child: Text(
              text,
              style: isTitle
                  ? AppText.text16r
                  : AppText.text14r.copyWith(
                      color: isRed ? AppColor.redMain : AppColor.blackText),
            ),
          ),
        ],
      ),
    );
  }
}
