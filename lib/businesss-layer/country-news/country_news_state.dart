part of 'country_news_cubit.dart';

@immutable
abstract class CountryNewsState {}

class CountryNewsLoading extends CountryNewsState {}
class CountryNewsSocketException extends CountryNewsState {}

class CountryNewsException extends CountryNewsState {
  final String status;
  // final String code;
  final String message;
  CountryNewsException({this.status, this.message});
}
class CountryNewsLoaded extends CountryNewsState {
  final List<NewsModel> newsList;
  CountryNewsLoaded({this.newsList});
}
