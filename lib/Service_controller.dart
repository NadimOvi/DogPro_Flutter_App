import 'dart:convert';

import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'LocalDatabase/dataModel.dart';
import 'LocalDatabase/databaseHelper.dart';
import 'LocalDatabase/localDatabasePostModel.dart';

class ServiceController extends GetxController{

  String? id;
  List<Data>? dataList;
  /*var dataList = List<Data>().obs;*/
  @override
  void onInit(){
    super.onInit();
    getDataModelList();
    postData(id);
  }


  Future<List<DataModel>> getDataModelList () async {
    Database db = await DatabaseHelper.instance.database;
    var data = await db.query('dataModel', orderBy: 'ids');
    List<DataModel> dataList = data.isNotEmpty
        ? data.map((c) => DataModel.fromMap(c)).toList()
        : [];

    if(dataList!=null){
      List<String> idList =[];
      for(int i = 0; i<dataList.length; i++){
        idList.add(dataList[i].ids.toString());
      }
      print('idList = '+ idList.toString());
      id = idList.join(',');
    }
    return dataList;
  }

  Future<LocalDatabasePostModel> postData(String? id) async{

    final response = await http.get(Uri.parse("https://genofax.com/api/breed/history?ids=$id"),
      /*headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "X-Auth-Token": "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93"},*/);

    var data = await jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      var dataJson = await LocalDatabasePostModel.fromJson(data);
      dataList = dataJson.data.obs as List<Data>?;
      /*createAlearDiolog(context);*/
      print(response.statusCode);
      print(dataList);
      return dataJson;

    }else{
      throw Exception('Failed to load post');

    }
  }
}