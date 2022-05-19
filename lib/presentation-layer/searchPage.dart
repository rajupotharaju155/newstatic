import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newstatic/businesss-layer/search-news/search_news_cubit.dart';
import 'package:newstatic/const.dart';
import 'package:newstatic/models/newModel.dart';
import 'package:newstatic/presentation-layer/widgets/errorWidget.dart';
import 'package:newstatic/presentation-layer/widgets/newsTile.dart';
import 'package:newstatic/presentation-layer/widgets/noInernetWidget.dart';

class SearchPage extends StatefulWidget {
static const Route = '/search-page';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isfetching = false;
  List<NewsModel> _newsList = [];
  String query = '';
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search",
        style: TextStyle(
          fontSize: 15
        ),
        ),
        centerTitle: true,
      ),

      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              height: 40,
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor:  Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kSecondaryDark.withOpacity(0.4),
                          border: InputBorder.none,
                          hintText: "Search for news, topics..",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            query = value;
                          });
                          if(query.trim().length==0){
                            BlocProvider.of<SearchNewsCubit>(context).resetSearchResults();
                          }
                          // BlocProvider.of<SearchNewsCubit>(context).getSearchNews(value.trim());
                        },
                      ),
                    ),
                    SizedBox(width: 5,),
                    ElevatedButton(
                      onPressed:  query.trim().length>0? (){
                        BlocProvider.of<SearchNewsCubit>(context).getSearchNews(query.trim());
                      } : null, 
                      child: Icon(Icons.search_rounded), 
                      )
                  ],
                ),
              ),
            ),

            //top headlines
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Search results",
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Expanded(
              child: BlocConsumer<SearchNewsCubit, SearchNewsState>(
                listener: (context, state) {
                  if(state is SearchNewsLoadingPagination){
                    isfetching = true;
                    ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("More news results..")));
                  }
                },
                builder: (context, state) {
                  if(state is SearchNewsLoading){
                    _newsList.clear();
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }else if(state is SearchNewsException){
                    return CustomErrorWidget(status: state.status, message:state.message );
                  }else if(state is SearchNewsSocketException){
                    return NoInternetWidget();
                  }
                  else if(state is SearchNewsLoaded){
                    isfetching = false;
                    List<NewsModel> newsList = state.searchList;
                    _newsList.addAll(newsList);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    if(_newsList.isEmpty){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.announcement_outlined,color: Colors.grey[400], size: 80),
                          Text("No results found for your query:\n$query",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600]
                          ),
                          ),
                        ]
                      );
                    }
                    // return ListView.builder(
                    //   itemCount: _newsList.length,
                    //   itemBuilder: (context, index) {
                    //     return NewsTile(newsModel: _newsList[index]);
                    //   }); 
                    }else if(state is SearchNewsInitial){
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.plagiarism_outlined, color: Colors.grey[400], size: 80),
                              Text("Search for anything",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600]
                              ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        controller: _scrollController
                            ..addListener(() {
                              if (_scrollController.offset ==
                                      _scrollController.position.maxScrollExtent && isfetching==false
                                  ) {
                                print("Reached end of loop");
                                BlocProvider.of<SearchNewsCubit>(context).getSearchNewsPagination();
                              }
                            }),
                          itemCount: _newsList.length,
                          itemBuilder: (context, index) {
                            return NewsTile(newsModel: _newsList[index], index: index);
                          });
                  
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}