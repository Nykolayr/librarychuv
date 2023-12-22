import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/different.dart';
import 'package:librarychuv/presentation/theme/text.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

class SearchField extends StatefulWidget {
  final TextEditingController searchController;
  final FocusNode myFocusNode;
  const SearchField(
      {required this.searchController, required this.myFocusNode, super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  MainBloc bloc = Get.find<MainBloc>();

  @override
  initState() {
    widget.searchController.addListener(() {
      bloc.add(
          SortSearchEvent(item: widget.searchController.text, isSearch: true));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      padding: const EdgeInsets.only(left: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppDif.borderRadius10,
        border: AppDif.borderButton,
      ),
      child: TextField(
        controller: widget.searchController,
        focusNode: widget.myFocusNode,
        style: AppText.captionText14r.copyWith(height: 1.4),
        decoration: InputDecoration(
          hintStyle: AppText.captionText14r.copyWith(height: 1.4),
          hintText: 'Поиск',
          border: InputBorder.none,
          suffixIcon: Transform.scale(
            scale: 0.5,
            child: SvgPicture.asset('assets/svg/search.svg'),
          ),
        ),
      ),
    );
  }
}

/// простая поисковая строка
class SearchFieldSimple extends StatelessWidget {
  final TextEditingController searchController;

  const SearchFieldSimple({required this.searchController, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      padding: const EdgeInsets.only(left: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppDif.borderRadius10,
        border: AppDif.borderSearcch,
      ),
      child: TextField(
        controller: searchController,
        style: AppText.captionText14b.copyWith(height: 1.4),
        decoration: InputDecoration(
          hintStyle: AppText.captionText14r
              .copyWith(height: 1.4, color: AppColor.stroke),
          hintText: 'Поиск',
          border: InputBorder.none,
          suffixIcon: Transform.scale(
            scale: 0.5,
            child: SvgPicture.asset(
              'assets/svg/search.svg',
              colorFilter:
                  const ColorFilter.mode(AppColor.stroke, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
