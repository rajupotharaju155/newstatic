import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newstatic/businesss-layer/country-news/country_news_cubit.dart';
import 'package:newstatic/businesss-layer/filter-count/filter_count_cubit.dart';
import 'package:newstatic/businesss-layer/selected-country/selected_country_cubit.dart';

class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_off_rounded, size: 70, color: Colors.grey[400],),
                SizedBox(height: 10),
                Text(
                  "No Internet Connection",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: (){
                    BlocProvider.of<FilterCountCubit>(context).setFilterCount(0);
                    BlocProvider.of<CountryNewsCubit>(context).getCountryNews("in", "india");
                    BlocProvider.of<SelectedCountryCubit>(context)
                        .setSelectedCountry("in", "india");
                  }, 
                  child: Text("Try again"))
              ],
            ),
          );
  }
}