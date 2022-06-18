import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breed/Models/classify_breed_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class UploadResult extends StatefulWidget {
  ClassifyBreedModel dataJson;
  File imageFile;
  SharedPreferences? _prefs;
  UploadResult(this.dataJson, this.imageFile, {Key? key}) : super(key: key);

  @override
  _UploadResultState createState() => _UploadResultState(dataJson, imageFile);
}


GlobalKey shareContainer = GlobalKey();
GlobalKey previewContainer = new GlobalKey();
final double coverHeight = 280;
final double profileHeight = 144;
bool? isVisible;

bool yesButton = false;
bool noButton= false;
bool dontNoButton= false;

class _UploadResultState extends State<UploadResult> {
  _UploadResultState(this.classifyBreedModel, this.imageFile);
  ClassifyBreedModel classifyBreedModel;
  File imageFile;
  List<String> imagePaths = [];

  ClassifyData? dataList;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      FirebaseAnalytics.instance.logEvent(name: 'Upload_Result_Screen',parameters: {
        'note':"stay Breed Upload Result",
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double percentage = double.parse(
            classifyBreedModel.response!.data!.first.percentage.toString()) / 100;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final top = coverHeight - profileHeight/2;
    final bottom = profileHeight/2;

    var data = classifyBreedModel.response!.data;

    setState(() {
      var mediaQuery = MediaQuery.of(context);
      double physicalPixelWidth = mediaQuery.size.width * mediaQuery.devicePixelRatio;
      double physicalPixelHeight = mediaQuery.size.height * mediaQuery.devicePixelRatio;

      if(physicalPixelWidth>1300.0){
        isVisible = false;
        print("height is above 1300");
      }else{
        isVisible = true;
        print("height is below 1300");
      }
      print(physicalPixelHeight.toString());
      print(physicalPixelWidth.toString());

    });

    /*double percentage = classifyBreedModel.response!.data!.first.percentage as double;*/
    return WillPopScope(
      onWillPop: ()async {
        yesButton = false;
        noButton = false;
        dontNoButton = false;
        return true;
      },
      child: Scaffold(
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
          child: SafeArea(
            child: Container(
              child: Column(
                children: <Widget>[
                  /*Padding(padding: EdgeInsets.only(top: 10.0)),*/
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [

                        Container(
                            margin:EdgeInsets.only(bottom: bottom),
                            child: buildCoverImage(classifyBreedModel)),
                        Positioned(
                            top: top,
                            child: buildProfileImage(percentage,imageFile,profileHeight)),

                      /*  Container(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 100),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                classifyBreedModel.response!.data!.first.thumbnail
                                    .toString(),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 220,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: height * .15,
                            *//*top: height * .5 *//* *//*- (width * .2)*//* *//*,*//*
                            left: width * .3,
                            child: CircularPercentIndicator(
                              radius: 80.0,
                              percent: percentage,
                              lineWidth: 10.0,
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: Colors.grey,
                              progressColor: Colors.cyanAccent,
                              center: ClipOval(
                                child: Image.file(
                                  imageFile,
                                  fit: BoxFit.cover,
                                  width: 135,
                                  height: 135,
                                ),
                              ),
                            ))*/

                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25)),
                  Center(
                    child: Text(
                        classifyBreedModel.response!.data!.first.breed.toString(),
                        style: TextStyle(
                            color: Color(0xff24e7c1),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 19)),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Html(
                        data: classifyBreedModel.response!.classificationSummary
                            .toString(),
                        style: {
                          "body": Style(
                            color: Colors.white,
                            fontSize: FontSize(13),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal,
                          )
                        },
                      )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      child: Row(
                        children: [
                          Text("Am I right?",
                              style: TextStyle(
                                  color: Color(0xff24e7c1),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                          Padding(padding: EdgeInsets.only(left: 7)),

                          ElevatedButton.icon(
                              onPressed: () {
                                  setState( () {
                                    yesButton = true;
                                    noButton = false;
                                    dontNoButton = false;
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: yesButton == false? Colors.white : Color(
                                      0xff0c877c),
                                  onPrimary: Colors.black38),
                              icon: Icon(
                                Icons.thumb_up_alt_outlined,
                                color: Colors.greenAccent,
                              ),
                              label: Text("Yes",
                                  style: TextStyle(
                                      color: yesButton == false? Colors.black : Colors.white,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10))),
                          Padding(padding: EdgeInsets.only(left: 3)),

                          ElevatedButton.icon(
                              onPressed: () {
                                  setState( () {
                                    yesButton = false;
                                    noButton = true;
                                    dontNoButton = false;
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: noButton == false? Colors.white : Color(
                                      0xff0c877c),
                                  onPrimary: Colors.black38),
                              icon: Icon(
                                Icons.thumb_down_alt_outlined,
                                color: Colors.redAccent,
                              ),
                              label: Text("No",
                                  style: TextStyle(
                                      color: noButton == false? Colors.black : Colors.white,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10))),
                          Padding(padding: EdgeInsets.only(left: 3)),

                          Expanded(
                            flex: 1,
                            child: ElevatedButton.icon(
                                onPressed: () {
                                    setState( () {
                                      yesButton = false;
                                      noButton = false;
                                      dontNoButton = true;
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: dontNoButton == false? Colors.white : Color(
                                        0xff0c877c),
                                    onPrimary: Colors.black38),
                                icon: Icon(
                                  Icons.info_outline,
                                  color: Color(0xfffcb500),
                                ),
                                label: Text("Don't know",
                                    style: TextStyle(
                                        color: dontNoButton == false? Colors.black : Colors.white,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10))),
                          ),
                          Padding(padding: EdgeInsets.only(left: 3)),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 0,
                              width: width * .9,
                            ),
                            Text(
                              "Your Result",
                              style: TextStyle(
                                  color: Color(0xff118173),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            Text(
                              "Would you like more information about each breed?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13),
                            ),
                            Text(
                              "Just tap on one of the breed names given below",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                            Padding(padding: EdgeInsets.only(top: 5)),
                            Material(child: buildCard(context,classifyBreedModel.response!.data!)),


                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: null == data ? 0 : data.length,
                        itemBuilder: (context, index) {
                          dataList = data![index];
                          return Card(
                            color: Colors.white,
                            elevation: 20,
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              title: Text(
                                dataList!.breed.toString(),
                                style: TextStyle(
                                    color: Color(0xff118173),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                              leading: buildImage(dataList!),
                              onTap: () {
                                if (data == null) {
                                  print("null data found");
                                } else {
                                  createAlearDiolog(context, data[index]);
                                }
                              },
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: isVisible!,
                            child: ElevatedButton.icon(
                                onPressed: () async {
                                  var image = classifyBreedModel.imageUrl.toString();
                                  _captureSocialPng(context,dataList!,image);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.teal,
                                    onPrimary: Colors.black38),
                                icon: Icon(
                                  Icons.share_outlined,
                                  color: Colors.white,
                                ),
                                label: Text("What to share?",
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
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {

    final getColor = (Set<MaterialState> states){
      if(states.contains(MaterialState.pressed)){
        return colorPressed;
      }else{
        return color;
      }

    };
    return MaterialStateProperty.resolveWith(getColor);

 }


}

Widget buildCoverImage(ClassifyBreedModel classifyBreedModel)=>Container(
  child: ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: CachedNetworkImage(
      imageUrl: classifyBreedModel.response!.data!.first.thumbnail
          .toString(),
      width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover,

    ),
  ),
);

Widget buildProfileImage(double percentage, File imageFile, double profileHeight) => CircularPercentIndicator(
  radius: profileHeight*0.6,
  percent: percentage,
  lineWidth: 10.0,
  circularStrokeCap: CircularStrokeCap.round,
  backgroundColor: Colors.grey,
  progressColor: Colors.cyanAccent,
  center: ClipOval(
    child: Image.file(
      imageFile,
      fit: BoxFit.cover,
      width: 144,
      height: profileHeight,
    ),
  ),
);


Widget buildCard(BuildContext context, List<ClassifyData> data) {
  return RepaintBoundary(
    key: previewContainer,
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: DonutChartWidget(data),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> _captureSocialPng(BuildContext context, ClassifyData data, String imageShow) {
  List<String> imagePaths = [];
  final RenderBox box = context.findRenderObject() as RenderBox;
  return new Future.delayed(const Duration(milliseconds: 20), () async {
    RenderRepaintBoundary? boundary = previewContainer.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    ui.Image image = await boundary!.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();


    File imgFile = new File('$directory/screenshot.png');
    imagePaths.add(imgFile.path);

    shareAlertDialog(context,data,imageShow,pngBytes,imgFile);


  });
}

shareAlertDialog(BuildContext context, ClassifyData dataList, String image,Uint8List bytes, File imgFile) {
  return showDialog(
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

                  RepaintBoundary(
                    key: shareContainer,
                    child: Container(
                      width: double.infinity,
                      color: Color(0xff233f4b),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 10.0)),
                          Container(
                            child: Padding(
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
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(15,5,15,0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: AspectRatio(
                                        aspectRatio: 1/1,
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
                                        aspectRatio: 1/1,
                                        child: Image.network(dataList.thumbnail.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),

                          Padding(padding: EdgeInsets.only(top: 5.0)),
                          Row(
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
                            ],
                          ),

                          Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: SizedBox(

                                    width: MediaQuery.of(context).size.height,
                                    child: Image.memory(bytes),
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
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
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
                          ),
                        ],
                      ),
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        ElevatedButton.icon(
                            onPressed: () {
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
        );
      });
}

void _takeScreenshot(BuildContext context) async {

  return new Future.delayed(const Duration(milliseconds: 20), () async {
    List<String> imagePaths = [];
    final RenderBox box = context.findRenderObject() as RenderBox;

    RenderRepaintBoundary? boundary = shareContainer.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    ui.Image image = await boundary!.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();


    File imgFile = new File('$directory/screenshot.png');
    imagePaths.add(imgFile.path);

    imgFile.writeAsBytes(pngBytes).then((value) async {
      await Share.shareFiles(imagePaths,
          subject: 'Share',
          text: 'Check this Out!',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }).catchError((onError) {
      print(onError);
    });

  });






}

createAlearDiolog(BuildContext context, ClassifyData dataList) {
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
                            imageUrl: dataList.thumbnail.toString(),
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
                        dataList.breed.toString(),
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
                                  dataList.briefHistory.toString(),
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
                                  dataList.idealWeight!.first.toString(),
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
                                  dataList.idealHeight!.first.toString(),
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
                                  dataList.temperament!.join(",\n").toString(),
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
                                  dataList.utilization!.join(",\n").toString(),
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

Widget buildImage(ClassifyData data) => ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: data.thumbnail.toString(),
        height: 50,
        width: 50,
        fit: BoxFit.cover,
      ),
    );

class DonutChartWidget extends StatefulWidget {
  List<ClassifyData> data;
  DonutChartWidget(this.data, {Key? key}) : super(key: key);

  @override
  _DonutChartWidgetState createState() => _DonutChartWidgetState(data);
}

class _DonutChartWidgetState extends State<DonutChartWidget> {
  _DonutChartWidgetState(this.data);
  List<ClassifyData> data;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // TODO: implement initState
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int value = (double.parse(data.first.percentage.toString())).round();
    int value2 = (double.parse(data.first.percentage.toString())).toInt();
    return SingleChildScrollView(
      child: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*SfCircularChart(
              backgroundColor: Colors.white,
              series: <CircularSeries<ClassifyData, String>>[
                DoughnutSeries<ClassifyData, String>(
                    selectionBehavior: SelectionBehavior(enable: true),
                    explode: true,
                    dataSource: data,
                    xValueMapper: (ClassifyData data, _) => data.breed,
                    yValueMapper: (ClassifyData data, _) =>
                        (double.parse(data.percentage.toString())),
                    name: 'Sales',
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                    ),
                    startAngle: 0,
                    radius: "100%",
                    endAngle: 355,
                    innerRadius: '50%')
              ]),*/
          Padding(
            padding: EdgeInsets.fromLTRB(0,5,0,5),
            child: Center(
              child: CircularPercentIndicator(
                animationDuration: 1000,
                radius: 125.0,
                lineWidth: 55.0,
                percent: (double.parse(value.toString()))/100,
                center: Text(value2.toString()+"%"),
                animation: true,
                progressColor: Colors.green,
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final List<ClassifyData> data;
  DonutChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    final c = Offset(size.width / 2.0, size.height / 2.0);
    final radius = size.width * 0.50;
    final rect = Rect.fromCenter(center: c, width: radius, height: radius);
    var startAngle = 0.0;
    data.forEach((element) {
      final sweepAngle =
          double.parse(element.percentage.toString()) * 360.0 * pi / 180.0;
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      startAngle += sweepAngle;
      print(data.length.toString());
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
