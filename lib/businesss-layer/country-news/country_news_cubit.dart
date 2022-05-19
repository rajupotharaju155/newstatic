import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newstatic/models/newModel.dart';
import 'package:newstatic/service-layer/api-service.dart';

part 'country_news_state.dart';

class CountryNewsCubit extends Cubit<CountryNewsState> {
  CountryNewsCubit() : super(CountryNewsLoading());

  List<NewsModel> newsList = [];
  int page = 0;
  String finalSourceString;

  Future<void> getCountryNews(String countryCode, String countryName)async{
    page = 1;
    emit(CountryNewsLoading());
    dynamic result = await ApiService.getTopHeadlinesFromCountry(countryCode, page.toString());
    print(result);
    if(result is Map){
      print("result is map");
      // print(result);
      emit(CountryNewsException(status: result['status'], message: result['message']));
    }
    else if(result=='1'){
      emit(CountryNewsSocketException());
    }else{
      List<dynamic> news = result;
      newsList = news.map((e) => NewsModel.fromjson(e)).toList();
      emit(CountryNewsLoaded(newsList: newsList));
    }
  }

    Future<void> getCountryNewsPagination(String countryCode, String countryName)async{
    emit(CountryNewsPaginationLoading());
    page+=1;
    dynamic result = await ApiService.getTopHeadlinesFromCountry(countryCode, page.toString());
    print(result);
    if(result is Map){
      print("result is map");
      // print(result);
      emit(CountryNewsException(status: result['status'], message: result['message']));
    }
    else if(result=='1'){
      emit(CountryNewsSocketException());
    }else{
      List<dynamic> news = result;
      newsList = news.map((e) => NewsModel.fromjson(e)).toList();
      emit(CountryNewsLoaded(newsList: newsList));
    }
  }
 
    Future<void> getsourceNews(String sourceList)async{
      finalSourceString = sourceList;
      page = 1;
    emit(CountryNewsLoading());
    dynamic result = await ApiService.getTopHeadlinesFromSource(sourceList, page.toString());
    if(result is Map){
      print("result is map");
      // print(result);
      emit(CountryNewsException(status: result['status'], message: result['message']));
    }else if(result=='1'){
      emit(CountryNewsSocketException());
    }else{
      List<dynamic> news = result;
      newsList = news.map((e) => NewsModel.fromjson(e)).toList();
      print(newsList);
      emit(CountryNewsLoaded(newsList: newsList));
    }
  }

      Future<void> getsourceNewsPagination()async{
        page+=1;
      emit(CountryNewsLoading());
      dynamic result = await ApiService.getTopHeadlinesFromSource(finalSourceString, page.toString());
      if(result is Map){
        print("result is map");
        // print(result);
        emit(CountryNewsException(status: result['status'], message: result['message']));
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
