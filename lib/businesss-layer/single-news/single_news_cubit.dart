import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newstatic/models/newModel.dart';

part 'single_news_state.dart';

class SingleNewsCubit extends Cubit<SingleNewsState> {
  SingleNewsCubit() : super(SingleNewsInitial());

  void setSingleNews(NewsModel newsModel){
    emit(SingleNewsLoaded(newsModel: newsModel));
  }
}
