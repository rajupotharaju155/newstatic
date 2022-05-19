part of 'selected_country_cubit.dart';

@immutable
abstract class SelectedCountryState {}

class SelectedCountryInitial extends SelectedCountryState {}
class SelectedCountrySet extends SelectedCountryState {
  final String countryName;
  final String countryCode;
  SelectedCountrySet({this.countryCode, this.countryName});
}
