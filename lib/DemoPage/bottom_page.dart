import 'dart:io';
import 'dart:typed_data';

import 'package:dog_breed/DemoPage/home_page.dart';
import 'package:dog_breed/Models/RecentBreedHistoryList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BottomPage extends StatefulWidget {
  BuildContext context;
  DataIndividual dataList;
  String image;
  Uint8List pngBytes;
  File imgFile;
  BottomPage(this.context,this.dataList,this.image,this.pngBytes,this.imgFile  );

  @override
  _BottomPageState createState() => _BottomPageState(this.context,this.dataList,this.image,this.pngBytes,this.imgFile );
}

bool? isVisible;

class _BottomPageState extends State<BottomPage> {
  BuildContext context;
  DataIndividual dataList;
  String image;
  Uint8List pngBytes;
  File imgFile;

  _BottomPageState(this.context,this.dataList,this.image,this.pngBytes,this.imgFile );

  GlobalKey shareAnotherContainer = new GlobalKey();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  void _takeScreenshot(BuildContext context) async {

    return new Future.delayed(const Duration(milliseconds: 20), () async {
      List<String> imagePaths = [];
      final RenderBox box = context.findRenderObject() as RenderBox;

      RenderRepaintBoundary? boundary = shareAnotherContainer.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();


      File imgFile = new File('$directory/screenshot.png');
      imagePaths.add(imgFile.path);

      imgFile.writeAsBytes(pngBytes).then((value) async {
        /*await Share.shareFiles(imagePaths,
            subject: 'Share',
            text: 'Check this Out!',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);*/
        Rect? sharePositionOrigin;
        if (imagePaths.isNotEmpty) {
          await Share.shareFiles(imagePaths,
              text: "Check this out",
              subject: "Subject",
              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
        } else {
          await Share.share("image is not found",
              subject: "Error",
              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
        }



      }).catchError((onError) {
        print(onError);
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      if(height>1000.0){
        isVisible = false;
        print("height is above 1000");
      }else{
        isVisible = true;
        print("height is below 1000");
      }
      print(height.toString());
      print(width.toString());

    });

    return Scaffold(
      backgroundColor: Color(0xff0c0f14),
      body: RepaintBoundary(
        key: shareAnotherContainer,
        child: Container(
          width: double.infinity,
          color: Color(0xff233f4b),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  width: double.infinity,
                  color: Color(0xff233f4b),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: EdgeInsets.fromLTRB(15,10,15,0),
                        child: Row(
                          children: [

                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: AspectRatio(
                                  aspectRatio: 20/2,
                                  child: Text("Your Image",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: AspectRatio(
                                  aspectRatio: 20/2,
                                  child: Text(dataList.breed.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(15,5,15,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: AspectRatio(
                                  aspectRatio: 2/1,
                                  child: Image.network(image.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: AspectRatio(
                                  aspectRatio: 2/1,
                                  child: Image.network(dataList.thumbnail.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),

                      Padding(padding: EdgeInsets.only(top: 5.0)),



                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Chart Result",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: SizedBox(

                                width: 300,
                                child: Image.memory(pngBytes),
                              ),
                            ),
                          ),
                        ],
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
                                      dataList.countryOfOrigin.toString(),
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
                                      dataList.lifeSpan!.first.toString(),
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
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget> [

                            Container(
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              height: 50,
                              width: MediaQuery.of(context).size.width *0.2,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    image: AssetImage("assets/logo.png"),
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Visibility(
                        visible: isVisible!,
                        child: ElevatedButton.icon(
                            onPressed: () async {
                              _takeScreenshot(context);

                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.teal,
                                onPrimary: Colors.black38),
                            icon: Icon(
                              Icons.share_outlined,
                              color: Colors.white,
                            ),
                            label: Text("Share",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12))),
                      ),

                      Padding(padding: EdgeInsets.only(left: 10)),
                      ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
                              onPrimary: Colors.black38),
                          icon: Icon(
                            Icons.assignment_return_outlined,
                            color: Colors.white,
                          ),
                          label: Text("Return",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12))),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

