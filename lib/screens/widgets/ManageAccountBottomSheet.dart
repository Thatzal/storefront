import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/controller/share_preferences.dart';
import 'package:socialapps/model/GetUserAccountModal.dart';
import 'package:socialapps/screens/widgets/alertDialogWithMessage.dart';
import '../../Auth/RagistrationPreviewScreen.dart';
import 'package:get/get.dart';
Future<dynamic> ManageAccount (BuildContext context,
{  GetUserAccountResult? selectedUserValue,
List<GetUserAccountResult> ?getUserAccountList ,String ? token}
    ) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var tabWidth = ResponsiveHelper.TabModeWidth;
  var isMobile = ResponsiveHelper.isMobile(context);
  bool accountSwitchLoader = false;

  Color FieldBgColor = Color(0xFFF4F8F6);
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    constraints: BoxConstraints(maxWidth: ResponsiveHelper.isMobile(context)?MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Stack(
            children: [
                  Container(
                  height: height * 0.6,
                  width:  isMobile?width:tabWidth,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                      color:Colors.white
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 12),
                          height: 4,width: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),color: Colors.black54
                          ),
                        ),
                        15.height,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text( "Manage Accounts",style: BlackBottomHeadStyle18500,),

                            ],
                          ),
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          children: <Widget>[
                            15.height,

                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: getUserAccountList!.length,
                              itemBuilder: (context, index) {
                                var item = getUserAccountList[index];
                                   return InkWell(
                                     onTap: (){
                                       setModalState(() {
                                         selectedUserValue = item;
                                         accountSwitchLoader = true;
                                       });
                                       DrawAuraAPi().loginApi(phonenumber: selectedUserValue!.phonenumber, username: selectedUserValue!.username.toString(),
                                           deviceToken: token == "" || token == null
                                               ? "eyAia2lkIjogIjhZTDNHM1JSWDciIH0.eyAiaXNzIjogIkM4Nk5WOUpYM0QiLCAiaWF0IjogIjE0NTkxNDM1ODA2NTAiIH0.MEYCIQDzqyahmH1rz1s-LFNkylXEa2lZ_aOCX4daxxTZkVEGzwIhALvkClnx5m5eAT6Lxw7LZtEQcH6JENhJTMArwLf3sXwi"
                                               : token.toString())
                                           .then((loginRes) async {
                                         print(loginRes);
                                         var body = {
                                           "id": DataManager.getInstance().getuserId().toString(),
                                           "deviceToken": "",
                                         };
                                         final SharedPreferences sharedpreferences =
                                         await SharedPreferences.getInstance();sharedpreferences.clear();
                                         DrawAuraAPi.CreateDataApi(ApiEndPoint: "updateSubscriberProfile", body: body);
                                         DrawAuraAPi.getSubscriberDetailsApi(
                                             userId: selectedUserValue!.id.toString()).then((OtpRes) {
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
                                           Fluttertoast.showToast(
                                               msg:"${Url.AccountSwitchMessage}",
                                               toastLength: Toast.LENGTH_SHORT,
                                               gravity: ToastGravity.BOTTOM,
                                               timeInSecForIosWeb: 2,
                                               backgroundColor: Constants.primaryColor1,
                                               textColor: Colors.white,
                                               fontSize: 18.0);
                                           setModalState(() {
                                             accountSwitchLoader = false;
                                           });
                                           // Navigator.pushAndRemoveUntil(
                                           //     context,
                                           //     MaterialPageRoute(
                                           //       builder: (context) => Dashboard_screen(backIndex: 4),
                                           //     ),
                                           //         (route) => false);
                                         });
                                       });
                                     },
                                     child: Container(
                                       height: 50,
                                       decoration: BoxDecoration(
                                         color: FieldBgColor,
                                         borderRadius: BorderRadius.circular(5),
                                       ),padding: EdgeInsets.all(5),
                                       margin: EdgeInsets.only(bottom: 5),
                                       width: isMobile?width:tabWidth,
                                       child:  Row(
                                         children: [
                                           ClipOval(
                                             child: Image.network(
                                               "${item.profilePicture}",
                                               width: 40,
                                               height: 40,
                                               fit: BoxFit.fill,
                                               errorBuilder: (BuildContext context,
                                                   Object exception, StackTrace? stackTrace) {
                                                 return Image.network(
                                                   "https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                                   width: 40,
                                                   height: 40,
                                                   fit: BoxFit.fill,
                                                 );
                                               },
                                             ),
                                           ),
                                           Padding(
                                             padding: const EdgeInsets.only(left: 10.0),
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 SizedBox(
                                                     width: isMobile?width * 0.5:tabWidth*0.5,
                                                     child: Text(
                                                       item.displayname.toString(),
                                                       style: selectedUserValue!.username ==
                                                           item.username
                                                           ? BlackHeadingStyle
                                                           : BlackSubTitleStyle,
                                                       overflow: TextOverflow.ellipsis,
                                                     )),

                                               ],
                                             ),
                                           ),
                                           Spacer(),
                                           selectedUserValue == item? Padding(
                                             padding: const EdgeInsets.only(right: 5.0),
                                             child: CircleAvatar(
                                               radius: 11,backgroundColor: Constants.primaryColor1,
                                               child: CircleAvatar(
                                                 radius: 4,backgroundColor: Colors.white,
                                               ),
                                             ),
                                           ):SizedBox()
                                         ],
                                       ),
                                     ),
                                   );
                            },),
                            10.height,
                            Divider(
                              color: Constants.borderColor,
                              thickness: 1,
                            ),
                            10.height,
                            InkWell(
                              onTap: (){

                                   Navigator.push(context, MaterialPageRoute(builder: (context) => RagistrationPreviewScreen(MobileNumber: DataManager.getInstance().getphonedata().toString(),)));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: FieldBgColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(bottom: 5),
                                width: isMobile?width:tabWidth,
                                child:  Row(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child:Icon(Icons.add,color: Constants.black,size: 35,)
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: isMobile?width * 0.5:tabWidth*0.5,
                                              child: Text( "Create new account",
                                                style:BlackSubHeadingStyle,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),

                            InkWell(
                              onTap: (){
                                showDeleteAccountDialog(context,"Profile",DataManager.getInstance().getuserId().toString(),token!).then((value) {

                                });
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: FieldBgColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(bottom: 5),
                                width: isMobile?width:tabWidth,
                                child:  Row(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child:Icon(Icons.delete_rounded,color: Constants.black,size: 24,)
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: isMobile?width * 0.5:tabWidth*0.5,
                                              child: Text( "Delete account",
                                                style:BlackSubHeadingStyle,
                                                overflow: TextOverflow.ellipsis,
                                              )),


                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),),
              accountSwitchLoader ?
                  Container(
                    height: height * 0.6,
                    width:  isMobile?width:tabWidth,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                        color:Colors.black12
                    ),
                    child: Center(
                      child: LoadingWidget(),
                    ),
                  )
                  :SizedBox(),
                  Positioned(
                  right: 10,
                  top: 8,
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
                  )),
                ],
          );
        },

      );

    },

  );

}



class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' '); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length)
    );
  }
}
