import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class BottomSheetCamera extends StatefulWidget {
  const BottomSheetCamera({Key? key}) : super(key: key);

  @override
  _BottomSheetCameraState createState() => _BottomSheetCameraState();
}

class _BottomSheetCameraState extends State<BottomSheetCamera> {
  late XFile _selectedFile;

  File? pickedImage;
  late String files;

  pickImage(ImageSource imageType) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: imageType);
      if (image != null) {
        XFile cropped = (await ImageCropper().cropImage(
            sourcePath: image.path,
            aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
            compressQuality: 100,
            maxHeight: 700,
            maxWidth: 700,
            compressFormat: ImageCompressFormat.jpg,
            androidUiSettings: AndroidUiSettings(
                toolbarColor: Colors.teal,
                toolbarTitle: "RPS Cropper",
                toolbarWidgetColor: Colors.white,
                statusBarColor: Colors.teal.shade400,
                backgroundColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            iosUiSettings: IOSUiSettings(
              minimumAspectRatio: 1.0,
            ))) as XFile;

        _selectedFile = cropped;
        pickedImage = File(_selectedFile.path);

        this.setState(() {});
      }
    } catch (error) {
      debugPrint(error.toString());
    }

    /*try {
      final photo = await ImagePicker().pickImage(source: imageType);

      if (photo == null) return;
      final tempImage = File(photo.path);

      int sizeInBytes = tempImage.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      print(sizeInMb);
      File compressedImage =await customCompressed(imagePathCompress: tempImage);
      int sizeInBytes2 = compressedImage.lengthSync();
      double sizeInMb2 = sizeInBytes2 / (1024 * 1024);
      print(sizeInMb2);

      setState(() {
        pickedImage = tempImage;
        String fileName = compressedImage.path.toString();
        print(fileName);
        uploadImage(fileName);
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }*/
  }

  Future<File> customCompressed({
    required File imagePathCompress,
    quality = 100,
    percentage = 10,
  }) async {
    var path = await FlutterNativeImage.compressImage(
      imagePathCompress.absolute.path,
      quality: 100,
      percentage: 10,
    );
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          color: Colors.white,
          height: 480,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: pickedImage != null
                      ? Image.file(
                          pickedImage!,
                          width: 170,
                          height: 270,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          "https://genofax.s3.ap-southeast-1.amazonaws.com/breed-thumbnails/affenpinscher.jpg",
                          width: 170,
                          height: 270,
                          fit: BoxFit.cover,
                        ),
                ),
                const Text(
                  "Picture Image From",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xff118173),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  icon: const Icon(Icons.camera),
                  label: const Text("Camera"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xff118173),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  icon: const Icon(Icons.image),
                  label: const Text("Gallery"),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage(String fileName) async {
    /*var request =*/
    var postUri = Uri.parse("https://api.genofax.com/classify_breed/");
    http.MultipartRequest request = new http.MultipartRequest("POST", postUri);

    /*  Map<String, String> headers = {
      "X-Auth-Token": "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93"
    };*/

    request.headers['X-Auth-Token'] =
        "FE:38:E1:DA:42:34:BB:83:F3:1C:B8:27:75:9F:75:80:98:A8:24:93";

    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('file', fileName);

    request.files.add(multipartFile);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("result : \n");
      print(response.statusCode);
    } else {
      print(response.statusCode);
    }
  }
}
