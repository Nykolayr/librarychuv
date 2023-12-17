import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final Widget widget;
  const MainPage({required this.widget, Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return widget.widget;
  }
}
