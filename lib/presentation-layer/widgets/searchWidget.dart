import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newstatic/businesss-layer/search-news/search_news_cubit.dart';
import 'package:newstatic/presentation-layer/searchPage.dart';

import '../../const.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    ));
  }
}