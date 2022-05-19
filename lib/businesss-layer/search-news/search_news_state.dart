part of 'search_news_cubit.dart';

@immutable
abstract class SearchNewsState {}

class SearchNewsInitial extends SearchNewsState {}
class SearchNewsLoading extends SearchNewsState {}
class SearchNewsLoadingPagination extends SearchNewsState {}
class SearchNewsSocketException extends SearchNewsState {}

class SearchNewsException extends SearchNewsState {
    final String status;
  // final String code;
  final String message;
  SearchNewsException({this.status, this.message});
}
class SearchNewsLoaded extends SearchNewsState {
  final List<NewsModel> searchList;
  SearchNewsLoaded({this.searchList});
}
