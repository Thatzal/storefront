// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:offerpagenew0804/common/style.dart';
// import 'package:offerpagenew0804/model/GetUserAccountModal.dart';
//
// import '../Apis/urls.dart';
//
// class getAppBar {
//        CommanAppbar(context) {
//             return AppBar(
//               backgroundColor: Colors.white,
//               leadingWidth: MediaQuery.of(context).size.width*0.6,
//               leading: Padding(
//                 padding: const EdgeInsets.only(right: 10.0,left: 15),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton2(
//                     hint:  Text('Choose Account', style: black16500,),
//                     items: getUserAccountList.map((item) => DropdownMenuItem<GetUserAccountResult>(
//                       value: item,
//                       child: Row(
//                         children: [
//                           ClipOval(
//                             child: Image.network(
//                               "${Url.IMAGE_URL}${item.profilePicture}",
//                               width: 30,
//                               height: 30,
//                               fit: BoxFit.fill,
//                               errorBuilder: (BuildContext context, Object exception,
//                                   StackTrace? stackTrace) {
//                                 return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
//                                   width: 30,
//                                   height: 30,
//                                   fit: BoxFit.fill,);
//                               },),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10.0),
//                             child: Text(item.username.toString(), style: selectedUserValue!.username == item.username ?black16500:blackMText,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )).toList(),
//                     value: selectedUserValue,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedUserValue = value;
//                         accountSwitchLoader = true;
//                       });
//                       DrawAuraAPi().loginApi(phonenumber: selectedUserValue!.phonenumber,username: selectedUserValue!.username.toString()).then((loginRes) {
//                         print(loginRes);
//                         DrawAuraAPi().otpLoginVerifyApi(otp:loginRes["OTP"],phonenumber: selectedUserValue!.phonenumber,username:selectedUserValue!.username.toString()).then((OtpRes) {
//                           SharePre.setUserId(OtpRes["result"]["id"].toString());
//                           SharePre.setUserName(OtpRes["result"]["username"].toString());
//                           SharePre.setUserMobile(OtpRes["result"]["phonenumber"].toString());
//                           SharePre.setUserEmail(OtpRes["result"]["email"].toString());
//                           SharePre.setUserImage(OtpRes["result"]["profile_picture"].toString());
//                           DataManager.getInstance().setuserId(OtpRes["result"]["id"].toString());
//                           DataManager.getInstance().setuserName(OtpRes["result"]["username"].toString());
//                           DataManager.getInstance().setphonedata(OtpRes["result"]["phonenumber"].toString());
//                           DataManager.getInstance().setuserEmail(OtpRes["result"]["email"].toString());
//                           DataManager.getInstance().setuserImage(OtpRes["result"]["profile_picture"].toString());
//                           Fluttertoast.showToast(
//                               msg: "Account Switching Successfully",
//                               toastLength: Toast.LENGTH_SHORT,
//                               gravity: ToastGravity.BOTTOM,
//                               timeInSecForIosWeb: 2,
//                               backgroundColor: Colors.green,
//                               textColor: Colors.white,
//                               fontSize: 18.0
//                           );
//                           // if(otpData["type"]=="exist"){
//                           //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  Dashboard_screen(backIndex:2,),));
//                           // }else{
//                           setState(() {
//                             accountSwitchLoader = false;
//                           });
//                           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 4),), (route) => false);
//                         });
//                       });
//                       print(value!.profilePicture);
//                     },
//                     iconStyleData: const IconStyleData(
//                       icon: Padding(
//                         padding: EdgeInsets.only(top: 5.0),
//                         child: Icon(Icons.keyboard_arrow_down_rounded,
//                             color: Constants.primaryColor, size: 28),
//                       ),
//                     ),
//                     buttonStyleData: const ButtonStyleData(
//                       height: 40,
//                       width: 180,
//                     ),
//                     dropdownStyleData: const DropdownStyleData(
//                       width: 220,
//                     ),
//                     menuItemStyleData: const MenuItemStyleData(
//                       height: 40,
//                     ),
//                   ),
//                 ),
//               ),
//               actions: <Widget>[
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: ()
//                       {
//                         Get.to(()=>const notify());},
//                       child: const Image(image: AssetImage("assets/notification.png"),
//                         height: 40,
//                         width: 40,
//                       ),
//                     ),
//                     InkWell(
//                       onTap: (){Get.to(()=>const setting_screen());},
//                       child: const Image(image: AssetImage("assets/setting.png"), height: 40, width: 40,),
//                     ),
//                     const SizedBox(width: 30,),
//                   ],
//                 )
//               ],
//             );
//        }
// }