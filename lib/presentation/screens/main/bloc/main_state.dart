part of 'main_bloc.dart';

class MainState {
  final Widget? page;
  final String error;
  final bool isSucsess;
  final bool isLoading;
  final bool isSearch;
  final bool isPage;
  final List<String> dropItems;
  final List<Libriry> searchLibriryItems;
  final int curLibriryId;

  const MainState(
      {required this.page,
      required this.error,
      required this.isSucsess,
      required this.isLoading,
      required this.isPage,
      required this.dropItems,
      required this.searchLibriryItems,
      required this.isSearch,
      required this.curLibriryId});

  factory MainState.initial() {
    List<Region> regions = Get.find<MainRepository>().regionies;
    List<Libriry> libriries = Get.find<MainRepository>().libriries;
    List<String> regionsNames = regions.map((e) => e.name).toList();
    return MainState(
      page: null,
      error: '',
      isSucsess: false,
      isLoading: false,
      isPage: false,
      dropItems: regionsNames,
      searchLibriryItems: libriries,
      isSearch: false,
      curLibriryId: -1,
    );
  }

  MainState copyWith({
    Widget? page,
    String? error,
    bool? isSucsess,
    bool? isLoading,
    bool? isPage,
    List<String>? dropItems,
    List<Libriry>? searchLibriryItems,
    bool? isSearch,
    int? curLibriryId,
  }) {
    return MainState(
      page: page ?? this.page,
      error: error ?? this.error,
      isSucsess: isSucsess ?? this.isSucsess,
      isLoading: isLoading ?? this.isLoading,
      isPage: isPage ?? this.isPage,
      dropItems: dropItems ?? this.dropItems,
      searchLibriryItems: searchLibriryItems ?? this.searchLibriryItems,
      isSearch: isSearch ?? this.isSearch,
      curLibriryId: curLibriryId ?? this.curLibriryId,
    );
  }
}
