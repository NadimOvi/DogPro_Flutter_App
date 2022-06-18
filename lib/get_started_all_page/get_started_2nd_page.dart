import 'package:dog_breed/DemoPage/bottom_page.dart';
import 'package:dog_breed/page/filter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'filter_started_page.dart';
class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {


  @override
  void initState(){
    setState(() {

      super.initState();
      FirebaseAnalytics.instance.logEvent(name: 'Instruction _filter_Screen',parameters: {
        'note':"stay Instruction",
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Intruduction for Filter Search'),
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
                    child: Padding(padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
                      child: Text("This feature of our app allows you to search for breeds based on your preferred criteria. For now, you can find the breeds based on different sets of parameters. These parameters include Ideal Height, Ideal Weight ranges including Temperaments and Utilization.",
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
                    child: Padding(padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
                      child: Text("You can apply all the search queries at a time or leave any of them empty. The more parameters you set the more rigorous the search becomes.  If this feature doesn’t help to find your desired dog then you can see the full list of the dogs and learn about each of them in the Full List fragment of the app.",
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FilterStartedPage(),),);
                              /*Navigator.push(context, MaterialPageRoute(builder: (context) => BottomPage(),),);*/
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
                        ),
                      ],

                    ),
                  )
                ],
              ),
            )

        )

    );
  }
}
