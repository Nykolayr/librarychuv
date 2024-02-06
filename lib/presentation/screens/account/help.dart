import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

import '../main/bloc/main_bloc.dart';

/// страница справки и вопросов
class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MainBloc bloc = Get.find<MainBloc>();
    return BlocBuilder<MainBloc, MainState>(
        bloc: bloc,
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.only(bottom: 70, left: 12, right: 12),
            width: context.mediaQuerySize.width,
            height: context.mediaQuerySize.height - 120,
            color: AppColor.fon,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                
                children: [],
              ),
            ),
          );
        });
  }
}
