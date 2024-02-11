import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialapps/common/style.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';


extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';

}

extension EmptySpace on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}
extension AadharNumberValidator on String {
  bool isValidAadharNumber() {
    return RegExp(
        r'^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$')
        .hasMatch(this);
  }
}

extension PanCardValidator on String {
  bool isValidPanCardNo() {
    return RegExp(
        r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$')
        .hasMatch(this);
  }
}

extension DrivingLicenseValidator on String {
bool isValidLicenseNo() {
  return RegExp(
      r'^(([A-Z]{2}[0-9]{2})( )|([A-Z]{2}-[0-9]{2}))((19|20)[0-9][0-9])[0-9]{7}$')
      .hasMatch(this);
}
}

extension PassportValidator on String {
  bool isValidPassportNo() {
    return RegExp("^[A-PR-WY-Z][1-9]")
        .hasMatch(this);
  }
}

extension VoterIDValidator on String {
  bool isValidVoterNo() {
    return RegExp(
        r'^[A-Z]{3}[0-9]{7}$')
        .hasMatch(this);
  }
}

String validateAadharcard(String value) {
  print(value);
  String pattern = r"^[2-9][0-9]{3}\s[0-9]{4}\s[0-9]{4}$";
  RegExp regExp = RegExp(pattern);
  if (value.isEmpty) {
    return 'Please Enter Aadhar card Number';
  } else if (!regExp.hasMatch(value)) {
    return 'Please Enter Valid Aadhar card Number';
  }
  return "";
}


class Constants{
  //colors
  static const Color newBackground = Color(0xFFFDFCFC);
  static const Color primaryColor1 = primaryColor;
  static const Color primaryColor20 = Color(0x3352B46B);
  static const Color lightGreen = Color(0xFFDCF0DD);
  static const Color unActiveTabBg = Colors.transparent;
  static const Color greyLight = Color(0xFFDFEAE4);
  static const Color greyDark = Color(0xFF8F8F8F);
  static const Color greyFieldColor = Color(0xFFE7E6E6);
  static const Color black = Color(0xFF171717);
  static const Color white = Color(0xFFFFFFFF);
  static const Color redColor = Color(0xFFBC2F10);
  static const Color templateBg = Colors.deepOrangeAccent;
  static const Color textFieldBorder = Color(0xFFDFEAE4);
  static const Color closeOfferCard = Color(0x99DCF0DD);
  static const Color offerPageSecoundry =  Color(0xFFE7E6E6);
  static const borderColor = Color(0xFFE1E1E1);
  static const TextStyle hintStyle = TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: greyDark);

  static const Color tabBackGroundColor = Color(0xFF1E1F1E);
  static const Color bottomSheetBg = Color(0xFF0E7E6E6);

  //status bar style

  static statusBar(Color color, Brightness brightness) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: color,
      statusBarIconBrightness: brightness,
      statusBarBrightness: brightness,
    ));
  }
  static showToast(String message) {
    EasyLoading.showToast(message, toastPosition: EasyLoadingToastPosition.top);
  }
  static showToastAtBottom(String message) {
    EasyLoading.showToast(message, toastPosition: EasyLoadingToastPosition.bottom,duration: Duration(seconds: 3));
  }
  //button style
  // static buttonStyle(){
  //   return ButtonStyle(
  //       backgroundColor: MaterialStateProperty.all(Constants.buttonColor ),
  //       elevation: MaterialStateProperty.all(0),
  //       foregroundColor: MaterialStateProperty.all(Colors.transparent),
  //       overlayColor: MaterialStateProperty.all(Colors.transparent),
  //       shadowColor: MaterialStateProperty.all(Colors.transparent),
  //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8),
  //       ),)
  //   );
  // }
  // static boxDecoration(){
  //   return BoxDecoration(
  //     color: Constants.buttonColor.withOpacity(.3),
  //     borderRadius: const BorderRadius.all(
  //       Radius.circular(50.0),
  //     ),
  //     boxShadow: [
  //       BoxShadow(
  //         color: Colors.grey.withOpacity(0.2),
  //         spreadRadius: -2,
  //         blurRadius: 5,
  //         offset: const Offset(0, 6),
  //       ),
  //     ],
  //   );
  // }
  //show toast
  // static showToast(String message) {
  //   EasyLoading.showToast(message, toastPosition: EasyLoadingToastPosition.top);
  // }

  // static String? validateMobile(String value, BuildContext context) {
  //   String pattern = r'(^[0-9]*$)';
  //   RegExp regExp = new RegExp(pattern);
  //   if (value.isEmpty) {
  //   } else if (value.length != 10) {
  //     return "Mobile number must 10 digits";
  //   } else if (!regExp.hasMatch(value)) {
  //     return "Mobile number must be digits";
  //   }
  //   return null;
  // }


// static Future<void> preCacheLoadSVG() async {
//   // const loader = SvgAssetLoader('assets/icons/ic_available_full_day.svg');
//   // svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
//   final manifestJson = await rootBundle.loadString('AssetManifest.json');
//   List svgsPaths = (json.decode(manifestJson).keys.where((String key) => key.startsWith('assets/') && key.endsWith('.svg')) as Iterable).toList();
//
//   await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, 'assets/icons/ic_available_full_day.svg'), null);
// }

  static MessageShowDialog(context, Widget messageWidget , Callback onTap){
    showDialog(context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.center,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          elevation: BorderSide.strokeAlignOutside,
          child: Container(
            padding: EdgeInsets.only( top: 0,bottom: 0),
            width: MediaQuery.of(context).size.width*0.85,
            decoration:  BoxDecoration(color: Color(0x1A52B46B),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Constants.greyDark,width: 0.5)
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.55,
                    child: Center(
                      child:messageWidget,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor:Constants.primaryColor1, elevation: 1),
                          onPressed: onTap,
                          child: Text("OK",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900,color: Constants.white),)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },);
  }
}
//
// Future generateThumbnail() async {
//   final fileName = await VideoThumbnail.thumbnailFile(
//     video: "http://13.51.44.195:8000/media/counterofferitemsmedia/1000100799.mp4",
//     thumbnailPath: (await getTemporaryDirectory()).path,
//     imageFormat: ImageFormat.WEBP                                                                                                                                                                                                                                                                                                                                                      ,
//     maxHeight: 200, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
//     quality: 66,
//   );
//   print("VideoThumbnail");
//   print(fileName);
//   return fileName;
// }

 NotAvailableText(message){
  return  Padding(
    padding: const EdgeInsets.only(top: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$message",style: greySubTitleItalicStyle,textAlign: TextAlign.center,),
      ],
    ),
  );
 }

privetPublicLogo({bool ? isPrivet}){
  return  CircleAvatar(
    radius: 15,
    backgroundColor: Constants.lightGreen,
    child: Center(
      child: isPrivet == true? Image(image: AssetImage("assets/secured_lock.png"),width: 16,height: 16,color: primaryColor):Image(image: AssetImage("assets/world.png"),width: 18,height: 18,color: primaryColor)
    ),
  );
}

privetPublicLogoNew({bool ? isPrivet}){
  return  Container(
    padding: EdgeInsets.all(2),
    decoration: BoxDecoration(
      color:Constants.lightGreen,
      borderRadius: BorderRadius.only(topLeft:Radius.circular(3) ,bottomRight: Radius.circular(8))
  ), 
    child: Center(
        child: isPrivet == true? Image(image: AssetImage("assets/secured_lock.png"),width: 15,height: 15,color: primaryColor):Image(image: AssetImage("assets/world.png"),width: 15,height: 15,color: primaryColor,)
    ),
  );
}