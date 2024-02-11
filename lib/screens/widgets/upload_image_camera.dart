import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';

class UploadImageCameraScreen extends StatefulWidget {
  /// Default Constructor
  const UploadImageCameraScreen({super.key});
  @override
  State<UploadImageCameraScreen> createState()=> _UploadImageCameraScreenState();
}

class _UploadImageCameraScreenState extends State<UploadImageCameraScreen> with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  bool? isFlashoff;
  XFile? imageFile;
  List<CameraDescription> _cameras = <CameraDescription>[];

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    ControllerInitializeCamera();
  }

  ControllerInitializeCamera() async {
    if(mounted){
      _cameras = await availableCameras();
      setState(() {});
      setState(()  {
        Future.delayed(Duration.zero).then((value) {
          print("controller!.description");
          controller = CameraController(_cameras[1], ResolutionPreset.max);
          print(controller!.description);
          controller!.setFlashMode(FlashMode.off);
          isFlashoff=true;
          controller!.initialize().then((_) {
            if (!mounted) {
              return;
            }
            setState(() {});
          }).catchError((Object e) {
            if (e is CameraException) {
              switch (e.code) {
                case 'CameraAccessDenied':
                // Handle access errors here.
                  break;
                default:
                // Handle other errors here.
                  break;
              }
            }
          });


        });
       if(mounted){
         setState(() {
           isLoad = false;
         });
       }
      });
    }
  }
   bool isLoad = true;
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    var isMobile= ResponsiveHelper.isMobile(context);
    return Scaffold(

      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body:  responsiveContainer(
        context,
        ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
        Scaffold(
          body: isLoad ? Center(
            child: SizedBox(
              height: 30,width: 30,
              child: CircularProgressIndicator(
                color: Colors.blue,strokeWidth: 3,
              ),
            ),
          ):_cameras.isEmpty?

          Column(
            children: [
              100.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  20.width,
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: primaryColor20,
                      child: Center(child: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,size: 24,)),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Center(
                  child: NotAvailableText("Camera Not Found!"),
                ),
              ),
            ],
          )
              :Stack(
            children: [
              Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Center(
                          child: CameraPreview(controller!),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              Positioned(left: 20,right: 20,bottom: 50,child:_captureControlRowWidget(),)
            ],
          ),
        ),
      ),
    );
  }

  Widget _captureControlRowWidget() {
    final CameraController? cameraController = controller;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              if (controller!.description.name.toString()=="0") {
                controller!.setDescription(_cameras[1]);
              }else if(controller!.description.name.toString()=="1"){
                controller!.setDescription(_cameras[0]);
              }else{
                return;
              }
            });
          },
          child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white54,
                shape: BoxShape.circle,

              ),
              child: Icon(Icons.cameraswitch_outlined,color: Colors.white,size: 24,)
          ),
        ),
        InkWell(
          onTap: cameraController != null &&
              cameraController.value.isInitialized
              ? onTakePictureButtonPressed
              : null,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white38,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white,width: 3)

            ),
            child:  Icon(Icons.camera_alt_outlined,color: Colors.white,size: 24,),

          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              if(controller!.value.flashMode.name.toString()=="off"){
                isFlashoff=false;
                controller!.setFlashMode(FlashMode.always);
              }else {
                isFlashoff=true;
                controller!.setFlashMode(FlashMode.off);
              }
            });
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white54,
              shape: BoxShape.circle,

            ),
            child:isFlashoff==true?Icon(Icons.flash_on,size: 24,color: Colors.white,):Icon(Icons.flash_off,size: 24,color: Colors.white),

          ),
        ),
      ],
    );
  }
  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          imageFile = file;

        });
        if (file != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(imagepath: file.path.toString()))).then((value) {
            Navigator.pop(context,"${value.toString()}");
          });
        }
      }
    });
  }
  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      return null;
    }
  }
  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

}



class ImageView extends StatefulWidget {
  String imagepath;
  ImageView({super.key,required this.imagepath});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    var isMobile= ResponsiveHelper.isMobile(context);
    return Scaffold(
        backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
    body:  responsiveContainer(
    context,
    ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
       Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Container(
              margin: EdgeInsets.all(10),
              width: isMobile?width:tabWidth,
              height: MediaQuery.of(context).size.height*0.7,
              decoration: BoxDecoration(
                  image: DecorationImage(image: FileImage(File(widget.imagepath.toString())),fit: BoxFit.fill)
            ),),
                SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        },
                      child: Container(
                        padding:EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.white38,
                            shape: BoxShape.circle
                        ),
                        child: Icon(Icons.close,size: 24,color: Colors.white,),
                      ),
                    ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context,"${widget.imagepath.toString()}");
                    },
                    child: Container(
                      padding:EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white38,
                          shape: BoxShape.circle
                      ),
                      child: Icon(Icons.done,size: 24,color: Colors.white,),
                    ),
                  )

                ],)
          ]),
        ),
      ),
    ));
  }
}
