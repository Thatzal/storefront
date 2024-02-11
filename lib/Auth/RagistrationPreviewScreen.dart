import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Auth/RagistrationScreen.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loader.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/style.dart';


class RagistrationPreviewScreen extends StatefulWidget {
  String MobileNumber;
  RagistrationPreviewScreen({Key? key,required this.MobileNumber}) : super(key: key);
  @override
  State<RagistrationPreviewScreen> createState() => _RagistrationPreviewScreenState();
}

class _RagistrationPreviewScreenState extends State<RagistrationPreviewScreen> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
  if(mounted){
    setState(() {
      _phoneNoController.text = widget.MobileNumber.toString();
    });
  }
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
      body:responsiveContainer(
          context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Scaffold(
            backgroundColor:   primaryColor,
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: isMobile ?width:tabWidth,
                  color: primaryColor,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
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
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            height: MediaQuery.of(context).size.height * 0.45,
                            width: isMobile ?width:tabWidth,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    blurStyle: BlurStyle.inner,
                                  )
                                ]),
                            child: SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: Form(
                                key: globalKey,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                child: Column(children: [
                                  const SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text("Enter your details", style: BlackTitleStyle,),
                                    ],
                                  ),
                                  const SizedBox(height: 20,),
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
                                              readOnly: true,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              onChanged: (value){
                                                if(value.toString().length == 10){
                                                  setState(() {
                                                    FetchingAccount = true;
                                                  });

                                                }
                                                setState(() {

                                                });
                                              },
                                              style: BlackFieldStyleBold,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  counterText: "",
                                                  contentPadding: EdgeInsets.only(bottom: 0),
                                                  fillColor: Colors.transparent,
                                                  hintText: "Enter mobile Number",
                                                  hintStyle:greyHintStyle),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
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
                                  ),
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
                                        DrawAuraAPi().registrationApi(phonenumber:_phoneNoController.text,displayname:_userNameController.text.toString() ).then((value) {
                                              print(value);
                                          if(value!=null){
                                            try{
                                              if(value['status'] != 200){
                                                setState(() {
                                                  loader=false;
                                                });
                                              Constants.showToast("${value["message"]}");
                                              }else{
                                                setState(() {
                                                  loader=false;
                                                });
                                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  welcome_screen(username:_userNameController.text.toString(),UserId:value['result']["id"].toString()),));
                                              //  Navigator.push(context, MaterialPageRoute(builder: (context) =>  welcome_screen(username:widget.username.toString(),UserId: value["result"]["id"].toString()),));
                                              //   Navigator.push(context, MaterialPageRoute(builder: (context) => otp_screen(phone: _phoneNoController.text.toString(),username:_userNameController.text.toString(),otpVerify:value['OTP'].toString())));
                                              }
                                            }catch(e){
                                              print(e);
                                            }
                                          }
                                          else{
                                            setState(() {
                                              loader=false;
                                            });
                                            Fluttertoast.showToast(
                                                msg: "Server Error",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 2,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 18.0
                                            );
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
                                          backgroundColor: Constants.primaryColor1,
                                        ),
                                        onPressed: () {
                                        },
                                        child: const Text("Continue")),
                                  ),


                                  const SizedBox(height: 30,),
                                  // RichText(
                                  //   text: const TextSpan(
                                  //       children: [
                                  //         TextSpan(text: 'Connect & get your need:', style: PrimaryColor13500Style),
                                  //         TextSpan(text: ' whatever, wherever, whenever...', style: BlackColor13500Style),
                                  //         TextSpan(text: ' That’s all!', style: PrimaryColor13500Style)
                                  //       ]
                                  //   ),
                                  // ),

                                  Align(
                                    alignment: Alignment.center,
                                    child: RichText(
                                        text: TextSpan(style: TextStyle(color: Colors.black), children: [
                                          TextSpan(text: "By continuing you agree to the ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Constants.black)),
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
                                                  launchUrl(Uri.parse("https://docs.google.com/viewer?url=https://drawaura-bucket.s3.amazonaws.com/media/terms/Drawaura_TERMS_OF_USE_n104wxp.pdf"));
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
                                                  launchUrl(Uri.parse("https://docs.google.com/viewer?url=https://drawaura-bucket.s3.amazonaws.com/media/privacy/ThatzalTermsConditionAndPrivacyPolicy.pdf"));
                                                }),
                                        ])),
                                  ),

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
                ):SizedBox()
              ],
            ),
          )) ,
    );
  }
}
