import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newstatic/businesss-layer/country-news/country_news_cubit.dart';
import 'package:newstatic/businesss-layer/filter-count/filter_count_cubit.dart';
import 'package:newstatic/businesss-layer/selected-country/selected_country_cubit.dart';

import '../../const.dart';

class CounryModalSheet extends StatefulWidget {
  @override
  State<CounryModalSheet> createState() => _CounryModalSheetState();
}

class _CounryModalSheetState extends State<CounryModalSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10),
            child: Text(
              "Choose your location",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]),
            ),
          ),
          BlocBuilder<SelectedCountryCubit, SelectedCountryState>(
            builder: (context, state) {
              
              if(state is SelectedCountrySet){
                String countryCode = state.countryCode;
                return Expanded(
                child: ListView.builder(
                  
                    itemCount: countryCodeList.length,
                    itemBuilder: (context, index) {
                          String val = countryCodeList[index]['code'];
                      return InkWell(
                        onTap: (){
                              BlocProvider.of<FilterCountCubit>(context).setFilterCount(0);
                              BlocProvider.of<CountryNewsCubit>(context).getCountryNews(val, countryCodeList[index]['name']);
                              BlocProvider.of<SelectedCountryCubit>(context).setSelectedCountry(val, countryCodeList[index]['name']);
                              Navigator.of(context).pop();
                        },
                        child: ListTile(
                          leading: Text(countryCodeList[index]['name'].toUpperCase()),
                          trailing: countryCode==val? Icon(Icons.radio_button_checked_rounded, color: kPrimaryLight) : Icon(Icons.radio_button_off_rounded)
                        ),
                      );
                    }),
              );
              }else{
                return Center(child: CircularProgressIndicator());
              }
              
            },
          ),
          // Center(
          //   child: ElevatedButton(
          //     onPressed: applyFilters,
          //     child: Text("Apply filter")),
          // )
        ],
      ),
    );
  }
}
