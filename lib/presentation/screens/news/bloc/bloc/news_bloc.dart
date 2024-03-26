import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsState.initial()) {
    // on<AuthLoginEvent>(_onAuthLoginEvent);
    // on<AuthPassEvent>(_onPassEvent);
  }
}
