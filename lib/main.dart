import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newstatic/businesss-layer/country-news/country_news_cubit.dart';
import 'package:newstatic/businesss-layer/search-news/search_news_cubit.dart';
import 'package:newstatic/const.dart';
import 'package:newstatic/presentation-layer/HomePage.dart';

import 'businesss-layer/filter-count/filter_count_cubit.dart';
import 'businesss-layer/selected-country/selected_country_cubit.dart';
import 'businesss-layer/single-news/single_news_cubit.dart';
import 'presentation-layer/newsDetailPage.dart';
import 'presentation-layer/searchPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CountryNewsCubit(),
        ),
        BlocProvider(
          create: (context) => SingleNewsCubit(),
        ),
        BlocProvider(
          create: (context) => SearchNewsCubit(),
        ),
        BlocProvider(
          create: (context) => FilterCountCubit(),
        ),
        BlocProvider(
          create: (context) => SelectedCountryCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Newtatic',
        theme: ThemeData(
          primarySwatch: createMaterialColor(kPrimaryLight),
          scaffoldBackgroundColor: kSecondaryLight
        ),
        // home: HomePage(),
        routes: {
          HomePage.Route: (context) => HomePage(),
          NewsDetailPage.Route: (context) => NewsDetailPage(),
          SearchPage.Route: (context) => SearchPage(),
        }
      ),
    );
  }
}