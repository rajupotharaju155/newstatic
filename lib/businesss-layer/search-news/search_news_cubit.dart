import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newstatic/models/newModel.dart';
import 'package:newstatic/service-layer/api-service.dart';

part 'search_news_state.dart';

class SearchNewsCubit extends Cubit<SearchNewsState> {
  SearchNewsCubit() : super(SearchNewsInitial());

    List<NewsModel> searchList = [];

  Future<void> getSearchNews(String query)async{
    emit(SearchNewsLoading());
    dynamic result = await ApiService.getEverythingFromQuery(query);
    if(result is Map){
      print("result is map");
      print(result);
      emit(SearchNewsException(status: result['status'], message: result['message']));
    }else if(result=='1'){
      emit(SearchNewsSocketException());
    }else{
      List<dynamic> news = result;
      searchList = news.map((e) => NewsModel.fromjson(e)).toList();
      print(searchList);
      emit(SearchNewsLoaded(searchList: searchList));
    }
  }

  void resetSearchResults(){
    searchList.clear();
    emit(SearchNewsInitial());
  }
}
