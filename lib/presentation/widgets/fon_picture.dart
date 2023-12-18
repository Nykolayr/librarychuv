import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

/// фоновый рисунок внизу страниц
class FonPicture extends StatelessWidget {
  const FonPicture({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: SvgPicture.asset('assets/svg/fon.svg',
          width: context.mediaQuerySize.width),
    );
  }
}
