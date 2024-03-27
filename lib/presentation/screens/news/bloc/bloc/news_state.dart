part of 'news_bloc.dart';

class NewsState {
  final String error;
  final bool isLoading;
  final NewsForPage news;

  const NewsState({
    required this.error,
    required this.isLoading,
    required this.news,
  });

  factory NewsState.initial() => NewsState(
        error: '',
        isLoading: false,
        news: Get.find<MainRepository>().news,
      );

  NewsState copyWith({
    String? error,
    bool? isLoading,
    NewsForPage? news,
  }) {
    return NewsState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      news: news ?? this.news,
    );
  }
}
