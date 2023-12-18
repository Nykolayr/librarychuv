import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:librarychuv/presentation/theme/text.dart';

/// страница книг
class BooksPage extends StatelessWidget {
  const BooksPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Gap(50),
      Text('BooksPage', style: AppText.text14bCom),
    ]);
  }
}
