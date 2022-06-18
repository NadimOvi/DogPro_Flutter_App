import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breed/Models/get_breed_history_list.dart';
import 'package:dog_breed/Models/get_physical_attributes_list.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class LearnBreedHistory extends StatefulWidget {
  List<HistoryData> historyDataList;
  LearnBreedHistory(this.historyDataList,  {Key? key}) : super(key: key);

  @override
  _LearnBreedHistoryState createState() => _LearnBreedHistoryState(historyDataList);
}

class _LearnBreedHistoryState extends State<LearnBreedHistory> {
  List<HistoryData> historyDataList;
  _LearnBreedHistoryState(this.historyDataList);
  TextEditingController controller = new TextEditingController();

  List<HistoryData>? foundList;


  @override
  void initState(){
    super.initState();
    foundList =historyDataList;

    setState(() {
      FirebaseAnalytics.instance.logEvent(name: 'Learn_Breed_History',parameters: {
        'note':"stay Breed page",
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Dog History'),
        centerTitle: true,
        backgroundColor: Color(0xff233f4b),
      ),
      body: Container(
        color: Color(0xff233f4b),
        child: Column(
          children: <Widget> [
            Padding(padding: EdgeInsets.all(12),
              child:Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search breed', border: InputBorder.none
                    ),
                    onChanged: (value) {
                      if(value==null){
                        foundList =historyDataList;
                      }
                      _runFilter(value);
                    },
                  ),
                ),
              ), ),

            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.fromLTRB(10, 5, 15, 10),
                  itemCount: null == foundList ?0 : foundList!.length,
                  itemBuilder: (context, index){
                    HistoryData data = foundList![index];
                    return Card(
                      color: Colors.white,
                      elevation: 20,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                        title: Text(data.breedName.toString(),
                          style: TextStyle(color: Color(0xff118173),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.normal,
                              fontSize: 16),),
                        subtitle: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 2)),

                            Html(
                              data:data.history.toString(),
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
                        onTap: (){
                          if(data==null){
                            print("null data found");
                          }else{
                            createAlertDialog(context,data);
                          }
                        },
                      ),
                    );
                  }),)

          ],
        ),
      ),
    );
  }
  void _runFilter (String enteredKeyword) {
    List<HistoryData>? result = [];
    /*List<Map<String,dynamic>> result = [];*/
    if(enteredKeyword.isEmpty){
      result = historyDataList;
    }else{
      result = historyDataList.where((user) => user.breedName!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    setState(() {
      foundList = result!;
      print(result.length);
    });
  }

  createAlertDialog(BuildContext context,HistoryData data){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
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
                              imageUrl: data.thumbnail.toString(),
                              width: 144,
                              height: 144,
                              fit: BoxFit.cover,

                            ),
                          ),

                        ],
                      ) ,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(data.breedName.toString(),style: TextStyle(
                            color: Colors.white,fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),),
                      ],
                    ),

                    Padding(padding: EdgeInsets.only(top: 10.0)),

                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 20,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(left: 7),
                                  child: Text("Summary",
                                    style: TextStyle(
                                        color: Colors.black,fontFamily: "Poppins",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13
                                    ),),),


                                  Html(
                                    data:data.history.toString(),
                                    style: {
                                      "body": Style(
                                          color: Colors.black45,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.normal,
                                          fontSize: FontSize(12),
                                      )
                                    },),
                                ],
                              ),)
                          ],
                        ),

                      ),),



                    Padding(padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                                "Ok",
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
                        ],
                      ),),




                  ],
                ),
              ),
            ),
          );
        });
  }


  Widget buildImage(HistoryData data) => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: CachedNetworkImage(
      imageUrl: data.thumbnail.toString(),
      height: 60,
      width: 60,
      fit: BoxFit.cover,
    ),

  );
}
