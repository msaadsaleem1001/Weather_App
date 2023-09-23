
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weather_app/Data/Api%20Services/base_api_services.dart';
import 'package:weather_app/Data/app_exceptions.dart';

class ApiServices extends BaseApiServices{

  @override
  Future<dynamic> getApi(String url, dynamic header) async{
    dynamic returnResponse;
    try{
      final response = await http.get(Uri.parse(url), headers: header).timeout(const Duration(seconds: 10));
      returnResponse = responseReturning(response);
    }
    on SocketException{
      throw InternetException('No Internet');
    }on RequestTimeOut{
      throw RequestTimeOut('Request Timeout');
    }
    return returnResponse;
  }


  dynamic responseReturning(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw InvalidUrlException('Invalid Url');
      default:
        throw FetchDataException('Error while fetching data + ${response.statusCode.toString()}');
    }
  }

}