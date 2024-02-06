part of 'main_bloc.dart';

class MainState {
  final List<SecondPageType> typePages;
  final String error;
  final bool isSucsess;
  final bool isLoading;
  final bool isSearch;
  final List<String> dropItems;
  final List<Libriry> searchLibriryItems;
  final int curLibriryId;
  final List<AllModels> items;
  final AllModels chooseItem;
  final String tempNamePage;
  final bool isHelp;

  const MainState({
    required this.typePages,
    required this.error,
    required this.isSucsess,
    required this.isLoading,
    required this.dropItems,
    required this.searchLibriryItems,
    required this.isSearch,
    required this.curLibriryId,
    required this.items,
    required this.tempNamePage,
    required this.chooseItem,
    required this.isHelp,
  });

  bool get isSecondPage => typePages.isNotEmpty;

  factory MainState.initial() {
    List<Region> regions = Get.find<MainRepository>().regionies;
    List<Libriry> libriries = Get.find<MainRepository>().libriries;
    List<String> regionsNames = regions.map((e) => e.name).toList();
    return MainState(
      typePages: [],
      error: '',
      isSucsess: false,
      isLoading: false,
      dropItems: regionsNames,
      searchLibriryItems: libriries,
      isSearch: false,
      curLibriryId: -1,
      items: [],
      tempNamePage: '',
      chooseItem: Book.initial(),
      isHelp: false,
    );
  }

  MainState copyWith({
    List<SecondPageType>? typePages,
    String? error,
    bool? isSucsess,
    bool? isLoading,
    List<String>? dropItems,
    List<Libriry>? searchLibriryItems,
    bool? isSearch,
    int? curLibriryId,
    String? appBarTitle,
    List<AllModels>? items,
    String? tempNamePage,
    int? indexItem,
    AllModels? chooseItem,
    bool? isHelp,
  }) {
    return MainState(
      typePages: typePages ?? this.typePages,
      error: error ?? this.error,
      isSucsess: isSucsess ?? this.isSucsess,
      isLoading: isLoading ?? this.isLoading,
      dropItems: dropItems ?? this.dropItems,
      searchLibriryItems: searchLibriryItems ?? this.searchLibriryItems,
      isSearch: isSearch ?? this.isSearch,
      curLibriryId: curLibriryId ?? this.curLibriryId,
      items: items ?? this.items,
      tempNamePage: tempNamePage ?? this.tempNamePage,
      chooseItem: chooseItem ?? this.chooseItem,
      isHelp: isHelp ?? this.isHelp,
    );
  }
}
