import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selected_country_state.dart';

class SelectedCountryCubit extends Cubit<SelectedCountryState> {
  SelectedCountryCubit() : super(SelectedCountryInitial());
  String countryCode;
  String countryName;
  void setSelectedCountry(String countryCode, String countryName){
    countryCode = countryCode;
    countryName = countryName;
    emit(SelectedCountrySet(countryCode: countryCode, countryName: countryName));
  }
}
