part of 'main_bloc.dart';

class MainState {
  final Widget? page;
  final String error;
  final bool isSucsess;
  final bool isLoading;
  final bool isPage;

  const MainState({
    required this.page,
    required this.error,
    required this.isSucsess,
    required this.isLoading,
    required this.isPage,
  });

  factory MainState.initial() {
    return const MainState(
      page: null,
      error: '',
      isSucsess: false,
      isLoading: false,
      isPage: false,
    );
  }

  MainState copyWith({
    Widget? page,
    String? error,
    bool? isSucsess,
    bool? isLoading,
    bool? isPage,
  }) {
    return MainState(
      page: page ?? this.page,
      error: error ?? this.error,
      isSucsess: isSucsess ?? this.isSucsess,
      isLoading: isLoading ?? this.isLoading,
      isPage: isPage ?? this.isPage,
    );
  }
}
