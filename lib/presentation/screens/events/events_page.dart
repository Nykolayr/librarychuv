import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:librarychuv/presentation/theme/text.dart';

/// страница событий
class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Gap(50),
      Text('EventsPage', style: AppText.text14bCom),
    ]);
  }
}
