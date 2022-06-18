import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breed/Service_controller.dart';
import 'package:dog_breed/api/strings.dart';
import 'package:dog_breed/header_menu/navigation_drawer_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../LocalDatabase/LocalDataHistoryShow.dart';
import '../LocalDatabase/dataModel.dart';
import '../LocalDatabase/databaseHelper.dart';
import '../LocalDatabase/localDatabasePostModel.dart';

import 'package:http/http.dart' as http;

String? id;
List<Data>? dataList =[];

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(this.mounted){
      setState(() {
        getDataModelList();
        FirebaseAnalytics.instance.logEvent(name: 'HistoryPage_Screen_Stay',parameters: {
          'note':"stay History page",
        });
      });
    }
  }

/*  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff233f4b),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: (){
              Scaffold.of(context).openDrawer();
            },

            icon: Image.asset("assets/images/menu_bar_icon.png"),
          ),
        ),
        title: Center(
          child: Container(
            child: Text('DogPro',
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            margin: const EdgeInsets.fromLTRB(0, 0, 50, 0),
          ),
        ),
        backgroundColor: Color(0xff233f4b),
      ),
      drawer: NavigationDrawerWidget(),
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.fromLTRB(10, 5, 15, 10),
                  itemCount: dataList!.length,
                  itemBuilder: (context, index){
                    Data data = dataList![index];
                    return dataList==null? Center(child: CircularProgressIndicator(),):
                    Card(
                      color: Colors.white,
                      elevation: 20,
                      child: Center(
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                          title: Text(data.response!.data!.first.breed.toString(),
                            style: TextStyle(color: Color(0xff118173),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.normal,
                                fontSize: 16),),

                          subtitle: Html(
                            data: data.response!.classificationSummary.toString(),
                            style: {
                              "body": Style(
                                color: Colors.black54,
                                fontSize: FontSize(12),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.normal,
                              )
                            },),

                          leading: buildImage(data),
                          onTap: (){
                            if(data==null){
                              print("null data found");
                            }else{
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LocalDataShow(data),),);
                            }
                          },
                          onLongPress: (){
                            setState(() {
                              remove(data.id!);
                            });
                          },
                        ),
                      ),

                    );
                  }),),

          ],
        ),
      ),
    );
  }

  Future<LocalDatabasePostModel> postData(String? id) async{

    final response = await http.get(Uri.parse("https://genofax.com/api/breed/history?ids=$id"),);
    var data = await jsonDecode(response.body.toString());
    if(response.statusCode == 200){

      var dataJson = await LocalDatabasePostModel.fromJson(data);
      setState(() {
        dataList = dataJson.data;
        print(id);
        print(response.statusCode);
        print(dataList);
      });
      return dataJson;
    }else{
      throw Exception('Failed to load post');

    }


  }

  Future<List<DataModel>> getDataModelList () async {
    Database db = await DatabaseHelper.instance.database;
    var data = await db.query('dataModel', orderBy: 'ids');


    List<DataModel> dataList = await data.isNotEmpty
        ? data.map((c) => DataModel.fromMap(c)).toList()
        : [];


    if(dataList!=null){
      List<String> idList =[];
      for(int i = 0; i<dataList.length; i++){

        idList.add(dataList[i].ids.toString());

      }

      id = idList.join(',');

      print('id = '+ id!);
      if(id!=""){
        setState(() {
          postData(id);
        });

      }

    }
    return dataList;
  }
}

Future<int> remove(int id) async{
  Database db = await DatabaseHelper.instance.database;
  return await db.delete('dataModel', where: 'id = ?', whereArgs: [id]);
}




Widget buildImage(Data data) => ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: CachedNetworkImage(
    imageUrl: data.imageUrl.toString(),
    height: 60,
    width: 60,
    fit: BoxFit.cover,
  ),

);
