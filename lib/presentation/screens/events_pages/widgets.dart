import 'package:flutter/material.dart';
import 'package:librarychuv/domain/models/events.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

class ItemEventsType extends StatelessWidget {
  final EventsLib item;
  const ItemEventsType({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: AppDif.borderRadius20,
        border: AppDif.borderSearcch,
      ),
      child: Center(
        child: Text(item.type.title, style: AppText.text12g),
      ),
    );
  }
}
