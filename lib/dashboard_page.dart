
import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:dog_breed/page/history.dart';
import 'package:dog_breed/page/home.dart';
import 'package:dog_breed/page/breeds.dart';
import 'package:dog_breed/page/filter.dart';
import 'package:dog_breed/upload_result/upload_result_show.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LocalDatabase/dataModel.dart';
import 'LocalDatabase/databaseHelper.dart';
import 'Models/RecentBreedHistoryList.dart';
import 'Models/classify_breed_model.dart';
import 'Models/jsonBreedListModel.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  File? imageFile;
  bool showSpinner = false;

  List<BreedListData>? dataList;
  List<ClassifyData>? classifyData;
  List<String>? sharePreList = ['122','232','123'];
  String? sharePre ;

  @override
  void initState(){
    WidgetsFlutterBinding.ensureInitialized();
    setState(() {
      showSpinner = true;
      getList();

      super.initState();
    });

  }

  int currentTab = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  ///////////////////Camera & Pick//////////////////
  String imageUrl ="";

  void _showImageDialog(){
    showDialog(
      context: this.context,
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
    Navigator.pop(this.context);
  }

  void getFromCamera() async{
    PickedFile? pickedFile= await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    _cropImage(pickedFile!.path);
    Navigator.pop(this.context);
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
        final dataJson = ClassifyBreedModel.fromJson(data);
         add(DataModel(ids: dataJson.id));
        /*print(dataJson.id.toString());*/
        /*setDataSave(dataJson.id.toString());*/
        Navigator.push(this.context, MaterialPageRoute(builder: (context) => UploadResult(dataJson,imageFile!),),);
      });


    }else{
      setState(() {
        showSpinner = false;
      });

      throw Exception('Failed to load post');
    }


  }
  /////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Color(0xff233f4b),
        body: Container(
          child: PageStorage(
            child: currentScreen,
            bucket: bucket,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Image.asset("assets/dog_camera.png"),
          elevation: 100,
          onPressed: () async{
              _showImageDialog();

          },
          backgroundColor: Color(0xff199E83),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          color: Color(0xff199E83),
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget> [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: MaterialButton(

                          onPressed: (){
                            setState(() {
                              currentScreen = HomeScreen();
                              currentTab = 0;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home_rounded,
                                color: currentTab==0?Colors.white : Color(0xff15282E),
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                    color: currentTab == 0 ? Colors.white : Color(0xff15282E),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(

                          onPressed: (){
                            setState(() {
                              currentScreen = History();
                              currentTab = 1;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.history_outlined,
                                  color: currentTab==1?Colors.white : Color(0xff15282E),
                              ),
                              Text(
                                "History",
                                style: TextStyle(
                                    color: currentTab==1?Colors.white : Color(0xff15282E),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],),
                ),

                const SizedBox(width: 30,),

                ///Right Tab Bar Icons
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: MaterialButton(

                          onPressed: (){

                            setState(() {
                              var demo = "This one is share";
                              currentScreen = Breeds(list: dataList!,
                              );
                              currentTab = 2;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.list,
                                color: currentTab==2?Colors.white : Color(0xff15282E),
                              ),
                              Text(
                                "Breeds",
                                style: TextStyle(
                                    color: currentTab==2?Colors.white : Color(0xff15282E),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(

                          onPressed: (){
                            setState(() {
                              currentScreen = Filter();
                              currentTab = 3;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.filter_list_sharp,
                                color: currentTab==3?Colors.white : Color(0xff15282E),
                              ),
                              Text(
                                "Filter",
                                style: TextStyle(
                                    color: currentTab==3?Colors.white : Color(0xff15282E),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],),
                )

              ],
            ),
            //Right Tab Bar Icons

          ),
        ),
      ),
    );

  }
  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  /////////Breed List Call
  Future<JsonBreedListModel> getList() async{
    setState(() {
      showSpinner = false;
      super.initState();
    });
    final response = await http.post(Uri.parse("https://api.genofax.com/breeds_list/"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "X-Auth-Token": "https://api.genofax.com/breeds_list/"},);

    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      setState(() {
        showSpinner = false;
        final dataJson = JsonBreedListModel.fromJson(data);
        dataList = dataJson.data;
      });
      return JsonBreedListModel.fromJson(data);
    }else{
      showSpinner = false;
      throw Exception('Failed to load post');
    }
  }
  /*Future<void> setDataSave(String id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("Id", id);
  }*/
}

Future<int> add(DataModel dataModel) async {
  Database db = await DatabaseHelper.instance.database;
  print(dataModel.ids.toString());
  return await db.insert('dataModel', dataModel.toMap());
}




