
import 'package:flutter/material.dart';

const kPrimaryLight = Color(0xff0C54BE);
const kPrimaryDark = Color(0xff303F60);
const kSecondaryLight = Color(0xffF5F9FD);
const kSecondaryDark = Color(0xffCED3DC);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}


const List<Map<String, dynamic>> countryCodeList = [
  {
    'code': 'in',
    'name': 'india'
  },
  {
    'code': 'np',
    'name': 'nepal'
  },
  {
    'code': 'us',
    'name': 'usa'
  },
  {
    'code': 'gb',
    'name': 'england'
  },
  {
    'code': 'se',
    'name': 'sweden'
  },
  {
    'code': 'nl',
    'name': 'netherlands'
  },
  {
    'code': 'ae',
    'name': 'uae'
  },
  {
    'code': 'ru',
    'name': 'russia'
  }
];

List<Map<String, dynamic>> sourceCodeList = [
  {
  "id": "the-washington-post",
  "name": "The Washington Post",
  'value': false
  },
  {
  "id": "cnn",
  "name": "CNN",
  'value': false
  },
  {
  "id": "politico",
  "name": "Politico",
  'value': false
  },
  {
  "id": "the-verge",
  "name": "The Verge",
  'value': false
  },
  {
  "id": "axios",
  "name": "Axios",
  'value': false
  },
  {
  "id": "bbc-news",
  "name": "BBC News",
  'value': false
  },
];