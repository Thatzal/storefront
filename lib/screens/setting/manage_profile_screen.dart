
import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapps/Apis/CommonApis.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Auth/login_screen.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/constant_function.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loader.dart';
import 'package:socialapps/constant/text_form_feild.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/controller/share_preferences.dart';
import 'package:socialapps/model/GetCategoryListModal.dart';
import 'package:socialapps/model/GetKYCListModel.dart';
import 'package:socialapps/model/GetSegmentListModal.dart';
import 'package:socialapps/model/GetSubSegmentListModal.dart';
import 'package:socialapps/model/GetUserAccountModal.dart';
import 'package:socialapps/model/PrefChoiseCategories.dart';
import 'package:socialapps/model/SkillSetListModel.dart';
import 'package:socialapps/model/classificationListModel.dart';
import 'package:socialapps/screens/Dashboard/dashboard_screen.dart';

import 'package:socialapps/screens/widgets/CategorySegmentSubSegmentAddEdit.dart';
import 'package:socialapps/screens/widgets/CollegeStudiesAddScreen.dart';
import 'package:socialapps/screens/widgets/DeleteDataPopUp.dart';
import 'package:socialapps/screens/widgets/NewAddressPickers/NewAddressPickerList.dart';
import 'package:socialapps/screens/widgets/RecognitionsScreen.dart';
import 'package:socialapps/screens/widgets/SchoolStudiesAddScreen.dart';
import 'package:socialapps/screens/widgets/ShowDurationPicker.dart';
import 'package:socialapps/screens/widgets/SimmerLoadingBuilder.dart';
import 'package:socialapps/screens/widgets/SkillSetsAddUpdateScreen.dart';
import 'package:socialapps/screens/widgets/WorkExperienceScreen.dart';
import 'package:socialapps/screens/widgets/kyc_documents_screen.dart';
import 'package:socialapps/screens/widgets/upload_image_camera.dart';
import '../../Apis/urls.dart';
import '../../common/style.dart';
import '../../constant/loading.dart';
import '../../../model/workExperiencesListModel.dart';
import '../../../model/CertificationListModel.dart';
import '../../../model/CollageListModel.dart';
import '../../../model/SchoolListModel.dart';

import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class ManageProfileScreen extends StatefulWidget {
  String From;
  ManageProfileScreen({Key? key,required this.From}) : super(key: key);

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {

  double TextFieldCommonHeight=38;
  String isAgreeTC = "";


  List<ClassificationListModel> ClassificationListPublic = [];
  List<ClassificationListModel> ClassificationListBussines = [];

  getClassification() async{
    var BodyPublic = {
      "type": "public"
    };
    var BodyBusiness = {
      "type": "business"
    };
   await DrawAuraAPi.getClassificationAPi(BodyParam:BodyPublic ,Endpoint:ApiUrls.getClassifications ).then((value) {
     print("value");
     print(value);
      setState((){
        ClassificationListPublic = value;
      });
    });
    await DrawAuraAPi.getClassificationAPi(BodyParam:BodyBusiness ,Endpoint:ApiUrls.getClassifications ).then((value) {
      setState((){
        ClassificationListBussines = value;
      });
    });
    isLoadingClassification = true;
  }

  bool isLoadingClassification =false;
  bool loader =false;
  String? selectedClassification;

  String? userProfileImagePath;
  String? userProfileImageURL;
  String? userBackImagePath;
  String? userBackImagePathURL;

  bool iSPlaceType = true;
  bool isAddressType = true;
  bool movable = true;
  bool isPublicType = true;
  bool isBuyPref = true;
  bool isSellPref = true;
  bool academy = false;
  bool experi = false;
  bool recog = false;
  bool exp = false;
  bool PlaceDetailsIsView = false;
  bool opting = true;
  bool isCloseConfirmedoffers = true;
  bool isNotOfferingReminder = true;
  bool isCurrentLocationOffers = true;
  String? userName;
  TextEditingController PrefSearchWindowPreferencesController = TextEditingController();
  TextEditingController PrefDefaultofferDurationController = TextEditingController();
  TextEditingController PrefOffermatchController = TextEditingController();

  TextEditingController profileDescriptionController = TextEditingController();
  TextEditingController profileEmailController = TextEditingController();
  TextEditingController UserDisplayNameController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();
  TextEditingController userAdressControler = TextEditingController();


  TextEditingController MaterialstatusController = TextEditingController();
  TextEditingController PassportNoController = TextEditingController();
  TextEditingController DateOfIssueController = TextEditingController();
  TextEditingController NationalityController = TextEditingController();
  TextEditingController DateTimeOfBirthController = TextEditingController();
  TextEditingController SexController = TextEditingController();
  TextEditingController ReligionController = TextEditingController();
  TextEditingController SubDevisionController = TextEditingController();
  TextEditingController CasteController = TextEditingController();
  TextEditingController SubCastController = TextEditingController();

  String DateTimeOfBirthApiValue = "";
  String DateTimeOfIssuesApiValue = "";
  String DateTimeOfIssuesApiValueTemp = "";
  String DateTimeOfBirthApiValueTemp = "";
  var maskFormatter = new MaskTextInputFormatter(
      mask: '##:##:##:##:##', filter: {"#": RegExp(r'[0-9]')});
  String DateOfIssueTemp = DateTime.now().toString();
  String DateOfBirthTemp = "";
  String SelectedGender = "";
  bool schoolLoader = false;
  bool collegeLoader = false;
  bool workExpiLoader = false;
  bool certificateLoader = false;
  var collegeDate;
  var schoolDate;
  var workExpiFromDate;
  var workExpiToDate;
  var certiFromDate;
  var certiToDate;
  var _token='';


  List<SchoolListData> SchoolDetailsList = [];
  List<CollegeListData> CollegeDetailsList = [];
  List<CertificationDataList> CertificationDetailsList = [];
  List<WorkExperiencesListData> WorkExperiencesDetailsList = [];
  List<SkillSetData> SkillSetsDetailsList = [];
  List<PrefChoiseCategoriesData> PrefChoiseCategoriesList = [];
  List<TextEditingController> serviceAreaList =[TextEditingController(text: "")];
  List<KYCDocData> KycDataList = [];
  String selectedMarriedStatus = "";
  List <String> marriedStatusList = [
    'Single',
    'Married',
    "Separated",
    "Live-in",
    "Other"
  ];
  @override
  void initState() {
    super.initState();
    load();
    DialogForKYCRequest(context);
    getClassification();
    FirebaseMessaging.instance.getToken().then((newToken){
      _token = newToken!;
    });
  }
  GetUserAccountModal ? UserAccountDetails;
  GetUserAccountResult? selectedUserValue;
  List<GetUserAccountResult> getUserAccountList=[];
  load(){
    loader=true;
    DrawAuraAPi.getSubscriberDetailsApi(userId: DataManager.getInstance().getuserId().toString()).then((value) async {
      if(mounted){
        setState(() {
          PrefOffermatchController.text = value["result"]["Offer_match_percentage"] == null ?"":value["result"]["Offer_match_percentage"];
          isSellPref = value["result"]["Want_to_sell"];
          isBuyPref = value["result"]["Want_to_Buy"];
          opting =value["result"]["Opt_Delivery"];
          isCloseConfirmedoffers = value["result"]["Close_Confirmed_Offers"];
          isCurrentLocationOffers = value["result"]["Ok_for_Current_location_Offers"];
          userName=value["result"]["username"] == null?"": value["result"]["username"];
          userProfileImageURL = value["result"]["profile_picture"] == null ? "": "${Url.IMAGE_URL}${value["result"]["profile_picture"].toString()}";
          userBackImagePathURL = value["result"]["page_picture"] == null ? "": "${Url.IMAGE_URL}${value["result"]["page_picture"].toString()}";
          UserDisplayNameController.text= value["result"]["displayname"]  == null?"": value["result"]["displayname"];
          profileDescriptionController.text=  value["result"]["desc"]  == null?"":"${value["result"]["desc"]}";
          profileEmailController.text= value["result"]["email"]  == null?"":"${value["result"]["email"]}";
          userPhoneNumberController.text= value["result"]["phonenumber"] == null?"":"${value["result"]["phonenumber"]}";
          secoundryMobileNumberController.text = value["result"]["additionalnumber"] == null?"":"${value["result"]["additionalnumber"]}";
          userAdressControler.text = value["result"]["operatingaddress"] == null?"": "${value["result"]["operatingaddress"]}";
          isPublicType =  "${value["result"]["businessORpublic"]}" == "public" ?true :false;
          iSPlaceType =  "${value["result"]["placeORperson"]}" == "person" ?false :true;
          selectedMarriedStatus  = value["result"]["maritalstatus"]  == null?"": "${value["result"]["maritalstatus"].toString().toCapitalized()}";
          PassportNoController.text = value["result"]["passportnumber"] == null?"":"${value["result"]["passportnumber"]}";
          NationalityController.text = value["result"]["nationality"] == null?"": "${value["result"]["nationality"]}";
          SelectedGender = "${value["result"]["gender"]}".toString().trim() == "M" ? "Male" : "${value["result"]["gender"]}".toString().trim() == "F" ? "Female" :"Other's";
          ReligionController.text = value["result"]["religion"] == null ? "": "${value["result"]["religion"]}";
          SubDevisionController.text =value["result"]["subreligion"]  == null ? "":"${value["result"]["subreligion"]}";
          CasteController.text = value["result"]["caste"]  == null ? "":"${value["result"]["caste"]}";
          SubCastController.text = value["result"]["subsect"] == null ? "":"${value["result"]["subsect"]}";
           selectedClassification = value["result"]["classification"]["id"] == null ? null: value["result"]["classification"]["id"].toString();
          print( "${value["result"]["classification"]}");
          print("cccccccccccccccccc");
          //selectedClassification = "${value["result"]["classification"]}" == "" || "${value["result"]["classification"]}" == "null"?null:"${value["result"]["classification"]}";
          // isBusinessType ? ClassificationListBussines.where((element) {
          //   element.name.toString() == "${value["result"]["classification"]}" ? selectedClassification = element.id.toString():null
          // } ) : ClassificationListBussines.where((element) {
          //   element.name.toString() == "${value["result"]["classification"]}" ? selectedClassification = element.id.toString():null
          // } )
          // "${value["result"]["classification"]}":"":
          // ClassificationListPublic.contains("${value["result"]["classification"]}")?
          // "${value["result"]["classification"]}":"";

          DateTimeOfIssuesApiValue = value["result"]["dateofissue"]  == null ? "":"${value["result"]["dateofissue"]}";
          DateOfIssueController.text = value["result"]["dateofissue"]  == null ? "":"${value["result"]["dateofissue"].toString().split(" ").first}";

          DateTimeOfBirthApiValue = value["result"]["dateofbirth"]  == null ? "":"${value["result"]["dateofbirth"]}";
          DateTimeOfBirthController.text = value["result"]["dateofbirth"]  == null ? "":"${value["result"]["dateofbirth"].toString().split(" ").first}";
          PrefSearchWindowPreferencesController.text = value["result"]["search_page_preferences"]  == null ? "":"${value["result"]["search_page_preferences"]}";
          PrefDefaultofferDurationController.text = value["result"]["deafault_offer_duration"] == null ?"": "${value["result"]["deafault_offer_duration"]}";
          isNotOfferingReminder = value["result"]["not_offering_reminder"];
          OfferViewChoicesList = value["result"]["home_page_preferences"] == null ?[]: value["result"]["home_page_preferences"].toString().contains(",") ? value["result"]["home_page_preferences"].toString().split(','):["${value["result"]["home_page_preferences"].toString()}"];
          loader=false;
          List serviceTemp = value["result"]["Current_Location"] == null ? []:jsonDecode("${value["result"]["Current_Location"]}");
          serviceAreaList = serviceTemp.isEmpty ? [TextEditingController(text: "")]: serviceTemp.map((e) => TextEditingController(text: e["Address"])).toList();
        });

      }

      DrawAuraAPi.getUserAccountsApi(MobileNumber: userPhoneNumberController.text.toString()).then((UserAccountRes) {
        print("getUserAccountsApi Call Done");
        if (UserAccountRes["status"] == 200) {
          if(mounted){
            setState(() {
              UserAccountDetails = GetUserAccountModal.fromJson(UserAccountRes);
              getUserAccountList = UserAccountDetails!.result!;
              for (var i = 0; i < getUserAccountList.length; i++) {
                if (getUserAccountList[i].id.toString().trim() ==
                    value["result"]["id"].toString().trim()) {
                  selectedUserValue = getUserAccountList[i];
                }
              }
            });
          }
        }
      });
    });
    for(var i = 0 ; i<7; i++){
      var body = {
        "user_id" : DataManager.getInstance().getuserId().toString().trim()
      };
      String endPoint = i ==0 ? "getSubscriberSchoolStudyList" : i == 1 ? "getSubscriberCollegeStudyList" : i == 2 ? "getSubscribersCertificationList" : i == 3 ? "getSubscribersWorkList" :i == 4 ?"getSubscriberSkillsList":i == 5 ? "getPreference": "getSubscriberKYCList";
      DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {

        if(value["status"] == 200 ){
          if(i == 0 ){
            if(mounted){
              setState(() {
                var data = SchoolListModel.fromJson(value);
                SchoolDetailsList = data.result!;
              });
            }
          }else if(i==1){
            if(mounted){
              setState(() {
                var data = CollegeListModel.fromJson(value);
                CollegeDetailsList = data.result!;
              });
            }
          }else if(i==2){
            if(mounted){
              setState(() {
                var data = CertificationListModel.fromJson(value);
                CertificationDetailsList = data.result!;
              });
            }
          }else if(i==3){
            if(mounted){
              setState(() {
                var data = WorkExperiencesListModel.fromJson(value);
                WorkExperiencesDetailsList = data.result!;
                loader=false;
              });
            }
          } else if(i==4){
            if(mounted){
              setState(() {
                var data = SkillSetListModel.fromJson(value);
                SkillSetsDetailsList = data.result!;
                loader=false;
              });
            }
          } else  if(i==5) {
            if(mounted){
              setState(() {
                var data = PrefChoiseCategories.fromJson(value);
                PrefChoiseCategoriesList = data.result!;
                print("data.result!");
                print(data.result!);
                loader=false;
              });
            }
          }else{
            if(mounted){
              setState(() {
                var data = GetKycListModel.fromJson(value);
                KycDataList = data.result!;
                print("data.result!");
                print(data.result!);
                print(KycDataList.length);
                loader=false;
              });
            }
          }
        }
      });
    }
  }

  bool accountSwitchLoader = false;
  /// Category Segment SubSegment
  TextEditingController secoundryMobileNumberController = TextEditingController();
  TextEditingController searchCategoryController = TextEditingController();
  TextEditingController searchSegmentController = TextEditingController();
  TextEditingController searchSubSegmentController = TextEditingController();
  var searchCategoryId = "";
  var searchSegmentId = "";
  var searchSubSegmentId = "";
  bool showOther = false;
  bool isloadNewCategory = false;
  int selectedCategoryIndex = -1;
  bool showOtherSegment = false;
  bool isloadNewSegment = false;
  int selectedSegmentIndex = -1;
  bool showOtherSubSegment = false;
  bool isloadNewSubSegment = false;
  bool segmentLoader=false;
  List<CategoryData> GetCategoryList = [];
  List<CategoryData> filterGetCategoryList = [];

  List<SegmentResult> getSegmentList = [];
  List<SegmentResult> filterGetSegmentList = [];

  List<SubSegmentResult> getSubSegmentList=[];
  List<SubSegmentResult> filterGetSubSegmentList=[];

  List SchoolStudiesList = [];
  List CollegesStudiesList = [];
  List WorkExperienceList = [];
  List RecognitionsList = [];
  List ExperienceList = [];
  bool isUpdateProfileLoading = false;

  final List<String> Gender = [
    'Male',
    'Female',
    "Other's"
  ];
  final _formKey = GlobalKey<FormState>();

  String YourFav = "";
  String YourOpen = "";
  String YourCounter = "";
  String YourConfirm = "";

  List <String> OfferViewChoicesList = [];
  bool isSaveChoice = false;

  DialogForKYCRequest(context){
    log( DataManager.getInstance().getUserIsPlaceType().toString() );
    Future.delayed(Duration(milliseconds: 1000),(){
      widget.From == "SignUp"?
      DataManager.getInstance().getUserIsPlaceType().toString() == "true" ?null:
      MessageShowDialogWithText(context,
          Text("Please add at least two document for KYC then you are eligible for publish the offer.",
            textAlign: TextAlign.center,style: BlackTitle500height,)
          ,(){
             Navigator.pop(context);
           }):null;
    }) ;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    var isMobile = ResponsiveHelper.isMobile(context);
    return Scaffold(
        backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(
          context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leadingWidth: 30,
              titleSpacing: 15,
              leading: widget.From == "SignUp"?SizedBox():Padding(
                padding: const EdgeInsets.only(left:5.0),
                child: InkWell(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back,color:Colors.black,size:24)),
              ),
              iconTheme: const IconThemeData(color: Colors.black),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: const Text("Manage Profile", style: AppBarTitle,)),
                  widget.From == "SignUp"?SizedBox():  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint:  Text('Choose Account', style: BlackTabStyle,),
                        items: getUserAccountList.map((item) => DropdownMenuItem<GetUserAccountResult>(
                          value: item,
                          child: Row(

                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(item.displayname.toString(), style: selectedUserValue!.displayname == item.displayname ?BlackTabStyle:BlackSubTitleStyle,),

                              ),

                            ],
                          ),
                        )).toList(),
                        value: selectedUserValue,
                        onChanged: (value) {
                          setState(() {
                            selectedUserValue = value;
                            accountSwitchLoader = true;
                          });
                          DrawAuraAPi().loginApi(phonenumber: selectedUserValue!.phonenumber,username: selectedUserValue!.username.toString(),
                              deviceToken: _token == ""? "eyAia2lkIjogIjhZTDNHM1JSWDciIH0.eyAiaXNzIjogIkM4Nk5WOUpYM0QiLCAiaWF0IjogIjE0NTkxNDM1ODA2NTAiIH0.MEYCIQDzqyahmH1rz1s-LFNkylXEa2lZ_aOCX4daxxTZkVEGzwIhALvkClnx5m5eAT6Lxw7LZtEQcH6JENhJTMArwLf3sXwi": _token.toString()
                          ).then((loginRes) async {

                            var body = {
                              "id":DataManager.getInstance().getuserId().toString(),
                              "deviceToken" : "",
                            };
                            final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
                            sharedpreferences.clear();
                            DrawAuraAPi.CreateDataApi(ApiEndPoint: "updateSubscriberProfile",body: body);

                            DrawAuraAPi.getSubscriberDetailsApi(userId: selectedUserValue!.id.toString()).then((OtpRes) {
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
                                  msg: "${Url.AccountSwitchMessage}",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Constants.primaryColor1,
                                  textColor: Colors.white,
                                  fontSize: 18.0
                              );
                              setState(() {
                                accountSwitchLoader = false;
                              });
                            });
                            //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManageProfileScreen(),));
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ManageProfileScreen(From: widget.From),));
                          });

                        },
                        iconStyleData: const IconStyleData(
                          icon: Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Icon(Icons.keyboard_arrow_down_rounded,
                                color: Constants.primaryColor1, size: 28),
                          ),
                        ),
                        buttonStyleData:  ButtonStyleData(
                          height: 40,
                          width: ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width*0.47:ResponsiveHelper.TabModeWidth/2,
                        ),
                        dropdownStyleData:  DropdownStyleData(
                            width: ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width*0.46:ResponsiveHelper.TabModeWidth/2
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),


            ),
            body:loader==true?const Center(child: LoadingWidget()):
            ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                SizedBox(
                  height: 210,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 150,
                        width: ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth,
                        child: userBackImagePath == null ?userBackImagePathURL == ""?  Image.asset("assets/placeholder_cover.png",fit: BoxFit.fill,): Image.network("${userBackImagePathURL}",fit: BoxFit.cover,):Image.file(File(userBackImagePath.toString()),fit: BoxFit.cover,),
                        //image:imageProfilefile==null && userProfileImage==null? DecorationImage(image: AssetImage("assets/homeProfileImage.png")):userProfileImage==null?DecorationImage(image: FileImage(imageProfilefile!),fit: BoxFit.cover):DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${userProfileImage}",), fit: BoxFit.fill),
                      ),
                      Positioned(
                        top: 80,
                        left: 20,
                        child: InkWell(
                          onTap: () async {
                            showModalBottomSheet(
                              constraints: BoxConstraints(maxWidth: ResponsiveHelper.isMobile(context)?MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth),
                              context: context,shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
                              builder: (BuildContext context) {
                                return SafeArea(
                                  child: Wrap(
                                    children: <Widget>[
                                      Padding(
                                        padding:  EdgeInsets.only(top:12.0),
                                        child: ListTile(
                                          leading: const Icon(Icons.photo_library,color: primaryColor,),
                                          minVerticalPadding: 0,
                                          dense: true,
                                          horizontalTitleGap: 10,
                                          title: const Text('Gallery',style: BlackFieldStyle54,),
                                          onTap: () async {
                                            final ImagePicker picker = ImagePicker();
                                            final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                            XFile? xfilePick = pickedFile;
                                            if (xfilePick != null) {
                                              ConstantFun.imageProfileCropper(path: pickedFile!.path).then((file) async {
                                                setState(() {
                                                  userProfileImagePath = file.path.toString();
                                                });
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
                                                  const SnackBar(content: Text('Nothing is selected',style: BlackFieldStyle,)));
                                            }
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                      ListTile(
                                          leading: const Icon(Icons.photo_camera,color: primaryColor,),
                                          title: const Text('Camera',style: BlackFieldStyle54,),
                                          minVerticalPadding: 0,
                                          dense: true,
                                          horizontalTitleGap: 10,
                                          onTap: () async {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageCameraScreen())).then((value) {
                                              Navigator.of(context).pop();
                                              if (value != null) {
                                                ConstantFun.imageProfileCropper(path: value).then((file) async {
                                                  setState(() {
                                                    userProfileImagePath = file.path.toString();
                                                  });
                                                });
                                              }else{
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar( // is this context <<<
                                                    const SnackBar(content: Text(
                                                        'Nothing is selected')));
                                              }
                                            });
                                          }
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );

                          },
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color:Colors.white,width: 2),
                              image: userProfileImagePath ==null?DecorationImage(image: NetworkImage(userProfileImageURL == "" ?"https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg": "${userProfileImageURL}"),fit: BoxFit.cover): DecorationImage(image: FileImage(File(userProfileImagePath.toString())),fit: BoxFit.cover),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 20,
                          top: 20,
                          child: InkWell(
                            onTap: () async {
                              showModalBottomSheet(
                                constraints: BoxConstraints(maxWidth: ResponsiveHelper.isMobile(context)?MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth),
                                context: context,shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
                                builder: (BuildContext context) {
                                  return SafeArea(
                                    child: Wrap(
                                      children: <Widget>[
                                        Padding(
                                          padding:  EdgeInsets.only(top:12.0),
                                          child: ListTile(
                                            leading: const Icon(Icons.photo_library,color: primaryColor,),
                                            minVerticalPadding: 0,
                                            dense: true,
                                            horizontalTitleGap: 10,
                                            title: const Text('Gallery',style: BlackFieldStyle54,),
                                            onTap: () async {
                                              final ImagePicker picker = ImagePicker();
                                              final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                              XFile? xfilePick = pickedFile;
                                              if (xfilePick != null) {
                                                ConstantFun.imageCropper(path: pickedFile!.path).then((file) async {
                                                  setState(() {
                                                    userBackImagePath = file.path.toString();
                                                  });
                                                });
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
                                                    const SnackBar(content: Text('Nothing is selected',style: BlackFieldStyle,)));
                                              }
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.photo_camera,color: primaryColor,),
                                          title: const Text('Camera',style: BlackFieldStyle54,),
                                          minVerticalPadding: 0,
                                          dense: true,
                                          horizontalTitleGap: 10,
                                          onTap: () async {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageCameraScreen())).then((value) {
                                              Navigator.of(context).pop();
                                                if (value != null) {
                                                  ConstantFun.imageCropper(path: value).then((file) async {
                                                    setState(() {
                                                      userBackImagePath = file.path.toString();
                                                    });
                                                  });
                                              }else{
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar( // is this context <<<
                                                    const SnackBar(content: Text(
                                                        'Nothing is selected')));
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(color: Colors.black45),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffe7e6e6),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "About Yourself as User / About Entity",
                          style: BlackTabStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: profileDescriptionController,
                            style:BlackHeadingStyle,
                            maxLines: 3,
                            decoration: const InputDecoration(
                                hintStyle: greyHintStyle,
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                fillColor: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Core Details", style: BlackTitleStyle,),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(" Name",style: BlackSubTitleStyle,),
                                ),
                                Container(
                                  height: 38,
                               //   width:ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.3:ResponsiveHelper.TabModeWidth * 0.3,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                  child: TextFormField(

                                    cursorColor: Constants.primaryColor1,
                                    controller: UserDisplayNameController,
                                    textAlign: TextAlign.start,
                                    style: BlackDescStyle,
                                    decoration: inputDecoration(context,hint: "Name", ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          5.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text("  User type",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 3),
                                height: 38,
                                width:ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.31:ResponsiveHelper.TabModeWidth * 0.31,
                                decoration: BoxDecoration(
                                    color:Colors.white,
                                    border: Border.all(color: Constants.lightGreen),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Person", style: BlackHintStyle,),
                                    Padding(
                                      padding: const EdgeInsets.only(left:3.0,right:3),
                                      child: FlutterSwitch(
                                        showOnOff: false,
                                        value: iSPlaceType,
                                        toggleSize: 20,
                                        padding: 1,
                                        height: 20,
                                        width: 35,valueFontSize: 14,
                                        activeColor: SwitchButtonActiveColor,
                                        inactiveColor:SwitchButtonActiveColor,
                                        onToggle: (newVal) async {
                                          // setState(() {
                                          //   iSPlaceType = !iSPlaceType;
                                          //
                                          // });
                                        },
                                      ),
                                    ),
                                    const Text("Place", style: BlackHintStyle,)
                                  ],
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),

                      const SizedBox(height: 8,),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 3),
                                height: 38,
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.26:ResponsiveHelper.TabModeWidth * 0.26,
                                decoration: BoxDecoration(
                                    color:Colors.white,
                                    border: Border.all(color: Constants.lightGreen),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Add", style: BlackHintStyle,),
                                    Padding(
                                      padding: const EdgeInsets.only(left:3.0,right:3),
                                      child: FlutterSwitch(
                                        showOnOff: false,
                                        value: isAddressType,
                                        toggleSize: 20,
                                        padding: 1,
                                        height: 20,
                                        width: 35,valueFontSize: 14,
                                        activeColor: SwitchButtonActiveColor,
                                        inactiveColor:SwitchButtonActiveColor,
                                        onToggle: (newVal) async {
                                          setState(() {
                                            isAddressType = !isAddressType;
                                          });
                                        },
                                      ),
                                    ),
                                    const Text("Area", style:  BlackHintStyle,)
                                  ],
                                ),
                              ),

                              const SizedBox(width: 2,),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                                height: 38,
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.28:ResponsiveHelper.TabModeWidth * 0.28,
                                decoration: BoxDecoration(
                                    color:Colors.white,
                                    border: Border.all(color: Constants.lightGreen),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    const Text("Movable", style:  BlackHintStyle,),
                                    Padding(
                                      padding: const EdgeInsets.only(left:5.0,right:3),
                                      child: FlutterSwitch(
                                        showOnOff: false,
                                        value: movable,
                                        toggleSize: 20,
                                        padding: 1,
                                        height: 20,
                                        width: 35,valueFontSize: 14,
                                        inactiveColor : Color(0xFFE3E8DE),
                                        activeColor: SwitchButtonActiveColor,
                                        onToggle: (newVal) async {
                                          setState(() {
                                            movable = !movable;
                                          });
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              const SizedBox(width: 2,),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 3),
                                height: 38,
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.36:ResponsiveHelper.TabModeWidth * 0.36,
                                decoration: BoxDecoration(
                                    color:Colors.white,
                                    border: Border.all(color: Constants.lightGreen),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Business", style:  BlackHintStyle,),
                                    Padding(
                                      padding: const EdgeInsets.only(left:3.0,right:3),
                                      child: FlutterSwitch(
                                        showOnOff: false,
                                        value: isPublicType,
                                        toggleSize: 20,
                                        padding: 1,
                                        height: 20,
                                        width: 35,valueFontSize: 14,
                                        activeColor: SwitchButtonActiveColor,
                                        inactiveColor: SwitchButtonActiveColor,
                                        onToggle: (newVal) async {
                                          setState(() {
                                            isPublicType = !isPublicType;
                                            selectedClassification = "";
                                          });
                                        },
                                      ),
                                    ),
                                    const Text("Public", style: BlackHintStyle,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          iSPlaceType ?SizedBox():  Positioned(
                              top:0,bottom: 0,left: 0,right: 0,
                              child:Container(
                                  color:Color(0xB3FFFFFF)
                              )
                          ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      iSPlaceType ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0,left: 2),
                            child: Text("Classification",style: BlackSubTitleStyle,),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                                isExpanded: true,
                                items: isPublicType?ClassificationListPublic.map((item) => DropdownMenuItem (
                                  value: item.id.toString(),
                                  child: Text(
                                    item.name.toString(),
                                    style: BlackDescStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )).toList():
                                ClassificationListBussines.map((item) => DropdownMenuItem (
                                  value: item.id.toString(),
                                  child: Text(
                                    item.name.toString(),
                                    style: BlackDescStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )).toList(),
                                value: selectedClassification ==""?null:selectedClassification,
                                onChanged: (newValue) {
                                setState((){
                                  selectedClassification = newValue.toString();
                                  print(selectedClassification);
                                });

                                },
                                hint: const Text(
                                    "Select Classification",
                                    style:BlackDescStyle
                                ),
                                      iconStyleData: const IconStyleData(
                                        icon: Padding(
                                          padding: EdgeInsets.only(left:0.0),
                                          child: Icon(Icons.keyboard_arrow_down_sharp,),
                                        ),
                                        iconSize: 20,
                                        iconEnabledColor: Colors.grey,
                                        iconDisabledColor:Colors.grey,
                                      ),
                                      buttonStyleData: ButtonStyleData(
                                          height:  38,
                                          width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.95:ResponsiveHelper.TabModeWidth * 0.95,
                                          padding: const EdgeInsets.only(left: 10, right: 3),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white,  border: Border.all(color:  Constants.lightGreen,width: 1)),
                                          elevation:  0,
                                          overlayColor: MaterialStateProperty.all(Colors.white)
                                      ),
                                      menuItemStyleData: MenuItemStyleData(
                                        height: 33,
                                        selectedMenuItemBuilder: (context, child) {
                                          return     Container(
                                            padding: const EdgeInsets.only(left: 0, right: 0),
                                            width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.95:ResponsiveHelper.TabModeWidth * 0.95,
                                            height: 30,color:Constants.primaryColor1,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // child,
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 0.0),
                                                  child:child
                                                ),
                                                 Padding(
                                                  padding: EdgeInsets.only(right: 5.0),
                                                  child: Icon(Icons.done,color: Colors.white,size: 20,),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        padding: const EdgeInsets.only(left: 8, right: 3),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,direction: DropdownDirection.left,
                                        padding: const EdgeInsets.only(left: 0, right: 0),
                                        width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.92:ResponsiveHelper.TabModeWidth * 0.92,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white,
                                            border: Border.all(color:  Constants.primaryColor1,width: 1)
                                        ),
                                        elevation: 0,
                                        scrollbarTheme: ScrollbarThemeData(
                                            radius:  const Radius.circular(20),
                                            thickness: MaterialStateProperty.all(5.0),
                                            minThumbLength: 20
                                        ),
                                        offset: const Offset(0, 0),
                                      ),


                                style:BlackFieldStyle

                            ),
                          ),
                          // DropdownButtonHideUnderline(
                          //   child: DropdownButton2(
                          //       isExpanded: true,
                          //       items:isBusinessType? ClassificationList.map((item) => DropdownMenuItem (
                          //         value: item,
                          //         child: Text(
                          //           item,
                          //           style: BlackDescStyle,
                          //           overflow: TextOverflow.ellipsis,
                          //         ),
                          //       )).toList():
                          //       ClassificationListPerson.map((item) => DropdownMenuItem (
                          //         value: item,
                          //         child: Text(
                          //           item,
                          //           style: BlackDescStyle,
                          //           overflow: TextOverflow.ellipsis,
                          //         ),
                          //       )).toList(),
                          //       value: selectedClassification==""?null:selectedClassification,
                          //       onChanged: (newValue) {
                          //         setState(() {
                          //           selectedClassification = newValue.toString();
                          //         });
                          //       },
                          //       hint: const Text(
                          //           "Classification",
                          //           style:BlackDescStyle
                          //       ),
                          //       iconStyleData: const IconStyleData(
                          //         icon: Padding(
                          //           padding: EdgeInsets.only(left:0.0),
                          //           child: Icon(Icons.keyboard_arrow_down_sharp,),
                          //         ),
                          //         iconSize: 20,
                          //         iconEnabledColor: Colors.grey,
                          //         iconDisabledColor:Colors.grey,
                          //       ),
                          //       buttonStyleData: ButtonStyleData(
                          //           height:  38,
                          //           width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.95:ResponsiveHelper.TabModeWidth * 0.95,
                          //           padding: const EdgeInsets.only(left: 10, right: 3),
                          //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white,  border: Border.all(color:  Constants.lightGreen,width: 1)),
                          //           elevation:  0,
                          //           overlayColor: MaterialStateProperty.all(Colors.white)
                          //       ),
                          //       menuItemStyleData: MenuItemStyleData(
                          //         height: 33,
                          //         selectedMenuItemBuilder: (context, child) {
                          //           return     Container(
                          //             padding: const EdgeInsets.only(left: 0, right: 0),
                          //             width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.95:ResponsiveHelper.TabModeWidth * 0.95,
                          //             height: 30,color:Constants.primaryColor1,
                          //             child: Row(
                          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 // child,
                          //                 Padding(
                          //                   padding: const EdgeInsets.only(left: 5.0),
                          //                   child: Text(
                          //                     "${selectedClassification}",
                          //                     style: White13400Style,
                          //                     overflow: TextOverflow.ellipsis,
                          //                   ),
                          //                 ),
                          //                  Padding(
                          //                   padding: EdgeInsets.only(right: 5.0),
                          //                   child: Icon(Icons.done,color: Colors.white,size: 20,),
                          //                 )
                          //               ],
                          //             ),
                          //           );
                          //         },
                          //         padding: const EdgeInsets.only(left: 8, right: 3),
                          //       ),
                          //       dropdownStyleData: DropdownStyleData(
                          //         maxHeight: 200,direction: DropdownDirection.left,
                          //         padding: const EdgeInsets.only(left: 0, right: 0),
                          //         width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.92:ResponsiveHelper.TabModeWidth * 0.92,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(5),
                          //             color: Colors.white,
                          //             border: Border.all(color:  Constants.primaryColor1,width: 1)
                          //         ),
                          //         elevation: 0,
                          //         scrollbarTheme: ScrollbarThemeData(
                          //             radius:  const Radius.circular(20),
                          //             thickness: MaterialStateProperty.all(5.0),
                          //             minThumbLength: 20
                          //         ),
                          //         offset: const Offset(0, 0),
                          //       ),
                          //
                          //       style:BlackFieldStyle
                          //
                          //   ),
                          // ),
                        ],
                      ):SizedBox(),
                      const SizedBox(height: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(" Address",style: BlackSubTitleStyle,),
                          ),
                          Container(
                            height: userAdressControler.text.length < 15 ?35:null,
                            width:isMobile?width:tabWidth,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxHeight: 150.0
                              ),
                              child: TextFormField(
                                cursorColor: Constants.primaryColor1,
                                readOnly: false,
                                maxLines: null,

                                controller: userAdressControler,
                                textAlign: TextAlign.start,
                                style: BlackFieldStyle,
                                decoration: inputDecoration(context,hint: "Enter your address",suffixIcon: InkWell(
                                    onTap:() async {
                                      Permission.location.request();
                                      var permissionNotificationStatus = await Permission.location.status;
                                      print(permissionNotificationStatus);
                                      if(permissionNotificationStatus.isGranted){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201),isAppPlaceView: false,isTitleSelectAsAddress: true ))).then((value) {
                                          setState(() {
                                            userAdressControler.text=value.toString();
                                          });
                                        });
                                      }else {
                                        Permission.location.request().then((value) async {
                                          //print("permission is NOT granted.");
                                          if (value.index == 1) {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201),isAppPlaceView: false ,isTitleSelectAsAddress: true))).then((value) {
                                              setState(() {
                                                userAdressControler.text=value.toString();
                                              });
                                            });

                                          }else{
                                            Constants.showToast("Please enabled location permission from setting for selection of address from map");
                                          }
                                        });
                                      }

                                    },
                                    child: Icon(Icons.location_on,color:Constants.primaryColor1,size:24))),

                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Mobile number",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                height: 38,
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  readOnly :true,
                                  cursorColor:Constants.primaryColor1,
                                  controller: userPhoneNumberController,
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.phone,
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "Phone Number", ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Email-ID",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                height: 38,
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  cursorColor:Constants.primaryColor1,
                                  controller: profileEmailController,
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.emailAddress,
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "E-mail", ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                      5.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text("Secondary mobile number",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                height: 38,
                                width:isMobile?width*0.91:tabWidth*0.91,
                              //  width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width :ResponsiveHelper.TabModeWidth ,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  readOnly :false,
                                  cursorColor:Constants.primaryColor1,
                                  controller: secoundryMobileNumberController,
                                  textAlign: TextAlign.start,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                                  keyboardType: TextInputType.phone,
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "Secondary phone number", ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                iSPlaceType ==false? Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xfffe7e6e6),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Marital Status",style: BlackSubTitleStyle,),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                    isExpanded: true,
                                    items:marriedStatusList.map((item) => DropdownMenuItem (
                                      value: item,
                                      child: Text(item,
                                        style:  BlackFieldStyle,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )).toList(),
                                    value: selectedMarriedStatus==""?null:selectedMarriedStatus,
                                    onChanged: (newValue) {
                                      setState(() {

                                        selectedMarriedStatus =  newValue.toString();
                                      });
                                    },
                                    hint: const Text(
                                        "Select status",
                                        style:greyHintStyle
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Padding(
                                        padding: EdgeInsets.only(right:0.0),
                                        child: Icon(Icons.keyboard_arrow_down_sharp,),
                                      ),
                                      iconSize: 20,
                                      iconEnabledColor: Colors.grey,
                                      iconDisabledColor:Colors.grey,
                                    ),
                                    buttonStyleData: ButtonStyleData(
                                        height:TextFieldCommonHeight,
                                        width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                        padding: const EdgeInsets.only(left: 10, right: 3),
                                        decoration: BoxDecoration(  color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Constants.lightGreen,)),
                                        overlayColor: MaterialStateProperty.all(Colors.white)
                                    ),
                                    menuItemStyleData: MenuItemStyleData(
                                      height: 33,
                                      selectedMenuItemBuilder: (context, child) {
                                        return     Container(
                                          padding: const EdgeInsets.only(left: 0, right: 0),
                                          width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.3:ResponsiveHelper.TabModeWidth * 0.3,
                                          height: 30,color:Constants.primaryColor1,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              child,
                                              const Padding(
                                                padding: EdgeInsets.only(right: 5.0),
                                                child: Icon(Icons.done,color: Colors.white,size: 20,),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      padding: const EdgeInsets.only(left: 8, right: 3),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      padding: const EdgeInsets.only(left: 0, right: 0),
                                      width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                          border: Border.all(color:  Constants.primaryColor1,width: 1)
                                      ),
                                      elevation: 1,
                                      scrollbarTheme: ScrollbarThemeData(
                                          radius:  const Radius.circular(20),
                                          thickness: MaterialStateProperty.all(5.0),
                                          minThumbLength: 20
                                      ),
                                      offset: const Offset(0, -5),
                                    ),

                                    style: BlackFieldStyle

                                ),
                              ),
                              // Container(
                              //   alignment: Alignment.center,
                              //   height:TextFieldCommonHeight,
                              //   width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                              //   decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(5),
                              //       border: Border.all(color: Colors.white)),
                              //   child: TextFormField(
                              //     cursorColor: Constants.primaryColor1,
                              //     controller: MaterialstatusController,
                              //     textAlign: TextAlign.start,
                              //     style: BlackFieldStyle,
                              //     decoration: inputDecoration(context,hint: "Marital Status"),
                              //   ),
                              // ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Passport No.",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height:TextFieldCommonHeight,
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.white)),
                                child: TextFormField(
                                  cursorColor: Constants.primaryColor1,
                                  controller: PassportNoController,
                                  textAlign: TextAlign.start,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(12)
                                  ],
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "Passport No."),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      7.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Date of issue",style: BlackSubTitleStyle,),
                              ),
                              Container (
                                alignment: Alignment.center,
                                height:TextFieldCommonHeight,
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.white)),
                                child: TextFormField(
                                  cursorColor: Constants.primaryColor1,
                                  onTap:(){
                                    showGeneralDialog(
                                        barrierColor: Colors.black.withOpacity(0.5),
                                        transitionBuilder: (context, a1, a2, widget) {
                                          return Transform.scale(
                                            scale: a1.value,
                                            child: Opacity(
                                                opacity: a1.value,
                                                child: Dialog(
                                                    clipBehavior: Clip.hardEdge,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    insetPadding: const EdgeInsets.symmetric(horizontal: 25),
                                                    backgroundColor: Colors.white,
                                                    child:SizedBox(
                                                      height: MediaQuery.of(context).size.height*0.3,
                                                      child:  Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Flexible(
                                                            child: Padding(
                                                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                                                child: CupertinoDatePicker(
                                                                  mode: CupertinoDatePickerMode.date,
                                                                  dateOrder: DatePickerDateOrder.dmy,
                                                                  use24hFormat: false,
                                                                  minuteInterval: 1,
                                                                  initialDateTime: DateTime.now(),
                                                                  onDateTimeChanged: (DateTime newDateTime) {
                                                                    setState((){
                                                                      print(DateFormat("dd-MM-yyyy HH:mm").format(newDateTime).toString());
                                                                      DateOfIssueTemp = DateFormat("dd-MM-yyyy").format(newDateTime).toString();
                                                                      DateTimeOfIssuesApiValueTemp = DateFormat("dd-MM-yyyy HH:mm").format(newDateTime).toString();
                                                                      print(DateOfIssueTemp);
                                                                    });
                                                                  },
                                                                  maximumDate: DateTime.now().add(const Duration(days: 25)),
                                                                )
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                                            child: ElevatedButton(
                                                              style: ButtonStyle(
                                                                  backgroundColor: MaterialStateProperty.all(Constants.primaryColor1 ),
                                                                  elevation: MaterialStateProperty.all(0),
                                                                  foregroundColor: MaterialStateProperty.all(Colors.transparent),
                                                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                                                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                                                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),)
                                                              ),
                                                              onPressed: () {
                                                                setState((){
                                                                  DateOfIssueController.text = DateOfIssueTemp;
                                                                  DateTimeOfIssuesApiValue = DateTimeOfIssuesApiValueTemp;
                                                                });
                                                                Navigator.pop(context);
                                                              },
                                                              child: const Padding(
                                                                padding: EdgeInsets.all(12.0),
                                                                child: Center(
                                                                  child: Text(
                                                                    'Save',
                                                                    style: WhiteSubTitleStyle,
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                )),
                                          );
                                        },
                                        transitionDuration: const Duration(milliseconds: 300),
                                        barrierDismissible: true,
                                        barrierLabel: '',
                                        context: context,
                                        pageBuilder: (BuildContext context, Animation<double> animation,
                                            Animation<double> secondaryAnimation) {
                                          return const Text('');
                                        }
                                    );
                                  },
                                  readOnly: true,
                                  controller: DateOfIssueController,
                                  textAlign: TextAlign.start,
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "Date of issue"),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Nationality",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height:TextFieldCommonHeight,
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.white)),
                                child: TextFormField(
                                  cursorColor: Constants.primaryColor1,
                                  controller: NationalityController,
                                  textAlign: TextAlign.start,
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "Nationality"),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                      7.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Date Of Birth",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height:TextFieldCommonHeight,
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.white)),
                                child: TextFormField(
                                  cursorColor:Constants.primaryColor1,
                                  readOnly: true,
                                  onTap: (){
                                    showGeneralDialog(
                                        barrierColor: Colors.black.withOpacity(0.5),
                                        transitionBuilder: (context, a1, a2, widget) {
                                          return Transform.scale(
                                            scale: a1.value,
                                            child: Opacity(
                                                opacity: a1.value,
                                                child: Dialog(
                                                    clipBehavior: Clip.hardEdge,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    insetPadding: const EdgeInsets.symmetric(horizontal: 25),
                                                    backgroundColor: Colors.white,
                                                    child:SizedBox(
                                                      height: MediaQuery.of(context).size.height*0.3,
                                                      child:  Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Flexible(
                                                            child: Padding(
                                                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                                                child: CupertinoDatePicker(
                                                                  mode: CupertinoDatePickerMode.date,
                                                                  dateOrder: DatePickerDateOrder.dmy,
                                                                  use24hFormat: false,
                                                                  minuteInterval: 1,
                                                                  initialDateTime:  DateTime.now().subtract(Duration(days: 3650)),
                                                                  onDateTimeChanged: (DateTime newDateTime) {
                                                                    setState((){
                                                                      DateOfBirthTemp = DateFormat("dd-MM-yyyy").format(newDateTime).toString();
                                                                      DateTimeOfBirthApiValueTemp = DateFormat("dd-MM-yyyy HH:mm").format(newDateTime).toString();
                                                                    });
                                                                  },
                                                                  maximumDate:  DateTime.now().subtract(Duration(days: 3649)),
                                                                )
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                                            child: ElevatedButton(
                                                              style: ButtonStyle(
                                                                  backgroundColor: MaterialStateProperty.all(Constants.primaryColor1 ),
                                                                  elevation: MaterialStateProperty.all(0),
                                                                  foregroundColor: MaterialStateProperty.all(Colors.transparent),
                                                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                                                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                                                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),)
                                                              ),
                                                              onPressed: () {
                                                                setState((){
                                                                  DateTimeOfBirthController.text = DateOfBirthTemp;
                                                                  DateTimeOfBirthApiValue = DateTimeOfBirthApiValueTemp;
                                                                });
                                                                Navigator.pop(context);
                                                              },
                                                              child: const Padding(
                                                                padding: EdgeInsets.all(12.0),
                                                                child: Center(
                                                                  child: Text(
                                                                    'Save',
                                                                    style: WhiteSubTitleStyle,
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                )),
                                          );
                                        },
                                        transitionDuration: const Duration(milliseconds: 300),
                                        barrierDismissible: true,
                                        barrierLabel: '',
                                        context: context,
                                        pageBuilder: (BuildContext context, Animation<double> animation,
                                            Animation<double> secondaryAnimation) {
                                          return const Text('');
                                        }
                                    );
                                  },
                                  controller: DateTimeOfBirthController,
                                  textAlign: TextAlign.start,
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "DateTime Of Birth"),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Gender",style: BlackSubTitleStyle,),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                    isExpanded: true,
                                    items:Gender.map((item) => DropdownMenuItem (
                                      value: item,
                                      child: Text(item,
                                        style:  BlackFieldStyle,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )).toList(),
                                    value: SelectedGender==""?null:SelectedGender,
                                    onChanged: (newValue) {
                                      setState(() {
                                        SexController.text = newValue!.toString();
                                        SelectedGender =  newValue.toString();
                                      });
                                    },
                                    hint: const Text(
                                        "Select Gender",
                                        style:greyHintStyle
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Padding(
                                        padding: EdgeInsets.only(right:0.0),
                                        child: Icon(Icons.keyboard_arrow_down_sharp,),
                                      ),
                                      iconSize: 20,
                                      iconEnabledColor: Colors.grey,
                                      iconDisabledColor:Colors.grey,
                                    ),
                                    buttonStyleData: ButtonStyleData(
                                        height:TextFieldCommonHeight,
                                        width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                        padding: const EdgeInsets.only(left: 10, right: 3),
                                        decoration: BoxDecoration(  color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Constants.lightGreen)),
                                        overlayColor: MaterialStateProperty.all(Colors.white)
                                    ),
                                    menuItemStyleData: MenuItemStyleData(
                                      height: 33,
                                      selectedMenuItemBuilder: (context, child) {
                                        return     Container(
                                          padding: const EdgeInsets.only(left: 0, right: 0),
                                          width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.3:ResponsiveHelper.TabModeWidth * 0.3,
                                          height: 30,color:Constants.primaryColor1,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              child,
                                              const Padding(
                                                padding: EdgeInsets.only(right: 5.0),
                                                child: Icon(Icons.done,color: Colors.white,size: 20,),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      padding: const EdgeInsets.only(left: 8, right: 3),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      padding: const EdgeInsets.only(left: 0, right: 0),
                                      width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                          border: Border.all(color:  Constants.primaryColor1,width: 1)
                                      ),
                                      elevation: 1,
                                      scrollbarTheme: ScrollbarThemeData(
                                          radius:  const Radius.circular(20),
                                          thickness: MaterialStateProperty.all(5.0),
                                          minThumbLength: 20
                                      ),
                                      offset: const Offset(0, -5),
                                    ),

                                    style: BlackFieldStyle

                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      7.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Religion",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height:TextFieldCommonHeight,
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.white)),
                                child: TextFormField(
                                  cursorColor:Constants.primaryColor1,
                                  controller: ReligionController,
                                  textAlign: TextAlign.start,
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "Religion"),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Sub-Devision",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height:TextFieldCommonHeight,
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.white)),
                                child: TextFormField(
                                  cursorColor: Constants.primaryColor1,
                                  controller: SubDevisionController,
                                  textAlign: TextAlign.start,
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "Sub-Devision"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      7.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Caste",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height:TextFieldCommonHeight,
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.white)),
                                child: TextFormField(
                                  cursorColor:Constants.primaryColor1,
                                  controller: CasteController,
                                  textAlign: TextAlign.start,
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "Caste"),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Sub-Caste Gothram",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height:TextFieldCommonHeight,
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.white)),
                                child: TextFormField(
                                  cursorColor:Constants.primaryColor1,
                                  controller: SubCastController,
                                  textAlign: TextAlign.start,
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "Sub-Caste Gothram"),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                      7.height,
                    ],
                  ),
                ):SizedBox(),
                iSPlaceType ==false?Container(

                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 11),
                  decoration: const BoxDecoration(color: Color(0xfffe7e6e6),border: Border(top: BorderSide(color: Colors.white,width: 1))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("KYC Document",style: BlackTitleStyle,),
                          Spacer(),
                          KycDataList.isEmpty? Row(
                            children:  [
                              Text("To Add: ",style: BlackSubTitleStyle,),
                              InkWell(
                                  onTap: (){
                                    KYCDocumentsPage(context,From: "New",KYDDocDetails: KYCDocData(),KycDataList: KycDataList,DocNo: "First").then((value) {
                                      var body = {
                                        "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                      };
                                      String endPoint = "getSubscriberKYCList";
                                      DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                        if(value["status"] == 200 ){
                                          if(mounted){
                                            setState(() {
                                              var data = GetKycListModel.fromJson(value);
                                              KycDataList = data.result!;
                                            });
                                          }
                                        }
                                      });
                                    }
                                    );
                                  },
                                  child: Icon(Icons.add_circle,color: Constants.primaryColor1,))
                            ],
                          ):SizedBox(),
                          KycDataList.isEmpty?SizedBox():Row(
                            children:  [

                              InkWell(
                                  onTap: (){
                                    KYCDocumentsPage(context,From: "Edit",KYDDocDetails:KycDataList.first,KycDataList: KycDataList ,DocNo: "First").then((value) {
                                      var body = {
                                        "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                      };
                                      String endPoint = "getSubscriberKYCList";
                                      DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                        if(value["status"] == 200 ){
                                          if(mounted){
                                            setState(() {
                                              var data = GetKycListModel.fromJson(value);
                                              KycDataList = data.result!;
                                            });
                                          }
                                        }
                                      });
                                    });
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Constants.primaryColor1,
                                      radius: 10,
                                      child: Icon(Icons.edit,color:Colors.white,size: 15,)))
                            ],
                          )
                        ],
                      ),
                      KycDataList.isEmpty?SizedBox():  Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0,top: 10),
                                child: Text(" Doc Type",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                height:TextFieldCommonHeight,
                                margin: EdgeInsets.only(top: 0,right: 10),
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.4:ResponsiveHelper.TabModeWidth * 0.4,
                                child: TextFormField(
                                  cursorColor: Constants.primaryColor1,
                                  controller: TextEditingController(text:  KycDataList.first.kycName.toString()),
                                  textAlign: TextAlign.start,
                                  readOnly: true,
                                  style:BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "Doc Type"),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0,top: 10),
                                child: Text(" ${KycDataList.first.kycName} Number",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                height:TextFieldCommonHeight,
                                margin: EdgeInsets.only(top: 0,right: 10),
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.4:ResponsiveHelper.TabModeWidth * 0.4,
                                child: TextFormField(
                                  cursorColor: Constants.primaryColor1,
                                  controller: TextEditingController(text:  KycDataList.first.kycId.toString()),
                                  textAlign: TextAlign.start,
                                  readOnly: true,
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "${KycDataList.first.kycName} Number"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      10.height,
                      KycDataList.isEmpty?SizedBox():  Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0,top: 10),
                                child: Text(" Mobile number",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                height:TextFieldCommonHeight,
                                margin: EdgeInsets.only(top: 0,right: 10),
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.3:ResponsiveHelper.TabModeWidth * 0.3,
                                child: TextFormField(
                                  cursorColor: Constants.primaryColor1,
                                  controller: TextEditingController(text:  KycDataList.first.phoneNumberOtp.toString()),
                                  textAlign: TextAlign.start,
                                  readOnly: true,
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "Mobile number"),
                                ),
                              ),
                            ],
                          ),
                          DottedBorder(
                            dashPattern: const [6, 2],
                            strokeWidth: 1.5,
                            color: Constants.primaryColor1,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(2),
                            child:SizedBox(height: 50, width: 80, child: Image.network("${Url.IMAGE_URL}${KycDataList.first.kycImageFront.toString()}",fit: BoxFit.fill,)),
                          ),
                          SizedBox(width: 10,),
                          DottedBorder(
                            dashPattern: const [6, 2],
                            strokeWidth: 1.5,
                            color: Constants.primaryColor1,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(2),
                            child:SizedBox(height: 50, width: 80, child: Image.network("${Url.IMAGE_URL}${KycDataList.first.kycImageBack.toString()}",fit: BoxFit.fill)),
                          )
                        ],
                      ),
                    ],
                  ),
                ):SizedBox(),
                iSPlaceType ==false?Container(

                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 11),
                  decoration: const BoxDecoration(color: Color(0xfffe7e6e6),border: Border(top: BorderSide(color: Colors.white,width: 1))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("KYC Document",style: BlackTitleStyle,),
                          Spacer(),
                          KycDataList.length == 1?Row(
                            children:  [
                              Text("To Add: ",style: BlackSubTitleStyle,),
                              InkWell(
                                  onTap: (){
                                    KYCDocumentsPage(context,From: "New",KYDDocDetails:KYCDocData(),KycDataList: KycDataList,DocNo: "2nd").then((value) {
                                      var body = {
                                        "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                      };
                                      String endPoint = "getSubscriberKYCList";
                                      DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                        if(value["status"] == 200 ){
                                          if(mounted){
                                            setState(() {
                                              var data = GetKycListModel.fromJson(value);
                                              KycDataList = data.result!;
                                            });
                                          }
                                        }
                                      });
                                    });
                                  },
                                  child: Icon(Icons.add_circle,color: Constants.primaryColor1,))
                            ],
                          ):SizedBox(),
                          KycDataList.length ==2?Row(
                            children:  [
                              InkWell(
                                  onTap: (){
                                    KYCDocumentsPage(context,From: "Edit",KYDDocDetails:KycDataList[1],KycDataList: KycDataList,DocNo: "2nd").then((value) {
                                      var body = {
                                        "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                      };
                                      String endPoint = "getSubscriberKYCList";
                                      DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                        if(value["status"] == 200 ){
                                          if(mounted){
                                            setState(() {
                                              var data = GetKycListModel.fromJson(value);
                                              KycDataList = data.result!;
                                            });
                                          }
                                        }
                                      });
                                    });
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Constants.primaryColor1,
                                      radius: 10,
                                      child: Icon(Icons.edit,color:Colors.white,size: 15,)))
                            ],
                          ):SizedBox()
                        ],
                      ),
                      KycDataList.length ==2? Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0,top: 10),
                                child: Text(" Doc Type",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                height:TextFieldCommonHeight,
                                margin: EdgeInsets.only(top: 0,right: 10),
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.4:ResponsiveHelper.TabModeWidth * 0.4,
                                child: TextFormField(
                                  cursorColor:Constants.primaryColor1,
                                  controller: TextEditingController(text:  KycDataList[1].kycName.toString()),
                                  textAlign: TextAlign.start,
                                  readOnly: true,
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "Doc Type"),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0,top: 10),
                                child: Text("  ${KycDataList[1].kycName} number",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                height:TextFieldCommonHeight,
                                margin: EdgeInsets.only(top: 0,right: 10),
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.4:ResponsiveHelper.TabModeWidth * 0.4,
                                child: TextFormField(
                                  cursorColor:Constants.primaryColor1,
                                  controller: TextEditingController(text:  KycDataList[1].kycId.toString()),
                                  textAlign: TextAlign.start,
                                  readOnly: true,
                                  style: BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "Doc number"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ):SizedBox(),
                      10.height,
                      KycDataList.length ==2? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0,top: 10),
                                child: Text(" Mobile number",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                height:38,
                                margin: EdgeInsets.only(top: 0,right: 10),
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.3:ResponsiveHelper.TabModeWidth * 0.3,
                                child: TextFormField(
                                  cursorColor: Constants.primaryColor1,
                                  controller: TextEditingController(text:  KycDataList[1].phoneNumberOtp.toString()),
                                  textAlign: TextAlign.start,
                                  readOnly: true,
                                  style:BlackFieldStyle,
                                  decoration: inputDecoration(context,hint: "Mobile number"),
                                ),
                              ),
                            ],
                          ),
                          DottedBorder(
                            dashPattern: const [6, 2],
                            strokeWidth: 1.5,
                            color: Constants.primaryColor1,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(2),
                            child:SizedBox(height: 50, width: 80, child: Image.network("${Url.IMAGE_URL}${KycDataList[1].kycImageFront.toString()}",fit: BoxFit.fill,)),
                          ),
                          SizedBox(width: 10,),
                          DottedBorder(
                            dashPattern: const [6, 2],
                            strokeWidth: 1.5,
                            color: Constants.primaryColor1,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(2),
                            child:SizedBox(height: 50, width: 80, child: Image.network("${Url.IMAGE_URL}${KycDataList[1].kycImageBack.toString()}",fit: BoxFit.fill)),
                          )
                        ],
                      ):SizedBox(),
                    ],
                  ),
                ):SizedBox(),
                iSPlaceType ==true?SizedBox():   academy==false?
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  decoration: const BoxDecoration(color: Color(0xfffe7e6e6),border: Border(top: BorderSide(color: Colors.white,width: 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Text("Academic Credentials(Click to expand)",style: BlackTitleStyle,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            academy=!academy;
                          });
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: const Text("+",style: BlackTitleUltraLargeBoldStyle,)),
                      ),
                    ],
                  ),
                ):
                SchoolDetailsList.isEmpty ?
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  decoration: const BoxDecoration(color: Color(0xfffe7e6e6),border: Border(top: BorderSide(color: Colors.white,width: 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Schools Studied",style:  BlackTitleStyle,),
                      Spacer(),
                      Row(
                        children:  [
                          Text("To Add: ",style: BlackSubTitleStyle,),
                          InkWell(
                              onTap: (){
                                SchoolStudiesAdd(context,From: "New",SchoolData: SchoolListData()).then((value) {
                                  var body = {
                                    "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                  };
                                  String endPoint = "getSubscriberSchoolStudyList";
                                  DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                    if(value["status"] == 200 ){
                                      if(mounted){
                                        setState(() {
                                          var data = SchoolListModel.fromJson(value);
                                          SchoolDetailsList = data.result!;
                                        });
                                      }
                                    }
                                  });
                                });
                              },
                              child: Icon(Icons.add_circle,color: Constants.primaryColor1,))
                        ],
                      ) ,

                    ],
                  ),
                ):
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: SchoolDetailsList.length,
                  itemBuilder: (context, index) {
                    var data = SchoolDetailsList[index];
                    return  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                      decoration: const BoxDecoration(color: Color(0xfffe7e6e6)),
                      child:  Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Schools Studied",style:  BlackTitleStyle,),
                              10.width,
                              InkWell(
                                onTap: (){
                                  SchoolStudiesAdd(context,From: "Edit",SchoolData: data).then((value) {
                                    var body = {
                                      "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                    };
                                    String endPoint = "getSubscriberSchoolStudyList";
                                    DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                      if(value["status"] == 200 ){
                                        if(mounted){
                                          setState(() {
                                            var data = SchoolListModel.fromJson(value);
                                            SchoolDetailsList = data.result!;
                                          });
                                        }
                                      }
                                    });
                                  });
                                },
                                child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Constants.primaryColor1,
                                    child: Icon(Icons.edit,color: Colors.white,size: 15,)),
                              ),
                              10.width,
                              InkWell(
                                onTap: (){
                                  Map<dynamic,String> bodyParam = {
                                    "school_id" :data.id.toString(),
                                  };
                                  DeleteDataPopUp(context,body:bodyParam ,ApiEndPoint: "deleteSubscriberSchoolStudy").then((value) {
                                    var body = {
                                      "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                    };
                                    String endPoint = "getSubscriberSchoolStudyList";
                                    DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                      if(value["status"] == 200 ){
                                        if(mounted){
                                          setState(() {
                                            var data = SchoolListModel.fromJson(value);
                                            SchoolDetailsList = data.result!;
                                          });
                                        }
                                      }
                                    });
                                  });
                                },
                                child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Constants.primaryColor1,
                                    child: Icon(Icons.delete,color: Colors.white,size: 15,)),
                              ),

                              Spacer(),
                              index == 0 ?  Row(
                                children:  [
                                  Text("To Add: ",style: BlackSubTitleStyle,),
                                  InkWell(
                                      onTap: (){
                                        SchoolStudiesAdd(context,From: "New",SchoolData: data).then((value) {
                                          var body = {
                                            "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                          };
                                          String endPoint = "getSubscriberSchoolStudyList";
                                          DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                            if(value["status"] == 200 ){
                                              if(mounted){
                                                setState(() {
                                                  var data = SchoolListModel.fromJson(value);
                                                  SchoolDetailsList = data.result!;
                                                });
                                              }
                                            }
                                          });
                                        });
                                      },
                                      child: Icon(Icons.add_circle,color: Constants.primaryColor1,))
                                ],
                              ) :   SizedBox(),
                              Spacer(),
                              index == 0 ?  InkWell(
                                onTap: (){
                                  setState(() {
                                    academy=!academy;
                                  });
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                                    child: const Text("-",style: BlackTitleUltraLargeBoldStyle,)),
                              ):SizedBox(),
                            ],
                          ),
                          index != 0?10.height:SizedBox(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" School name",style: BlackSubTitleStyle,),
                              ),
                              TextFormField(
                                controller: TextEditingController(text: data.schoolName.toString()),
                                style: BlackFieldStyle,
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter school name';
                                  }
                                  return null;
                                },
                                decoration: inputDecoration(context,hint: "School name", ),
                                // obscureText: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Column( crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Address",style: BlackSubTitleStyle,),
                              ),
                              TextFormField(
                                controller: TextEditingController(text: data.schoolAddress.toString()),
                                readOnly: true,
                                style: BlackFieldStyle,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter school address';
                                  }
                                  return null;
                                },
                                decoration: inputDecoration(context,hint: "Enter Address", ),
                                // obscureText: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" Standard / Form",style: BlackSubTitleStyle,),
                                  ),
                                  SizedBox(
                                    width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.3:ResponsiveHelper.TabModeWidth * 0.3,
                                    child: TextFormField(
                                      controller: TextEditingController(text: data.standardForm.toString()),
                                      readOnly: true,
                                      style: BlackFieldStyle,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter school standard';
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration(context,hint: "Standard / Form", ),
                                      // obscureText: true,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" Grade",style: BlackSubTitleStyle,),
                                  ),
                                  SizedBox(
                                    width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.25:ResponsiveHelper.TabModeWidth * 0.25,
                                    child: TextFormField(
                                      controller: TextEditingController(text: data.grade.toString()),
                                      readOnly: true,
                                      style: BlackFieldStyle,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Grade';
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration(context,hint: "Grade", ),
                                      // obscureText: true,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" Year of passing",style: BlackSubTitleStyle,),
                                  ),
                                  InkWell(
                                    onTap:(){
                                      // showMonthPicker(
                                      //   context: context,
                                      // selectedMonthBackgroundColor: Constants.primaryColor,
                                      //   initialDate: DateTime.now(),
                                      // ).then((date) {
                                      //   if (date != null) {
                                      //     // setState(() {
                                      //     //   data["SchoolMonthYearValue"] = DateFormat("MMM-yyyy").format(date);
                                      //     // });
                                      //   }
                                      // });
                                    },
                                    child: Container(
                                        height: 38,  width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.3:ResponsiveHelper.TabModeWidth * 0.3,
                                        decoration: BoxDecoration(color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.white),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            8.width,
                                            Text("${data.yearofpassing}", style:BlackFieldStyle),
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    );
                  },),
                iSPlaceType ==true?SizedBox():   academy==true?
                CollegeDetailsList.isEmpty ?
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  decoration: const BoxDecoration(color: Color(0xfffe7e6e6),border: Border(top: BorderSide(color: Colors.white,width: 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Colleges Studied",style:  BlackTitleStyle,),
                      Spacer(),
                      Row(
                        children:  [
                          Text("To Add: ",style: BlackSubTitleStyle,),
                          InkWell(
                              onTap: (){
                                CollegeStudiesAddUpdate(context,From: "New",CollegeData: CollegeListData()).then((value) {
                                  var body = {
                                    "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                  };
                                  String endPoint = "getSubscriberCollegeStudyList";
                                  DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                    if(value["status"] == 200 ){
                                      if(mounted){
                                        setState(() {
                                          var data = CollegeListModel.fromJson(value);
                                          CollegeDetailsList = data.result!;
                                        });
                                      }
                                    }
                                  });
                                });
                              },
                              child: Icon(Icons.add_circle,color: Constants.primaryColor1,))
                        ],
                      ) ,
                    ],
                  ),
                )
                    :
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: CollegeDetailsList.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = CollegeDetailsList[index];
                    return  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: const BoxDecoration(color: Colors.white),
                      child:Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Colleges Studied",style:  BlackTitleStyle,),
                              10.width,
                              InkWell(
                                onTap: (){
                                  CollegeStudiesAddUpdate(context,From: "Edit",CollegeData: data).then((value) {
                                    var body = {
                                      "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                    };
                                    String endPoint = "getSubscriberCollegeStudyList";
                                    DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                      if(value["status"] == 200 ){
                                        if(mounted){
                                          setState(() {
                                            var data = CollegeListModel.fromJson(value);
                                            CollegeDetailsList = data.result!;
                                          });
                                        }
                                      }
                                    });
                                  });
                                },
                                child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Constants.primaryColor1,
                                    child: Icon(Icons.edit,color: Colors.white,size: 15,)),
                              ),
                              10.width,
                              InkWell(
                                onTap: (){
                                  Map<dynamic,String> bodyParam = {
                                    "college_id" :data.id.toString()
                                  };
                                  DeleteDataPopUp(context,body:bodyParam ,ApiEndPoint: "deleteSubscriberCollegeStudy").then((value) {
                                    var body = {
                                      "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                    };
                                    String endPoint = "getSubscriberCollegeStudyList";
                                    DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                      if(value["status"] == 200 ){
                                        if(mounted){
                                          setState(() {
                                            var data = CollegeListModel.fromJson(value);
                                            CollegeDetailsList = data.result!;
                                          });
                                        }
                                      }
                                    });
                                  });
                                },
                                child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Constants.primaryColor1,
                                    child: Icon(Icons.delete,color: Colors.white,size: 15,)),
                              ),
                              Spacer(),
                              index == 0 ?  Row(
                                children:  [
                                  Text("To Add: ",style: BlackSubTitleStyle,),
                                  InkWell(
                                      onTap: (){
                                        CollegeStudiesAddUpdate(context,From: "New",CollegeData: data).then((value) {
                                          var body = {
                                            "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                          };
                                          String endPoint = "getSubscriberCollegeStudyList";
                                          DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                            if(value["status"] == 200 ){
                                              if(mounted){
                                                setState(() {
                                                  var data = CollegeListModel.fromJson(value);
                                                  CollegeDetailsList = data.result!;
                                                });
                                              }
                                            }
                                          });
                                        });
                                      },
                                      child: Icon(Icons.add_circle,color: Constants.primaryColor1,))
                                ],
                              ) :   SizedBox(),
                              Spacer(),
                              SizedBox()
                            ],
                          ),
                          10.height,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Institution name",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  controller: TextEditingController(text: data.collegeName.toString()),
                                  readOnly: true,
                                  style: BlackFieldStyle,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter college';
                                    }
                                    return null;
                                  },
                                  decoration: inputDecoration(context,hint: "Institution name", ),
                                  // obscureText: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Address",style: BlackSubTitleStyle,),
                              ),
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  controller: TextEditingController(text: data.collegeAddress.toString()),
                                  readOnly: true,
                                  style: BlackFieldStyle,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter address';
                                    }
                                    return null;
                                  },
                                  decoration: inputDecoration(context,hint: "Enter address", ),
                                  // obscureText: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" Degree",style: BlackSubTitleStyle,),
                                  ),
                                  Container(
                                    width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.32:ResponsiveHelper.TabModeWidth * 0.32,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                    child: TextFormField(
                                      controller: TextEditingController(text: data.degreeequivalent.toString()),
                                      readOnly: true,
                                      style: BlackFieldStyle,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter degree';
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration(context,hint: "Degree / Equivalent", ),
                                      // obscureText: true,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" Class",style: BlackSubTitleStyle,),
                                  ),
                                  Container(
                                    width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.3:ResponsiveHelper.TabModeWidth * 0.3,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                    child: TextFormField(
                                      controller: TextEditingController(text: data.classNo.toString()),
                                      readOnly: true,
                                      style: BlackFieldStyle,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter class';
                                        }
                                        return null;
                                      },
                                      decoration: inputDecoration(context,hint: "Class", ),
                                      // obscureText: true,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" Year of passing",style: BlackSubTitleStyle,),
                                  ),
                                  InkWell(
                                    onTap:(){

                                    },
                                    child: Container(
                                        height: 38,
                                        width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.28:ResponsiveHelper.TabModeWidth * 0.28,
                                        decoration: BoxDecoration(color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),border: Border.all(color: Constants.lightGreen),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            8.width,
                                            Text("${data.yearofpassing}", style:BlackFieldStyle),
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10,),

                        ],
                      ),
                    );
                  },):SizedBox(),
                const SizedBox(height: 1,),

                iSPlaceType ==true?SizedBox():   experi==false?
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  decoration: const BoxDecoration(color: Color(0xfffe7e6e6)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Text("Work Experience (Click to expand)",style: BlackTitleStyle,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            experi=!experi;
                          });
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: const Text("+",style: BlackTitleUltraLargeBoldStyle,)),
                      ),
                    ],
                  ),
                ):
                WorkExperiencesDetailsList.isEmpty?
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  decoration: const BoxDecoration(color: Color(0xfffe7e6e6),border: Border(top: BorderSide(color: Colors.white,width: 1))),
                  child:    Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Work Experiences",style:  BlackTitleStyle,),
                      Spacer(),
                      Row(
                        children:  [
                          Text("To Add: ",style: BlackSubTitleStyle,),
                          InkWell(
                              onTap: (){
                                WorkExperienceAddUpdate(context,From: "New",WorkExperienceData:  WorkExperiencesListData()).then((value) {
                                  var body = {
                                    "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                  };
                                  String endPoint = "getSubscribersWorkList";
                                  DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                    if(value["status"] == 200 ){
                                      if(mounted){
                                        setState(() {
                                          var data = WorkExperiencesListModel.fromJson(value);
                                          WorkExperiencesDetailsList = data.result!;
                                        });
                                      }
                                    }
                                  });
                                });
                              },
                              child: Icon(Icons.add_circle,color: Constants.primaryColor1,))
                        ],
                      ) ,

                    ],
                  ) ,
                )
                    :
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: WorkExperiencesDetailsList.length,
                  itemBuilder: (context, index) {
                    var data = WorkExperiencesDetailsList[index];
                    return  Container(
                      padding: const EdgeInsets.only(left: 15,right: 15,bottom: 5),
                      decoration: const BoxDecoration(color: Color(0xfffe7e6e6)),
                      child:  Column(
                        children: [
                          index != 0 ?5.height:SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Work Experiences",style:  BlackTitleStyle,),

                              10.width,
                              InkWell(
                                onTap: (){
                                  WorkExperienceAddUpdate(context,From: "Edit",WorkExperienceData: data).then((value) {
                                    var body = {
                                      "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                    };
                                    String endPoint = "getSubscribersWorkList";
                                    DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                      if(value["status"] == 200 ){
                                        if(mounted){
                                          setState(() {
                                            var data = WorkExperiencesListModel.fromJson(value);
                                            WorkExperiencesDetailsList = data.result!;
                                          });
                                        }
                                      }
                                    });
                                  });
                                },
                                child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Constants.primaryColor1,
                                    child: Icon(Icons.edit,color: Colors.white,size: 15,)),
                              ),
                              10.width,
                              InkWell(
                                onTap: (){
                                  Map<dynamic,String> bodyParam = {
                                    "work_id" :data.id.toString()
                                  };
                                  DeleteDataPopUp(context,body:bodyParam ,ApiEndPoint: "deleteSubscribersWork").then((value) {
                                    var body = {
                                      "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                    };
                                    String endPoint = "getSubscribersWorkList";
                                    DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                      if(value["status"] == 200 ){
                                        if(mounted){
                                          setState(() {
                                            var data = WorkExperiencesListModel.fromJson(value);
                                            WorkExperiencesDetailsList = data.result!;
                                          });
                                        }
                                      }
                                    });
                                  });
                                },
                                child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Constants.primaryColor1,
                                    child: Icon(Icons.delete,color: Colors.white,size: 15,)),
                              ),
                              Spacer(),
                              index == 0 ?  Row(
                                children:  [
                                  Text("To Add: ",style: BlackSubTitleStyle,),
                                  InkWell(
                                      onTap: (){
                                        WorkExperienceAddUpdate(context,From: "New",WorkExperienceData: data).then((value) {
                                          var body = {
                                            "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                          };
                                          String endPoint = "getSubscribersWorkList";
                                          DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                            if(value["status"] == 200 ){
                                              if(mounted){
                                                setState(() {
                                                  var data = WorkExperiencesListModel.fromJson(value);
                                                  WorkExperiencesDetailsList = data.result!;
                                                });
                                              }
                                            }
                                          });
                                        });
                                      },
                                      child: Icon(Icons.add_circle,color: Constants.primaryColor1,))
                                ],
                              ) :   SizedBox(),
                              Spacer(),
                              index == 0 ?  InkWell(
                                onTap: (){
                                  setState(() {
                                    experi=!experi;
                                  });
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                                    child: const Text("-",style: BlackTitleUltraLargeBoldStyle,)),
                              ):SizedBox(),
                            ],
                          ),
                          index != 0 ?10.height:SizedBox(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Company name",style: BlackSubTitleStyle,),
                              ),
                              TextFormField(
                                controller: TextEditingController(text: data.firmName.toString()),
                                readOnly: true,
                                style: BlackFieldStyle,
                                keyboardType: TextInputType.text,

                                decoration: inputDecoration(context,hint: "Company Name", ),
                                // obscureText: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Company Address",style: BlackSubTitleStyle,),
                              ),
                              TextFormField(
                                controller: TextEditingController(text: data.firmAddress.toString()),
                                readOnly: true,
                                style: BlackFieldStyle,
                                keyboardType: TextInputType.text,

                                decoration: inputDecoration(context,hint: "Company Address", ),
                                // obscureText: true,
                              ),
                            ],
                          ),


                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" Position",style: BlackSubTitleStyle,),
                                  ),
                                  SizedBox(
                                    width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                    child: TextFormField(
                                      controller: TextEditingController(text: data.designation.toString()),
                                      readOnly: true,
                                      style: BlackFieldStyle,
                                      keyboardType: TextInputType.text,

                                      decoration: inputDecoration(context,hint: "Designation / Position", ),
                                      // obscureText: true,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: Text(" Job Role",style: BlackSubTitleStyle,),
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(text: data.jobRole.toString()),
                                      readOnly: true,
                                      style: BlackFieldStyle,
                                      keyboardType: TextInputType.text,

                                      decoration: inputDecoration(context,hint: "Job Role", ),
                                      // obscureText: true,
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" From Date",style: BlackSubTitleStyle,),
                                  ),
                                  InkWell(
                                    onTap:(){

                                    },
                                    child: Container(
                                        height: 38,  width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                        decoration: BoxDecoration(color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),border: Border.all(color: Constants.lightGreen),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            8.width,
                                            Text("${data.fromperiod}", style:BlackFieldStyle),
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" To Date",style: BlackSubTitleStyle,),
                                  ),
                                  InkWell(
                                    onTap:(){
                                      // showMonthPicker(
                                      //   context: context,
                                      //   selectedMonthBackgroundColor: Constants.primaryColor,
                                      //   initialDate: DateTime.now(),
                                      // ).then((date) {
                                      //   if (date != null) {
                                      //     setState(() {
                                      //       data["CompanyTODateController"] = DateFormat("MMM-yyyy").format(date);
                                      //     });
                                      //   }
                                      // });
                                    },
                                    child: Container(
                                        height: 38,  width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                        decoration: BoxDecoration(color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),border: Border.all(color: Constants.lightGreen),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            8.width,
                                            Text("${data.toperiod}", style:BlackFieldStyle),
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    );
                  },),


                const SizedBox(height: 1,),
                iSPlaceType ==true?SizedBox():  recog==false?
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  decoration: const BoxDecoration(color: Color(0xfffe7e6e6)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Text("Recgn / Certifications (Click to expand)",style: BlackTitleStyle,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            recog=!recog;

                          });
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: const Text("+",style: BlackTitleUltraLargeBoldStyle,)),
                      ),
                    ],
                  ),
                ):
                CertificationDetailsList.isEmpty ?
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  decoration: const BoxDecoration(color: Color(0xfffe7e6e6),border: Border(top: BorderSide(color: Colors.white,width: 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Recgn /Certifications",style:  BlackTitleStyle,),
                      Spacer(),
                      Row(
                        children:  [
                          Text("To Add: ",style: BlackSubTitleStyle,),
                          InkWell(
                              onTap: (){
                                RecognitionsAddUpdate(context,From: "New",RecognitionsScreenData:  CertificationDataList()).then((value) {
                                  var body = {
                                    "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                  };
                                  String endPoint = "getSubscribersCertificationList";
                                  DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                    if(value["status"] == 200 ){
                                      if(mounted){
                                        setState(() {
                                          var data = CertificationListModel.fromJson(value);
                                          CertificationDetailsList = data.result!;
                                        });
                                      }
                                    }
                                  });
                                });
                              },
                              child: Icon(Icons.add_circle,color: Constants.primaryColor1,))
                        ],
                      ),

                    ],
                  ),
                )
                    :
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: CertificationDetailsList.length,
                  itemBuilder: (context, index) {
                    var data = CertificationDetailsList[index];
                    return  Container(
                      padding: const EdgeInsets.only(left: 15,right: 15,bottom: 5,),
                      decoration: const BoxDecoration(color: Colors.white),
                      child:  Column(
                        children: [
                          index != 0 ?5.height:SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Recgn /Certifications",style:  BlackTitleStyle,),

                              10.width,
                              InkWell(
                                onTap: (){
                                  RecognitionsAddUpdate(context,From: "Edit",RecognitionsScreenData:  data).then((value) {
                                    var body = {
                                      "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                    };
                                    String endPoint = "getSubscribersCertificationList";
                                    DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                      if(value["status"] == 200 ){
                                        if(mounted){
                                          setState(() {
                                            var data = CertificationListModel.fromJson(value);
                                            CertificationDetailsList = data.result!;
                                          });
                                        }
                                      }
                                    });
                                  });
                                },
                                child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Constants.primaryColor1,
                                    child: Icon(Icons.edit,color: Colors.white,size: 15,)),
                              ),
                              10.width,
                              InkWell(
                                onTap: (){
                                  Map<dynamic,String> bodyParam = {
                                    "certificate_id" :data.id.toString()
                                  };
                                  DeleteDataPopUp(context,body:bodyParam ,ApiEndPoint: "deleteSubscribersCertification").then((value) {
                                    var body = {
                                      "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                    };
                                    String endPoint = "getSubscribersCertificationList";
                                    DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                      if(value["status"] == 200 ){
                                        if(mounted){
                                          setState(() {
                                            var data = CertificationListModel.fromJson(value);
                                            CertificationDetailsList = data.result!;
                                          });
                                        }
                                      }
                                    });
                                  });
                                },
                                child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Constants.primaryColor1,
                                    child: Icon(Icons.delete,color: Colors.white,size: 15,)),
                              ),
                              Spacer(),
                              index == 0 ?  Row(
                                children:  [
                                  Text("To Add: ",style: BlackSubTitleStyle,),
                                  InkWell(
                                      onTap: (){
                                        RecognitionsAddUpdate(context,From: "New",RecognitionsScreenData:  data).then((value) {
                                          var body = {
                                            "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                          };
                                          String endPoint = "getSubscribersCertificationList";
                                          DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                            if(value["status"] == 200 ){
                                              if(mounted){
                                                setState(() {
                                                  var data = CertificationListModel.fromJson(value);
                                                  CertificationDetailsList = data.result!;
                                                });
                                              }
                                            }
                                          });
                                        });
                                      },
                                      child: Icon(Icons.add_circle,color: Constants.primaryColor1,))
                                ],
                              ) :   SizedBox(),
                              Spacer(),
                              index == 0 ?  InkWell(
                                onTap: (){
                                  setState(() {
                                    recog=!recog;
                                  });
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                                    child: const Text("-",style: BlackTitleUltraLargeBoldStyle,)),
                              ):SizedBox(),
                            ],
                          ),
                          index != 0 ?10.height:SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" Certification",style: BlackSubTitleStyle,),
                                  ),
                                  SizedBox(
                                    width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                    child:  TextFormField(
                                      controller: TextEditingController(text: data.certificate.toString()),
                                      readOnly: true,
                                      style: BlackFieldStyle,
                                      keyboardType: TextInputType.text,
                                      decoration: inputDecoration(context,hint: "Certification", ),
                                      // obscureText: true,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" Institution name",style: BlackSubTitleStyle,),
                                  ),
                                  SizedBox(
                                    width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                    child: TextFormField(
                                      controller: TextEditingController(text: data.institutionName.toString()),
                                      readOnly: true,
                                      style: BlackFieldStyle,
                                      keyboardType: TextInputType.text,
                                      decoration: inputDecoration(context,hint: "Institution Name", ),
                                      // obscureText: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" Institution Address",style: BlackSubTitleStyle,),
                                  ),
                                  SizedBox(
                                    width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                    child: TextFormField(
                                      controller: TextEditingController(text: data.institutionAddress.toString()),
                                      readOnly: true,
                                      style: BlackFieldStyle,
                                      keyboardType: TextInputType.text,
                                      decoration: inputDecoration(context,hint: "Institution Address", ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" Job role",style: BlackSubTitleStyle,),
                                  ),
                                  SizedBox(
                                    width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                    child: TextFormField(
                                      controller: TextEditingController(text: data.subject.toString()),
                                      readOnly: true,
                                      style: BlackFieldStyle,
                                      keyboardType: TextInputType.text,
                                      decoration: inputDecoration(context,hint: "Subject / Job Role", ),

                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),

                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" From date",style: BlackSubTitleStyle,),
                                  ),
                                  InkWell(
                                    onTap:(){
                                    },
                                    child: Container(
                                        height: 38, width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                        decoration: BoxDecoration(color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),border: Border.all(color: Constants.lightGreen),
                                        ),
                                        child: Row(

                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            8.width,
                                            Text("${data.fromperiod}", style:BlackFieldStyle),
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" To date",style: BlackSubTitleStyle,),
                                  ),
                                  InkWell(
                                    onTap:(){
                                    },
                                    child: Container(
                                        height: 38,  width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                        decoration: BoxDecoration(color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),border: Border.all(color: Constants.lightGreen),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            8.width,
                                            Text("${data.toperiod}", style:BlackFieldStyle),
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    );
                  },),


                const SizedBox(height: 1,),
                iSPlaceType ==true?SizedBox():   exp==false?
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  decoration: const BoxDecoration(color: Color(0xfffe7e6e6)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Text("Experience/Skill sets (Click to expand)",style: BlackTitleStyle,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            exp=!exp;
                          });
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: const Text("+",style: BlackTitleUltraLargeBoldStyle,)),
                      ),
                    ],
                  ),
                ):
                SkillSetsDetailsList.isEmpty ?
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  decoration: const BoxDecoration(color: Color(0xfffe7e6e6),border: Border(top: BorderSide(color: Colors.white,width: 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Experience/Skill sets",style:  BlackTitleStyle,),

                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:  [
                          Text("To Add: ",style: BlackSubTitleStyle,),
                          InkWell(
                              onTap: (){
                                SkillSetsAddUpdate(context,From: "New",SkillSetsScreenData:  SkillSetData()).then((value) {
                                  var body = {
                                    "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                  };
                                  String endPoint = "getSubscriberSkillsList";
                                  DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                    if(value["status"] == 200 ){
                                      if(mounted){
                                        setState(() {
                                          var data = SkillSetListModel.fromJson(value);
                                          SkillSetsDetailsList = data.result!;
                                        });
                                      }
                                    }
                                  });
                                });
                              },
                              child: Icon(Icons.add_circle,color: Constants.primaryColor1,))
                        ],
                      ) ,

                    ],
                  ),
                )
                    :
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: SkillSetsDetailsList.length,
                  itemBuilder: (context, index) {
                    var data = SkillSetsDetailsList[index];
                    return  Container(
                      padding: const EdgeInsets.only(left: 15,right: 15,bottom: 5,),
                      decoration: const BoxDecoration(color: Color(0xfffe7e6e6)),
                      child:  Column(
                        children: [
                          index != 0 ?5.height:SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Exp. /Skillsets",style:  BlackTitleStyle,),
                              8.width,
                              InkWell(
                                onTap: (){
                                  SkillSetsAddUpdate(context,From: "Edit",SkillSetsScreenData:  data).then((value) {
                                    var body = {
                                      "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                    };
                                    String endPoint = "getSubscriberSkillsList";
                                    DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                      if(value["status"] == 200 ){
                                        if(mounted){
                                          setState(() {
                                            var data = SkillSetListModel.fromJson(value);
                                            SkillSetsDetailsList = data.result!;
                                          });
                                        }
                                      }
                                    });
                                  });
                                },
                                child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Constants.primaryColor1,
                                    child: Icon(Icons.edit,color: Colors.white,size: 15,)),
                              ),
                              8.width,
                              InkWell(
                                onTap: (){
                                  Map<dynamic,String> bodyParam = {
                                    "skill_id" :data.id.toString()
                                  };
                                  DeleteDataPopUp(context,body:bodyParam ,ApiEndPoint: "deleteSubscriberSkills").then((value) {
                                    var body = {
                                      "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                    };
                                    String endPoint = "getSubscriberSkillsList";
                                    DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                      if(value["status"] == 200 ){
                                        if(mounted){
                                          setState(() {
                                            var data = SkillSetListModel.fromJson(value);
                                            SkillSetsDetailsList = data.result!;
                                          });
                                        }
                                      }
                                    });
                                  });
                                },
                                child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Constants.primaryColor1,
                                    child: Icon(Icons.delete,color: Colors.white,size: 15,)),
                              ),
                              Spacer(),
                              index == 0 ?  Row(
                                children:  [
                                  Text("To Add: ",style: BlackSubTitleStyle,),
                                  InkWell(
                                      onTap: (){
                                        SkillSetsAddUpdate(context,From: "New",SkillSetsScreenData:  SkillSetData()).then((value) {
                                          var body = {
                                            "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                          };
                                          String endPoint = "getSubscriberSkillsList";
                                          DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                            if(value["status"] == 200 ){
                                              if(mounted){
                                                setState(() {
                                                  var data = SkillSetListModel.fromJson(value);
                                                  SkillSetsDetailsList = data.result!;
                                                });
                                              }
                                            }
                                          });
                                        });
                                      },
                                      child: Icon(Icons.add_circle,color: Constants.primaryColor1,))
                                ],
                              ) :   SizedBox(),
                              Spacer(),
                              index == 0 ?  InkWell(
                                onTap: (){
                                  setState(() {
                                    exp=!exp;
                                  });
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                                    child: const Text("-",style: BlackTitleUltraLargeBoldStyle,)),
                              ):SizedBox(),
                            ],
                          ),
                          index != 0 ?10.height:SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" Project Name",style: BlackSubTitleStyle,),
                                  ),
                                  SizedBox(
                                    width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                    child:  TextFormField(
                                      controller:TextEditingController(text: data.projectName.toString()),
                                      readOnly: true,
                                      style: BlackHeadingStyle,
                                      keyboardType: TextInputType.text,
                                      decoration: inputDecoration(context,hint: "Project Name ", ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(" Institution name",style: BlackSubTitleStyle,),
                                  ),
                                  SizedBox(
                                    width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                    child: TextFormField(
                                      controller:TextEditingController(text: data.companyName.toString()),
                                      readOnly: true,
                                      style: BlackHeadingStyle,
                                      keyboardType: TextInputType.text,
                                      decoration: inputDecoration(context,hint: "Institution / Company", ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          10.height,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Experience / Skillset gained",style: BlackSubTitleStyle,),
                              ),
                              TextFormField(
                                controller:TextEditingController(text: data.experience.toString()),
                                readOnly: true,
                                style: BlackHeadingStyle,
                                keyboardType: TextInputType.text,
                                decoration: inputDecoration(context,hint: "Experience / Skillset gained (Summary)", ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },),



                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Preferences / Choices",style: BlackTitleStyle,),
                      PlaceDetailsIsView == true? SizedBox():   Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("To Add:",style: BlackSubTitleStyle,),
                          InkWell(
                            onTap: (){
                              setState(() {
                                PlaceDetailsIsView = true;
                              });
                            },
                            child: const Icon(
                              Icons.add_circle,
                              color:Constants.primaryColor1,size: 22,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            PlaceDetailsIsView = false;
                          });
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: PlaceDetailsIsView ?Icon(Icons.remove,color: Colors.black87,size:24):SizedBox()),
                      ),
                    ],
                  ),
                ),

                PlaceDetailsIsView? Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 15, ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(" Area of Offering", style: BlackSubTitleStyle,)),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: SizedBox(
                          height: 55,
                          child: ListView.builder (
                            scrollDirection: Axis.horizontal,
                            itemCount: serviceAreaList.length,
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0,top:8,bottom: 5,left: 1),
                                    child: Container(
                                      height: 35,
                                      padding: EdgeInsets.only(left:12),
                                      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Constants.lightGreen,width: 1), borderRadius: BorderRadius.circular(5)),
                                      width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45,
                                      child: TextFormField(
                                        controller: serviceAreaList[index],
                                        onTap:() async {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201),isAppPlaceView: true ,isTitleSelectAsAddress: true))).then((value) {
                                            setState(() {
                                              serviceAreaList[index].text=value.toString();
                                            });
                                          });
                                        },
                                        readOnly:true,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(hintText:"Offer Location", fillColor:  Colors.white, hintStyle: greyHintStyle,
                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                          border: const OutlineInputBorder(),
                                        ),
                                        style: Black87HintStyle,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom:12,left:2,
                                      child: InkWell(
                                        onTap:(){
                                          setState((){
                                            serviceAreaList.removeAt(index);
                                          });
                                        },
                                        child: CircleAvatar(
                                          radius:9,
                                          backgroundColor: Color(
                                              0x3389F6B9) ,
                                          child: Center(
                                              child:Icon(Icons.close,color: Colors.black,size:14,)
                                          ),
                                        ),
                                      )),
                                  serviceAreaList.length-1 == index?   Positioned(
                                      top:1,right:2,
                                      child: InkWell(
                                        onTap:(){
                                          setState((){
                                            serviceAreaList.add(TextEditingController()) ;
                                          });
                                        },
                                        child: CircleAvatar(
                                          radius:9,
                                          backgroundColor: Constants.primaryColor1 ,
                                          child: Center(
                                              child:Icon(Icons.add,color: Colors.white,size:14,)
                                          ),
                                        ),
                                      )):SizedBox()
                                ],
                              );
                            },),
                        ),
                      ),

                      Container(
                          color: Color(0xfffe7e6e6),
                          padding:EdgeInsets.symmetric(horizontal: 15,vertical: 10),

                          width: ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth,
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Category > Segment > Subsegment",style:  BlackTitleStyle,),

                                  Spacer(),
                                  Text("To Add: ",style: BlackSubTitleStyle,),
                                  InkWell(
                                      onTap: (){
                                        CategorySubSegAddUpdate(context,From: "New",PrefChoiseCategoriesDetaisl: PrefChoiseCategoriesData()).then((value) {
                                          var body = {
                                            "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                          };
                                          String endPoint = "getPreference";
                                          DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                            if(value["status"] == 200 ){
                                              if(mounted){
                                                setState(() {
                                                  var data = PrefChoiseCategories.fromJson(value);
                                                  PrefChoiseCategoriesList = data.result!;
                                                });
                                              }
                                            }
                                          });
                                        });
                                      },
                                      child: Icon(Icons.add_circle,color: Constants.primaryColor1,))

                                ],
                              ),

                              10.height,
                              PrefChoiseCategoriesList.isEmpty?
                              Text("Not Added any categories",style: greyFieldStyle,textAlign: TextAlign.center,)
                                  :   ListView.builder(
                                itemCount: PrefChoiseCategoriesList.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var data =  PrefChoiseCategoriesList[index];
                                  return   Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children:  [
                                        Flexible(
                                          child: Container(
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.white,
                                            ),

                                            child: TextFormField(
                                              controller: TextEditingController(text: "${data.category!.name} > ${data.segment!.name} > ${data.subsegment!.name}"),
                                              onTap:() async {
                                                // String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => NormalPlacePickerScreen("${ApiUrls.mapKey}")));
                                                // setState((){
                                                //   AreaOfOfferingLocation.text=result.toString();
                                                // });
                                              },
                                              readOnly:true,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(hintText:"Offer Location", fillColor:  Colors.white, hintStyle: greyHintStyle,
                                                focusedBorder:OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1, color: Constants.lightGreen
                                                    ),
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1, color: Constants.lightGreen
                                                    ),
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                border: const OutlineInputBorder(),
                                              ),
                                              style: BlackFieldStyle,
                                            ),
                                          ),
                                        ),
                                        10.width,
                                        InkWell(
                                          onTap: (){
                                            CategorySubSegAddUpdate(context,From: "Edit",PrefChoiseCategoriesDetaisl: data).then((value) {
                                              var body = {
                                                "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                              };
                                              String endPoint = "getPreference";
                                              DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                                if(value["status"] == 200 ){
                                                  if(mounted){
                                                    setState(() {
                                                      var data = PrefChoiseCategories.fromJson(value);
                                                      PrefChoiseCategoriesList = data.result!;
                                                    });
                                                  }
                                                }
                                              });
                                            });
                                          },
                                          child: CircleAvatar(
                                              radius: 10,
                                              backgroundColor: Constants.primaryColor1,
                                              child: Icon(Icons.edit,color: Colors.white,size: 15,)),
                                        ),
                                        8.width,
                                        InkWell(
                                          onTap: (){
                                            Map<dynamic,String> bodyParam = {
                                              "preference_id":data.id.toString()
                                            };
                                            DeleteDataPopUp(context,body:bodyParam ,ApiEndPoint: "deletePreference").then((value) {
                                              var body = {
                                                "user_id" : DataManager.getInstance().getuserId().toString().trim()
                                              };
                                              String endPoint = "getPreference";
                                              DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                                if(value["status"] == 200 ){
                                                  if(mounted){
                                                    setState(() {
                                                      var data = PrefChoiseCategories.fromJson(value);
                                                      PrefChoiseCategoriesList = data.result!;
                                                    });
                                                  }
                                                }
                                              });
                                            });
                                          },
                                          child: CircleAvatar(
                                              radius: 10,
                                              backgroundColor: Constants.primaryColor1,
                                              child: Icon(Icons.delete,color: Colors.white,size: 15,)),
                                        ),
                                      ],
                                    ),
                                  );
                                },)
                            ],
                          )
                      ),

                      10.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 52,
                              width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.25:ResponsiveHelper.TabModeWidth * 0.25,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Constants.lightGreen,width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text("Buy",style: BlackDescStyle,),
                                      5.height,
                                      FlutterSwitch(
                                        showOnOff: false,
                                        value: isBuyPref,
                                        toggleSize: 20,
                                        padding: 1,
                                        height: 20,
                                        width: 35,valueFontSize: 14,
                                        inactiveColor : Color(0xFFE3E8DE),
                                        activeColor: SwitchButtonActiveColor,
                                        onToggle: (newVal) async {
                                          setState(() {
                                            isBuyPref = !isBuyPref;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text("Sell",style: BlackDescStyle,) ,
                                      5.height,
                                      FlutterSwitch(
                                        showOnOff: false,
                                        value: isSellPref,
                                        toggleSize: 20,
                                        padding: 1,
                                        height: 20,
                                        width: 35,valueFontSize: 14,
                                        inactiveColor : Color(0xFFE3E8DE),
                                        activeColor: SwitchButtonActiveColor,
                                        onToggle: (newVal) async {
                                          setState(() {
                                            isSellPref = !isSellPref;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 52,
                              width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.27:ResponsiveHelper.TabModeWidth * 0.27,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Constants.lightGreen,width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child:  Column(
                                children: [
                                  const Text("Opting Delivery",style: BlackSubCardTitle,),
                                  5.height,
                                  FlutterSwitch(
                                    showOnOff: false,
                                    value: opting,
                                    toggleSize: 20,
                                    padding: 1,
                                    height: 20,
                                    width: 35,valueFontSize: 14,
                                    inactiveColor : Color(0xFFE3E8DE),
                                    activeColor: SwitchButtonActiveColor,
                                    onToggle: (newVal) async {
                                      setState(() {
                                        opting = !opting;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 52,
                              width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.39:ResponsiveHelper.TabModeWidth * 0.39,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Constants.lightGreen,width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child:  Column(
                                children: [
                                  const Text("Close Confirmed offers",style: BlackSubCardTitle,),
                                  5.height,
                                  FlutterSwitch(
                                    showOnOff: false,
                                    value: isCloseConfirmedoffers,
                                    toggleSize: 20,
                                    padding: 1,
                                    height: 20,
                                    width: 35,valueFontSize: 14,
                                    inactiveColor : Color(0xFFE3E8DE),
                                    activeColor: SwitchButtonActiveColor,
                                    onToggle: (newVal) async {
                                      setState(() {
                                        isCloseConfirmedoffers = !isCloseConfirmedoffers;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Flexible(
                              child: Container(
                                height: 52,
                               // width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.46:ResponsiveHelper.TabModeWidth * 0.46,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Constants.lightGreen,width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                child:  Column(
                                  children: [
                                    const Text("Current Location Offers",style: BlackDescStyle,),
                                    5.height,
                                    FlutterSwitch(
                                      showOnOff: false,
                                      value: isCurrentLocationOffers,
                                      toggleSize: 20,
                                      padding: 1,
                                      height: 20,
                                      width: 35,valueFontSize: 14,
                                      inactiveColor : Color(0xFFE3E8DE),
                                      activeColor: SwitchButtonActiveColor,
                                      onToggle: (newVal) async {
                                        setState(() {
                                          isCurrentLocationOffers = !isCurrentLocationOffers;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                height: 52,
                              margin: EdgeInsets.only(left: 5),
                              //  width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.43:ResponsiveHelper.TabModeWidth * 0.43,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Constants.lightGreen,width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                child:  Column(
                                  children: [
                                    const Text("Not Offering Reminder",style: BlackDescStyle,),
                                    5.height,
                                    FlutterSwitch(
                                      showOnOff: false,
                                      value: isNotOfferingReminder,
                                      toggleSize: 20,
                                      padding: 1,
                                      height: 20,
                                      width: 35,valueFontSize: 14,
                                      inactiveColor : Color(0xFFE3E8DE),
                                      activeColor: SwitchButtonActiveColor,
                                      onToggle: (newVal) async {
                                        setState(() {
                                          isNotOfferingReminder = !isNotOfferingReminder;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(" Default offer Duration(YY:MM:DD:HH:MI)",style: BlackSubTitleStyle,),
                            ),
                            Container(
                              height: 35,
                              padding:EdgeInsets.only(left:12),
                              decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 0.8,color: Constants.lightGreen), borderRadius: BorderRadius.circular(5)),
                              width: isMobile?width*0.95:tabWidth*0.95,
                              child: TextFormField(
                                inputFormatters: [maskFormatter],
                                controller: PrefDefaultofferDurationController,
                                keyboardType: TextInputType.number,

                                onTap:(){
                                  showDurationPicker(context,setState,PrefDefaultofferDurationController);
                                },
                                //readOnly: isSinglePeriodSelect==true?false:true,
                                readOnly: true,
                                decoration: InputDecoration(hintText: "YY : MM : DD : HH : MI", fillColor:  Colors.white, hintStyle: greyHintStyle,
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                  border: const OutlineInputBorder(),
                                  // hintText: 'Enter Query',hintStyle: hintstyle,
                                ),

                                style: Black87HintStyle,
                              ),
                            ),
                            // Container(
                            //   height: 35,
                            //   padding:EdgeInsets.only(left:12),
                            //   decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       border: Border.all(color: Constants.lightGreen,width: 1),
                            //       borderRadius: BorderRadius.circular(5)
                            //   ),
                            //   width: isMobile?width:tabWidth,
                            //   child: TextFormField(
                            //     inputFormatters: [maskFormatter],
                            //     controller:  PrefDefaultofferDurationController,
                            //     keyboardType: TextInputType.number,
                            //
                            //     onFieldSubmitted: (value){
                            //       print(value);
                            //       String empty = "";
                            //       int years =  value!.length < 2 ?int.parse(value) :int.parse(value.split(":").first);
                            //       int months =  value.length > 3 ?int.parse(value.split(":")[1]):0;
                            //       int days =  value.length > 5 ?int.parse(value.split(":")[2]):0;
                            //       int hours =  value.length > 7 ?int.parse(value.split(":")[3]):0;
                            //       int min =  value.length > 9 ?int.parse(value.split(":")[4]):0;
                            //       setState(() {
                            //         PrefDefaultofferDurationController.text ="${years != 0 ? '${years} Years': empty} ${ months != 0 ? '${months} Months': empty } ${days != 0 ?'${days} Days': empty } ${ hours != 0 ?'${hours} Hours': empty } ${ min != 0 ?'${min} Minutes': empty}";
                            //       });
                            //       print(PrefDefaultofferDurationController.text);
                            //     },
                            //
                            //     decoration: InputDecoration(
                            //       hintText: "YY : MM : DD : HH : MI", fillColor:  Colors.white, hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 12),
                            //       focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                            //       enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                            //       floatingLabelBehavior: FloatingLabelBehavior.never,
                            //       contentPadding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                            //       border: const OutlineInputBorder(),
                            //       // hintText: 'Enter Query',hintStyle: hintstyle,
                            //     ),
                            //     style: Black87HintStyle,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      10.height,
                      Padding(
                        padding:    EdgeInsets.symmetric(horizontal: 10,
                      ),
                        child:  Container(

                          width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(" Offer match (0 to 100)%",style: BlackSubTitleStyle,),
                              ),
                              TextFormField(
                                key: _formKey,autovalidateMode: AutovalidateMode.onUserInteraction,
                                cursorColor: Constants.primaryColor1,
                                controller: PrefOffermatchController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.number,

                                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3),],
                                style: BlackFieldStyle,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "Please enter valid value";
                                  }else{
                                    if ( int.parse(value.toString()) > 100 ) {
                                      return 'Please enter between 0 to 100';
                                    }
                                    return null;
                                  }
                                },
                                decoration: inputDecoration(context,hint: "Offer match %"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      10.height,
                      Container(
                          color: Color(0xfffe7e6e6),
                          padding:EdgeInsets.symmetric(horizontal: 10,vertical: 10),

                          width: ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth,
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Select your view order",style:  BlackTitleStyle,),

                                  Spacer(),
                                  Text("Select: ",style: BlackSubTitleStyle,),
                                  InkWell(
                                      onTap: (){
                                        showDialog(
                                          context: context, builder: (context) {
                                          return StatefulBuilder(builder: (context, setModalState) {
                                            return Dialog(
                                              insetPadding: EdgeInsets.symmetric(horizontal: 20),
                                              child: Container(
                                                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width*0.9 :ResponsiveHelper.TabModeWidth*0.9 ,
                                                //height: MediaQuery.of(context).size.height*0.45,
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                                  children: [

                                                    Text("Select any two choices for viewing.",style: BlackTitleBoldStyle15500,),
                                                    10.height,
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("1. YOUR FAVOURITES",style: Black87HintStyle,),
                                                        Checkbox(
                                                          value: OfferViewChoicesList.contains("YOUR FAVOURITES")?true:false,
                                                          checkColor: Colors.white,
                                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                          activeColor: Constants.primaryColor1,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                                          onChanged: (bool? vaue) {
                                                            setModalState((){
                                                              if(OfferViewChoicesList.length == 2 ){
                                                                if(  OfferViewChoicesList.contains("YOUR FAVOURITES")){
                                                                  OfferViewChoicesList.remove("YOUR FAVOURITES");
                                                                }else{
                                                                  OfferViewChoicesList.removeAt(0);
                                                                  OfferViewChoicesList.add("YOUR FAVOURITES");
                                                                }
                                                              }else{
                                                                OfferViewChoicesList.contains("YOUR FAVOURITES") ? OfferViewChoicesList.remove("YOUR FAVOURITES"):
                                                                OfferViewChoicesList.add("YOUR FAVOURITES");
                                                              }
                                                            });
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                    10.height,
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("2. YOUR OPEN OFFERS",style: Black87HintStyle,),
                                                        Checkbox(
                                                          value: OfferViewChoicesList.contains("YOUR OPEN OFFERS")?true:false,
                                                          checkColor: Colors.white,
                                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                          activeColor: Constants.primaryColor1,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                                          onChanged: (bool? vaue) {
                                                            setModalState((){
                                                              if(OfferViewChoicesList.length == 2 ){
                                                                if(  OfferViewChoicesList.contains("YOUR OPEN OFFERS")){
                                                                  OfferViewChoicesList.remove("YOUR OPEN OFFERS");
                                                                }else{
                                                                  OfferViewChoicesList.removeAt(0);
                                                                  OfferViewChoicesList.add("YOUR OPEN OFFERS");
                                                                }
                                                              }else{
                                                                OfferViewChoicesList.contains("YOUR OPEN OFFERS") ? OfferViewChoicesList.remove("YOUR OPEN OFFERS"):
                                                                OfferViewChoicesList.add("YOUR OPEN OFFERS");
                                                              }
                                                            });

                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    10.height,
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("3. YOUR COUNTERS",style: Black87HintStyle,),
                                                        Checkbox(
                                                          value: OfferViewChoicesList.contains("YOUR COUNTERS")?true:false,
                                                          checkColor: Colors.white,
                                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                          activeColor: Constants.primaryColor1,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                                          onChanged: (bool? vaue) {
                                                            setModalState((){
                                                              if(OfferViewChoicesList.length == 2 ){
                                                                if(  OfferViewChoicesList.contains("YOUR COUNTERS")){
                                                                  OfferViewChoicesList.remove("YOUR COUNTERS");
                                                                }else{
                                                                  OfferViewChoicesList.removeAt(0);
                                                                  OfferViewChoicesList.add("YOUR COUNTERS");
                                                                }
                                                              }else{
                                                                OfferViewChoicesList.contains("YOUR COUNTERS") ? OfferViewChoicesList.remove("YOUR COUNTERS"):
                                                                OfferViewChoicesList.add("YOUR COUNTERS");
                                                              }
                                                            });

                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    10.height,
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("4. YOUR CONFIRMED OFFERS",style: Black87HintStyle,),
                                                        Checkbox(
                                                          value: OfferViewChoicesList.contains("YOUR CONFIRMED OFFERS")?true:false,
                                                          checkColor: Colors.white,
                                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                          activeColor: Constants.primaryColor1,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                                          onChanged: (bool? vaue) {
                                                            setModalState((){
                                                              if(OfferViewChoicesList.length == 2 ){
                                                                if(  OfferViewChoicesList.contains("YOUR CONFIRMED OFFERS")){
                                                                  OfferViewChoicesList.remove("YOUR CONFIRMED OFFERS");
                                                                }else{
                                                                  OfferViewChoicesList.removeAt(0);
                                                                  OfferViewChoicesList.add("YOUR CONFIRMED OFFERS");
                                                                }
                                                              }else{
                                                                OfferViewChoicesList.contains("YOUR CONFIRMED OFFERS") ? OfferViewChoicesList.remove("YOUR CONFIRMED OFFERS"):
                                                                OfferViewChoicesList.add("YOUR CONFIRMED OFFERS");
                                                              }
                                                            });

                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    20.height,
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ElevatedButton(
                                                          style:ElevatedButton.styleFrom(
                                                              elevation: 0,
                                                              backgroundColor: primaryColor,
                                                              fixedSize: Size(   ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width * 0.45:ResponsiveHelper.TabModeWidth * 0.45, 40)
                                                          ),
                                                          onPressed: (){
                                                            if(OfferViewChoicesList.isNotEmpty){
                                                              isSaveChoice = true;
                                                              var body = {
                                                                "id":DataManager.getInstance().getuserId().toString(),
                                                                "home_page_preferences" : OfferViewChoicesList.length == 1? "${OfferViewChoicesList.first}":"${OfferViewChoicesList[0]},${OfferViewChoicesList[1]}"
                                                              };
                                                              DrawAuraAPi.CreateDataApi(ApiEndPoint: "updateSubscriberProfile",body: body).then((value) {
                                                                if(value["status"] == "200"){
                                                                  setModalState((){
                                                                    isSaveChoice = false;
                                                                  });
                                                                  SharePre.setOfferChoice(value["result"]["home_page_preferences"].toString());
                                                                  Navigator.pop(context);
                                                                  Constants.showToast(value["message"]);
                                                                }else{
                                                                  setModalState((){
                                                                    isSaveChoice = false;
                                                                  });
                                                                  Navigator.pop(context);
                                                                }
                                                              });
                                                            }else{
                                                              Constants.showToast("Please select your preferences");
                                                            }
                                                          }, child: isSaveChoice ? SizedBox(height: 28,width: 28,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)) :  Text("Save",style: WhiteButtonStyle,),),
                                                      ],
                                                    )

                                                  ],
                                                ),
                                              ),
                                            );
                                          },);
                                        },);

                                      },
                                      child: Icon(Icons.add_circle,color: Constants.primaryColor1,))

                                ],
                              ),

                              10.height,
                              const Text("Agree terms and services of THATZAL app ?",style:  BlackTitleStyle,),
                              10.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Container(
                                    width: 65,height: 35,
                                    decoration: BoxDecoration(
                                        color: isAgreeTC == "y"? Colors.white:Colors.transparent,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color:Colors.white,width: 1)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(

                                          height: 25,width: 25,
                                          child: Radio(
                                              value: "y",
                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              groupValue: isAgreeTC,
                                              activeColor: Constants.primaryColor1,
                                              fillColor: MaterialStateColor.resolveWith((states) => isAgreeTC == "y" ?Constants.primaryColor1:Colors.grey.shade400),
                                              onChanged: (value){
                                                setState(() {
                                                  isAgreeTC = value!;
                                                });
                                              }
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 2.0,left:3),
                                          child: Text("Yes",style: isAgreeTC == "y"? BlackDescStyle:greyHintStyle,),
                                        )
                                      ],
                                    ),
                                  ),
                                  25.width,
                                  Container(
                                    width: 65,height: 35,
                                    decoration: BoxDecoration(

                                        color: isAgreeTC == "n"? Colors.white:Colors.transparent,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color:Colors.white,width: 1)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(

                                          height: 25,width: 25,
                                          child: Radio(
                                              fillColor: MaterialStateColor.resolveWith((states) => isAgreeTC == "n" ?Constants.primaryColor1:Colors.grey.shade400),
                                              value: "n",
                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              groupValue: isAgreeTC,
                                              activeColor: Constants.primaryColor1,
                                              onChanged: (value){
                                                setState(() {
                                                  isAgreeTC = value!;
                                                });
                                              }
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(right: 2.0,left:3),
                                          child: Text("No",style: isAgreeTC == "n"? BlackDescStyle:greyHintStyle,),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              10.height,

                            ],
                          )
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(bottom: 5.0,left: 15),
                      //       child: Text(" Search Window Preferences",style: BlackSubTitleStyle,),
                      //     ),
                      //     Container(
                      //       padding: const EdgeInsets.symmetric(horizontal: 15, ),
                      //       width: MediaQuery.of(context).size.width,
                      //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      //       child: TextFormField(
                      //         cursorColor:Constants.primaryColor,
                      //         controller: PrefSearchWindowPreferencesController,
                      //         textAlign: TextAlign.start,
                      //         style: BlackFieldStyle,
                      //         decoration: inputDecoration(context,hint: "Search Window Preferences"),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                    ],
                  ),
                ):SizedBox(),

                SizedBox(height: 80,),
              ],
            ),
            bottomSheet:
            loader==true?SizedBox():
            Container(padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: primaryColor,
                    fixedSize: Size(isMobile?width:tabWidth, 50)
                ),
                
                onPressed: () {

                  if(PrefOffermatchController.text.isEmpty ||  int.parse(PrefOffermatchController.text.toString().split(".").first ) <= 100 ){
                    setState(() {
                      isUpdateProfileLoading = true;
                    });
                    List offerAreas = [];
                    for (var i in serviceAreaList){
                      setState(() {
                        offerAreas.add({"Address": i.text.toString(),"latitude": "" ,"longitude": ""});
                      });
                    }
                    String TextModeration = "${profileDescriptionController.text.toString()}";
                    var TextModerationBody = {
                      "text": TextModeration,
                      "lang":"en",
                      "mode":"ml",
                      "api_user":"1460174402",
                      "api_secret":"T4dJ3z9fvFNTwHJCRaKDTvFhhd"
                    };
                    print("TextModerationBody");
                    print(TextModerationBody.toString());
                    DrawAuraAPi.TextModeration(body:TextModerationBody ).then((value) {
                      if(value != null){
                        if( double.parse(value["moderation_classes"]["sexual"].toString()) > 0.05){
                          var reportUserBody = {
                            "user_id":DataManager.getInstance().getuserId().toString()
                          };
                          DrawAuraAPi.CreateDataApi(ApiEndPoint: "reportUser",body: reportUserBody ).then((reportUserRes){

                            MessageShowDialogWithTextForBlock(context,
                                Text(reportUserRes["message"],textAlign: TextAlign.center,style: BlackTitle500height,)
                                ,(){
                                  if(reportUserRes["blocked"] == false){
                                    Navigator.pop(context);
                                  }else{
                                    Future.delayed(const Duration(
                                        milliseconds: 200), () async {
                                      final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
                                      sharedpreferences.clear();
                                      var body = {
                                        "id":DataManager.getInstance().getuserId().toString(),
                                        "deviceToken" : "",
                                      };
                                      DrawAuraAPi.CreateDataApi(ApiEndPoint: "updateSubscriberProfile",body: body);
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login_screen(isGuestUser: false),), (route) => false);
                                    });
                                  }

                                });

                          });
                        }
                      }
                    });
                    print("UpcadetClassification");
                    print( selectedClassification.toString());
                    Map<String, String> updateSubsribeDetails = {
                      "id":DataManager.getInstance().getuserId().toString(),
                      "username":userName.toString(),
                      "desc":profileDescriptionController.text.toString(),
                      "email":profileEmailController.text.toString(),
                      "displayname": UserDisplayNameController.text,
                      "placeORperson": iSPlaceType == true ? "place" : "person",
                      "businessORpublic" : isPublicType  == true ?  "public":"business",
                      "classification" : selectedClassification.toString(),
                      "movable" : "$movable",
                      "addressORarea" : isAddressType == true ? "address": "area",
                      "operatingaddress" : userAdressControler.text,
                      "gender" :SelectedGender == "Male" ? "M" : SelectedGender == "Female" ? "F": "O",
                      "maritalstatus" : selectedMarriedStatus == "" ? "null" : selectedMarriedStatus.toString().toLowerCase(),
                      "passportnumber" : PassportNoController.text,
                      "dateofissue" : DateTimeOfIssuesApiValue,
                      "nationality" : NationalityController.text,
                      "dateofbirth" : DateTimeOfBirthApiValue,
                      "religion" : ReligionController.text,
                      "subreligion" : SubDevisionController.text,
                      "caste" : CasteController.text,
                      "subsect" : SubCastController.text,
                      "Current_Location" :jsonEncode(offerAreas).toString(),
                      "Offer_match_percentage":  PrefOffermatchController.text,
                      "Want_to_sell" : isSellPref.toString(),
                      "Want_to_Buy" :isBuyPref.toString(),
                      "Opt_Delivery" : opting.toString() ,
                      "Close_Confirmed_Offers" : isCloseConfirmedoffers.toString() ,
                      "Ok_for_Current_location_Offers" : isCurrentLocationOffers.toString(),
                      "search_page_preferences" : "",
                      "not_offering_reminder" : isNotOfferingReminder.toString(),
                      "deafault_offer_duration" : PrefDefaultofferDurationController.text,
                      "additionalnumber" : secoundryMobileNumberController.text,
                    };


                    DrawAuraAPi.updateSubscriberProfileManageProfileApi(data:updateSubsribeDetails,profileImage:userProfileImagePath==null?null:userProfileImagePath,backImage:userBackImagePath,).then((value) {
                      print("UpdateApi Done");
                      print(value.stream);
                      print("UpdateApi Done");
                      setState(() {
                        isUpdateProfileLoading = false;
                      });
                      SharePre.setOfferingArea(jsonEncode(offerAreas).toString());
                      DataManager.getInstance().setOfferArea(jsonEncode(offerAreas).toString());


                      load();
                      if(widget.From == "SignUp"){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 2),), (route) => false);
                      }else{
                        Navigator.pop(context);
                      }

                    });

                  }else{
                    Constants.showToast("Please enter valid Offer match %");
                  }
                  // }
                },

                child: isUpdateProfileLoading == true ? ButtonLoaderWhite() : Text("Save Profile",style: WhiteButtonStyle,),
              ),
            ),
          )),
    );
  }
}
