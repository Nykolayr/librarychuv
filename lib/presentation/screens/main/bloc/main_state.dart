part of 'main_bloc.dart';

class MainState {
  final List<Widget> pages;
  final String error;
  final String appBarTitle;
  final bool isSucsess;
  final bool isLoading;
  final bool isSearch;
  final List<String> dropItems;
  final List<Libriry> searchLibriryItems;
  final int curLibriryId;

  const MainState({
    required this.pages,
    required this.error,
    required this.isSucsess,
    required this.isLoading,
    required this.dropItems,
    required this.searchLibriryItems,
    required this.isSearch,
    required this.curLibriryId,
    required this.appBarTitle,
  });

  factory MainState.initial() {
    List<Region> regions = Get.find<MainRepository>().regionies;
    List<Libriry> libriries = Get.find<MainRepository>().libriries;
    List<String> regionsNames = regions.map((e) => e.name).toList();
    return MainState(
      pages: [],
      error: '',
      isSucsess: false,
      isLoading: false,
      dropItems: regionsNames,
      searchLibriryItems: libriries,
      isSearch: false,
      curLibriryId: -1,
      appBarTitle: '',
    );
  }

  MainState copyWith({
    List<Widget>? pages,
    String? error,
    bool? isSucsess,
    bool? isLoading,
    List<String>? dropItems,
    List<Libriry>? searchLibriryItems,
    bool? isSearch,
    int? curLibriryId,
    String? appBarTitle,
  }) {
    return MainState(
      pages: pages ?? this.pages,
      error: error ?? this.error,
      isSucsess: isSucsess ?? this.isSucsess,
      isLoading: isLoading ?? this.isLoading,
      dropItems: dropItems ?? this.dropItems,
      searchLibriryItems: searchLibriryItems ?? this.searchLibriryItems,
      isSearch: isSearch ?? this.isSearch,
      curLibriryId: curLibriryId ?? this.curLibriryId,
      appBarTitle: appBarTitle ?? this.appBarTitle,
    );
  }
}
