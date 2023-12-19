import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/theme/text.dart';

/// страница библиотек на
class LybraryPage extends StatelessWidget {
  const LybraryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height,
      color: Colors.amber,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text('LybraryPage', style: AppText.text14bCom),
      ]),
    );
  }
}
