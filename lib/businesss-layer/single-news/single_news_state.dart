part of 'single_news_cubit.dart';

@immutable
abstract class SingleNewsState {}

class SingleNewsInitial extends SingleNewsState {}
class SingleNewsLoaded extends SingleNewsState {
  final NewsModel newsModel;
  SingleNewsLoaded({this.newsModel});
}
