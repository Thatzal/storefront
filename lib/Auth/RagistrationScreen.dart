import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/Auth/subscription_screen.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loader.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/controller/share_preferences.dart';
import 'package:socialapps/screens/setting/manage_profile_screen.dart';
import '../common/style.dart';
import '../model/GetAvailableUserNameListModel.dart';

class welcome_screen extends StatefulWidget {
  String? username;
  String? UserId;
  welcome_screen({Key? key,required this.username,required this.UserId}) : super(key: key);
  @override
  State<welcome_screen> createState() => _welcome_screenState();
}

class _welcome_screenState extends State<welcome_screen> {
  // TextEditingController checkUserController = TextEditingController();
  final  checkUserController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> avalaibleUserName = [];
  bool ShowAvailableName = false;
  bool isLoading = false;
  GlobalKey<FormState> globalKey=GlobalKey<FormState>();
  static final RegExp nameRegExp = RegExp("[a-zA-Z0-9](_|-| |@|)[a-zA-Z0-9]");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getLocation();
  }
  late LatLng currentPostion;
  late LatLng pickedPosition;
  List offerAreas = [];
  String? _currentAddress;
  Position? _currentPosition;
  String? CurrentAddress;
  var lat;
  var long;


  _getLocation() async
  {
    await Permission.location.request().then((value) async {
      if(value.isGranted){
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        debugPrint('location: ${position.latitude}');
        var addresses = await getAddressFromLatLong(position.latitude.toString(),position.longitude.toString());
        var first = addresses;

        offerAreas.add({"Address": "${first}" });
      }else{
        Constants.showToast("Your location not arrowed");
        offerAreas.add({"Address": ""});
      }});

  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    bool isMobile = ResponsiveHelper.isMobile(context);
    return Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(
          context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Scaffold(
            body: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: isMobile ?width:tabWidth,
                    padding: const EdgeInsets.only(top: 20),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.5,
                      width: isMobile ?width:tabWidth,
                      decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/Login_Banner_2.png"),fit: BoxFit.cover)
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20,),
                        height:checkUserController.text.isEmpty?MediaQuery.of(context).size.height * 0.48:MediaQuery.of(context).size.height * 0.5,
                        width: isMobile ?width:tabWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            boxShadow:  [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                spreadRadius: 1,
                                blurRadius: 1,
                                blurStyle: BlurStyle.solid,
                              )
                            ]),
                        child: SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start  ,
                            children: [
                              const SizedBox(height: 50,),
                              Text("Welcome ${widget.username.toString()}!", textAlign: TextAlign.start, style: BlackBottomHeadStyle18500,),
                              const SizedBox(height: 10,),
                              const Text("We are all set to create an Account for you now!", style: greyDescItalicStyle,),
                              const SizedBox(height: 20,),
                              TextFormField(
                                controller:checkUserController ,
                                decoration: InputDecoration(
                                  // errorText: "",
                                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(color: Constants.textFieldBorder)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(color: Constants.textFieldBorder)
                                    ),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: const BorderSide(color: Constants.primaryColor1)),
                                    hintText: 'Enter a unique Account ID to name this account',
                                    hintStyle: greyHintStyle),
                                validator: (value) => value!.isEmpty || value == ""
                                    ? 'Enter your Account ID'
                                    : (nameRegExp.hasMatch(value)
                                    ? null
                                    : 'Enter a valid Account ID'),
                                onChanged: (value) {
                                  setState(() {
                                  });
                                },
                              ),

                              ShowAvailableName == false?SizedBox():
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10,),
                                  Text("Someone already has that Account ID. Try another ?", textAlign: TextAlign.left, style: Red12400,
                                  ),
                                  const SizedBox(height: 15,),
                                  const Text("Available Account IDs:",textAlign: TextAlign.left,style: BlackSubTitleStyle,),
                                  const SizedBox(height: 5,),
                                  SizedBox(
                                    height: 45,
                                    width: double.infinity,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: avalaibleUserName.length,
                                      itemBuilder: (context, index) {
                                        var data = avalaibleUserName[index];
                                        return InkWell(
                                          onTap: (){
                                            setState(() {
                                              isLoading = true;
                                            });
                                            var updateSubsribeDetails = {
                                              "id":widget.UserId.toString(),
                                              "username":data.toString(),
                                              "not_offering_reminder" :"true",
                                              "Offer_match_percentage": "0",
                                              "Want_to_sell" : "true",
                                              "Want_to_Buy" : "true",
                                              "Opt_Delivery" : "true",
                                              "Ok_for_Current_location_Offers" : "true",
                                              "Current_Location" :jsonEncode(offerAreas).toString(),
                                            };

                                            DrawAuraAPi().updateSubscriberProfileApi(data:updateSubsribeDetails).then((otpData) {

                                              if(otpData["status"]=="200"){
                                                SharePre.setUserId(otpData["result"]["id"].toString());
                                                SharePre.setUserName(otpData["result"]["username"].toString());
                                                SharePre.setUserMobile(otpData["result"]["phonenumber"].toString());
                                                SharePre.setUserEmail(otpData["result"]["email"].toString());
                                                SharePre.setUserImage(otpData["result"]["profile_picture"].toString());
                                                SharePre.setOfferingArea(otpData["result"]["Current_Location"].toString());
                                                SharePre.setUserDisplayName(otpData["result"]["displayname"].toString());
                                                SharePre.setUserIsPlaceType(otpData["result"]["placeORperson"].toString().toUpperCase().trim() == "PERSON" ? "false":"true");
                                                DataManager.getInstance().setuserId(otpData["result"]["id"].toString());
                                                DataManager.getInstance().setuserName(otpData["result"]["username"].toString());
                                                DataManager.getInstance().setphonedata(otpData["result"]["phonenumber"].toString());
                                                DataManager.getInstance().setuserEmail(otpData["result"]["email"].toString());
                                                DataManager.getInstance().setuserImage(otpData["result"]["profile_picture"].toString());
                                                DataManager.getInstance().setOfferArea(otpData["result"]["Current_Location"].toString());
                                                DataManager.getInstance().setUserDisplayName(otpData["result"]["displayname"].toString());
                                                DataManager.getInstance().setUserIsPlaceType(otpData["result"]["placeORperson"].toString().toUpperCase().trim() == "PERSON" ? "false":"true");
                                                DataManager.getInstance().setUserSecMobile(otpData["result"]["additionalnumber"].toString());
                                                SharePre.setUserSecMobile(otpData["result"]["additionalnumber"].toString());
                                                Fluttertoast.showToast(
                                                    msg: "${Url.AccountIDCreated}",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 2,
                                                    backgroundColor: Constants.primaryColor1,
                                                    textColor: Colors.white,
                                                    fontSize: 18.0
                                                );
                                                DrawAuraAPi().subscribePlanApi(userId:DataManager.getInstance().getuserId(),planId:"1").then((value) {
                                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ManageProfileScreen(From: "SignUp"),), (route) => false);
                                                });
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }else{
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                Fluttertoast.showToast(
                                                    msg: otpData["username"].toString(),
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 2,
                                                    backgroundColor: Constants.redColor,
                                                    textColor: Colors.white,
                                                    fontSize: 18.0
                                                );
                                              }
                                            });
                                          },
                                          child: Container(
                                            margin:const EdgeInsets.only(right: 10,top: 5,bottom: 5),
                                            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
                                            decoration: BoxDecoration(
                                              color:const Color(0xfffdfeae4),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text("${data.toString()}", style: BlackDescStyle,),
                                                const SizedBox(width: 15,),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                ],
                              ),
                              20.height,
                              checkUserController.text.isEmpty? Opacity(
                                opacity: 0.5,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(  isMobile ?width:tabWidth, 45),
                                        padding: const EdgeInsets.symmetric(horizontal: 10,),elevation: 0,
                                        backgroundColor:primaryColor),
                                    child: isLoading ?ButtonLoaderWhite(): Text("Create",style: WhiteButtonStyle,),
                                    onPressed: () {
                                      Fluttertoast.showToast(
                                          msg: "Please enter Account ID",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 18.0
                                      );
                                    }
                                ),
                              ):ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: Size(isMobile ?width:tabWidth, 40),
                                      padding: const EdgeInsets.symmetric(horizontal: 10,),elevation: 0,
                                      backgroundColor:primaryColor),
                                  child: isLoading ?ButtonLoaderWhite():  Text("Create",style: WhiteTitleStyle,),
                                  onPressed: () {

                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        ShowAvailableName = false;
                                        avalaibleUserName.clear();
                                        isLoading = true;
                                      });
                                      DrawAuraAPi().checkUserNameApi(userName: checkUserController.text.toString()).then((value) {

                                        if(value["status"]==200){
                                          if(value["is_available"] == true){
                                            var updateSubsribeDetails = {
                                              "id":widget.UserId.toString(),
                                              "username":checkUserController.text.toString(),
                                              "not_offering_reminder" :"true",
                                              "Offer_match_percentage": "0",
                                              "Want_to_sell" : "true",
                                              "Want_to_Buy" : "true",
                                              "Opt_Delivery" : "true",
                                              "Ok_for_Current_location_Offers" : "true",
                                              "Current_Location" :jsonEncode(offerAreas).toString(),
                                            };

                                            DrawAuraAPi().updateSubscriberProfileApi(data:updateSubsribeDetails).then((otpData) {
                                              print("updateSubscriberdata");
                                              print(otpData.toString());
                                              setState(() {
                                                isLoading = false;
                                              });
                                              if(otpData["status"]=="200"){
                                                Fluttertoast.showToast(
                                                    msg:  "${Url.AccountIDCreated}",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 2,
                                                    backgroundColor: Constants.primaryColor1,
                                                    textColor: Colors.white,
                                                    fontSize: 18.0
                                                );

                                                SharePre.setUserId(otpData["result"]["id"].toString());
                                                SharePre.setUserName(otpData["result"]["username"].toString());
                                                SharePre.setUserMobile(otpData["result"]["phonenumber"].toString());
                                                SharePre.setUserEmail(otpData["result"]["email"].toString());
                                                SharePre.setUserImage(otpData["result"]["profile_picture"].toString());
                                                SharePre.setOfferingArea(otpData["result"]["Current_Location"].toString());
                                                SharePre.setUserDisplayName(otpData["result"]["displayname"].toString());
                                                SharePre.setUserIsPlaceType(otpData["result"]["placeORperson"].toString().toUpperCase().trim() == "PERSON" ? "false":"true");
                                                DataManager.getInstance().setuserId(otpData["result"]["id"].toString());
                                                DataManager.getInstance().setuserName(otpData["result"]["username"].toString());
                                                DataManager.getInstance().setphonedata(otpData["result"]["phonenumber"].toString());
                                                DataManager.getInstance().setuserEmail(otpData["result"]["email"].toString());
                                                DataManager.getInstance().setuserImage(otpData["result"]["profile_picture"].toString());
                                                DataManager.getInstance().setOfferArea(otpData["result"]["Current_Location"].toString());
                                                DataManager.getInstance().setUserDisplayName(otpData["result"]["displayname"].toString());
                                                DataManager.getInstance().setUserIsPlaceType(otpData["result"]["placeORperson"].toString().toUpperCase().trim() == "PERSON" ? "false":"true");
                                                DataManager.getInstance().setUserSecMobile(otpData["result"]["additionalnumber"].toString());
                                                SharePre.setUserSecMobile(otpData["result"]["additionalnumber"].toString());
                                                DrawAuraAPi().subscribePlanApi(userId:DataManager.getInstance().getuserId(),planId:"1").then((value) {
                                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ManageProfileScreen(From: "SignUp"),), (route) => false);
                                                });
                                              }else{
                                                Fluttertoast.showToast(
                                                    msg: otpData["message"].toString(),
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 2,
                                                    backgroundColor: Constants.redColor,
                                                    textColor: Colors.white,
                                                    fontSize: 18.0
                                                );
                                              }
                                            });
                                          }else{

                                            for(var i = 0 ; i < value["related_name"].length; i++){
                                              setState(() {
                                                avalaibleUserName.add(value["related_name"][i].toString().trim());
                                              });
                                            }
                                            Future.delayed(Duration(seconds: 1),() {
                                              setState(() {
                                                ShowAvailableName = true;
                                                isLoading = false;
                                              });
                                            },);

                                            Constants.showToast(value["message"]);
                                          }
                                        }
                                      });
                                    }else{
                                      Constants.showToast("please enter a valid Account ID");
                                    }
                                  }
                              ),
                              const SizedBox(height: 20,),
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
