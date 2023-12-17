import 'package:flutter/material.dart';

class AppBarWithBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  AppBarWithBackButton({this.title = 'Назад'});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: const BackButton(),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
