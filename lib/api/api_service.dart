import 'dart:convert';

import 'package:dog_breed/Models/breed_list.dart';
import 'package:dog_breed/Models/post.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService{
  /*final baseUrl = "jsonplaceholder.typicode.com";*/
  final baseUrl = "api.genofax.com";
  final baseUrlDemo = "jsonplaceholder.typicode.com";

 /* Future getData() async{
    *//*var response = await http.get(Uri.https("$baseUrl", "albums"));*//*
    var response = await http.post(Uri.https("$baseUrl", "breeds_list/"),

      headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "X-Auth-Token": "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93"},);

    if( response.statusCode ==200){
      return jsonDecode(response.body);
    }else{
      throw Exception("Failed");
    }
  }*/

  Future<List<Data>> getAll() async {
    final response = await http.post(Uri.https("$baseUrl", "breeds_list/"),

      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "X-Auth-Token": "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93"},
    );


    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      final dataJson = BreedList.fromJson(parsed);
      var dataList = dataJson.data as List<dynamic>;
      List<Data> dataModelList = dataList.map((i) => Data.fromJson(i)).toList();
      /*return compute(parsesPost,response.body);*/
      return dataModelList;

      return parsed.map((i) => new BreedList.fromJson(i)).toList();

     /* var jsonData = json.decode(response.body);

      List<Data> result = jsonData.map((x) => Data.fromJson(x)).toList();

      List<Data> data = [];

      for (var dataShow in data) {
        Data datas = Data(dataShow["breed_id"], dataShow["name"], dataShow["thumbnail"]);
    }


      print("Proccessing");
      print(result.first.name);
      return result;*/

    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<Post>> getPostData() async{
    final response = await http.get(Uri.https("$baseUrlDemo", "posts"));

    if(response.statusCode == 200){
      final parsed = json.decode(response.body);
      /*return parsed.map((i) => new Post.fromJson(i)).toList();*/
      return compute(parsePost,response.body);

    }else{
      throw Exception('Failed to load post');
    }

  }

  List<Post> parsePost(String responseBody){
    var list = json.decode(responseBody) as List<dynamic>;
    List<Post> photos = list.map((e) => Post.fromJson(e)).toList();
    return photos;
  }

  List<Data> parsesPost(String responseBody){
    var list = json.decode(responseBody) as List<dynamic>;
    List<Data> photos = list.map((e) => Data.fromJson(e)).toList();
    return photos;
  }


}