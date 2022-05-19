import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newstatic/businesss-layer/country-news/country_news_cubit.dart';

import '../../const.dart';

class SourceModalSheet extends StatefulWidget {

  @override
  State<SourceModalSheet> createState() => _SourceModalSheetState();
}

class _SourceModalSheetState extends State<SourceModalSheet> {

  List<String> filtersSelected = [];
  void addSourceToList(String sourceCode){
    filtersSelected.add(sourceCode);
  }
  void applyFilters(){
    if(filtersSelected.isEmpty) {
      print("All filters removed");
      BlocProvider.of<CountryNewsCubit>(context).getCountryNews("in");
      Navigator.of(context).pop();
      Fluttertoast.showToast(
      msg: "Filters removed",
      toastLength: Toast.LENGTH_SHORT,
    );
      return;
    }
    String finalString = filtersSelected.join(',');
    print(finalString);
    BlocProvider.of<CountryNewsCubit>(context).getsourceNews(finalString);

    Navigator.of(context).pop();
    Fluttertoast.showToast(
      msg: "Filters Applied",
      toastLength: Toast.LENGTH_SHORT,
    );
  }
  void removeSourceFromList(String sourceCode){
    filtersSelected.remove(sourceCode);
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
                  itemCount: sourceCodeList.length,
                  itemBuilder: (context, index){
                    return CheckboxListTile(
                      title: Text(sourceCodeList[index]['name'],
                      style: TextStyle(color: Colors.grey[800]),
                      ),
                      value: sourceCodeList[index]['value'], 
                      onChanged: (val){
                        setState(() {
                        sourceCodeList[index]['value']  = val;
                        });
                        if(val) addSourceToList(sourceCodeList[index]['id']);
                        else removeSourceFromList(sourceCodeList[index]['id']);
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