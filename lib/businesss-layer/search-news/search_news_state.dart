part of 'search_news_cubit.dart';

@immutable
abstract class SearchNewsState {}

class SearchNewsInitial extends SearchNewsState {}
class SearchNewsLoading extends SearchNewsState {}
class SearchNewsSocketException extends SearchNewsState {}

class SearchNewsException extends SearchNewsState {}
class SearchNewsLoaded extends SearchNewsState {
  final List<NewsModel> searchList;
  SearchNewsLoaded({this.searchList});
}
