
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:socialapps/constant/constatnt.dart';

class ConstantFun{
  static checkLocation(BuildContext context) async {
    await Permission.location.request();
    var status = await Permission.location.status;
    if (status.isDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permissions error'),
          content: const Text('Please enable location access'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () => Navigator.of(context).pop(), child: const Text("Cancel",style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.w400),)
                  ),
                  InkWell(
                      onTap: () {
                        openAppSettings();
                        Navigator.of(context).pop();
                      }, child: const Text("OpenAppSetting",style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.w400),)
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
    else{
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }
  }

  // static checkFileSize(String path,int size) {
  //   var fileSizeLimit = size*1024;
  //   var s = File(path).lengthSync(); // returns in bytes
  //   var fileSizeInKB = s / 1024;
  //   if(fileSizeInKB > fileSizeLimit) {
  //     showToast("File size greater than the limit");
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  static Future<File> fileFromImageUrl({url, name}) async {
    final response = await http.get(Uri.parse(url.toString()));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File(join(documentDirectory.path, name.toString()));
    file.writeAsBytesSync(response.bodyBytes);
    return file;
  }



  static Future<String>getFileSize(String url) async {
    final response = await http.get(Uri.parse(url));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File(join(documentDirectory.path, "temp"));
    file.writeAsBytesSync(response.bodyBytes);

    var s = file.lengthSync(); // returns in bytes
    var fileSizeInKB = s / 1024;
    var fileSizeInMB = (s / 1024)/1024;
    // print(fileSizeInKB);
    // print(fileSizeInMB.toStringAsFixed(2));
    return fileSizeInMB.toStringAsFixed(2);
  }

  // static Future<File> imageCropper({path}) async {
  //   CroppedFile ? croppedFile = await ImageCropper().cropImage(
  //     sourcePath: path,
  //     aspectRatioPresets: Platform.isAndroid ?
  //     [CropAspectRatioPreset.ratio3x2,CropAspectRatioPreset.ratio4x3,CropAspectRatioPreset.square,CropAspectRatioPreset.ratio7x5,CropAspectRatioPreset.ratio16x9,] :
  //     [CropAspectRatioPreset.ratio3x2,CropAspectRatioPreset.ratio4x3,CropAspectRatioPreset.square,CropAspectRatioPreset.ratio7x5,CropAspectRatioPreset.ratio16x9,],
  //     uiSettings: [
  //       AndroidUiSettings(
  //         toolbarTitle: 'Image Cropper',
  //         toolbarColor: primary,
  //         toolbarWidgetColor: Colors.white,
  //         initAspectRatio: CropAspectRatioPreset.square,
  //         lockAspectRatio: false,
  //         showCropGrid: false,
  //         hideBottomControls: false,
  //       ),
  //       IOSUiSettings(title: 'Image Cropper',),
  //     ],
  //     cropStyle: CropStyle.rectangle,
  //   );
  //   return File(croppedFile!.path);
  // }




  static Future<File> imageCropper({path}) async {
    CroppedFile ? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid ?
      [CropAspectRatioPreset.ratio3x2,CropAspectRatioPreset.ratio4x3,CropAspectRatioPreset.ratio7x5,CropAspectRatioPreset.ratio16x9,] :
      [CropAspectRatioPreset.ratio3x2,CropAspectRatioPreset.ratio4x3,CropAspectRatioPreset.ratio7x5,CropAspectRatioPreset.ratio16x9,],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Image Cropper',
          toolbarColor: Constants.primaryColor1,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
          showCropGrid: false,
          hideBottomControls: false,
        ),
        IOSUiSettings(title: 'Image Cropper',),
      ],
      cropStyle: CropStyle.rectangle,
    );
    return File(croppedFile!.path);
  }

  static Future<File> imageProfileCropper({path}) async {
    CroppedFile ? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid ?
      [CropAspectRatioPreset.ratio3x2,CropAspectRatioPreset.ratio4x3,CropAspectRatioPreset.square,CropAspectRatioPreset.ratio5x3,CropAspectRatioPreset.ratio7x5,] :
      [CropAspectRatioPreset.ratio3x2,CropAspectRatioPreset.ratio4x3,CropAspectRatioPreset.square,CropAspectRatioPreset.ratio5x3,CropAspectRatioPreset.ratio7x5,],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Image Cropper',
          toolbarColor: Constants.primaryColor1,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
          showCropGrid: false,
          hideBottomControls: false,
        ),
        IOSUiSettings(title: 'Image Cropper',),
      ],
      cropStyle: CropStyle.rectangle,
    );
    return File(croppedFile!.path);
  }
}