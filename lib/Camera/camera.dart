import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

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
        maxHeight: 1080,
        maxWidth: 1080);
    if (croppedImage != null){
      setState(() {
        imageFile = croppedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF307777),
          title: Text("Image Cropper"),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
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




