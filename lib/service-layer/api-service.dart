import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api-constants.dart';

class ApiService{

  static String pageSiZe = "15";
  
  static Future<dynamic> getTopHeadlinesFromCountry(String countryCode, String page)async{
    try {
      print("Getting headlines for country: "+ countryCode+" for PAGE: "+ page);
      final response = await http.get(BASE_URL + 'top-headlines?country=$countryCode&apiKey=$API_KEY&pageSize=$pageSiZe&page=$page');
      // print(response); 
      print(response.statusCode);
      var jsondata = jsonDecode(response.body);
      print(jsondata);
      var status = jsondata['status'];
      // print(status);
      if(status == 'ok'){
        List<dynamic> articleList = jsondata['articles'];
        // print(articleList);
        return articleList;
      }else if(status == 'error'){
        return {"status": jsondata['status'], "code": jsondata['code'], "message": jsondata['message']};
      }
    } on SocketException catch (e){
      print("Socket exception occured: "+ e.toString());
      return "1";
    }
    catch (e) {
      print("Some exception occured: "+ e.toString());
       return {"status": "Error","message": e.toString()};
    }
  }

  static Future<dynamic> getTopHeadlinesFromSource(String source, String page)async{
    try {
      print("Getting headlines for source: "+ source+" for PAGE: "+ page);
      final response = await http.get(BASE_URL + 'top-headlines?sources=$source&apiKey=$API_KEY&pageSize=$pageSiZe&page=$page');
      // print(response); 
      print(response.statusCode);
      var jsondata = jsonDecode(response.body);
      var status = jsondata['status'];
      if(status == 'ok'){
        List<dynamic> articleList = jsondata['articles'];
        // print(articleList);
        return articleList;
      }else if(status == 'error'){
        return {"status": jsondata['status'], "code": jsondata['code'], "message": jsondata['message']};
      }
    } on SocketException catch (e){
      print("Socket exception occured: "+ e.toString());
      return "1";
    }
    catch (e) {
      print("Some exception occured: "+ e.toString());
      return {"status": "Error","message": e.toString()};
    }
  }

  static Future<dynamic> getEverythingFromQuery(String query, String page)async{
    try {
      print("Getting headlines for query: "+ query+" for PAGE: "+ page);
      final response = await http.get(BASE_URL + 'everything?q=$query&apiKey=$API_KEY&pageSize=$pageSiZe&page=$page');
      // print(response); 
      print(response.statusCode);
      var jsondata = jsonDecode(response.body);
      var status = jsondata['status'];
      // print(status);
      if(status == 'ok'){
        List<dynamic> articleList = jsondata['articles'];
        // print(articleList);
        return articleList;
      }else if(status == 'error'){
        return {"status": jsondata['status'], "code": jsondata['code'], "message": jsondata['message']};
      }
    } on SocketException catch (e){
      print("Socket exception occured: "+ e.toString());
      return "1";
    }
    catch (e) {
      print("Some exception occured: "+ e.toString());
      return {"status": "Error","message": e.toString()};
    }
  }
}
