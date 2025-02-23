import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/news_event.dart';
import 'package:newsapp/bloc/news_state.dart';
import 'package:newsapp/view_model/news_viewModel.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsViewModel _newsViewModel;

  NewsBloc(this._newsViewModel) : super(NewsInitial()) {
    on<FetchNewsHeadlines>(_onFetchNewsHeadlines);
    on<FetchVideoNews>(_onFetchVideoNews);
    on<ChangeCategory>(_onChangeCategory);
  }

  Future<void> _onFetchNewsHeadlines(
    FetchNewsHeadlines event,
    Emitter<NewsState> emit,
  ) async {
    try {
      emit(NewsLoading());
      final news = await _newsViewModel.fetchNewsChannelHeadlinesApi(
        category: event.category ?? '',
      );
      emit(NewsLoaded(news: news, currentCategory: event.category ?? ''));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> _onFetchVideoNews(
    FetchVideoNews event,
    Emitter<NewsState> emit,
  ) async {
    try {
      emit(VideoNewsLoading());
      final videos = await _newsViewModel.fetchNewsChannelHeadlinesApi(
        category: 'technology',
      );
      emit(VideoNewsLoaded(videos));
    } catch (e) {
      emit(VideoNewsError(e.toString()));
    }
  }

  Future<void> _onChangeCategory(
    ChangeCategory event,
    Emitter<NewsState> emit,
  ) async {
    try {
      emit(NewsLoading());
      final news = await _newsViewModel.fetchNewsChannelHeadlinesApi(
        category: event.category,
      );
      emit(NewsLoaded(news: news, currentCategory: event.category));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
