import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:librarychuv/presentation/theme/text.dart';

/// страница новостей
class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Gap(50),
      Text('NewsPage', style: AppText.text14bCom),
    ]);
  }
}
