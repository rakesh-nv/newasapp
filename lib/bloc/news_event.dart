import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class FetchNewsHeadlines extends NewsEvent {
  final String? category;

  const FetchNewsHeadlines({this.category});

  @override
  List<Object?> get props => [category];
}

class FetchVideoNews extends NewsEvent {
  const FetchVideoNews();
}

class ChangeCategory extends NewsEvent {
  final String category;

  const ChangeCategory(this.category);

  @override
  List<Object?> get props => [category];
}
