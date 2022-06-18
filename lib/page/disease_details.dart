import 'dart:convert';

import 'package:dog_breed/Models/diseases_details_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DiseaseDetails extends StatefulWidget {
  int diseaseId;
  String diseaseName;
  DiseaseDetails(this.diseaseId, this.diseaseName, {Key? key}) : super(key: key);

  @override
  _DiseaseDetailsState createState() => _DiseaseDetailsState(this.diseaseId,this.diseaseName);
}

class _DiseaseDetailsState extends State<DiseaseDetails> {
  int diseaseId;
  String diseaseName;
  _DiseaseDetailsState(this.diseaseId,this.diseaseName);

  List<AssociatedDiseases>? dataList;
  DiseasesDetailsModel? dataJson;
  String? alternative_name;
  String? description;
  String? symptom;
  String? diagnosis;
  String? treat_method;
  String? associatedName;
  String? other_name;

  @override
  void initState(){
    super.initState();

    setState(() {
      getList();
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff233f4b),
      appBar: AppBar(
        title: Text(diseaseName),
        centerTitle: true,
        backgroundColor: Color(0xff233f4b),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Padding(
                        padding: new EdgeInsets.fromLTRB(15,12,0,0),
                        child: const Text("Basic Information",
                          style: TextStyle(color: Color(0xff0adcc3),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 16),),
                      ),
                      Padding(
                          padding: new EdgeInsets.fromLTRB(7,5,7,5),
                          child: Row(
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.fromLTRB(10,0,0,0),
                                child: const Text("Another Name:",
                                  style: TextStyle(color: Color(0xff000000),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),),
                              ),
                              new Padding(
                                padding: new EdgeInsets.all(0.0),
                                child: Text(
                                  alternative_name.toString(),
                                  style: new TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          )),

                      Padding(
                          padding: new EdgeInsets.fromLTRB(7,5,7,10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.fromLTRB(10,0,0,0),
                                child: const Text("Disease Description: ",
                                  style: TextStyle(color: Color(0xff000000),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: new EdgeInsets.all(0.0),
                                  child: Text(
                                    description.toString()/*!=null?dataJson!.alternativeName.toString():"asd"*/,
                                    style: new TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Padding(
                        padding: new EdgeInsets.fromLTRB(15,12,0,0),
                        child: const Text("Inherit Mode",
                          style: TextStyle(color: Color(0xff0adcc3),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 16),),
                      ),

                      Padding(
                          padding: new EdgeInsets.fromLTRB(7,5,7,10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.fromLTRB(10,0,0,0),
                                child: const Text("Disease Symptom: ",
                                  style: TextStyle(color: Color(0xff000000),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: new EdgeInsets.all(0.0),
                                  child: Text(
                                    symptom.toString()/*!=null?dataJson!.alternativeName.toString():"asd"*/,
                                    style: new TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),

                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Padding(
                        padding: new EdgeInsets.fromLTRB(15,12,0,0),
                        child: const Text("Disease Cause",
                          style: TextStyle(color: Color(0xff0adcc3),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 16),),
                      ),
                      Padding(
                          padding: new EdgeInsets.fromLTRB(7,5,7,5),
                          child: Row(
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.fromLTRB(10,0,0,0),
                                child: const Text("Disease Diagnose:",
                                  style: TextStyle(color: Color(0xff000000),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),),
                              ),
                              new Padding(
                                padding: new EdgeInsets.all(0.0),
                                child: Text(
                                  diagnosis.toString(),
                                  style: new TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          )),

                      Padding(
                          padding: new EdgeInsets.fromLTRB(7,5,7,10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.fromLTRB(10,0,0,0),
                                child: const Text("Treat Method: ",
                                  style: TextStyle(color: Color(0xff000000),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: new EdgeInsets.all(0.0),
                                  child: Text(
                                    treat_method.toString()/*!=null?dataJson!.alternativeName.toString():"asd"*/,
                                    style: new TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),

                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: new EdgeInsets.fromLTRB(15,12,0,0),
                        child: const Text("More Details",
                          style: TextStyle(color: Color(0xff0adcc3),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 16),),
                      ),
                      SizedBox(
                        height: 200,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.fromLTRB(10, 5, 15, 10),
                            itemCount: null == dataList ?0 : dataList!.length,
                            itemBuilder: (context, index) {
                              AssociatedDiseases data = dataList![index];
                              return ListTile(
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
                              );
                            },
                          ),
                        ),
                      ),



                    ],
                  ),
                ),
              ],
              ),





            ],
          ),
        ),
      ),
    );
  }

  Future<DiseasesDetailsModel> getList() async{
    final response = await http.post(
      Uri.parse("https://api.genofax.com/disease_info/?disease_id=$diseaseId"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "X-Auth-Token":
        "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93"
      },
    );

    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      setState(() {
        dataJson = DiseasesDetailsModel.fromJson(data);
        dataList = dataJson!.associatedDiseases;
        /*print(dataJson!.name.toString());*/
        alternative_name = dataJson!.alternativeName.toString();
        description = dataJson!.description.toString();
        symptom = dataJson!.symptom.toString();
        diagnosis = dataJson!.diagnosis.toString();
        treat_method = dataJson!.treatMethod.toString();
      });
      return DiseasesDetailsModel.fromJson(data);
    }else{
      throw Exception('Failed to load post');
    }
  }
}
