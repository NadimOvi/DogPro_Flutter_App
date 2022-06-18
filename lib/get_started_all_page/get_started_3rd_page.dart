import 'dart:convert';
import 'package:dog_breed/Models/jsonBreedListModel.dart';
import 'package:dog_breed/get_started_all_page/learn_breed_physical_attributes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:dog_breed/Models/get_physical_attributes_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/get_breed_history_list.dart';
import 'learn_breed_history.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  List<Data>? attributesList;
  List<HistoryData>? breedHistoryListData;

  bool showSpinner = false;


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    
    setState(() {
      this.getAttributesList();
      this.getBreedHistoryList();
      FirebaseAnalytics.instance.logEvent(name: 'Breed_History_Instruction_Screen',parameters: {
        'note':"stay Instruction",
      });
    });
    
  }

  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Learn more about dog breed'),
            centerTitle: true,
            backgroundColor: Color(0xff233f4b),
          ),
          body: Container(
              color: Color(0xff233f4b),
              child: Padding(padding: EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Padding(padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: Text("Brief History:",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ),


                    Container(
                      child: Padding(padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                        child: Text("There are three defined types of breeds of dog; Pure, Mixed and Designer. The attributes exhibited by any breed both physical as well as temperament depend upon its ancestry. Learn about where the dog breed originated and developed into its current form in this section.",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),

                    Container(
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LearnBreedHistory(breedHistoryListData!),),);

                            },
                            child:

                            Image.asset("assets/images/learn_dog_image.png",
                            height: 100,
                            width: 300,),


                           
                          ),
                        )
                    ),

                    Container(
                        child: Padding(padding: EdgeInsets.fromLTRB(15, 5, 15, 2),
                          child: Text("Dog Physics:",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        )
                    ),
                    Container(
                      child: Padding(padding: EdgeInsets.fromLTRB(15, 5, 15, 20),
                        child: Text("To understand the well being of the dog, it is important to be aware of its physical attributes. The breed's life expectancy, ideal height, ideal weight determines the overall health of the dog. Learn about the breed’s ideal health attributes in this section. ",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        textAlign: TextAlign.left,),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LearnBreedPhysivalAttributes(attributesList!),),);
                            },
                            child: /*Ink.image(
                              image: AssetImage("assets/images/learn_dog_image.png"),
                              height: 30,
                              width: 200,
                              fit: BoxFit.cover,
                            ),*/

                            Image.asset("assets/images/learn_dog_physical_image.png",
                              height: 100,
                              width: 300,),

                          ),
                        )
                    ),
                  ],
                ),
              )

          )

      ),
    );
  }

  Future<void> getAttributesList() async{
    setState(() {
      showSpinner = true;
      super.initState();
    });
    final response = await http.post(Uri.parse("https://api.genofax.com/get_physical_attributes_list/"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "X-Auth-Token": "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93"},);

    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){

      this.setState(() {
        var dataJson = GetPhysicalAttributesList.fromJson(data);
        attributesList = dataJson.data;
        showSpinner = false;

      });
      return data;

    }else{
      showSpinner = false;
      throw Exception('Failed to load post');

    }
  }
  Future<void> getBreedHistoryList() async{
    setState(() {
      showSpinner = true;
      super.initState();
    });
    final response = await http.post(Uri.parse("https://api.genofax.com/get_breed_history_list/"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "X-Auth-Token": "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93"},);

    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){

      this.setState(() {
        var dataJson = GetHistoryList.fromJson(data);
        breedHistoryListData = dataJson.data;
        showSpinner = false;

      });
      return data;

    }else{
      showSpinner = false;
      throw Exception('Failed to load post');

    }
  }

}
