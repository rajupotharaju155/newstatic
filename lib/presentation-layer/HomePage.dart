import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newstatic/businesss-layer/country-news/country_news_cubit.dart';
import 'package:newstatic/businesss-layer/filter-count/filter_count_cubit.dart';
import 'package:newstatic/businesss-layer/selected-country/selected_country_cubit.dart';
import 'package:newstatic/models/newModel.dart';
import 'package:newstatic/presentation-layer/widgets/errorWidget.dart';
import 'package:newstatic/presentation-layer/widgets/newsTile.dart';
import 'package:newstatic/presentation-layer/widgets/noInernetWidget.dart';
import 'package:newstatic/presentation-layer/widgets/searchWidget.dart';
import 'package:newstatic/presentation-layer/widgets/sourceModal.dart';

import 'widgets/countryModal.dart';

class HomePage extends StatefulWidget {
  static const Route = '/';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isfetching = false;
  int filterCount = 0;
  String countryName = '';
  String countryCode = '';
  final ScrollController _scrollController = ScrollController();
  List<NewsModel> _newsList = [];
  @override
  void initState() {
    BlocProvider.of<FilterCountCubit>(context).setFilterCount(0);
    BlocProvider.of<CountryNewsCubit>(context).getCountryNews("in", "india");
    BlocProvider.of<SelectedCountryCubit>(context)
        .setSelectedCountry("in", "india");
    super.initState();
  }

  void showSourceModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SourceModalSheet();
        });
  }

  void showCountryModalBottomSheet() {
    print('in country modal');
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return CounryModalSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            height: 70,
            padding: EdgeInsets.all(5),
            alignment: Alignment.bottomLeft,
            child: Text("Newstatic.com")),
        toolbarHeight: 70,
        actions: [
          InkWell(
            onTap: showCountryModalBottomSheet,
            child: Container(
              margin: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Location".toUpperCase(),
                    style: TextStyle(fontSize: 11),
                  ),
                  BlocBuilder<SelectedCountryCubit, SelectedCountryState>(
                    builder: (context, state) {
                      if (state is SelectedCountrySet) {
                        countryName = state.countryName;
                        countryCode = state.countryCode;
                      } else if (state is CountryNewsLoading) {
                        countryName = '';
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 12,
                          ),
                          Text(
                            countryName.toUpperCase(),
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w300),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: BlocBuilder<CountryNewsCubit, CountryNewsState>(
        builder: (context, state) {
          if (state is CountryNewsException ||
              state is CountryNewsSocketException) {
            return Container();
          }
          return FloatingActionButton(
            onPressed: showSourceModalBottomSheet,
            child: BlocBuilder<FilterCountCubit, FilterCountState>(
              builder: (context, state) {
                if (state is FilterCountSet) {
                  filterCount = state.filterCount;
                }
                return Badge(
                    showBadge: filterCount > 0 ? true : false,
                    badgeContent: Text(filterCount.toString()),
                    child: Icon(Icons.filter_alt_outlined));
              },
            ),
          );
        },
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            // ElevatedButton(
            //   onPressed: (){
            //     BlocProvider.of<CountryNewsCubit>(context).getCountryNews("in");
            //     // ApiService.getTopHeadlinesFromCountry("in");
            //   },
            //   child: Text("Get India news")),
            // ElevatedButton(
            // onPressed: (){
            //   ApiService.getTopHeadlinesFromCountry("us");
            // },
            // child: Text("Get US news")),
            // ElevatedButton(
            // onPressed: (){
            //   ApiService.getTopHeadlinesFromSource('bbc-news');
            // },
            // child: Text("Get the-washington-post news")),
            // ElevatedButton(
            // onPressed: (){
            //   ApiService.getTopHeadlinesFromSource('cnn');
            // },
            // child: Text("Get cnn news")),
            // ElevatedButton(
            // onPressed: (){
            //   ApiService.getEverythingFromQuery('terrorism');
            // },
            // child: Text("Get Query news - terrorism")),
            // ElevatedButton(
            // onPressed: (){
            //   ApiService.getEverythingFromQuery('tata consultancy');
            // },
            // child: Text("Get Query news - tata consultancy")),

            //search
            BlocBuilder<CountryNewsCubit, CountryNewsState>(
              builder: (context, state) {
                if (state is CountryNewsException ||
                    state is CountryNewsSocketException) {
                  return Container();
          }     
                return SearchWidget();
              },
            ),

            //top headlines
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Top Headlines",
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () => BlocProvider.of<CountryNewsCubit>(context)
                    .getCountryNews("in", "india"),
                child: BlocConsumer<CountryNewsCubit, CountryNewsState>(
                  listener: (context, state) {
                    if(state is CountryNewsPaginationLoading){
                      isfetching = true;
                      ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("More news loading..")));
                    }
                  },
                  builder: (context, state) {
                    if (state is CountryNewsLoading) {
                      _newsList.clear();
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is CountryNewsException) {
                      return CustomErrorWidget(
                          status: state.status, message: state.message);
                    } else if (state is CountryNewsSocketException) {
                      return NoInternetWidget();
                    } else if (state is CountryNewsLoaded) {
                      isfetching = false;
                      List<NewsModel> newsList = state.newsList;
                      _newsList.addAll(newsList);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      if(_newsList.isEmpty){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.announcement_outlined,color: Colors.grey[400], size: 80),
                          Text("No results found",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600]
                          ),
                          ),
                        ]
                      );
                    }
                    }
                      return ListView.builder(
                        controller: _scrollController
                            ..addListener(() {
                              if (_scrollController.offset ==
                                      _scrollController.position.maxScrollExtent && isfetching==false
                                  ) {
                                isfetching = true;
                                print("Reached end of loop");
                                // print(BlocProvider.of<SelectedCountryCubit>(context)..countryCode);
                                if(filterCount>0) BlocProvider.of<CountryNewsCubit>(context).getsourceNewsPagination();
                                else  BlocProvider.of<CountryNewsCubit>(context).getCountryNewsPagination(countryCode, countryName);
                              }
                            }),
                          itemCount: _newsList.length,
                          itemBuilder: (context, index) {
                            return NewsTile(newsModel: _newsList[index], index: index);
                          });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
