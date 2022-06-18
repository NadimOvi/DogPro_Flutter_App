import 'dart:convert';
import 'dart:io';

import 'package:dog_breed/Models/ImageResult.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CameraScreenShow extends StatefulWidget {
  const CameraScreenShow({Key? key}) : super(key: key);

  @override
  _CameraScreenShowState createState() => _CameraScreenShowState();
}

class _CameraScreenShowState extends State<CameraScreenShow> {
ImageResult imageResult = ImageResult();
  File? imageFile;

  String imageUrl ="";

  void _showImageDialog(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Please choose and option'),
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
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(
                        Icons.camera,
                        color: Colors.purple,
                      ),
                    ),
                    Text('Camera',style: TextStyle(color: Colors.purple),
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
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(
                        Icons.image,
                        color: Colors.purple,
                      ),
                    ),
                    Text('Gallery',
                      style: TextStyle(color: Colors.purple),
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
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),

        maxHeight: 1080,
        maxWidth: 1080);
    if (croppedImage != null){
      /*setState(() {

      });*/
      imageFile = croppedImage;
      int sizeInBytes = imageFile!.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      print(sizeInMb);

      String fileName = imageFile!.path.toString();

      uploadImage(fileName);

      print(imageResult.id);
      print(fileName);
    }
  }

  Future<ImageResult> uploadImage(String fileName) async {

      var postUri = Uri.parse("https://api.genofax.com/classify_breed/");
      http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
      request.headers['X-Auth-Token']= "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93";
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'file', fileName);
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();

      var responses = await http.Response.fromStream(response);
      if (responses.statusCode == 200){

        var jsonString = responses.body;
        var jsonMap = json.decode(jsonString);
        imageResult = ImageResult.fromJson(jsonMap);

        setState(() {
          print(imageResult.imageUrl);
          print(responses.statusCode);
        });

      }else{
        print(responses.statusCode);
      }



    return imageResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 50,
            /*width: size.width,*/
          ),
          imageFile != null?
          Container(
            child: GestureDetector(
              onTap: (){
                _showImageDialog();
              },
              child: Image.file(imageFile!),
            ),
          ):
          Container(
            child: GestureDetector(
              onTap: (){
                _showImageDialog();
              },
              child: Icon(
                Icons.camera_enhance_rounded,
                color: Colors.green,
                size: MediaQuery.of(context).size.width * .6,
              ),
            ),
          ),
        ],
      )
    );
  }
}
