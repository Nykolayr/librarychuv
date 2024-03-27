import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:librarychuv/data/local_data.dart';
import 'package:librarychuv/domain/models/news.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsState.initial()) {
    on<LoadNewsEvent>(_onLoadNewsEvent);
    on<LoadNewsSearchEvent>(_onLoadNewsSearchEvent);
    on<AddSearchTextEvent>(_onAddSearchEvent);
    on<ClearSearchEvent>(_onClearSearchEvent);
  }

  void _onAddSearchEvent(AddSearchTextEvent event, Emitter<NewsState> emit) {
    emit(state.copyWith(searchText: event.searchText));
  }

  void _onClearSearchEvent(ClearSearchEvent event, Emitter<NewsState> emit) {
    emit(state.copyWith(searchText: ''));
  }

  void _onLoadNewsEvent(LoadNewsEvent event, Emitter<NewsState> emit) async {
    if (state.news.isLastPage) return;
    emit(state.copyWith(isLoading: true));
    String answer = await Get.find<MainRepository>().loadListApi(
      LocalDataKey.news,
      page: state.news.pagination.currentPage + 1,
    );
    emit(state.copyWith(isLoading: false));
    if (answer.isEmpty) {
      emit(state.copyWith(news: Get.find<MainRepository>().news));
    } else {
      emit(state.copyWith(error: answer));
    }
  }

  void _onLoadNewsSearchEvent(
      LoadNewsSearchEvent event, Emitter<NewsState> emit) async {
    if (state.searchNews.isLastPage) return;
    emit(state.copyWith(isLoading: true));
    String answer = await Get.find<MainRepository>().loadListApi(
        LocalDataKey.searchNews,
        page: state.searchNews.pagination.currentPage + 1,
        search: state.searchText);
    emit(state.copyWith(isLoading: false));

    if (answer.isEmpty) {
      NewsForPage searchNews = Get.find<MainRepository>().searchNews;
      if (searchNews.news.isNotEmpty) {
        emit(state.copyWith(searchNews: searchNews));
      } else {
        emit(state.copyWith(error: 'Ничего не найдено'));
      }
    } else {
      emit(state.copyWith(error: answer));
    }
  }
}
