part of 'news_bloc.dart';

class NewsState {
  final String error;
  final bool isLoading;

  const NewsState({
    required this.error,
    required this.isLoading,
  });

  factory NewsState.initial() => const NewsState(
        error: '',
        isLoading: false,
      );

  NewsState copyWith({
    String? error,
    bool? isLoading,
  }) {
    return NewsState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
