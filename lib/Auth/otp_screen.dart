
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/Auth/RagistrationScreen.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../common/ResponsiveBuilder.dart';
import '../common/style.dart';
import '../constant/constatnt.dart';


class otp_screen extends StatefulWidget {
  String? phone;
  String? username;
  String ?UserID;
  String ? GenerateOTP;
  otp_screen({super.key, required this.phone,this.username,required this.UserID,required this.GenerateOTP});
  @override
  State<otp_screen> createState() => _otp_screenState();
}
class _otp_screenState extends State<otp_screen> {

  // var otpData;
  bool isTimerOn = true;
  bool isShowResendOTP = false;
  int codeRemainingSeconds = 60;
  bool isOTPExpired = false;
  late Timer timer;
  void startTimer() {
    codeRemainingSeconds = 60;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec, (Timer timer) {
      if(mounted){
        setState(() {
          if (codeRemainingSeconds == 0) {
            isTimerOn = false;
            isShowResendOTP = true;
            timer.cancel();
          } else {
            codeRemainingSeconds--;
          }
        });
      }
    },
    );
    Future.delayed(Duration(seconds: 120),() {
      setState(() {
        isOTPExpired = true;
      });
    },);
  }

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
    if(mounted){
      setState(() {
        GenerateOTP = widget.GenerateOTP.toString().trim();
      });
    }
  }
  String GenerateOTP = "";
  // load(){
  //   DrawAuraAPi().otpVerifyApi(otp:widget.otpVerify.toString(),phonenumber: widget.phone.toString(),displayName:widget.username).then((value) {
  //     setState(() {
  //       otpData=value;
  //     });
  //   },);
  // }

  TextEditingController _otpController = TextEditingController();
  bool isLoadingVerify = false;
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
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.6,
                    width: isMobile ?width:tabWidth,
                    decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/Login_Banner_2.png"),fit: BoxFit.cover)
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back,color: Colors.white,)),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Stack(
                    children: [
                          Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          height: MediaQuery.of(context).size.height*0.4,
                          width: MediaQuery.of(context).size.width,
                          decoration:  BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  blurStyle: BlurStyle.solid,
                                )
                              ]),
                          child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20,),
                                const Text("OTP Verification for Phone", style: BlackTitleBold,),
                                const SizedBox(height: 5,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:  [
                                    const Text('A verification code sent on ', style:BlackDescStyle,),
                                    Text("+91 ${widget.phone.toString()}",style:BlackTitleStyle,),
                                    const SizedBox(width: 2),
                                    InkWell(
                                        onTap: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: const Icon(Icons.edit_outlined,color: Constants.primaryColor1,size: 20,))
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     const Text('OTP - ', style:BlackFieldStyle,),
                                //     Text("${widget.otpVerify.toString()}",style:BlackTitleStyle,),
                                //   ],
                                // ),
                                const SizedBox(height: 20,),
                                PinCodeTextField(
                                  appContext: context,
                                  length: 6,
                                  obscureText: false,
                                  autoFocus:  true,
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                    // fieldOuterPadding: EdgeInsets.all(5),
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(5),
                                      errorBorderColor: Colors.black54,
                                      fieldHeight: 45,
                                      fieldWidth: 45,
                                      activeFillColor: Colors.white,
                                      activeColor: Constants.primaryColor1,
                                      borderWidth: 1,
                                      selectedColor: Colors.black54,
                                      disabledColor: Colors.black54,
                                      inactiveColor: Constants.lightGreen,
                                      inactiveFillColor: Colors.white,
                                      selectedFillColor: Colors.white
                                  ),
                                  autovalidateMode: AutovalidateMode.always,
                                  cursorColor: Constants.greyLight,
                                  textStyle: darkgreyFieldStyle20400,
                                  enableActiveFill: true,
                                  enablePinAutofill: true,
                                  controller: _otpController ,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                  },
                                  onCompleted: (value) async {
                                    if(isOTPExpired){
                                      Constants.showToast("OTP expired");
                                    }else{
                                      setState(() {
                                        isLoadingVerify = true;
                                      });
                                      if(GenerateOTP.toString().trim() == _otpController.text.toString().trim()){
                                        setState(() {
                                          isLoadingVerify = false;
                                        });
                                        Constants.showToast(Url.OTPVerified);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  welcome_screen(username:widget.username.toString(),UserId:widget.UserID.toString()),));
                                      }else{
                                        setState(() {
                                          isLoadingVerify = false;
                                        });
                                        Constants.showToast("Invalid OTP");
                                      }
                                    }
                                    // setState(() {
                                    //   isLoadingVerify = true;
                                    // });
                                    //
                                    // var body = {
                                    //   "phonenumber":widget.phone.toString(),
                                    //   "otp":_otpController.text.toString(),
                                    //   // "s_key":widget.s_key.toString()
                                    // };
                                    // print(body);
                                    // DrawAuraAPi.CreateDataApi(ApiEndPoint: "verifyLoginOTP",body: body).then((value) {
                                    //   print(value);
                                    //   if(value["verified"] == true){
                                    //     Fluttertoast.showToast(
                                    //         msg:"${value["message"]}",
                                    //         toastLength: Toast.LENGTH_SHORT,
                                    //         gravity: ToastGravity.BOTTOM,
                                    //         timeInSecForIosWeb: 2,
                                    //         backgroundColor:Constants.primaryColor1,
                                    //         textColor: Colors.white,
                                    //         fontSize: 18.0
                                    //     );
                                    //
                                    //     Navigator.push(context, MaterialPageRoute(builder: (context) =>  welcome_screen(username:widget.username.toString(),UserId:widget.UserID.toString()),));
                                    //
                                    //   }else{
                                    //     Fluttertoast.showToast(
                                    //         msg:"${value["message"]}",
                                    //         toastLength: Toast.LENGTH_SHORT,
                                    //         gravity: ToastGravity.BOTTOM,
                                    //         timeInSecForIosWeb: 2,
                                    //         backgroundColor: Colors.red,
                                    //         textColor: Colors.white,
                                    //         fontSize: 18.0
                                    //     );
                                    //   }
                                    //   setState(() {
                                    //     isLoadingVerify = false;
                                    //   });
                                    // });




                                    // var body = {
                                    //   "phonenumber":widget.phone.toString().trim(),
                                    //   "otp":_otpController.text.toString().trim(),
                                    //   "displayname":widget.username.toString().trim()
                                    // };
                                    //
                                    // DrawAuraAPi.CreateDataApi(ApiEndPoint: "verifyOTP",body: body).then((value) {
                                    //   if(value["status"] == 200){
                                    //     Fluttertoast.showToast(
                                    //         msg: value["message"].toString(),
                                    //         toastLength: Toast.LENGTH_SHORT,
                                    //         gravity: ToastGravity.BOTTOM,
                                    //         timeInSecForIosWeb: 2,
                                    //         backgroundColor: Constants.primaryColor,
                                    //         textColor: Colors.white,
                                    //         fontSize: 18.0
                                    //     );
                                    //     // if(otpData["type"]=="exist"){
                                    //     //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  Dashboard_screen(backIndex:2,),));
                                    //     // }else{
                                    //     Navigator.push(context, MaterialPageRoute(builder: (context) =>  welcome_screen(username:widget.username.toString(),UserId: value["result"]["id"].toString()),));
                                    //     // }
                                    //
                                    //   }else{
                                    //     Fluttertoast.showToast(
                                    //         msg: value["message"].toString(),
                                    //         toastLength: Toast.LENGTH_SHORT,
                                    //         gravity: ToastGravity.BOTTOM,
                                    //         timeInSecForIosWeb: 2,
                                    //         backgroundColor: Colors.red,
                                    //         textColor: Colors.white,
                                    //         fontSize: 18.0
                                    //     );
                                    //   }
                                    //   setState(() {
                                    //     isLoadingVerify = false;
                                    //   });
                                    // });
                                  },
                                  beforeTextPaste: (text) {
                                    return true;
                                  },

                                  autoDisposeControllers: false,
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(fixedSize: Size(  isMobile ?width*0.32:tabWidth*0.32, 35), backgroundColor: primaryColor,elevation: 0),
                                          onPressed:  isTimerOn?(){
                                            Constants.showToast("Please wait");
                                          }: () {
                                            if(widget.phone.toString() == "9876543210"){
                                              setState(() {
                                                GenerateOTP = "123456";
                                              });
                                            }else{
                                              setState(() {
                                                isTimerOn = true;
                                                isShowResendOTP = false;
                                                isOTPExpired = false;
                                              });
                                              startTimer();
                                              int randomOTP = Random().nextInt(900000) + 100000;
                                              var body = {
                                                "phonenumber" :  widget.phone.toString(),
                                                "otp" : randomOTP.toString()
                                              };
                                              setState(() {
                                                GenerateOTP = randomOTP.toString();
                                              });
                                              DrawAuraAPi.CreateDataApi(ApiEndPoint: "${ApiUrls.sendOtpV2}",body:body).then((value) {
                                                if(value["status"] == "200"){
                                                  Constants.showToast("${value["message"]}".toUpperCase());
                                                }else{
                                                  Constants.showToast("${value["message"]}");
                                                }
                                              });
                                            }
                                          },
                                          child:
                                          // isTimerOn?
                                          // Center(
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.center,
                                          //     children: [
                                          //       SizedBox(
                                          //         width: 30,
                                          //         child: Text(
                                          //           "${codeRemainingSeconds}",
                                          //           style: White13500Style
                                          //         ),
                                          //       ),
                                          //       Text(
                                          //         ' Seconds',
                                          //         style: White13500Style,
                                          //       )
                                          //     ],
                                          //   ),
                                          // ):
                                          Text("Resend OTP",style: White13500Style,)),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          )),
                      isLoadingVerify == true?   Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          height: MediaQuery.of(context).size.height*0.4,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(45),
                                  topRight: Radius.circular(45)),
                           ),
                          child:Center(
                            child: LoadingWidget(),
                          )

                      ) :SizedBox(),
                        ],

                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
