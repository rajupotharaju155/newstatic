import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newstatic/businesss-layer/country-news/country_news_cubit.dart';
import 'package:newstatic/const.dart';
import 'package:newstatic/presentation-layer/HomePage.dart';

import 'businesss-layer/single-news/single_news_cubit.dart';
import 'presentation-layer/newsDetailPage.dart';

void main() {
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

        }
      ),
    );
  }
}