import 'package:flutter/material.dart';
import 'package:newstatic/models/newModel.dart';

import '../../const.dart';

class NewsTile extends StatelessWidget {
 final NewsModel newsModel;
 NewsTile({this.newsModel});

 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: kSecondaryDark,
            spreadRadius: 2,
            blurRadius: 2
          )
        ]
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(newsModel.source,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryDark
                  ),
                  ),
                  SizedBox(height: 5,),
                  Flexible(
                    child: Text(newsModel.title,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[800]
                    ),
                    ),

                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(newsModel.urlToImage))
              )
            ),
          )
        ],
      ),
    );
  }
}