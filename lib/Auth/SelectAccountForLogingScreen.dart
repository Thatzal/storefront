import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Auth/RagistrationPreviewScreen.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/loader.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/controller/share_preferences.dart';
import 'package:socialapps/screens/Dashboard/dashboard_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:socialapps/screens/widgets/alertDialogWithMessage.dart';
import '../Apis/urls.dart';
import 'login_screen.dart';
import '../common/style.dart';
import '../constant/constatnt.dart';
import '../model/GetUserAccountModal.dart';

class welcomeBack_screen extends StatefulWidget {
  String? phonenumber;

  welcomeBack_screen({Key? key,required this.phonenumber}) : super(key: key);

  @override
  State<welcomeBack_screen> createState() => _welcomeBack_screenState();
}

class _welcomeBack_screenState extends State<welcomeBack_screen> {


  bool loaderContinue = false;

  GetUserAccountResult? selectedUserValue;
  List <GetUserAccountResult>  getUserAccountList = [];
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  var _token='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetToken();
    load();
  }

  GetUserAccountModal ? UserAccountDetails;
  load(){
    DrawAuraAPi.getUserAccountsApi(MobileNumber: widget.phonenumber).then((value) {
      if(value["status"] == 200){
        if (mounted) {
          setState(() {
            UserAccountDetails = GetUserAccountModal.fromJson(value);
            getUserAccountList = UserAccountDetails!.result!.isEmpty?[]:UserAccountDetails!.result!;
            isGettingAcc = false;
          });
        }
      }
    });
  }
  bool isGettingAcc = true;
  bool butttonLoader =false;
  String SelectedUserId = "";

  GetToken(){
    Future.delayed(Duration.zero,() {
      FirebaseMessaging.instance.getToken().then((newToken){
        if(mounted){
          setState(() {
            _token = newToken!;
          });
        }

      });
    },);
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
            body:Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: isMobile ?width:tabWidth,
                  padding: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                  ),
                  // child: Column(
                  //   children: [
                  //     Center(
                  //       child: Image.asset(
                  //         "assets/Login_Banner_2.png",width: isMobile ?width:tabWidth,
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: isMobile ?width:tabWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          boxShadow:  [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 1,
                              blurRadius: 1,
                              blurStyle: BlurStyle.solid,
                            )
                          ]),
                      child: SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: isGettingAcc ?
                            Padding(
                              padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.2),
                              child: LoadingWidget(),
                            )
                            :Column(
                          crossAxisAlignment: CrossAxisAlignment.start  ,
                          children: [
                            const SizedBox(height: 40,),
                            Text("Welcome Back ${getUserAccountList.isEmpty?"": getUserAccountList.first.displayname.toString()} !", style: BlackBottomHeadStyle18500,),
                            const SizedBox(height: 10,),
                            const Text("Choose an account to start", style: greySubTitleStyle,),
                            const SizedBox(height: 20,),
                            SizedBox(
                              width: isMobile ?width:tabWidth,
                              child:  Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    hint: Text('Select Account ID',
                                        style: greyHintStyle
                                    ),
                                    items: getUserAccountList.map((item) => DropdownMenuItem<GetUserAccountResult>(
                                      value: item,
                                      child: Text(item.displayname.toString(), style: greyFieldStyle,),)
                                    ).toList(),
                                    value: selectedUserValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedUserValue = value;
                                        SelectedUserId = value!.id.toString();
                                      });
                                    },
                                    iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down_rounded,color:Constants.primaryColor1,)),
                                    buttonStyleData: ButtonStyleData(
                                      padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.grey.shade300)),
                                      height: 45,
                                      width: isMobile ?width:tabWidth,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: isMobile ?width*0.5:tabWidth*0.5,
                                      padding: null,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      elevation: 2,
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness: MaterialStateProperty.all(6.0),
                                      ),
                                      offset:  Offset( isMobile ?width*0.2:tabWidth*0.2, 0),
                                    ),
                                    menuItemStyleData:  MenuItemStyleData(
                                      selectedMenuItemBuilder: (context, child) {
                                        return Container(
                                          color: Colors.red,
                                        );
                                      },
                                      height: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),

                            ElevatedButton(
                              onPressed: () {
                                if(selectedUserValue == null){
                                  Constants.showToast("Please select Account ID");
                                }else{
                                  setState(() {
                                    loaderContinue=true;
                                  });
                                  var body = {
                                    "phonenumber" : widget.phonenumber.toString(),
                                    "username" : selectedUserValue!.username.toString(),
                                    "deviceToken" :_token == ""?"eyAia2lkIjogIjhZTDNHM1JSWDciIH0.eyAiaXNzIjogIkM4Nk5WOUpYM0QiLCAiaWF0IjogIjE0NTkxNDM1ODA2NTAiIH0.MEYCIQDzqyahmH1rz1s-LFNkylXEa2lZ_aOCX4daxxTZkVEGzwIhALvkClnx5m5eAT6Lxw7LZtEQcH6JENhJTMArwLf3sXwi": _token.toString()
                                  };
                                  DrawAuraAPi.CreateDataApi(ApiEndPoint: "login",body:body).then((otpData) {
                                    print(otpData);
                                    if(otpData["status"]=="200"){
                                      Constants.showToast(Url.LogInMessage);
                                      SharePre.setUserId(otpData["result"]["id"].toString());
                                      SharePre.setUserName(otpData["result"]["username"].toString());
                                      SharePre.setUserMobile(otpData["result"]["phonenumber"].toString());
                                      SharePre.setUserEmail(otpData["result"]["email"].toString());
                                      SharePre.setUserImage(otpData["result"]["profile_picture"].toString());
                                      SharePre.setOfferingArea(otpData["result"]["Current_Location"].toString());
                                      SharePre.setUserDisplayName(otpData["result"]["displayname"].toString());
                                      SharePre.setUserIsPlaceType(otpData["result"]["placeORperson"].toString().toUpperCase().trim() == "PERSON" ? "false":"true");
                                      SharePre.setOfferChoice(otpData["result"]["home_page_preferences"] == null? "": otpData["result"]["home_page_preferences"].toString());
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
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 2),), (route) => false);
                                      setState(() {
                                        loaderContinue=false;
                                      });
                                    }else{
                                      Fluttertoast.showToast(
                                          msg: otpData["message"].toString(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 18.0
                                      );
                                    }
                                    setState(() {
                                      loaderContinue=false;
                                    });
                                  });


                                }

                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size( isMobile ?width:tabWidth, 50),
                                  padding: const EdgeInsets.symmetric(horizontal: 10,),
                                  backgroundColor: Constants.primaryColor1,elevation: 0
                              ),
                              child: loaderContinue==true?const ButtonLoaderWhite():Text("Continue",style: WhiteButtonStyle,),
                            ),
                            const SizedBox(height: 40,),
                            selectedUserValue==null?
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size( isMobile ?width:tabWidth, 50),
                                    padding: const EdgeInsets.symmetric(horizontal: 10,),
                                    backgroundColor:Constants.primaryColor1,elevation: 0
                                ),
                                child: const Text("Create Another Account",style: WhiteButtonStyle,),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  RagistrationPreviewScreen(MobileNumber: widget.phonenumber.toString()),));
                                }):SizedBox(),
                            selectedUserValue != null ?   ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size( isMobile ?width:tabWidth, 50),
                                    padding: const EdgeInsets.symmetric(horizontal: 10,),
                                    backgroundColor:Constants.primaryColor1,elevation: 0
                                ),
                                child: const Text("Delete Account",style: WhiteButtonStyle,),
                                onPressed: () {
                                  showDeleteAccountDialog(context,"LogIn",selectedUserValue!.id.toString(),_token).then((v) {
                                    DrawAuraAPi.getUserAccountsApi(MobileNumber: widget.phonenumber).then((value) async {
                                      if(value["status"] == 200){
                                        if(value["result"].isEmpty){
                                          final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
                                          sharedpreferences.clear();
                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login_screen(isGuestUser: false),), (route) => false);
                                        }else{
                                          if (mounted) {
                                            setState(() {
                                              UserAccountDetails = GetUserAccountModal.fromJson(value);
                                              getUserAccountList = UserAccountDetails!.result!.isEmpty?[]:UserAccountDetails!.result!;
                                              isGettingAcc = false;
                                            });
                                          }
                                        }
                                      }
                                    });
                                    setState(() {
                                      selectedUserValue = null;
                                    });
                                  });
                                }) :SizedBox()

                          ],
                        ),
                      )),
                )
              ],
            ),
          )

      ),
    );
  }
}
