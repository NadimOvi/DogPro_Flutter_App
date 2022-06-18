import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breed/Models/breed_list_details_model.dart';
import 'package:dog_breed/Models/jsonBreedListModel.dart';
import 'package:dog_breed/page/disease_details.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter/material.dart';
import 'package:dog_breed/header_menu/navigation_drawer_widget.dart';

import 'package:http/http.dart' as http;

class Breeds extends StatefulWidget {
  List<BreedListData> list;
  Breeds({Key? key, required this.list}) : super(key: key);

  @override
  _BreedsState createState() => _BreedsState(list);
}

class _BreedsState extends State<Breeds> {
  TextEditingController controller = new TextEditingController();

  List<BreedListData> list;
  List<BreedListData>? foundList;
  List<AssociatedDiseases>? associatedDiseases;


  _BreedsState(this.list);
  BreedListDetailsModel? dataJson;

  @override
  void initState() {
    // TODO: implement initState
    foundList =list;
    super.initState();
    setState(() {
      FirebaseAnalytics.instance.logEvent(name: 'Breed_List_Screen',parameters: {
        'note':"stay Breed page",
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff233f4b),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Image.asset("assets/images/menu_bar_icon.png"),
          ),
        ),
        title: Center(
          child: Container(
            child: Text(
              'DogPro',
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
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(12),
            child: Card(
              child: new ListTile(
                leading: new Icon(Icons.search),
                title: new TextField(
                  controller: controller,
                  decoration: new InputDecoration(
                      hintText: 'Search breed', border: InputBorder.none),
                  onChanged: (value) {
                    if(value==null){
                      foundList =list;
                    }
                    _runFilter(value);
                  },

                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.fromLTRB(10, 5, 15, 10),
                itemCount: null == foundList ?0 : foundList!.length,
                itemBuilder: (context, index) {
                  BreedListData data = foundList![index];
                  return Card(
                    color: Colors.white,
                    elevation: 20,
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      title: Text(
                        data.name.toString(),
                        style: TextStyle(
                            color: Color(0xff118173),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                      leading: buildImage(data),
                      onTap: () {
                        if (data == null) {
                          print("null data found");
                        } else {
                          getList(data.name.toString());
                        }
                      },
                    ),
                  );
                },
            ),


          )
        ],
      ),
    );
  }

  void _runFilter (String enteredKeyword) {
    List<BreedListData>? result = [];
    /*List<Map<String,dynamic>> result = [];*/
    if(enteredKeyword.isEmpty){
      result = list;
    }else{
      result = list.where((user) => user.name!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();

    }

    setState(() {
      foundList = result!;
      print(result.length);
    });
  }

  Widget buildImage(BreedListData data) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: data.thumbnail.toString(),
          height: 60,
          width: 60,
          fit: BoxFit.cover,
        ),
      );

  Future<BreedListDetailsModel> getList(String breedName) async {
    var query = list.first.name.toString();
    final response = await http.post(
      Uri.parse("https://api.genofax.com/breed_info/?breed_name=$breedName"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "X-Auth-Token":
            "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93"
      },
    );

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      dataJson = BreedListDetailsModel.fromJson(data);
      associatedDiseases = dataJson!.associatedDiseases;

      /*createAlearDiolog(context);*/
      return createAlearDiolog(context);
    } else {
      throw Exception('Failed to load post');
    }
  }

  createAlearDiolog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)), //this right here
            child: Container(
              width: double.infinity,
              color: Color(0xff233f4b),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: dataJson!.thumbnail.toString(),
                              width: 144,
                              height: 144,
                              fit: BoxFit.cover,

                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dataJson!.breed.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 20,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Summary",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Text(
                                    dataJson!.briefHistory.toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 20,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Country",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10.0)),
                                  Text(
                                    dataJson!.countryOfOrigin.toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Life Time",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10.0)),
                                  Text(
                                    dataJson!.lifeSpan!.first.toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 20,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Weight",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10.0)),
                                  Text(
                                    dataJson!.idealWeight!.first.toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Height",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10.0)),
                                  Text(
                                    dataJson!.idealHeight!.first.toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Temperament",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10.0)),
                                  Text(
                                    dataJson!.temperament!
                                        .join(",\n")
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Utilization",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10.0)),
                                  Text(
                                    dataJson!.utilization!
                                        .join(",\n")
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Diseases",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 5.0)),

                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.zero,
                                      itemCount: null == associatedDiseases ?0 : associatedDiseases!.length,
                                      itemBuilder: (context, index) {
                                        AssociatedDiseases data = associatedDiseases![index];
                                        return ListTile(
                                          dense:true,
                                          visualDensity: VisualDensity(horizontal: 0, vertical: -4.0),
                                          title: Text(
                                            associatedDiseases![index].diseaseName.toString(),
                                            style: TextStyle(
                                                color: Color(0xff118173),
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.normal,
                                                decoration: TextDecoration.underline,
                                                fontSize: 13),
                                          ),
                                          onTap: () {
                                            if (data == null) {
                                              print("null data found");
                                            } else {
                                             print(associatedDiseases![index].diseaseId);
                                             Navigator.push(this.context, MaterialPageRoute(builder: (context) => DiseaseDetails(associatedDiseases![index].diseaseId!.toInt(),associatedDiseases![index].diseaseName!.toString()),),);
                                            }
                                          },
                                        );
                                      },
                                    ),


                                  )
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Ok",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                )),
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xff118173),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}




