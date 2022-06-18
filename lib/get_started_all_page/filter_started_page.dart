import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breed/Models/filter_search_breed.dart';
import 'package:dog_breed/api/strings.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dog_breed/header_menu/navigation_drawer_widget.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:searchfield/searchfield.dart';
import '../Models/QueryParametersModels.dart';

class FilterStartedPage extends StatefulWidget {
  const FilterStartedPage({Key? key}) : super(key: key);

  @override
  _FilterStartedPageState createState() => _FilterStartedPageState();
}

class _FilterStartedPageState extends State<FilterStartedPage> {
  /* Map<String, dynamic> ideal_weights_range = new Map<String, dynamic>();
   Map<String, dynamic> ideal_heights_range = new Map<String, dynamic>();*/
  /*var ideal_weights_range;
  var ideal_heights_range;*/
  Map<String, dynamic>? ideal_heights_range;
  Map<String, dynamic>? ideal_weights_range;

  List<String> temperaments = [];
  List<String> utilization = [];
  String? temperamentsValue;
  String? utilizationValue;

  List<String> temperamentAddChip = [];
  List<String> utilizationAddChip = [];

  String selectval = "Tokyo";
  dynamic select = [];
  int counter = 0;
  List<Widget> _list = [];
  List<Widget> _utiliaztionList = [];
  List<Breeds>? list;
  String? heightTextShow;
  String? weightTextShow;
  var height;
  var weight;

  @override
  void initState() {
    super.initState();
    getList();
    print(temperamentAddChip);

    for (int i = 0; i < temperamentAddChip.length; i++) {
      temperamentAddChip.add(temperamentsValue!);
      Widget child = newItem(i, temperamentsValue!);
      _list.add(child);
    }

    for (int i = 0; i < utilizationAddChip.length; i++) {
      utilizationAddChip.add(utilizationValue!);
      Widget child = newItem(i, utilizationValue!);
      _utiliaztionList.add(child);
    }
    setState(() {
      FirebaseAnalytics.instance.logEvent(name: 'Filter_Screen',parameters: {
        'note':"stay Breed Filter page",
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    String? dropdownValue;
    var heightList,weightList;
    if(ideal_heights_range!=null&&ideal_weights_range!=null){
      height= ideal_heights_range!.keys
          .map(buildMenuItem)
          .toList();
      weight= ideal_weights_range!.keys
          .map(buildMenuItem)
          .toList();
      heightList = ideal_heights_range!.keys.toList();
      weightList = ideal_weights_range!.keys.toList();
    }

    return Scaffold(
      backgroundColor: Color(0xff233f4b),
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Card(
                color: Colors.white,
                elevation: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 5, 0, 10),
                                child: Text(
                                  "Filter",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                      ),
                                      child: DropdownButton<String>(
                                        icon: Expanded(
                                          flex:1,
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        value: temperamentsValue,
                                        hint: Text('Select a temperament'),
                                        items: temperaments
                                            .map(buildMenuItem)
                                            .toList(),
                                         onTap: (){onClicked();},
                                        onChanged: (value) {
                                          this.temperamentsValue = value;
                                          onClicked();
                                        }, itemHeight: 50
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),*/
                          Padding(padding: EdgeInsets.only(top: 5)),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: DropdownSearch<String>(
                                mode: Mode.DIALOG,
                                showSelectedItems: true,
                                items: temperaments,
                                label: "Temperament",
                                popupItemDisabled: (String s) => s.startsWith('I'),
                                onChanged: (value) {
                                  temperamentsValue = value;
                                  onDropTemperamentClicked(value!);
                                },
                                selectedItem: "Select a temperament"),
                          ),

                          Container(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              children: _list,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 15)),

                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                      ),
                                      child: DropdownButton<String>(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black54,
                                        ),
                                        value: utilizationValue,
                                        hint: Text('Select a utilization'),
                                        items: utilization
                                            .map(buildMenuItem)
                                            .toList(),
                                        onChanged: (value) => setState(() {
                                          this.utilizationValue = value!;
                                          utilizationOnClicked();
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),*/

                          Container(
                            height: 50,
                            child: DropdownSearch<String>(
                                mode: Mode.DIALOG,
                                showSelectedItems: true,
                                items: utilization,
                                label: "Utilization",

                                popupItemDisabled: (String s) => s.startsWith('I'),
                                onChanged: (value) {
                                  utilizationValue = value;
                                  onDroputilizationClicked(value!);
                                },

                                selectedItem: "Select a utilization"),
                          ),

                          SingleChildScrollView(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: _utiliaztionList,
                              ),
                            ),
                          ),

                          Padding(padding: EdgeInsets.only(top: 15)),
                          Container(
                            height: 50,
                            child: DropdownSearch<String>(
                                mode: Mode.MENU,
                                showSelectedItems: true,
                                items: heightList,
                                label: "Height",

                                popupItemDisabled: (String s) => s.startsWith('I'),
                                onChanged: (value) {
                                  /*utilizationValue = value;
                                  onDroputilizationClicked(value!);*/
                                  setState(() {
                                    this.heightTextShow = value;
                                    /*utilizationOnClicked();*/
                                    print(heightTextShow);
                                  });
                                },
                                selectedItem: "Select a height"),
                          ),

                          Padding(padding: EdgeInsets.only(top: 15)),
                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                      ),
                                      child: DropdownButton<String>(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black54,
                                        ),
                                        value: heightTextShow,
                                        hint: Text('Select a Height'),

                                        items: height,

                                        onChanged: (value) {

                                          setState(() {

                                            this.heightTextShow = value;

                                            print(heightTextShow);
                                          });
                                        },
                                      ),

                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),*/
                          Container(
                            height: 50,
                            child: DropdownSearch<String>(
                                mode: Mode.MENU,
                                showSelectedItems: true,
                                items: weightList,
                                label: "Weight",

                                popupItemDisabled: (String s) => s.startsWith('I'),
                                onChanged: (value) {
                                  /*utilizationValue = value;
                                  onDroputilizationClicked(value!);*/
                                  setState(() {
                                    this.weightTextShow = value;
                                    /*utilizationOnClicked();*/
                                    print(weightTextShow);
                                  });
                                },
                                selectedItem: "Select a weight"),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          /* Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                      ),
                                      child: DropdownButton<String>(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black54,
                                        ),
                                        value: weightTextShow,
                                        hint: Text('Select a Weight'),
                                        items: weight,

                                        onChanged: (value) {

                                          setState(() {

                                            this.weightTextShow = value;

                                            print(weightTextShow);
                                          });
                                        },
                                      ),

                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),*/

                          /* Container(
                            child: DropdownSearch<String>.multiSelection(
                                mode: Mode.MENU,
                                showSelectedItems: true,
                                items: utilization,
                                label: "Menu mode",
                                hint: "country in menu mode",
                                popupItemDisabled: (String s) => s.startsWith('I'),
                                onChanged: print,
                                selectedItems: ["Select a item"]),
                          ),*/

                          ElevatedButton(
                            child: Text("Search"),
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xff118173),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            onPressed: () {
                              showResult();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
                child: ListView.builder(
                    itemCount: list == null ? 0 : list!.length,
                    /*itemCount: 15,*/
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Breeds data = list![index];
                      return Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Card(
                          color: Colors.white,
                          elevation: 20,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            title: Text(
                              data.breed.toString(),
                              style: TextStyle(
                                  color: Color(0xff118173),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16),
                            ),
                            subtitle: Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 2)),

                                Html(
                                  data:data.briefHistory.toString(),
                                  style: {
                                    "body": Style(
                                        color: Colors.black45,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.normal,
                                        fontSize: FontSize(12),
                                        maxLines: 3
                                    )
                                  },),

                                Padding(padding: EdgeInsets.only(left: 7),
                                  child: Row(
                                    children: [
                                      Text("Show more  ",style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12
                                      )),
                                    ],
                                  ) ,)

                              ],
                            ),
                            leading: buildImage(data),
                            onTap: () {
                              if (data == null) {
                                print("null data found");
                              } else {
                                createAlearDiolog(context, data);
                              }
                            },
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }

  Widget buildImage(Breeds data) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: data.thumbnail.toString(),
          height: 60,
          width: 60,
          fit: BoxFit.cover,
        ),
      );

  void onClicked() {
    Widget child = newItem(counter, temperamentsValue!);
    setState(() {
      _list.add(child);
      temperamentAddChip.add(temperamentsValue!);
    });
  }
  void onDropTemperamentClicked(String value) {
    Widget child = newItem(counter, value);
    setState(() {
      _list.add(child);
      temperamentAddChip.add(value);
    });
  }

  void utilizationOnClicked() {
    Widget child = utilizationItem(counter, utilizationValue!);
    setState(() {
      _utiliaztionList.add(child);
      utilizationAddChip.add(utilizationValue!);
    });
  }

  void onDroputilizationClicked(String value) {
    Widget child = utilizationItem(counter, value);
    setState(() {
      _utiliaztionList.add(child);
      utilizationAddChip.add(value);
    });
  }


  Widget newItem(int i, String value) {
    Key key = Key('item_${i}');
    Container child = Container(
      key: key,
      padding: EdgeInsets.all(2.0),
      child: Expanded(
        child: Wrap(
          spacing: 5.0,
          children: [
            Chip(
              label: Text(/*'${i}'+*/ value),
              deleteIconColor: Colors.red,
              deleteButtonTooltipMessage: 'Delete',
              onDeleted: () => _removeItem(key),
            )
          ],
        ),
      ),
    );

    counter++;

    return child;
  }

  Widget utilizationItem(int i, String value) {
    Key key = Key('item_${i}');
    Container child = Container(
      key: key,
      padding: EdgeInsets.all(2.0),
      child: Wrap(
        children: [
          Chip(
            label: Text(value),
            deleteIconColor: Colors.red,
            deleteButtonTooltipMessage: 'Delete',
            onDeleted: () => _utilizationRemoveItem(key),
            /*avatar: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: Text(i.toString()),
            ),*/
          )
        ],
      ),
    );

    counter++;

    return child;
  }

  void _removeItem(Key key /*,String value*/) {
    for (int i = 0; i < _list.length; i++) {
      Widget child = _list.elementAt(i);
      if (child.key == key) {
        setState(() {
          _list.removeAt(i);
          temperamentAddChip.removeAt(i);
        });
        print('Removing ${key.toString()}');
      }
    }
  }

  void _utilizationRemoveItem(Key key /*,String value*/) {
    for (int i = 0; i < _utiliaztionList.length; i++) {
      Widget child = _utiliaztionList.elementAt(i);
      if (child.key == key) {
        setState(() {
          _utiliaztionList.removeAt(i);
          utilizationAddChip.removeAt(i);
        });
        print('Removing ${key.toString()}');
      }
    }
  }

  // api call to get data
  Future<QueryParametersModels> _getDropDownData() async {
    final response = await http.post(
      Uri.parse("https://api.genofax.com/query_parameters/"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "X-Auth-Token":
            "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93"
      },
    );
    return QueryParametersModels();
  }

  Future<QueryParametersModels> getList() async {
    final response = await http.post(
      Uri.parse("https://api.genofax.com/query_parameters/"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "X-Auth-Token":
            "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93"
      },
    );

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      var dataJson = QueryParametersModels.fromJson(data);
      /*    utilization = dataJson.utilization!;
     temperaments = dataJson.temperaments!;*/
      setState(() {
        utilization = dataJson.utilization!;
        temperaments = dataJson.temperaments!;
        ideal_weights_range = dataJson.idealWeightsRange!.toJson();
        ideal_heights_range = dataJson.idealHeightsRange!.toJson();
        // loop in the map and getting all the keys
        /*for(String key in ideal_heights_range!.keys){
          menuItems!.add(
              DropdownMenuItem<String>(
                // items[key] this instruction get the value of the respective key
                child: Text( ideal_heights_range![key] ), // the value as text label
                value: key, // the respective key as value
              ) );
        }*/

      });


      return dataJson;
    } else {
      throw Exception('Failed to load post');
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Poppins",
              fontWeight: FontWeight.normal,
              fontSize: 13),
        ),
      );

  void showResult() {
    if (temperamentAddChip != [] && utilizationAddChip != []) {
      getSearchList(temperamentAddChip, utilizationAddChip);
    } else
      (print("Null value"));
  }

  Future<FilterSearchBreed> getSearchList(
      List<String> temperamentAddChip, List<String> utilizationAddChip) async {
    var queryParameters = {
      'temperaments_list': temperamentAddChip,
      'utilization_list': utilizationAddChip,
    };

    var uri = Uri.parse("https://api.genofax.com/search_breed/");
    uri = uri.replace(queryParameters: queryParameters);

    final response = await http.post(
      uri,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "X-Auth-Token":
            "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93"
      },
    );

    var data = await jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      var dataJson = FilterSearchBreed.fromJson(data);
      setState(() {
        list = dataJson.breeds;
        print(response.statusCode);
        print(temperamentAddChip);
        print(utilizationAddChip);
        print(dataJson.breeds!.first.breed.toString());
      });

      return dataJson;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load post');
    }
  }

  createAlearDiolog(BuildContext context, Breeds dataJson) {
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
                              imageUrl: dataJson.thumbnail.toString(),
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
                          dataJson.breed.toString(),
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
                                    dataJson.briefHistory.toString(),
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
                                    dataJson.countryOfOrigin.toString(),
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
                                    dataJson.lifeSpan!.first.toString(),
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
                                    dataJson.idealWeight!.first.toString(),
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
                                    dataJson.idealHeight!.first.toString(),
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
                                    dataJson.temperament!
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
                                    dataJson.utilization!
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
