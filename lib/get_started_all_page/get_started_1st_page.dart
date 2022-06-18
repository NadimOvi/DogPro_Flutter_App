import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:dog_breed/upload_result/upload_result_show.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'dart:convert';

import 'dart:io';
import '../Models/classify_breed_model.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  File? imageFile;
  bool showSpinner = false;

  List<ClassifyData>? classifyData;

  @override
  void initState(){
    setState(() {

      super.initState();
      FirebaseAnalytics.instance.logEvent(name: 'Instruction_Screen',parameters: {
        'note':"stay Instruction",
      });




    });



  }
  ///////////////////Camera & Pick//////////////////

  String imageUrl ="";

  void _showImageDialog(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Please choose an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: (){
                  getFromCamera();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.camera,
                        color: Color(0xff233f4b),
                      ),
                    ),
                    Text('Camera',style: TextStyle(color: Color(0xff233f4b)),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  getFromGallery();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.image,
                        color: Color(0xff233f4b),
                      ),
                    ),
                    Text('Gallery',
                      style: TextStyle(color: Color(0xff233f4b)),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },

    );
  }

  void getFromGallery() async{
    PickedFile? pickedFile= await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void getFromCamera() async{
    PickedFile? pickedFile= await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],

        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Color(0xff233f4b),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),

        maxHeight: 1080,
        maxWidth: 1080);
    if (croppedImage != null){
      setState(() {
        imageFile = croppedImage;
        int sizeInBytes = imageFile!.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        print(sizeInMb);

        String fileName = imageFile!.path.toString();
        print(fileName);
        uploadImage(fileName);
      });
    }
  }

  Future<void> uploadImage(String fileName) async {

    setState(() {
      showSpinner = true;
    });
    var postUri = Uri.parse("https://api.genofax.com/classify_breed/");
    http.MultipartRequest request = new http.MultipartRequest("POST", postUri);

    request.headers['X-Auth-Token']= "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93";
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'file', fileName);

    request.files.add(multipartFile);
    http.Response response = await http.Response.fromStream(await request.send());
    print("Result: ${response.statusCode}");
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      setState(() {
        showSpinner = false;
      });
      final dataJson = ClassifyBreedModel.fromJson(data);
      print(dataJson);
      Navigator.push(context, MaterialPageRoute(builder: (context) => UploadResult(dataJson,imageFile!),),);
    }else{
      showSpinner = false;
      throw Exception('Failed to load post');
    }


  }
  /////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width/3;
    double height = mediaQuery.size.height/3;

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Color(0xff233f4b),
        appBar: AppBar(
          title: Text('Intruduction for identification'),
          centerTitle: true,
          backgroundColor: Color(0xff233f4b),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xff233f4b),
            child: Padding(padding: EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      child: Padding(padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
                        child: Text("Breed Identification is a feature in this app that you can use to know the breed of your dog. This identification process is performed based on an image of your dog you upload or take an image with your phone’s camera. For now, we can identify 130 dog breeds with significant accuracy. It is obvious that sometimes the breed might not be correctly identified as this is completely based on the visual feature of your dog.",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.left,),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                      child: Text("To utilize the full potential of our identification algorithm we recommend you to take the picture of your dog in certain set of criteria.\n",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.justify,),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset("assets/images/image1.png",
                            width: MediaQuery.of(context).size.width/3,),
                        ),
                        Expanded(

                          child: Text("Use your camera or upload your own photo from the gallery",
                            style: TextStyle(
                              color: Color(0xff14fcdf),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,),
                        )

                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("Within a few seconds the app determines the dog breed",
                            style: TextStyle(
                              color: Color(0xff14fcdf),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,),
                        ),

                        Container(
                          child: Image.asset("assets/images/image2.png",
                            width: MediaQuery.of(context).size.width/3,),
                        ),


                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 120),
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset("assets/images/image3.png",
                            width: MediaQuery.of(context).size.width/3,),
                        ),
                        Expanded(

                          child: Text("App will tell you which breeds have been mixed",
                            style: TextStyle(
                              color: Color(0xff14fcdf),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,),
                        )

                      ],
                    ),
                  ),

                ],
              ),
            )

          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 40),
          child: FloatingActionButton.extended(

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            icon: Icon(Icons.camera_enhance),
            label: Text("Identify your Breed"),
            onPressed: () async{
              _showImageDialog();

            },
            backgroundColor: Color(0xff199E83),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      ),

    );
  }
}
