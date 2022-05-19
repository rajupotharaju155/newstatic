import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newstatic/businesss-layer/country-news/country_news_cubit.dart';
import 'package:newstatic/businesss-layer/filter-count/filter_count_cubit.dart';
import 'package:newstatic/businesss-layer/search-news/search_news_cubit.dart';
import 'package:newstatic/const.dart';
import 'package:newstatic/models/newModel.dart';
import 'package:newstatic/presentation-layer/searchPage.dart';
import 'package:newstatic/presentation-layer/widgets/newsTile.dart';
import 'package:newstatic/presentation-layer/widgets/sourceModal.dart';

class HomePage extends StatefulWidget {
  static const Route = '/';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int filterCount = 0;
  @override
  void initState() {
    BlocProvider.of<FilterCountCubit>(context).setFilterCount(0);
    BlocProvider.of<CountryNewsCubit>(context).getCountryNews("in");
    super.initState();
  }

  void showSourceModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SourceModalSheet();
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
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Location".toUpperCase(),
                    style: TextStyle(fontSize: 11),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 12,
                      ),
                      Text(
                        "India",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w300),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showSourceModalBottomSheet,
        child: BlocBuilder<FilterCountCubit, FilterCountState>(
          builder: (context, state) {
            if(state is FilterCountSet){
              filterCount = state.filterCount;
            }
            return Badge(
                showBadge: filterCount>0? true: false,
                badgeContent:  Text(filterCount.toString()),
                child: Icon(Icons.filter_alt_outlined));
          },
        ),
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
            Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<SearchNewsCubit>(context)
                        .resetSearchResults();
                    Navigator.of(context).pushNamed(SearchPage.Route);
                  },
                  splashColor: Colors.grey,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: kSecondaryDark.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Search for news, topics..",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                )),

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
                    .getCountryNews("in"),
                child: BlocBuilder<CountryNewsCubit, CountryNewsState>(
                  builder: (context, state) {
                    if (state is CountryNewsLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is CountryNewsException) {
                      return Center(
                        child: Text("We couldnt fetch news at the monment"),
                      );
                    } else if (state is CountryNewsLoaded) {
                      List<NewsModel> newsList = state.newsList;
                      return ListView.builder(
                          itemCount: newsList.length,
                          itemBuilder: (context, index) {
                            return NewsTile(newsModel: newsList[index]);
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
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
