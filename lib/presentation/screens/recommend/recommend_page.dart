import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:librarychuv/presentation/theme/text.dart';

/// страница библиотек на карте
class RecommendPage extends StatelessWidget {
  const RecommendPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Gap(50),
      Text('RecommendPage', style: AppText.text14bCom),
    ]);
  }
}
