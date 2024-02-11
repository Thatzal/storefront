import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/Auth/login_screen.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loader.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/GetUserAccountModal.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/controller/share_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapps/screens/Dashboard/dashboard_screen.dart';
Future<void> showDeleteAccountDialog(BuildContext context,String From,String UserID,String Token) async {
  bool accountSwitchLoader = false;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
    return StatefulBuilder(builder: (context, setDialogState) {
      return Dialog(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 16,
          insetPadding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isMobile(context)?20:ResponsiveHelper.TabModeWidth*0.35),
          child: Stack(
            children: [
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:0,bottom: 10),
                    child: Text('Delete Account?',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),textAlign: TextAlign.center),
                  ),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "",
                        style: TextStyle(color: Colors.black87,fontSize: 13,fontWeight: FontWeight.w400),
                        children: const <TextSpan>[
                          TextSpan(text: "Account will be removed permanently",style: TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.w500)),
                          // TextSpan(text: " \nYou can't Undo this action.",style: TextStyle(color: Colors.black87,fontSize: 13,fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color:Color(0xFFFFEDEA),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width:ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width*0.8:ResponsiveHelper.TabModeWidth*0.8,
                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.warning_rounded,color:Color(0xFFf35627) ,),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 3,),
                                      Text("Warning",style: TextStyle(color: Color(0xFFA85346),fontSize: 14,fontWeight: FontWeight.w500),),
                                      SizedBox(
                                          width: ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width*0.65:ResponsiveHelper.TabModeWidth*0.65,
                                          child: Text( "Your account will be deleted in 15 days from the request for closure and all details will also be removed from our database. You will not able undo the data.",style: TextStyle(color: Color(0xFFC05D44),fontSize: 12,fontWeight: FontWeight.w400),)),
                                    ],
                                  )
                                ],
                              )
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              //padding: EdgeInsets.only(left: 10),
                              // margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              decoration: BoxDecoration(
                                color:Color(0xFFf35627),
                                borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
                              ),
                              width: 3.5,
                              height: 70,
                            ),)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () async{
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            fixedSize: Size(ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width*0.3:ResponsiveHelper.TabModeWidth*0.3, 35),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),side: BorderSide(color: Constants.primaryColor1,width: 1)

                            ),
                          ),
                          child: Center(child: const Text("Cancel",style:TextStyle(color: Constants.primaryColor1,fontWeight: FontWeight.w400,fontSize: 14),))),
                      ElevatedButton(
                          onPressed: (){
                            setDialogState(() {
                              accountSwitchLoader = true;
                            });
                            var body = {
                              "user_id" : UserID,
                            };
                            DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "deleteSubscriber").then((value) async {
                              print(value);


                              if(value["status"] == 200){
                                Constants.showToast("Account deleted".toUpperCase());
                                if(From == "LogIn"){
                                  Navigator.pop(context);
                                  setDialogState(() {
                                    accountSwitchLoader= false;
                                  });
                                } else{
                                  final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
                                  sharedpreferences.clear();

                                  DrawAuraAPi.getUserAccountsApi(MobileNumber: DataManager.getInstance().getphonedata().toString()).then((value) async {
                                    if(value["status"] == 200){
                                      GetUserAccountModal   UserAccountDetails = GetUserAccountModal.fromJson(value);
                                      List <GetUserAccountResult> getUserAccountList = UserAccountDetails.result!.isEmpty ? []: UserAccountDetails.result!;

                                      if(getUserAccountList.isEmpty){
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login_screen(isGuestUser: false),), (route) => false);
                                      }else{
                                        GetUserAccountResult firstAccount = getUserAccountList.first;
                                        DrawAuraAPi().loginApi(phonenumber: firstAccount.phonenumber, username: firstAccount.username.toString(),
                                            deviceToken: Token == "" || Token == "null"
                                                ? "eyAia2lkIjogIjhZTDNHM1JSWDciIH0.eyAiaXNzIjogIkM4Nk5WOUpYM0QiLCAiaWF0IjogIjE0NTkxNDM1ODA2NTAiIH0.MEYCIQDzqyahmH1rz1s-LFNkylXEa2lZ_aOCX4daxxTZkVEGzwIhALvkClnx5m5eAT6Lxw7LZtEQcH6JENhJTMArwLf3sXwi"
                                                : Token.toString())
                                            .then((loginRes) async {
                                          print(loginRes);
                                          var body = {
                                            "id": DataManager.getInstance().getuserId().toString(),
                                            "deviceToken": "",
                                          };
                                          final SharedPreferences sharedpreferences =
                                          await SharedPreferences.getInstance();
                                          sharedpreferences.clear();
                                          DrawAuraAPi.CreateDataApi(
                                              ApiEndPoint: "updateSubscriberProfile", body: body);
                                          DrawAuraAPi.getSubscriberDetailsApi(
                                              userId: firstAccount.id.toString()).then((OtpRes) {
                                            SharePre.setUserId(OtpRes["result"]["id"].toString());
                                            SharePre.setUserName(OtpRes["result"]["username"].toString());
                                            SharePre.setUserMobile(OtpRes["result"]["phonenumber"].toString());
                                            SharePre.setUserEmail(OtpRes["result"]["email"].toString());
                                            SharePre.setUserImage(OtpRes["result"]["profile_picture"].toString());
                                            SharePre.setOfferingArea(OtpRes["result"]["Current_Location"].toString());
                                            SharePre.setUserDisplayName(OtpRes["result"]["displayname"].toString());
                                            SharePre.setUserIsPlaceType(OtpRes["result"]["placeORperson"].toString().toUpperCase().trim() == "PERSON" ? "false":"true");
                                            DataManager.getInstance().setuserId(OtpRes["result"]["id"].toString());
                                            DataManager.getInstance().setuserName(OtpRes["result"]["username"].toString());
                                            DataManager.getInstance().setphonedata(OtpRes["result"]["phonenumber"].toString());
                                            DataManager.getInstance().setuserEmail(OtpRes["result"]["email"].toString());
                                            DataManager.getInstance().setuserImage(OtpRes["result"]["profile_picture"].toString());
                                            DataManager.getInstance().setOfferArea(OtpRes["result"]["Current_Location"].toString());
                                            DataManager.getInstance().setUserDisplayName(OtpRes["result"]["displayname"].toString());
                                            DataManager.getInstance().setUserIsPlaceType(OtpRes["result"]["placeORperson"].toString().toUpperCase().trim() == "PERSON" ? "false":"true");
                                            DataManager.getInstance().setUserSecMobile(OtpRes["result"]["additionalnumber"].toString());
                                            SharePre.setUserSecMobile(OtpRes["result"]["additionalnumber"].toString());
                                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 1),), (route) => false);
                                            setDialogState(() {
                                              accountSwitchLoader= false;
                                            });
                                            // Navigator.pushAndRemoveUntil(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) => Dashboard_screen(backIndex: 4),
                                            //     ),
                                            //         (route) => false);
                                          });
                                        });



                                      }
                                    }else{
                                      setDialogState(() {
                                        accountSwitchLoader= false;
                                      });
                                      Navigator.pop(context);
                                    }
                                  });


                                }
                                // From == "LogIn"?Navigator.pop(context):  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  login_screen(isGuestUser: false)), (route) => false);
                              }else{

                                Constants.showToast(Url.NotDeleteMessage);
                                Navigator.pop(context);
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE8422A),
                            fixedSize: Size(ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width*0.45:ResponsiveHelper.TabModeWidth*0.45, 35),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child:
                          accountSwitchLoader ?
                          Center(
                            child:ButtonLoaderWhite(),
                          ):
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Yes",style:TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 14),),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                  right: 5,
                  top: 5,
                  child:  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(Icons.clear_outlined,color: Constants.primaryColor1,size: 18,),
                      ),

                    ),
                  ))
            ],
          )
      );
    },);
    },
  );
}