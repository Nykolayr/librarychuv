import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

class DataNameUser extends StatelessWidget {
  final String title;
  final String sub;
  const DataNameUser({required this.title, required this.sub, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppText.captionText14b),
          const Gap(5),
          Text(sub, style: AppText.text14b),
          const Gap(10),
          const Divider(color: AppColor.greyText2),
        ],
      ),
    );
  }
}
