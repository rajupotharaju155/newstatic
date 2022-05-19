import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newstatic/businesss-layer/country-news/country_news_cubit.dart';
import 'package:newstatic/businesss-layer/filter-count/filter_count_cubit.dart';
import 'package:newstatic/businesss-layer/selected-country/selected_country_cubit.dart';

import '../../const.dart';

class SourceModalSheet extends StatefulWidget {

  @override
  State<SourceModalSheet> createState() => _SourceModalSheetState();
}

class _SourceModalSheetState extends State<SourceModalSheet> {
 List<Map<dynamic, dynamic>> sourceCodeList1 = sourceCodeList.map((e) => new Map.from(e)).toList();

  void applyFilters(){
    sourceCodeList = sourceCodeList1.map((e) => e).toList();
    List<Map<dynamic, dynamic>> appliedFilters = sourceCodeList.where((element) => element['value']==true).toList();
    print(appliedFilters.length);
    BlocProvider.of<FilterCountCubit>(context).setFilterCount(appliedFilters.length);  
    if(appliedFilters.isEmpty) {
      print("All filters removed");
      BlocProvider.of<CountryNewsCubit>(context).getCountryNews("in", "india");
      BlocProvider.of<SelectedCountryCubit>(context).setSelectedCountry("in", "india");
      Navigator.of(context).pop();
      Fluttertoast.showToast(
      msg: "Filters removed",
      toastLength: Toast.LENGTH_SHORT,
    );
    }else{  
      List selectedIdsList = appliedFilters.map((e) => e['id']).toList();
      String finalString = selectedIdsList.join(',');
      print(finalString);
      BlocProvider.of<CountryNewsCubit>(context).getsourceNews(finalString);

      Navigator.of(context).pop();
      Fluttertoast.showToast(
        msg: "Filters Applied",
        toastLength: Toast.LENGTH_SHORT,
      );
      }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: Text("Filter by Source",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: sourceCodeList1.length,
                  itemBuilder: (context, index){
                    return CheckboxListTile(
                      title: Text(sourceCodeList1[index]['name'],
                      style: TextStyle(color: Colors.grey[800]),
                      ),
                      value: sourceCodeList1[index]['value'], 
                      onChanged: (val){
                        setState(() {
                        sourceCodeList1[index]['value']  = val;
                        });
                        // if(val) addSourceToList(sourceCodeList1[index]['id']);
                        // else removeSourceFromList(sourceCodeList1[index]['id']);
                      });
                  }),
              ),
                Center(
                  child: ElevatedButton(
                    onPressed: applyFilters, 
                    child: Text("Apply filter")),
                )
            ],
          ),
        );
  }
}