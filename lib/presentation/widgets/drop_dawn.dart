import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

class DropdownButtons extends StatefulWidget {
  final String title;
  final List<String> items;
  final Function(String?)? onChanged;
  final bool isFull;
  final bool isRed;
  const DropdownButtons(
      {required this.title,
      required this.items,
      this.onChanged,
      this.isFull = false,
      this.isRed = true,
      super.key});

  @override
  State<DropdownButtons> createState() => _DropdownButtonsState();
}

class _DropdownButtonsState extends State<DropdownButtons> {
  MainBloc bloc = Get.find<MainBloc>();
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
        bloc: bloc,
        buildWhen: (previous, current) {
          if (previous.isSearch != current.isSearch) {
            selectedValue = null;
            setState(() {});
          }
          return true;
        },
        builder: (context, state) {
          return Container(
            width: widget.isFull
                ? context.mediaQuerySize.width
                : context.mediaQuerySize.width / 2 - 18,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: AppDif.borderRadius10,
                border:
                    widget.isRed ? AppDif.borderButton : AppDif.borderCarusel),
            height: 41,
            child: DropdownButton<String>(
              hint: Text(
                widget.title,
                style: widget.isRed
                    ? AppText.captionText14r
                    : AppText.captionText14b.copyWith(color: AppColor.greyText),
              ),
              icon: SvgPicture.asset(
                'assets/svg/down_arrow.svg',
                height: 8,
                colorFilter: ColorFilter.mode(
                    widget.isRed ? AppColor.redMain : AppColor.greyText,
                    BlendMode.srcIn),
              ),
              iconSize: 24,
              isExpanded: true,
              style: widget.isRed
                  ? AppText.captionText14r
                  : AppText.captionText14b.copyWith(color: AppColor.greyText),
              value: selectedValue,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedValue = newValue;
                  Logger.e('selectedValue == $selectedValue');
                  // widget.onChanged?.call(selectedValue);
                } else {
                  selectedValue = null;
                }
                setState(() {});
              },
              underline: const SizedBox.shrink(),
              items: widget.items
                  .toSet()
                  .map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item,
                      style: widget.isRed
                          ? AppText.captionText14r
                          : AppText.captionText14b
                              .copyWith(color: AppColor.greyText),
                      overflow: TextOverflow.ellipsis),
                );
              }).toList(),
            ),
          );
        });
  }
}
