import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'filter_count_state.dart';

class FilterCountCubit extends Cubit<FilterCountState> {
  FilterCountCubit() : super(FilterCountInitial());

  void setFilterCount(int count){
    emit(FilterCountSet(filterCount: count));
  }
}
