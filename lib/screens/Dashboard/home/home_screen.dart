
import 'package:flutter/material.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/controller/HomePageController.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/constant/constant_function.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/controller/share_preferences.dart';
import 'package:socialapps/model/PrefillOfferDataModel.dart';
import 'package:socialapps/screens/Dashboard/dashboard_screen.dart';
import 'package:socialapps/screens/Dashboard/notify/followers_following_screen.dart';
import 'package:socialapps/screens/newOfferPage.dart';
import 'package:socialapps/screens/setting/manage_profile_screen.dart';
import 'package:socialapps/screens/widgets/ImageGalleryByUrl.dart';
import 'package:socialapps/screens/widgets/SimmerLoadingBuilder.dart';
import 'package:socialapps/screens/widgets/commonCards.dart';
import 'package:socialapps/screens/widgets/upload_image_camera.dart';
import 'package:socialapps/screens/widgets/CommonOfferCardBuilderAndTap.dart';
import '../../../common/style.dart';
import '../../../model/GetUserAccountModal.dart';

class HomePageScreen extends StatelessWidget {
   HomePageScreen({super.key});

  final HomePageController tabx = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return GetX<HomePageController>(
        init: HomePageController(),
        initState: (state) async{

          Future.delayed(Duration.zero,() {
            state.controller!.isGetSubscriberDetails.value = false;
            state.controller!.isGetSubscriberAccounts.value = false;
            state.controller!.isGetSubscriberOffer.value = false;
            state.controller!.isGetSubscriberCounterOffer.value = false;
            state.controller!.isGetSubscriberTemplates.value = false;
            state.controller!.isGetSubscriberFavOffer.value = false;
            state.controller!.getUserDetails();
            state.controller!.getUserAccounts();
            state.controller!.getUserOffer();
            state.controller!.getUserTemplateOffer();
            state.controller!.getUserFavOffer();
          },);
        },
        builder: (controller) {
          var width = MediaQuery.of(context).size.width;
          var height = MediaQuery.of(context).size.height;
          var tabWidth = ResponsiveHelper.TabModeWidth;
          var tabHeight = ResponsiveHelper.TabModeHeight;
          var isMobile = ResponsiveHelper.isMobile(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leadingWidth: isMobile?width * 0.6:tabWidth*0.4,
              titleSpacing: 0,
              leading: Padding(padding: const EdgeInsets.only(right: 7.0, left: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      'Choose Account',
                      style: BlackHeadingStyle,
                    ),
                    items: controller.getUserAccountList.map((item) =>
                        DropdownMenuItem<GetUserAccountResult>(
                          value: item,
                          child: Row(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  "${Url.IMAGE_URL}${item.profilePicture}",
                                  width: 34,
                                  height: 34,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception, StackTrace? stackTrace) {
                                    return Image.network(
                                      "https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                      width: 34,
                                      height: 34,
                                      fit: BoxFit.cover,
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
                                        width: isMobile?width * 0.35:tabWidth*0.20,
                                        child: Text(
                                          item.displayname.toString(),
                                          style:BlackSubTitleStyle,
                                          overflow: TextOverflow.ellipsis,
                                        )),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                    value: controller.selectedUserValue.value,
                    onChanged: (value) {
                      controller.selectedUserValue.value = value!;
                      controller.isGetSubscriberDetails.value = false;
                      controller.accountSwitchLoader.value = true;
                      DrawAuraAPi().loginApi(
                          phonenumber:  controller.selectedUserValue.value.phonenumber,
                          username:  controller.selectedUserValue.value.username.toString(),
                          deviceToken:  controller.token.value == "" ? "eyAia2lkIjogIjhZTDNHM1JSWDciIH0.eyAiaXNzIjogIkM4Nk5WOUpYM0QiLCAiaWF0IjogIjE0NTkxNDM1ODA2NTAiIH0.MEYCIQDzqyahmH1rz1s-LFNkylXEa2lZ_aOCX4daxxTZkVEGzwIhALvkClnx5m5eAT6Lxw7LZtEQcH6JENhJTMArwLf3sXwi" :  controller.token.value.toString()).then((loginRes) async {

                        var body = {
                          "id": DataManager.getInstance().getuserId().toString(),
                          "deviceToken": "",
                        };
                        final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();sharedpreferences.clear();
                        DrawAuraAPi.CreateDataApi( ApiEndPoint: "updateSubscriberProfile", body: body);
                        DrawAuraAPi.getSubscriberDetailsApi(userId:  controller.selectedUserValue.value.id.toString()).then((OtpRes) {
                          SharePre.setUserId(OtpRes["result"]["id"].toString());
                          SharePre.setUserName(OtpRes["result"]["username"].toString());
                          SharePre.setUserMobile(OtpRes["result"]["phonenumber"].toString());
                          SharePre.setUserEmail(OtpRes["result"]["email"].toString());
                          SharePre.setUserImage(OtpRes["result"]["profile_picture"].toString());
                          SharePre.setOfferingArea(OtpRes["result"]["Current_Location"].toString());
                          SharePre.setUserDisplayName(OtpRes["result"]["displayname"].toString());
                          SharePre.setUserIsPlaceType(OtpRes["result"]["placeORperson"].toString().toUpperCase().trim() == "PERSON" ? "false":"true");
                          SharePre.setUserSecMobile(OtpRes["result"]["additionalnumber"].toString());
                          DataManager.getInstance().setuserId(OtpRes["result"]["id"].toString());
                          DataManager.getInstance().setuserName(OtpRes["result"]["username"].toString());
                          DataManager.getInstance().setphonedata(OtpRes["result"]["phonenumber"].toString());
                          DataManager.getInstance().setuserEmail(OtpRes["result"]["email"].toString());
                          DataManager.getInstance().setuserImage(OtpRes["result"]["profile_picture"].toString());
                          DataManager.getInstance().setOfferArea(OtpRes["result"]["Current_Location"].toString());
                          DataManager.getInstance().setUserDisplayName(OtpRes["result"]["displayname"].toString());
                          DataManager.getInstance().setUserIsPlaceType(OtpRes["result"]["placeORperson"].toString().toUpperCase().trim() == "PERSON" ? "false":"true");
                          DataManager.getInstance().setUserSecMobile(OtpRes["result"]["additionalnumber"].toString());

                          Fluttertoast.showToast(
                              msg: "${Url.AccountSwitchMessage}",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Constants.primaryColor1,
                              textColor: Colors.white,
                              fontSize: 18.0);

                          controller.isGetSubscriberDetails.value = false;
                          controller.isGetSubscriberAccounts.value = false;
                          controller.isGetSubscriberOffer.value = false;
                          controller.isGetSubscriberCounterOffer.value = false;
                          controller.isGetSubscriberTemplates.value = false;
                          controller.isGetSubscriberFavOffer.value = false;
                          controller.getUserDetails();
                          controller.getUserAccounts();
                          controller.getUserOffer();
                          controller.getUserTemplateOffer();
                          controller.getUserFavOffer();
                          controller.accountSwitchLoader.value = false;

                        });
                      });
                      print(value.profilePicture);
                    },
                    isDense: true,
                    isExpanded: true,
                    iconStyleData: const IconStyleData(
                      icon: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Icon(Icons.keyboard_arrow_down_rounded,
                            color: Constants.primaryColor1, size: 28),
                      ),
                    ),
                    buttonStyleData: ButtonStyleData(
                      height: 40,
                      width: isMobile?width * 0.5:tabWidth*0.5,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: isMobile?width * 0.6:tabWidth*0.4,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => NewOfferCreateScreen(Address: "", AddressTitle: "", From: "New", PrefillOfferData: PrefillOfferDataModel(), Type: "", OfferId: "", SubId: ""));
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Constants.primaryColor1,
                          boxShadow: [
                            BoxShadow(
                              color: Constants.primaryColor20,
                              blurRadius: 1.5,
                              spreadRadius: 2,
                              offset: Offset(
                                0,
                                3,
                              ),
                            )
                          ],
                        ),
                        child: Center(
                          child: Image.asset("assets/edit.png",
                              height: 20, width: 20, color: Constants.white),
                        ),
                      ),
                    ),
                    15.width,
                    InkWell(
                      onTap: () {
                        Get.offAll(() =>  Dashboard_screen(backIndex: 3));
                      },
                      child: const Image(
                        image: AssetImage("assets/notification.png"),
                        color: primaryColor,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    15.width,
                    InkWell(
                      onTap: () async {
                        Get.offAll(() =>  Dashboard_screen(backIndex: 1));
                      },
                      child: const Image(
                        image: AssetImage("assets/setting.png"),
                        color: primaryColor,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    15.width,
                  ],
                )
              ],
            ),
            body: NestedScrollView(
              floatHeaderSlivers: false,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    title: GetBuilder<HomePageController>(
                      builder: (controller2) {
                        return Stack(
                          children: [
                            SizedBox(

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 100),
                                    child:  controller2.isGetSubscriberDetails.value == false
                                        ? ShimmerProleBackImageLoadingBuilder(context)
                                        : controller2.backPageImage.value.toString() == ""
                                        ? InkWell(
                                        onTap: () async {
                                          showModalBottomSheet(context: context,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(15),
                                                    topRight:
                                                    Radius.circular(15))),
                                            builder: (BuildContext context) {
                                              return SafeArea(
                                                child: Wrap(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 12.0),
                                                      child: ListTile(
                                                          leading: const Icon(
                                                            Icons.photo_library,
                                                            color: primaryColor,
                                                          ),
                                                          minVerticalPadding: 0,
                                                          dense: true,
                                                          horizontalTitleGap: 10,
                                                          title: const Text(
                                                            'Gallery',
                                                            style:
                                                            BlackFieldStyle54,
                                                          ),
                                                          onTap: () async {
                                                            final ImagePicker
                                                            picker = ImagePicker();final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                                            XFile? xfilePick = pickedFile;
                                                            if (xfilePick != null) {
                                                              ConstantFun.imageProfileCropper(path: pickedFile!.path).then((file) async {
                                                                String?CoverImagePath;
                                                                CoverImagePath = file.path.toString();
                                                                var updateSubsribeDetails =
                                                                {
                                                                  "id": DataManager.getInstance().getuserId().toString(),
                                                                };
                                                                controller2.IsuploadingCoverImage.value = true;
                                                                controller2.update();
                                                                DrawAuraAPi.UpdateImageMultiPart(
                                                                    data: updateSubsribeDetails,
                                                                    imageName: "page_picture",
                                                                    ImagePath: CoverImagePath).then((UpdateRes) async {
                                                                  controller2.backPageImage.value = UpdateRes["result"]["page_picture"];
                                                                  controller2.IsuploadingCoverImage.value = false;
                                                                  controller2.update();
                                                                });
                                                              });
                                                            } else {
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                // is this context <<<
                                                                  const SnackBar(content:Text('Nothing is selected')));
                                                            }
                                                            Navigator.of(context).pop();
                                                          }),
                                                    ),
                                                    ListTile(
                                                        leading: const Icon(Icons.photo_camera, color: primaryColor,),
                                                        title: const Text('Camera', style: BlackFieldStyle54,),
                                                        minVerticalPadding: 0,
                                                        dense: true,
                                                        horizontalTitleGap: 10,
                                                        onTap: () async {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageCameraScreen())).then((value) {
                                                            Navigator.of(context).pop();
                                                            if (value != null) {
                                                              ConstantFun.imageProfileCropper(
                                                                  path: value).then((file) async {
                                                                String?CoverImagePath;
                                                                CoverImagePath = file.path.toString();
                                                                controller.IsuploadingCoverImage.value = true;
                                                                controller2.update();
                                                                var updateSubsribeDetails =
                                                                {
                                                                  "id": DataManager.getInstance().getuserId().toString(),
                                                                };
                                                                DrawAuraAPi.UpdateImageMultiPart(
                                                                    data: updateSubsribeDetails,
                                                                    imageName: "page_picture", ImagePath: CoverImagePath).then((UpdateRes) async {
                                                                  controller.IsuploadingCoverImage.value = false;
                                                                  controller.backPageImage.value = UpdateRes["result"]["page_picture"];
                                                                  controller2.update();
                                                                });
                                                              });
                                                            }else{
                                                              ScaffoldMessenger.of(context).showSnackBar( // is this context <<<
                                                                  const SnackBar(content: Text('Nothing is selected')));
                                                            }
                                                          });
                                                        }),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 5),
                                            width:isMobile ?width:tabWidth,
                                            height: isMobile ? height * 0.18: tabHeight*0.18,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey.shade500, width: 2),
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade300),
                                            child: Center(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(5),),
                                                      padding: EdgeInsets.all(5),
                                                      child: Text("Click here to upload", style: WhiteHeadingStyle,)),
                                                  controller2.IsuploadingCoverImage.value == true
                                                      ? Container(height: 50, width: 50,
                                                    child: CircularProgressIndicator(
                                                      color: Constants.primaryColor1,
                                                    ),
                                                  ) : SizedBox()
                                                ],
                                              ),
                                            )))
                                        : Image.network(
                                      "${Url.IMAGE_URL}${controller2.backPageImage.value}",
                                      width: isMobile ?width:tabWidth,
                                      height: isMobile? height * 0.18:tabHeight * 0.35,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ManageProfileScreen(From: "home"),)).then((value) {
                                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 4,),), (route) => false);
                                              // DrawAuraAPi.getSubscriberDetailsApi(userId: DataManager.getInstance().getuserId().toString()).then((value) {
                                              //   if (this.mounted) {
                                              //     setState(() {
                                              //       username = value["result"]["username"] == null ? "" : value["result"]["username"];
                                              //       placeOrperson = value["result"]["placeORperson"] == null ? "" : value["result"]["placeORperson"];
                                              //       followersCount = value["result"]["followers"] == null ? "" : value["result"]["followers"].toString();
                                              //       followingCount = value["result"]["following"] == null ? "0" : value["result"]["following"].toString();
                                              //       userProfileImage = value["result"]["profile_picture"] == null ? "" : value["result"]["profile_picture"];
                                              //       backPageImage = value["result"]["page_picture"] == null ? "" : value["result"]["page_picture"];
                                              //       SharePre.setUserImage(value["result"]["profile_picture"].toString());
                                              //       DataManager.getInstance().setuserImage(value["result"]["profile_picture"].toString());
                                              //     });
                                              //   }
                                              // });
                                              // DrawAuraAPi.getUserAccountsApi(MobileNumber: SubscriberDetails!.phonenumber.toString()).then((UserAccountRes) {
                                              //   if (UserAccountRes["status"] == 200) {
                                              //      setState(() {
                                              //        UserAccountDetails = GetUserAccountModal.fromJson(UserAccountRes);
                                              //        getUserAccountList = UserAccountDetails!.result!;
                                              //        for (var i = 0; i < getUserAccountList.length; i++) {
                                              //          if (getUserAccountList[i].id.toString().trim() == value["result"]["id"].toString().trim()) {
                                              //            selectedUserValue = getUserAccountList[i];
                                              //          }
                                              //        }
                                              //      });
                                              //   }
                                              // });
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: const [
                                              Icon(Icons.edit_outlined, size: 18,),
                                              SizedBox(width: 5,),
                                              Text("Edit Profile", style: BlackTitleBoldStyle, textAlign: TextAlign.end,),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => FollowersFollowingScreen(tabIndex: "0", userId: DataManager.getInstance().getuserId()),));
                                              },
                                              child: Row(
                                                children: [
                                                  controller2.isGetSubscriberDetails.value == false ? Text("__", style: PrimaryColorStyle16700,)
                                                      : Text("${controller2.followersCount.value}",
                                                    style: PrimaryColorStyle16700,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Text(
                                                    "Followers",
                                                    style: PrimaryColorStyle16500,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Center(
                                                child: Text(".",
                                                    style: PrimaryColorStyle16700)),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => FollowersFollowingScreen(tabIndex: "1", userId: DataManager.getInstance().getuserId()),));
                                              },
                                              child: Row(
                                                children: [
                                                  controller2.isGetSubscriberDetails.value == false ? Text("__", style: PrimaryColorStyle16700,)
                                                      : Text("${controller2.followingCount.value}", style: PrimaryColorStyle16700,),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Text(
                                                    "Following",
                                                    style: PrimaryColorStyle16500,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${controller2.isGetSubscriberDetails.value == false ? "_":controller2.SubscriberDetails.value.displayname}",
                                          style: BlackTitleLargeBoldStyle,
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${controller2.isGetSubscriberDetails.value == false ? "_":controller2.SubscriberDetails.value.username} - ${controller2.isGetSubscriberDetails.value == false ? "_" : controller.placeOrperson.value}",
                                              style: greySubTitleItalicStyle20400,
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                                bottom: 75,
                                left: 20,
                                child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 100),
                                    child: controller2.isGetSubscriberDetails.value == false
                                        ? ShimmerProleImageLoadingBuilder()
                                        : controller2.userProfileImage.value == ""
                                        ? InkWell(
                                        onTap: () async {
                                          showModalBottomSheet(
                                            context: context,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(15),
                                                    topRight: Radius.circular(15))),
                                            builder: (BuildContext context) {
                                              return SafeArea(
                                                child: Wrap(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 12.0),
                                                      child: ListTile(
                                                          leading: const Icon(
                                                            Icons.photo_library,
                                                            color: primaryColor,
                                                          ),
                                                          minVerticalPadding: 0,
                                                          dense: true,
                                                          horizontalTitleGap: 10,
                                                          title: const Text(
                                                            'Gallery',
                                                            style:
                                                            BlackFieldStyle54,
                                                          ),
                                                          onTap: () async {
                                                            final ImagePicker
                                                            picker = ImagePicker();
                                                            final pickedFile =
                                                            await picker.pickImage(source: ImageSource.gallery);
                                                            XFile? xfilePick = pickedFile;
                                                            if (xfilePick != null) {
                                                              ConstantFun.imageProfileCropper(path: pickedFile!.path).then((file) async {
                                                                String?
                                                                CoverImagePath;
                                                                CoverImagePath = file.path.toString();
                                                                controller2.IsuploadingProfileImage.value = true;
                                                                controller2.update();
                                                                var updateSubsribeDetails =
                                                                {
                                                                  "id": DataManager.getInstance().getuserId().toString(),
                                                                };
                                                                DrawAuraAPi.UpdateImageMultiPart(
                                                                    data: updateSubsribeDetails,
                                                                    imageName: "profile_picture",
                                                                    ImagePath: CoverImagePath).then(
                                                                        (UpdateRes) async {

                                                                      controller2.userProfileImage.value = UpdateRes["result"]["profile_picture"];
                                                                      controller2.IsuploadingProfileImage.value = false;
                                                                      controller2.update();
                                                                      Timer(Duration(seconds: 1),
                                                                              () {

                                                                          });
                                                                    });
                                                              });
                                                            } else {
                                                              ScaffoldMessenger.of(
                                                                  context)
                                                                  .showSnackBar(
                                                                // is this context <<<
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Nothing is selected')));
                                                            }
                                                            Navigator.of(context)
                                                                .pop();
                                                          }),
                                                    ),
                                                    ListTile(
                                                        leading: const Icon(
                                                          Icons.photo_camera,
                                                          color: primaryColor,
                                                        ),
                                                        title: const Text(
                                                          'Camera',
                                                          style: BlackFieldStyle54,
                                                        ),
                                                        minVerticalPadding: 0,
                                                        dense: true,
                                                        horizontalTitleGap: 10,
                                                        onTap: () async {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageCameraScreen())).then((value) {
                                                            Navigator.of(context).pop();
                                                            if (value != null) {
                                                              ConstantFun.imageProfileCropper(path:value)
                                                                  .then((file) async {
                                                                String?CoverImagePath;
                                                                CoverImagePath = file.path.toString();
                                                                controller2.IsuploadingProfileImage.value = true;
                                                                controller2.update();
                                                                var updateSubsribeDetails =
                                                                {
                                                                  "id": DataManager.getInstance().getuserId().toString(),
                                                                };
                                                                DrawAuraAPi.UpdateImageMultiPart(
                                                                    data: updateSubsribeDetails,
                                                                    imageName: "profile_picture",
                                                                    ImagePath: CoverImagePath)
                                                                    .then((UpdateRes) async {
                                                                  controller2.userProfileImage.value = UpdateRes["result"]["profile_picture"];
                                                                  controller2.IsuploadingProfileImage.value = false;
                                                                  controller2.update();

                                                                });
                                                              });
                                                            }else{
                                                              ScaffoldMessenger.of(context).showSnackBar( // is this context <<<
                                                                  const SnackBar(content: Text('Nothing is selected')));
                                                            }
                                                          });

                                                        }),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                            margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.grey.shade500,
                                                    width: 2),
                                                color: Colors.grey.shade300),
                                            child: Center(
                                              child: Stack(
                                                children: [
                                                  Center(
                                                    child: Container(
                                                        width: 80,
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                          color: Colors.black54,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                        ),
                                                        padding: EdgeInsets.all(5),
                                                        child: Text(
                                                          "Click here to upload ",
                                                          style: WhiteHeadingStyle,
                                                          textAlign:
                                                          TextAlign.center,
                                                        )),
                                                  ),
                                                  controller.IsuploadingProfileImage.value == true
                                                      ? Center(
                                                    child: SizedBox(
                                                        width: 90,
                                                        height: 90,
                                                        child: CircularProgressIndicator(
                                                            color: Constants
                                                                .primaryColor1,
                                                            strokeWidth: 4)),
                                                  )
                                                      : SizedBox()
                                                ],
                                              ),
                                            )))
                                        : Container(
                                      height: 120, width: 120,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: primaryColor,width: 2),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "${Url.IMAGE_URL}${controller2.userProfileImage.value}"
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                      ),
                                    )

                                  // ClipOval(
                                  //   child: Image.network(
                                  //     "${Url.IMAGE_URL}${controller.userProfileImage.value}",
                                  //     height: 120,
                                  //     width: 120,
                                  //
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),
                                ))
                          ],
                        )  ;
                      },),
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    centerTitle: true,
                    pinned: true,

                    toolbarHeight: isMobile ? height * 0.33: tabHeight*0.35,
                    floating: true,
                    bottom: PreferredSize(
                      preferredSize: Size(isMobile ? width * 0.85: tabWidth*0.85,48),
                      child: Row(
                        children: [
                          Flexible(
                            child: TabBar(
                              labelColor: Colors.black,
                              controller:tabx.tabController,
                              isScrollable: true,
                              indicatorWeight: 2.0,
                              indicatorColor: Colors.black,
                              indicatorPadding:
                              const EdgeInsets.only(top: 7, bottom: 5),
                              labelPadding: EdgeInsets.symmetric(horizontal: 10),
                              unselectedLabelColor: Colors.black,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelStyle: BlackTabStyle,
                              unselectedLabelStyle: BlackHeadingStyle,
                              tabs: <Widget>[
                                Tab(text: "My Offers"),
                                Tab(text: "Templates"),
                                Tab(text: "Favourites"),
                              ],
                            ),

                          ),
                          Stack(children: [
                            Container(
                                height: 25,
                                width: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Constants.primaryColor1),
                                child: Center(
                                    child: Icon(
                                      Icons.filter_alt_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ))),
                            Positioned(
                                top: 0,
                                // left:isMobile?10:tabWidth*0.55,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    // hint: Align(
                                    //   alignment: AlignmentDirectional.center,
                                    //   child: Text('', style: TextStyle(fontSize: 14, color: Theme.of(context).hintColor,),),
                                    // ),
                                    items: controller.filter.map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        //disable default onTap to avoid closing menu when selecting an item
                                        child: StatefulBuilder(
                                          builder: (context, menuSetState) {
                                            return InkWell(
                                              onTap: () {
                                                menuSetState(() {
                                                  controller.selectedItems.contains(item)
                                                      ?   controller.selectedItems.remove(item)
                                                      :   controller.selectedItems.add(item);
                                                });
                                                //This rebuilds the StatefulWidget to update the button's text

                                                //This rebuilds the dropdownMenu Widget to update the check mark
                                                if (  controller.selectedItems.contains(item)) {
                                                  controller.getMyOffersListFilter.clear();
                                                  menuSetState(() {
                                                    if (  controller.selectedItems.contains("NEW")) {
                                                      for (var j = 0; j < controller.getMyOffersList.length; j++) {
                                                        if (controller.getMyOffersList[j].offerCounters!.isEmpty) {
                                                          controller.getMyOffersListFilter.add(controller.getMyOffersList[j]);
                                                        }
                                                      }
                                                    }
                                                    if (controller.selectedItems.contains("QUERY")) {
                                                      for (var j = 0; j < controller.getMyOffersList.length; j++)
                                                      {if (controller.getMyOffersList[j].offerData!.buyORsell == "COUNTER BUY") {
                                                        controller.getMyOffersListFilter.add(controller.getMyOffersList[j]);}
                                                      }
                                                    }
                                                    if (controller.selectedItems.contains("ANSWER")) {
                                                      for (var j = 0; j < controller.getMyOffersList.length; j++) {
                                                        if (controller.getMyOffersList[j].offerData!.buyORsell == "COUNTER SELL") {
                                                          controller.getMyOffersListFilter.add(controller.getMyOffersList[j]);
                                                        }
                                                      }
                                                    }
                                                    if (controller.selectedItems.contains("SIGN-OFF")) {
                                                      for (var j = 0; j < controller.getMyOffersList.length; j++) {
                                                        if (controller.getMyOffersList[j].offerData!.offerstatus.toString().trim().toUpperCase() == "CLOSED") {
                                                          controller.getMyOffersListFilter.add(controller.getMyOffersList[j]);
                                                        }
                                                      }
                                                    }
                                                  });
                                                } else {
                                                  menuSetState(() {
                                                    controller.getMyOffersListFilter.clear();
                                                    if (controller.selectedItems.contains("NEW")) {
                                                      for (var j = 0; j < controller.getMyOffersList.length; j++) {
                                                        if (controller.getMyOffersList[j].offerCounters!.isEmpty) {
                                                          controller.getMyOffersListFilter.remove(controller.getMyOffersList[j]);
                                                        }
                                                      }
                                                    }
                                                    if (controller.selectedItems.contains("QUERY")) {
                                                      for (var j = 0; j < controller.getMyOffersList.length; j++) {
                                                        if (controller.getMyOffersList[j].offerData!.buyORsell == "COUNTER BUY") {controller.getMyOffersListFilter.value.remove(controller.getMyOffersList.value[j]);
                                                        }
                                                      }
                                                    }
                                                    if (controller.selectedItems.contains("ANSWER")) {
                                                      for (var j = 0; j < controller.getMyOffersList.length; j++) {
                                                        if (controller.getMyOffersList[j].offerData!.buyORsell == "COUNTER SELL")
                                                        {controller.getMyOffersListFilter.remove(controller.getMyOffersList[j]);}
                                                      }
                                                    }
                                                    if (controller.selectedItems.contains("SIGN-OFF")) {
                                                      for (var j = 0; j < controller.getMyOffersList.length; j++) {
                                                        if (controller.getMyOffersList[j].offerData!.offerstatus.toString().trim().toUpperCase() == "CLOSED") {
                                                          controller.getMyOffersListFilter.remove(controller.getMyOffersList[j]);
                                                        }
                                                      }
                                                    }
                                                  });
                                                }
                                              },
                                              child: Container(
                                                height: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                child: Row(
                                                  children: [
                                                    controller.selectedItems.contains(item) ? const Icon(Icons.check_box_rounded, color: Constants.primaryColor1,)
                                                        : Icon(Icons.check_box_outline_blank, color: Colors.grey.shade600),
                                                    const SizedBox(width: 14),
                                                    Text(item, style: BlackFieldStyle,),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }).toList(),
                                    value: null,
                                    onChanged: (value) {},
                                    iconStyleData: IconStyleData(icon: Icon(Icons.filter_alt_outlined, color: Colors.transparent, size: 10)),
                                    buttonStyleData: const ButtonStyleData(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                          color: Colors.transparent),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                        width:isMobile?width*0.45:tabWidth*0.45,

                                        offset: Offset(isMobile?0:-tabWidth*0.4,-10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(8))),
                                        elevation: 1),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                )),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: tabx.tabController,
                children: [

                  /// MyOffers
                  RefreshIndicator(
                    onRefresh: () async{
                      await  controller.getUserOffer();
                      return Future.value();
                    },
                    child:  controller.isGetSubscriberOffer.value == false || controller.isGetSubscriberCounterOffer.value == false
                        ? ShimmerLoadingGridViewBuilder(context)
                        : controller.selectedItems.isEmpty
                        ? controller.getMyOffersList.isEmpty
                        ?  Center(child: NotAvailableText("Not found!"),)
                        : Container(child: controller.listGrid.value == false
                        ? GridView.builder(
                        shrinkWrap: true,
                        itemCount: controller.getMyOffersList.length,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: isMobile ? 2 / 2.5 : 2 / 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics (),
                        itemBuilder: (context, index) {
                          var data = controller.getMyOffersList[index];
                          bool isConfirmingUser = false;
                          for (var i = 0; i < data.offerData!.ConfirmingSubscriber!.length; i++) {
                            if (data.offerData!.ConfirmingSubscriber![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()) {
                              isConfirmingUser = true;
                              break;
                            } else {
                              isConfirmingUser = false;
                            }
                          }
                          List <bool>isAllItemDone1 = [] ;
                          for(var p = 0 ; p < data.offerData!.offerItems!.length ; p++){
                            if( data.offerData!.offerItems![p].quantity.toString().trim() == "0"){
                              isAllItemDone1.add(true);
                            }else{
                              isAllItemDone1.add(false);
                            }
                          }
                          return FutureBuilder(
                              future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                              builder: (BuildContext
                              context, AsyncSnapshot<String>snapshot) {
                                return CommonVerticalForGridView(context,data,snapshot,
                                  data.offerData!.buyORsell == "COUNTER SELL" ||  data.offerData!.buyORsell == "COUNTER BUY"?true:false,
                                  controller.getMyOffersList,index,
                                      (){
                                        print("isAllItemDone1");
                                        print(isAllItemDone1);
                                    tapOnOffer(context,data, data.offerData!.buyORsell == "COUNTER SELL" ||  data.offerData!.buyORsell == "COUNTER BUY" ?true:false, isConfirmingUser,isAllItemDone1).then((value) {
                                        controller.getUserOffer();
                                    });}, true,isAllItemDone1,
                                    isConfirmingUser
                                );
                              });
                        })
                        : ListView.builder(
                      itemCount: controller.getMyOffersList.length,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) {
                        var data = controller.getMyOffersList[index];
                        bool isConfirmingUser = false;
                        for (var i = 0; i < data.offerData!.ConfirmingSubscriber!.length; i++) {
                          if (data.offerData!.ConfirmingSubscriber![i].id.toString().trim() ==
                              DataManager.getInstance().getuserId().toString().trim()) {
                            isConfirmingUser = true;
                            break;
                          } else {
                            isConfirmingUser = false;
                          }
                        }
                        List <bool>isAllItemDone1 = [] ;
                        for(var p = 0 ; p < data.offerData!.offerItems!.length ; p++){
                          if( data.offerData!.offerItems![p].quantity.toString().trim() == "0"){
                            print("");
                            isAllItemDone1.add(true);
                          }else{
                            isAllItemDone1.add(false);
                          }
                        }
                        return FutureBuilder(
                            future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                            builder: (BuildContext
                            context, AsyncSnapshot<String>snapshot) {
                              return CommonOfferCardListView(context,data,snapshot,
                                data.offerData!.buyORsell == "COUNTER SELL" ||  data.offerData!.buyORsell == "COUNTER BUY"?true:false,
                                controller.getMyOffersList,index,
                                    (){

                                tapOnOffer(context,data, data.offerData!.buyORsell == "COUNTER SELL" ||  data.offerData!.buyORsell == "COUNTER BUY" ?true:false, isConfirmingUser,isAllItemDone1).then((value){
                                  controller.getUserOffer();
                                });}, true,
                                  isAllItemDone1,
                                  isConfirmingUser
                              );
                            });
                      },
                    ),
                    )
                        : controller.getMyOffersListFilter.isEmpty ? Center(child: NotAvailableText("Not found!"))
                        : Container(child: controller.listGrid.value == false
                        ? GridView.builder(
                        shrinkWrap: true,
                        itemCount: controller.getMyOffersListFilter.length,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: isMobile ? 2 / 2.5 : 2 / 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics (),
                        itemBuilder: (context, index) {
                          var data = controller.getMyOffersListFilter[index];
                          bool isConfirmingUser = false;
                          for (var i = 0; i < data.offerData!.ConfirmingSubscriber!.length; i++) {
                            if (data.offerData!.ConfirmingSubscriber![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()) {
                              isConfirmingUser = true;
                              break;
                            } else {
                              isConfirmingUser = false;
                            }
                          }
                          List <bool>isAllItemDone1 = [] ;
                          for(var p = 0 ; p < data.offerData!.offerItems!.length ; p++){
                            if( data.offerData!.offerItems![p].quantity.toString().trim() == "0"){
                              isAllItemDone1.add(true);
                            }else{
                              isAllItemDone1.add(false);
                            }
                          }
                          return FutureBuilder(
                              future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                              builder: (BuildContext
                              context, AsyncSnapshot<String>snapshot) {
                                return CommonVerticalForGridView(context,data,snapshot,
                                  data.offerData!.buyORsell == "COUNTER SELL" ||  data.offerData!.buyORsell == "COUNTER BUY"?true:false,
                                  controller.getMyOffersListFilter,index,
                                      (){tapOnOffer(context,data, data.offerData!.buyORsell == "COUNTER SELL" ||  data.offerData!.buyORsell == "COUNTER BUY" ?true:false, isConfirmingUser,isAllItemDone1).then((value) {
                                        controller.getUserOffer();
                                      });}, true,isAllItemDone1
                                    ,isConfirmingUser
                                );
                              });
                        })
                        : ListView.builder(
                      itemCount: controller.getMyOffersListFilter.length,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10),
                      itemBuilder: (context, index) {
                        var data = controller.getMyOffersListFilter[index];

                        bool isConfirmingUser = false;
                        for (var i = 0; i < data.offerData!.ConfirmingSubscriber!.length; i++) {
                          if (data.offerData!.ConfirmingSubscriber![i].id.toString().trim() ==
                              DataManager.getInstance().getuserId().toString().trim()) {
                            isConfirmingUser = true;
                            break;
                          } else {
                            isConfirmingUser = false;
                          }
                        }
                        List <bool>isAllItemDone1 = [] ;
                        for(var p = 0 ; p < data.offerData!.offerItems!.length ; p++){
                          if( data.offerData!.offerItems![p].quantity.toString().trim() == "0"){
                            print("");
                            isAllItemDone1.add(true);
                          }else{
                            isAllItemDone1.add(false);
                          }
                        }
                        return FutureBuilder(
                            future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                            builder: (BuildContext
                            context, AsyncSnapshot<String>snapshot) {
                              return CommonOfferCardListView(context,data,snapshot,
                                data.offerData!.buyORsell == "COUNTER SELL" ||  data.offerData!.buyORsell == "COUNTER BUY"?true:false,
                                controller.getMyOffersListFilter,index,
                                    (){tapOnOffer(context,data, data.offerData!.buyORsell == "COUNTER SELL" ||  data.offerData!.buyORsell == "COUNTER BUY" ?true:false, isConfirmingUser,isAllItemDone1).then((value) {
                                      controller.getUserOffer();
                                    });}, true,
                                  isAllItemDone1,isConfirmingUser
                              );
                            });
                      },
                    ),
                    ),
                  ),

                  ///Templates
                  RefreshIndicator(
                    onRefresh: () async{
                      await  controller.getUserTemplateOffer();
                      return Future.value();
                    },
                    child:  controller.isGetSubscriberTemplates.value == false
                        ? ShimmerTemplateGridViewBuilder(context)
                        : controller.getTemplateOfferList.isEmpty
                        ?  Center(
                      child: NotAvailableText("Not found!"),) : Container(
                      child: controller.listGrid.value == false ?
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: controller.getTemplateOfferList.length,
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: isMobile ? 2 / 2.4 : 2 / 1.8,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics (),
                          itemBuilder: (context, index) {
                            var data = controller.getTemplateOfferList[index];
                            bool  isCounterSellBuy = false ;
                            for(var i = 0 ; i<data.offerData!.counterdUser!.length; i++){
                              if(data.offerData!.counterdUser![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                                isCounterSellBuy = true;
                                break ;
                              }else{
                                isCounterSellBuy = false;
                              }
                            }
                            return FutureBuilder(future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                              builder: (BuildContextcontext, AsyncSnapshot<String>snapshot) {
                                return TemplateCardGridView(context,data,snapshot,isCounterSellBuy,controller.getTemplateOfferList,index);
                              },
                            );
                          }) :
                      ListView.builder(
                        itemCount: controller.getTemplateOfferList.length,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemBuilder: (context, index) {
                          var data = controller.getTemplateOfferList[index];
                          bool  isCounterSellBuy = false ;
                          for(var i = 0 ; i<data.offerData!.counterdUser!.length; i++){
                            if(data.offerData!.counterdUser![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                              isCounterSellBuy = true;
                              break ;
                            }else{
                              isCounterSellBuy = false;
                            }
                          }
                          return FutureBuilder(
                              future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                              builder: (BuildContext
                              context, AsyncSnapshot<String>snapshot) {
                                return CommonTemplateCardListView(context,data,snapshot,
                                  isCounterSellBuy,
                                  controller.getTemplateOfferList,index,
                                      (){tapOnTemplate(context,data);}, true,
                                );
                              });
                        },
                      ),
                    ),
                  ),

                  ///Favourites Offer
                  RefreshIndicator(
                    onRefresh: () async{
                      await  controller.getUserFavOffer();
                      return Future.value();
                    },
                    child: controller.isGetSubscriberFavOffer.value == false ?
                    ShimmerLoadingGridViewBuilder(context) :
                    controller.getFavoriteOfferList.isEmpty ?
                    Center(child: NotAvailableText("Not found!")
                    ) : Container(
                      child: controller.listGrid.value == false
                          ? GridView.builder(
                          shrinkWrap: true,
                          itemCount: controller.getFavoriteOfferList.length,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: isMobile ? 2 / 2.5 : 2 / 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics (),
                          itemBuilder: (context, index) {
                            var data = controller.getFavoriteOfferList[index];
                            bool isConfirmingUser = false;
                            for (var i = 0; i < data.offerData!.ConfirmingSubscriber!.length; i++) {
                              if (data.offerData!.ConfirmingSubscriber![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()) {
                                isConfirmingUser = true;
                                break;
                              } else {
                                isConfirmingUser = false;
                              }
                            }
                            bool  isCounterSellBuy = false ;
                            for(var i = 0 ; i<data.offerData!.counterdUser!.length; i++){
                              if(data.offerData!.counterdUser![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                                isCounterSellBuy = true;
                                break ;
                              }else{
                                isCounterSellBuy = false;
                              }
                            }
                            List <bool>isAllItemDone1 = [] ;
                            for(var p = 0 ; p < data.offerData!.offerItems!.length ; p++){
                              if( data.offerData!.offerItems![p].quantity.toString().trim() == "0"){
                                isAllItemDone1.add(true);
                              }else{
                                isAllItemDone1.add(false);
                              }
                            }
                            return FutureBuilder(
                                future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                                builder: (BuildContext
                                context, AsyncSnapshot<String>snapshot) {
                                  return CommonVerticalForGridView(context,data,snapshot,
                                    isCounterSellBuy,
                                    controller.getFavoriteOfferList,index, (){tapOnOffer(context,data, isCounterSellBuy, isConfirmingUser,isAllItemDone1).then((value) {
                                        controller.getUserFavOffer();
                                      });}, false,isAllItemDone1
                                    ,isConfirmingUser
                                  );
                                });
                          })
                          : ListView.builder(
                        itemCount: controller.getFavoriteOfferList.length,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemBuilder: (context, index) {
                          var data = controller.getFavoriteOfferList[index];

                          bool isConfirmingUser = false;
                          for(var i = 0 ; i<data.offerData!.ConfirmingSubscriber!.length; i++){
                            if(data.offerData!.ConfirmingSubscriber![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                              isConfirmingUser = true;
                              break ;
                            }else{
                              isConfirmingUser = false;
                            }
                          }

                          bool  isCounterSellBuy = false ;
                          for(var i = 0 ; i<data.offerData!.counterdUser!.length; i++){
                            if(data.offerData!.counterdUser![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                              isCounterSellBuy = true;
                              break ;
                            }else{
                              isCounterSellBuy = false;
                            }
                          }
                          List <bool>isAllItemDone1 = [] ;
                          for(var p = 0 ; p < data.offerData!.offerItems!.length ; p++){
                            if( data.offerData!.offerItems![p].quantity.toString().trim() == "0"){
                              print("");
                              isAllItemDone1.add(true);
                            }else{
                              isAllItemDone1.add(false);
                            }
                          }
                          return FutureBuilder(
                              future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                              builder: (BuildContext
                              context, AsyncSnapshot<String>snapshot) {
                                return CommonOfferCardListView(context,data,snapshot,
                                  isCounterSellBuy,
                                  controller.getFavoriteOfferList,index,
                                      (){tapOnOffer(context,data,isCounterSellBuy, isConfirmingUser,isAllItemDone1).then((value) {
                                        controller.getUserFavOffer();
                                      });}, false,isAllItemDone1
                                   , isConfirmingUser
                                );
                              });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}


