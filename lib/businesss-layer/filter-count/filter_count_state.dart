part of 'filter_count_cubit.dart';

@immutable
abstract class FilterCountState {}

class FilterCountInitial extends FilterCountState {}

class FilterCountSet extends FilterCountState {
  final int filterCount;
  FilterCountSet({this.filterCount});
}