import 'dart:convert';

import 'package:dog_breed/Models/breed_list_details_model.dart';
import 'package:dog_breed/Models/jsonBreedListModel.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BreedListDetails extends StatefulWidget {
  List<BreedListData> list;
  BreedListDetails({Key? key,required this.list}) : super(key: key);

  @override
  _BreedListDetailsState createState() => _BreedListDetailsState(list);
}

class _BreedListDetailsState extends State<BreedListDetails> {
  List<BreedListData> list;
  _BreedListDetailsState(this.list);

  BreedListDetailsModel? dataJson;

  @override
  void initState(){
    super.initState();

    getList();

    setState(() {
      FirebaseAnalytics.instance.logEvent(name: 'Breed_List_Show',parameters: {
        'note':"stay Breed page",
      });
    });

  }

/*  @override
  void dispose() {
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    var nonNullable = 'hello';
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
      body: Center(
        child: Column(
          children: [
            /*Image.network(list.first.thumbnail.toString()),*/
            CircleAvatar(
              radius: 80.0,
              backgroundImage: NetworkImage(list.first.thumbnail.toString()),
            ),
            Text(
              list.first.name.toString(),style: TextStyle(color: Colors.white),),
            TextButton(
              onPressed: () {
                onClick();
              },
              child: Text(
                  "Check Dog Filter",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                  )
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Color(0xff118173),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),

            ),
            Text(
              dataJson!.breed.toString(),style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
  void onClick() {
    print(dataJson!.breed.toString());
  }

  /////////Breed List Details Call
  Future<BreedListDetailsModel> getList() async{

    var query = list.first.name.toString();
    final response = await http.post(Uri.parse("https://api.genofax.com/breed_info/?breed_name=$query"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "X-Auth-Token": "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93"},);

    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      if(dataJson==null){
        dataJson = BreedListDetailsModel.fromJson(data);
        print(dataJson!.breed != null);
      }else{
        print("Error");
      }

      return dataJson!;

    }else{
      throw Exception('Failed to load post');

    }
  }

}


