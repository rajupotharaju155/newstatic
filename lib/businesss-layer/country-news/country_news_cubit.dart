import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newstatic/models/newModel.dart';
import 'package:newstatic/service-layer/api-service.dart';

part 'country_news_state.dart';

class CountryNewsCubit extends Cubit<CountryNewsState> {
  CountryNewsCubit() : super(CountryNewsLoading());

  List<NewsModel> newsList = [];

  Future<void> getCountryNews(String countryCode)async{
    emit(CountryNewsLoading());
    dynamic result = await ApiService.getTopHeadlinesFromCountry(countryCode);
    if(result=='0' || result=='2'){
      emit(CountryNewsException());
    }else if(result=='1'){
      emit(CountryNewsSocketException());
    }else{
      List<dynamic> news = result;
      newsList = news.map((e) => NewsModel.fromjson(e)).toList();
      // print(newsList);
      emit(CountryNewsLoaded(newsList: newsList));
    }
  }

    Future<void> getsourceNews(String sourceList)async{
    emit(CountryNewsLoading());
    dynamic result = await ApiService.getTopHeadlinesFromSource(sourceList);
    if(result=='0' || result=='2'){
      emit(CountryNewsException());
    }else if(result=='1'){
      emit(CountryNewsSocketException());
    }else{
      List<dynamic> news = result;
      newsList = news.map((e) => NewsModel.fromjson(e)).toList();
      print(newsList);
      emit(CountryNewsLoaded(newsList: newsList));
    }
  }
}
