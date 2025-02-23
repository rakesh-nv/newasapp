import 'package:equatable/equatable.dart';
import 'package:newsapp/models/news_channel_headlinesModel.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final NewsChannelsHeadlinenModel news;
  final String currentCategory;

  const NewsLoaded({
    required this.news,
    this.currentCategory = '',
  });

  @override
  List<Object?> get props => [news, currentCategory];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object?> get props => [message];
}

class VideoNewsLoading extends NewsState {}

class VideoNewsLoaded extends NewsState {
  final NewsChannelsHeadlinenModel videos;

  const VideoNewsLoaded(this.videos);

  @override
  List<Object?> get props => [videos];
}

class VideoNewsError extends NewsState {
  final String message;

  const VideoNewsError(this.message);

  @override
  List<Object?> get props => [message];
}
