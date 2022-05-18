import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newstatic/businesss-layer/country-news/country_news_cubit.dart';
import 'package:newstatic/const.dart';
import 'package:newstatic/presentation-layer/HomePage.dart';

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
      ],
      child: MaterialApp(
        title: 'Newtatic',
        theme: ThemeData(
          primarySwatch: createMaterialColor(kPrimaryLight),
          scaffoldBackgroundColor: kSecondaryLight
        ),
        home: HomePage(),
      ),
    );
  }
}