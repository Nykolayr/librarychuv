part of 'news_bloc.dart';

class NewsState {
  final String error;
  final bool isLoading;
  final NewsForPage news;
  final NewsForPage searchNews;
  final String searchText;

  const NewsState({
    required this.error,
    required this.isLoading,
    required this.news,
    required this.searchNews,
    required this.searchText,
  });

  factory NewsState.initial() => NewsState(
        error: '',
        isLoading: false,
        news: Get.find<MainRepository>().news,
        searchNews: NewsForPage.init(),
        searchText: '',
      );

  NewsState copyWith({
    String? error,
    bool? isLoading,
    NewsForPage? news,
    NewsForPage? searchNews,
    String? searchText,
  }) {
    return NewsState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      news: news ?? this.news,
      searchNews: searchNews ?? this.searchNews,
      searchText: searchText ?? this.searchText,
    );
  }
}
