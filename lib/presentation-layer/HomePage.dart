import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newstatic/businesss-layer/country-news/country_news_cubit.dart';
import 'package:newstatic/service-layer/api-service.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Newstatic.com"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: (){
              BlocProvider.of<CountryNewsCubit>(context).getCountryNews("in");
              // ApiService.getTopHeadlinesFromCountry("in");
            }, 
            child: Text("Get India news")),
          ElevatedButton(
          onPressed: (){
            ApiService.getTopHeadlinesFromCountry("us");
          }, 
          child: Text("Get US news")),
          ElevatedButton(
          onPressed: (){
            ApiService.getTopHeadlinesFromSource('the-washington-post');
          }, 
          child: Text("Get the-washington-post news")),
          ElevatedButton(
          onPressed: (){
            ApiService.getTopHeadlinesFromSource('cnn');
          }, 
          child: Text("Get cnn news")),
          ElevatedButton(
          onPressed: (){
            ApiService.getEverythingFromQuery('terrorism');
          }, 
          child: Text("Get Query news - terrorism")),
          ElevatedButton(
          onPressed: (){
            ApiService.getEverythingFromQuery('tata consultancy');
          }, 
          child: Text("Get Query news - tata consultancy")),
        ],
      ),
    );
  }
}