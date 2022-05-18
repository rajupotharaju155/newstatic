import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newstatic/models/newModel.dart';
import 'package:newstatic/service-layer/api-service.dart';

part 'country_news_state.dart';

class CountryNewsCubit extends Cubit<CountryNewsState> {
  CountryNewsCubit() : super(CountryNewsInitial());

  List<NewsModel> newsList = [];

  Future<void> getCountryNews(String countryCode)async{
    dynamic result = await ApiService.getTopHeadlinesFromCountry(countryCode);
    if(result=='0'){
      emit(state);
    }
    List<dynamic> news = result;
    newsList = news.map((e) => NewsModel.fromjson(e)).toList();
    print(newsList);
  }
}
