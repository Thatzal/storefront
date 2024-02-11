import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapps/Apis/CommonApis.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/Auth/OtpVerifyLogIn.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loader.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/controller/share_preferences.dart';
import 'package:socialapps/model/GetUserAccountModal.dart';
import 'package:socialapps/screens/Dashboard/dashboard_screen.dart';
import 'package:socialapps/screens/widgets/TermsAndConditionsAgree.dart';
import 'package:socialapps/screens/widgets/PrivacyPolicyAgree.dart';
import '../common/style.dart';
import 'otp_screen.dart';



class login_screen extends StatefulWidget {
  bool isGuestUser;
  login_screen({Key? key,required this.isGuestUser}) : super(key: key);
  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  FocusNode myfocus = FocusNode();
  bool loader = false;
  bool focusBotton = false;
  final  _phoneNoController = TextEditingController();
  final  _userNameController = TextEditingController();
  bool FetchingAccount = false;
  bool isShowDisplayName = false;
  GlobalKey<FormState> globalKey=GlobalKey<FormState>();
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    bool isMobile = ResponsiveHelper.isMobile(context);
    return Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body:responsiveContainer(
          context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Scaffold(
            appBar: AppBar(toolbarHeight: 0,elevation: 0,backgroundColor:   primaryColor,),
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: isMobile ?width:tabWidth,
                  color: primaryColor,
                  child: Stack(
                    children: [
                      Positioned(
                        top:  0,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.5,
                          width: isMobile ?width:tabWidth,
                          decoration: const BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/Login_Banner_3.png"),fit: BoxFit.contain)
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                            padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            height: MediaQuery.of(context).size.height * 0.45,
                            width: isMobile ?width:tabWidth,
                            decoration:  BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    blurStyle: BlurStyle.solid,
                                  )
                                ]),
                            child: SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: Form(
                                key: globalKey,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                child: Column(children: [
                                  const SizedBox(height: 30,),
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(width: 1, color: Constants.borderColor),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0.2),
                                      //     spreadRadius: 0,
                                      //     blurRadius: 0,
                                      //     offset: Offset(0, 2), // changes position of shadow
                                      //   ),
                                      // ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "+91",
                                            style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.7), fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          SizedBox(
                                            height: 50,
                                            child: VerticalDivider(
                                              color: Constants.borderColor,
                                              width: 1,
                                              thickness: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                              maxLength: 10,
                                              controller: _phoneNoController,
                                              autofocus: false,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              onChanged: (value){
                                                if(value.toString().length == 10){
                                                  setState(() {
                                                    FetchingAccount = true;
                                                  });
                                                  DrawAuraAPi.getUserAccountsApi(MobileNumber:_phoneNoController.text).then((value) {
                                                    print(value);
                                                    if(value["status"] == 200){
                                                      if (mounted) {
                                                        GetUserAccountModal ? UserAccountDetails;
                                                        List<GetUserAccountResult> getUserAccountList=[];
                                                        UserAccountDetails = GetUserAccountModal.fromJson(value);
                                                        getUserAccountList = UserAccountDetails.result!;
                                                        if(getUserAccountList.isNotEmpty){
                                                          if(_phoneNoController.text.toString() == "9876543210"){
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerfiyForLoginAndManageAccount(phonenumber: _phoneNoController.text.toString(),getUserAccountList:getUserAccountList,GenerateOTP: "123456"),))  ;
                                                          }else{
                                                            int randomOTP = Random().nextInt(900000) + 100000;
                                                            var body = {
                                                              "phonenumber" :  _phoneNoController.text.toString(),
                                                              "otp" : randomOTP.toString()
                                                            };

                                                            DrawAuraAPi.CreateDataApi(ApiEndPoint: "${ApiUrls.sendOtpV2}",body:body).then((value) {
                                                              if(value["status"] == "200"){
                                                                Constants.showToast("${value["message"]}".toUpperCase());
                                                                setState(() {
                                                                  FetchingAccount = false;
                                                                });
                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerfiyForLoginAndManageAccount(phonenumber: value["phonenumber"],getUserAccountList:getUserAccountList,GenerateOTP: randomOTP.toString()),))  ;
                                                              }
                                                            });
                                                          }
                                                        }
                                                        else{
                                                          setState(() {
                                                            FetchingAccount = false;
                                                            isShowDisplayName = true;
                                                          });
                                                          Constants.showToast("Please enter your display name and continue");
                                                        }
                                                        setState(() {
                                                          FetchingAccount = false;
                                                        });
                                                      }

                                                    } else{
                                                      Fluttertoast.showToast(
                                                          msg: value.message.toString(),
                                                          toastLength: Toast.LENGTH_SHORT,
                                                          gravity: ToastGravity.BOTTOM,
                                                          timeInSecForIosWeb: 2,
                                                          backgroundColor: Colors.red,
                                                          textColor: Colors.white,
                                                          fontSize: 18.0
                                                      );
                                                      setState(() {
                                                        FetchingAccount = false;
                                                      });
                                                    }
                                                  });
                                                }
                                                setState(() {});
                                              },
                                              style: BlackFieldStyleBold,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  counterText: "",
                                                  contentPadding: EdgeInsets.only(bottom: 0),
                                                  fillColor: Colors.transparent,
                                                  hintText: "Enter mobile Number",
                                                  hintStyle:greyDescItalicStyle),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20,),
                                isShowDisplayName ?
                                  TextFormField(
                                      focusNode: myfocus,
                                      controller: _userNameController,
                                      onChanged: (value) {
                                        setState(() {
                                          focusBotton=true;
                                        });
                                      },
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        hintText: 'Enter your name (Display name)',
                                        enabledBorder:  OutlineInputBorder(borderSide: const BorderSide(color: Constants.borderColor),borderRadius: BorderRadius.circular(5)),
                                        hintStyle: greyHintStyle,
                                        errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(5)),
                                        border:  OutlineInputBorder(borderSide: const BorderSide(color: Constants.borderColor),borderRadius: BorderRadius.circular(5)),
                                        focusedErrorBorder:OutlineInputBorder(borderSide: const BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(5)),
                                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Constants.primaryColor1),borderRadius: BorderRadius.circular(5)),),

                                      validator: (value) => value!.isEmpty || value == ""
                                          ? 'Enter your display name'
                                          : (nameRegExp.hasMatch(value)
                                          ? null
                                          : 'Enter a valid display name')
                                  ):
                                  const SizedBox(),
                                  const SizedBox(height: 20,),
                                  focusBotton==true&&_userNameController.text.length!=0?
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size( isMobile ?width:tabWidth, 50),
                                      padding: const EdgeInsets.symmetric(horizontal: 10,),
                                      backgroundColor: Constants.primaryColor1,
                                    ),
                                    onPressed: () {
                                      // DataManager.getInstance().setphonedata(_phoneNoController.text);
                                      if(globalKey.currentState!.validate()){
                                        setState(() {
                                          loader=true;
                                        });
                                        DrawAuraAPi().registrationApi(phonenumber:_phoneNoController.text,displayname: _userNameController.text.toString()).then((value) {
                                              print(value);
                                              try{
                                                if(value['status'] != 200){
                                                  print("status");
                                                  setState(() {
                                                    loader=false;
                                                  });
                                                  Constants.showToast("${value["message"]}");
                                                }else{
                                                  if(_phoneNoController.text.toString() == "9876543210"){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => otp_screen(phone: _phoneNoController.text.toString(),username:_userNameController.text.toString(),UserID: value['result']["id"].toString(),GenerateOTP: "123456",)));
                                                  }else{
                                                    int randomOTP = Random().nextInt(900000) + 100000;
                                                    var body = {
                                                      "phonenumber" :  _phoneNoController.text.toString(),
                                                      "otp" : randomOTP.toString()
                                                    };
                                                    DrawAuraAPi.CreateDataApi(ApiEndPoint: "${ApiUrls.sendOtpV2}",body:body).then((OtpData) {
                                                      if(OtpData["status"] == "200"){
                                              //          Constants.showToast("${OtpData["message"]}");
                                                        Constants.showToast("TEST");
                                                        setState(() {
                                                          loader = false;
                                                        });
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => otp_screen(phone: _phoneNoController.text.toString(),username:_userNameController.text.toString(),UserID: value['result']["id"].toString(),GenerateOTP: randomOTP.toString(),)));
                                                      }
                                                    });
                                                  }

                                                  // var body = {
                                                  //   "phonenumber" :  _phoneNoController.text.toString()
                                                  // };
                                                  // DrawAuraAPi.CreateDataApi(ApiEndPoint: "sendOtp",body:body).then((OtpData) {
                                                  //   if(OtpData["status"] == "200"){
                                                  //     Constants.showToast("${OtpData["message"]}");
                                                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => otp_screen(phone: _phoneNoController.text.toString(),username:_userNameController.text.toString(),UserID: value['result']["id"].toString())));
                                                  //   }
                                                  //   setState(() {
                                                  //     loader=false;
                                                  //   });
                                                  // });
                                                }
                                              }catch(e){
                                                print(e);
                                              }
                                        });
                                      }
                                    },
                                    child: loader==false?Text("Continue"):ButtonLoaderWhite(),
                                  ):
                                  Opacity(
                                    opacity: 0.5,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(isMobile ?width:tabWidth, 50),
                                          padding: const EdgeInsets.symmetric(horizontal: 10,),
                                          backgroundColor: primaryColor,
                                        ),
                                        onPressed: () {
                                        },
                                        child: const Text("Continue")),
                                  ),
                                  const SizedBox(height: 10,),
                                  RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(style: TextStyle(color: Colors.black), children: [
                                        TextSpan(text: "By continuing, you agree to the Drawaura-Thatzal's", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Constants.black)),
                                        TextSpan(
                                            text: "Terms of service ",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Constants.primaryColor1,
                                              decoration: TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  TermsAndConditionAgree(From: "LogIn"),));
                                              }),
                                        TextSpan(text: "and ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color:  Constants.black)),
                                        TextSpan(
                                            text: "Privacy policy.",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Constants.primaryColor1,
                                              decoration: TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  PrivacyPolicyAgree(From: "LogIn"),));
                                              }),
                                      ])),
                                  // Row(
                                  //   children: [
                                  //     InkWell(
                                  //         onTap: (){
                                  //
                                  //           if(_phoneNoController.text.length ==10){
                                  //
                                  //             DrawAuraAPi.getUserAccountsApi(MobileNumber:_phoneNoController.text).then((value) {
                                  //               if(value["status"] == 200){
                                  //
                                  //                 GetUserAccountModal ? UserAccountDetails;
                                  //                 List<GetUserAccountResult> getUserAccountList=[];
                                  //                 UserAccountDetails = GetUserAccountModal.fromJson(value);
                                  //                 getUserAccountList = UserAccountDetails.result!;
                                  //                 if(getUserAccountList.isNotEmpty){
                                  //                   setState(() {
                                  //                     FetchingAccount = true;
                                  //                   });
                                  //                   var body = {
                                  //                     "phonenumber" :  _phoneNoController.text.toString()
                                  //                   };
                                  //                   DrawAuraAPi.CreateDataApi(ApiEndPoint: "sendOtp",body:body).then((value) {
                                  //                     if(value["status"] == "200"){
                                  //                       Constants.showToast("${value["message"]}");
                                  //                       setState(() {
                                  //                         FetchingAccount = false;
                                  //                       });
                                  //                       Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerfiyForLoginAndManageAccount(phonenumber: value["phonenumber"],getUserAccountList: getUserAccountList),))  ;
                                  //                     }
                                  //                   });
                                  //                 }else{
                                  //                   Constants.showToast("Phone number not found, please sign-up");
                                  //                 }
                                  //
                                  //               } else{
                                  //                 Fluttertoast.showToast(
                                  //                     msg: value.message.toString(),
                                  //                     toastLength: Toast.LENGTH_SHORT,
                                  //                     gravity: ToastGravity.BOTTOM,
                                  //                     timeInSecForIosWeb: 2,
                                  //                     backgroundColor: Colors.red,
                                  //                     textColor: Colors.white,
                                  //                     fontSize: 18.0
                                  //                 );
                                  //                 setState(() {
                                  //                   loader=true;
                                  //                 });
                                  //               }
                                  //             });
                                  //             //
                                  //           }else{
                                  //             Fluttertoast.showToast(
                                  //                 msg: "Please Enter Valid Number",
                                  //                 toastLength: Toast.LENGTH_SHORT,
                                  //                 gravity: ToastGravity.BOTTOM,
                                  //                 timeInSecForIosWeb: 2,
                                  //                 backgroundColor: Colors.red,
                                  //                 textColor: Colors.white,
                                  //                 fontSize: 18.0
                                  //             );
                                  //           }
                                  //         },
                                  //         child: const Text("Login ",style: BlackTitleBold,)),
                                  //     const Text("or", style: greytitleStyle,),
                                  //     InkWell(
                                  //         onTap: (){
                                  //           if(_userNameController.text.isEmpty){
                                  //             Constants.showToast("Please type your name (display name) to proceed");
                                  //           }else{
                                  //             Constants.showToast("Please click on continue to proceed");
                                  //           }
                                  //
                                  //         },
                                  //         child: const Text(" Sign-up", style: BlackTitleBold,))
                                  //   ],
                                  // ),
                                  const SizedBox(height: 60,),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: const TextSpan(
                                        children: [
                                          TextSpan(text: "You r Market, ", style: PrimaryColorStyle16500),
                                          TextSpan(text: " that's all.", style: PrimaryColorStyle16500)
                                        ]
                                    ),
                                  ),
                                  const SizedBox(height: 10,),


                                ]
                                ),
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                ),
                FetchingAccount?  Container(
                  height: MediaQuery.of(context).size.height,
                  width:   isMobile ?width:tabWidth,
                  color: Colors.black12,
                  child: Center(
                    child: LoadingWidget(),
                  ),
                ):SizedBox(),
                widget.isGuestUser?SizedBox():  Positioned(
                    top:20,right:25,
                    child: InkWell(
                      onTap:(){
                        SharePre.setUserId("1");
                        DataManager.getInstance().setuserId("1");
                        SharePre.setUserMobile("null");
                        SharePre.setUserImage("null");
                        SharePre.setOfferingArea("null");
                        DataManager.getInstance().setphonedata("null");
                        DataManager.getInstance().setuserImage("null");
                        DataManager.getInstance().setOfferArea("null");

                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 2),), (route) => false);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white24,
                        radius: 15,
                        child: Icon(Icons.close,color: Colors.white,size: 23,),
                      ),
                    ))
              ],
            ),
          )) ,
    );
  }
}
