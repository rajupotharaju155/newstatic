import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api-constants.dart';

class ApiService{
  
  static Future<dynamic> getTopHeadlinesFromCountry(String countryCode)async{
    try {
      print("Getting headlines for country: "+ countryCode);
      final response = await http.get(BASE_URL + 'top-headlines?country=$countryCode&apiKey=$API_KEY');
      print(response); 
      print(response.statusCode);
      var jsondata = jsonDecode(response.body);
      var status = jsondata['status'];
      if(status == 'ok'){
        List<dynamic> articleList = jsondata['articles'];
        print(articleList);
        return articleList;
      }else if(status == 'error'){
        return "0";
      }
    } on SocketException catch (e){
      print("Socket exception occured: "+ e.toString());
      return "1";
    }
    catch (e) {
      print("Some exception occured: "+ e.toString());
      return "2";
    }
  }

  static Future<dynamic> getTopHeadlinesFromSource(String source)async{
    try {
      print("Getting headlines for source: "+ source);
      final response = await http.get(BASE_URL + 'top-headlines?sources=$source&apiKey=$API_KEY');
      print(response); 
      print(response.statusCode);
      var jsondata = jsonDecode(response.body);
      var status = jsondata['status'];
      if(status == 'ok'){
        List<dynamic> articleList = jsondata['articles'];
        print(articleList);
        return articleList;
      }else if(status == 'error'){
        return "0";
      }
    } on SocketException catch (e){
      print("Socket exception occured: "+ e.toString());
      return "1";
    }
    catch (e) {
      print("Some exception occured: "+ e.toString());
      return "2";
    }
  }

  static Future<dynamic> getEverythingFromQuery(String query)async{
    try {
      print("Getting headlines for query: "+ query);
      final response = await http.get(BASE_URL + 'everything?q=$query&apiKey=$API_KEY&page=1&pageSize=10');
      print(response); 
      print(response.statusCode);
      var jsondata = jsonDecode(response.body);
      var status = jsondata['status'];
      print(status);
      if(status == 'ok'){
        List<dynamic> articleList = jsondata['articles'];
        print(articleList);
        return articleList;
      }else if(status == 'error'){
        return "0";
      }
    } on SocketException catch (e){
      print("Socket exception occured: "+ e.toString());
      return "1";
    }
    catch (e) {
      print("Some exception occured: "+ e.toString());
      return "2";
    }
  }
}
