import 'package:flutter/material.dart';

import '../../const.dart';

class NewsTile extends StatelessWidget {

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
                  Text("Moneycontrol",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryDark
                  ),
                  ),
                  SizedBox(height: 5,),
                  Flexible(
                    child: Text("Market LIVE Updates: Sensex, Nifty trade higher led by financials, auto, power; realty drags - Moneycontrol",
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
                  image: NetworkImage('https://images.moneycontrol.com/static-mcnews/2020/01/BSE_Sensex_Stocks_market_up_green-770x433.png'))
              )
            ),
          )
        ],
      ),
    );
  }
}