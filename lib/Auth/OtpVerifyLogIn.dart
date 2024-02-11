import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/model/GetUserAccountModal.dart';
import 'package:socialapps/Auth/SelectAccountForLogingScreen.dart';
import '../../../Auth/login_screen.dart';
import '../../../common/style.dart';
import '../../../constant/constatnt.dart';



class OtpVerfiyForLoginAndManageAccount extends StatefulWidget {

  String? phonenumber;
  // String s_key;

  List<GetUserAccountResult>? getUserAccountList;
  String ? GenerateOTP;
  OtpVerfiyForLoginAndManageAccount({Key? key,required this.phonenumber,required this.getUserAccountList,required this.GenerateOTP}) : super(key: key);

  @override
  State<OtpVerfiyForLoginAndManageAccount> createState() => _OtpVerfiyForLoginAndManageAccountState();
}

class _OtpVerfiyForLoginAndManageAccountState extends State<OtpVerfiyForLoginAndManageAccount> {

  TextEditingController _otpController = TextEditingController();
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
      if(mounted){
        setState(() {
          isOTPExpired = true;
        });
      }
    },);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    if(mounted){
      setState(() {
        GenerateOTP = widget.GenerateOTP.toString().trim();
      });
    }
  }

  bool isLoadingVerify = false;
  String GenerateOTP = "";
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
            backgroundColor: Color(0xFF1FBB3A),
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.65,
                    width: isMobile ?width:tabWidth,
                    decoration: const BoxDecoration(
                      //color: Color(0xFF1FBB3A),
                        gradient: LinearGradient(
                            colors: [
                          Color(0xFF147999),
                          Color(0xFF239cc1),
                          Color(0xFF2baed0),
                          Color(0xFF3ecbe9),
                        ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight
                        ),

                        image: DecorationImage(image: AssetImage("assets/Login_Banner_1.png"),fit: BoxFit.contain)
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 40,),
                                const Text("OTP Verification for Phone", style: BlackTitleBold,),
                                const SizedBox(height: 5,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:  [
                                    const Text('A verification code sent on ', style:BlackDescStyle,),
                                    Text("+91 ${widget.phonenumber}",style:BlackTitleStyle,),
                                    const SizedBox(width: 5),
                                    InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => login_screen(isGuestUser: false),));
                                        },
                                        child: const Icon(Icons.edit_outlined,color: Constants.primaryColor1,size: 20,))
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     const Text('OTP - ', style:BlackFieldStyle,),
                                //     Text("${widget.otp.toString()}",style:BlackTitleStyle,),
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
                                      borderRadius: BorderRadius.circular(2),
                                      errorBorderColor: Colors.black54,
                                      fieldHeight: 45,
                                      fieldWidth: 50,
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
                                  onChanged: (value) {},
                                  onCompleted: (value) async {
                                    if(isOTPExpired){
                                       Constants.showToast("OTP Expired");
                                    }else{
                                      setState(() {
                                        isLoadingVerify = true;
                                      });
                                      if(GenerateOTP.toString().trim() == _otpController.text.toString().trim()){
                                        setState(() {
                                          isLoadingVerify = false;
                                        });
                                        Constants.showToast(Url.OTPVerified);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => welcomeBack_screen(phonenumber: widget.phonenumber ),));
                                      }else{
                                        setState(() {
                                          isLoadingVerify = false;
                                        });
                                        Constants.showToast("INVALID OTP");
                                      }
                                    }
                                    // var body = {
                                    //   "phonenumber":widget.phonenumber.toString(),
                                    //   "otp":_otpController.text.toString(),
                                    //   // "s_key" : widget.s_key.toString()
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
                                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => welcomeBack_screen(phonenumber: widget.phonenumber ),));
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
                                            if(widget.phonenumber.toString() == "9876543210"){
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
                                                "phonenumber" :  widget.phonenumber.toString(),
                                                "otp" : randomOTP.toString()
                                              };
                                              setState(() {
                                                GenerateOTP = randomOTP.toString();
                                              });
                                              DrawAuraAPi.CreateDataApi(ApiEndPoint: "${ApiUrls.sendOtpV2}",body:body).then((value) {
                                                if(value["status"] == "200"){
                                                  Constants.showToast("${value["message"].toString()}");
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
                          width: isMobile ?width:tabWidth,
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
          )),
    );
  }
}
