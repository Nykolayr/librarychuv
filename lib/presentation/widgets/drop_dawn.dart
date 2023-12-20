import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/colors.dart';
import 'package:librarychuv/presentation/theme/different.dart';
import 'package:librarychuv/presentation/theme/text.dart';

class DropdownButtons extends StatefulWidget {
  const DropdownButtons({super.key});

  @override
  State<DropdownButtons> createState() => _DropdownButtonsState();
}

class _DropdownButtonsState extends State<DropdownButtons> {
  MainBloc bloc = Get.find<MainBloc>();
  String? selectedRegion;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
        bloc: bloc,
        buildWhen: (previous, current) {
          if (previous.isSearch != current.isSearch) {
            selectedRegion = null;
            setState(() {});
          }
          return true;
        },
        builder: (context, state) {
          return Container(
            width: context.mediaQuerySize.width / 2 - 18,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: AppDif.borderRadius10,
                border: AppDif.borderButton),
            height: 41,
            child: DropdownButton<String>(
              hint: Text(
                'Выбор региона',
                style: AppText.captionText14r,
              ),
              icon: SvgPicture.asset(
                'assets/svg/down_arrow.svg',
                height: 8,
              ),
              iconSize: 24,
              isExpanded: true,
              style: AppText.captionText14r,
              value: selectedRegion,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedRegion = newValue;
                  bloc.add(SortDropEvent(item: selectedRegion!));
                } else {
                  selectedRegion = null;
                }
                setState(() {});
              },
              underline: const SizedBox.shrink(),
              items: bloc.state.dropItems
                  .map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item,
                      style: AppText.captionText14r,
                      overflow: TextOverflow.ellipsis),
                );
              }).toList(),
            ),
          );
        });
  }
}
