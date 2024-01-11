import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// строчка с точкой вначале
class LinesWithDot extends StatelessWidget {
  final String text;
  final bool isTitle;
  const LinesWithDot({required this.text, this.isTitle = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6, color: AppColor.redMain),
          const Gap(10),
          Expanded(
            child: Text(
              text,
              style: isTitle ? AppText.text16r : AppText.text14r,
            ),
          ),
        ],
      ),
    );
  }
}
