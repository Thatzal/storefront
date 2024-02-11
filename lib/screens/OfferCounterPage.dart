import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:socialapps/Apis/CommonApis.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/Auth/login_screen.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/CustomMultiselect.dart';
import 'package:socialapps/constant/DateAndTimeOfferCondition.dart';
import 'package:socialapps/constant/constant_function.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loader.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/GetKYCListModel.dart';
import 'package:socialapps/model/OfferDataModel.dart';
import 'package:socialapps/model/PrefillOfferDataModel.dart';
import 'package:socialapps/model/ServicePersonListModel.dart';
import 'package:socialapps/model/UnitListModel.dart';
import 'package:socialapps/model/serviceAreaModel.dart';
import 'package:socialapps/screens/ViewFileListing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapps/screens/widgets/GuestLogInScreen.dart';
import 'package:socialapps/screens/widgets/ImagePickeBottomSheet.dart';
import 'package:socialapps/screens/widgets/ShowDurationPicker.dart';
import 'package:socialapps/screens/widgets/SimmerLoadingBuilder.dart';
import 'package:socialapps/screens/widgets/upload_image_camera.dart';
import '../common/style.dart';
import '../constant/loading.dart';
import 'newOfferPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'widgets/NewAddressPickers/NewAddressPickerList.dart';

class CreateOfferCounterScreen extends StatefulWidget {
  OfferDataModelResult OfferData;
  CreateOfferCounterScreen({Key? key,required this.OfferData}) : super(key: key);

  @override
  State<CreateOfferCounterScreen> createState() => _CreateOfferCounterScreenState();
}

class _CreateOfferCounterScreenState extends State<CreateOfferCounterScreen> {
  bool cateLoader=false;
  bool segmentLoader=false;
  bool addOfferHide = true;
  int _currentTapindex = 0;

  List<String> selectTypeList = [
    "Deliver",
    "Cancel",
    "Confirm",
    "Template",
    "Modify",
    "New",
  ];


  final List<String> periodicityList = [
    "Tomorrow",
    'Today',
    "Weekends",
    "Daily",
    "Monthly",
    "Yearly",
    "Weekly",
    "Weekdays",
    "Once"
  ];
  final List<String> periodicityDailyList = [
    "Daily",
    "Weekdays",
    "Alternate days",
    "Weekends",
    "Once"
  ];
  final List<String> periodicityWeekendsList = [
    "Weekends",
    "Saturday",
    "Sunday",
    "Once"
  ];
  final List<String> periodicityWeekDaysList = [
    "Weekdays",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Alternate days",
    "Once"
  ];
  final List<String> priority = [
    'Normal',
    'Immediate',
    'Premium',
    'Urgent',
    'Low',
    'High',
  ];

  String? selectedValuePriority;
  String? selectedPeriodicityValue;
  var Img = "";
  File? PhotoImg;



  var offerPeriodFromDate = "";
  var offerPeriodToDate = "";
  var offerPeriodFromTime = "";
  var offerPeriodToTime = "";
  var offerExpiryDateTime = "";



  TextEditingController OfferDurationController = TextEditingController();
  TextEditingController OfferPeriodController = TextEditingController();
  TextEditingController OfferExpiryController = TextEditingController();
  TextEditingController OfferFromLocationController = TextEditingController();
  TextEditingController OfferToLocationController = TextEditingController();
  TextEditingController OfferAtLocationController = TextEditingController();

  var maskFormatter = new MaskTextInputFormatter(
      mask: '##:##:##:##:##', filter: {"#": RegExp(r'[0-9]')});
      int Qty = 0;

  List<ServiceAreaModel> serviceAreaList =[];
  List<dynamic> ItemsList = [];

  List <ServiceAreaModel> serviceArea = [];
  bool isOfferOwner = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(widget.OfferData.offerData!.offerItems!.length.toString());
    getSaveData();
    getKYCList();
    RefreshAfter8Sec();
  }

  var months ;
  var diff_mi ;
  var diff_s;
  var diff_hr ;
  var years ;
  var diff_dy ;
  RefreshAfter8Sec(){
    Future.delayed(Duration(seconds: 8),() {
      if(mounted){
        setState(() {});
      }
    },);
  }


  @override
  void dispose(){
    super.dispose();
  }

  TextEditingController adressLocationController = TextEditingController();
  TextEditingController OfferInstruction1Controller = TextEditingController();
  TextEditingController OfferInstruction2Controller = TextEditingController();
  String selectedTap = "";
  List servicePersonCountList  =[];
  bool isSinglePeriodSelect = true;
  DateTime  ? ExDTime;
  bool isAdvancePriceShow = false;
  bool isMaintancePriceShow =false;

  ///Item Offer


  bool isItemServicePersonVisible = true;

  bool isItemSinglePeriodSelect = true;
  DateTime  ? ItemExDTime;
  bool OfferInstruction1Visible = true;
  bool OfferInstruction2Visible = false;
  bool PublishLoader = false;
  var saveAddress;
  var saveAddressTitle;
  var saveAddressId;
  var DisplayName;
  bool isPrivateOffer = false;
  List<UnitListData> getUnitList = [];
  List<ServicePersonListModel> ServicePersonList = [];
  List selectedItems = [];
  List <bool>isRequiredItemSelect = [];
  List <bool>requiredItemPriceIsEmpty = [];

  getSaveData()  {

    DrawAuraAPi.getUnitList().then((value) {
      if(mounted){
        setState(() {
          getUnitList = value.result!;
        });
      }
    });
    DrawAuraAPi.GetServicePersonList().then((value) {
      if(mounted){
        setState(() {
          ServicePersonList.add( ServicePersonListModel(
            id: 0,
            followers: 0,
            following: 0,
            displayname:  "NEEDED",
            phonenumber: "",
            username: "NEEDED",
            email: "",
            desc: "",
            placeORperson: "",
            businessORpublic: "",
            classification: "",
            movable: false,
            addressORarea: "",
            operatingaddress: "",
            maritalstatus: "",
            passportnumber: null,
            dateofissue: null,
            nationality: null,
            dateofbirth: null,
            gender: "M",
            religion: null,
            subreligion: null,
            caste: null,
            subsect: null,
            numberofcomputations: 0,
            blocked: "NO",
            blockedtime: null,
            deviceToken :"",
            modified: "",
          ));
          ServicePersonList.add( ServicePersonListModel(
            id: -1,
            followers: 0,
            following: 0,
            displayname: "NOT NEEDED",
            phonenumber: "",
            username: "NOT NEEDED",
            email: "",
            desc: "",
            placeORperson: "",
            businessORpublic: "",
            classification: "",
            movable: false,
            addressORarea: "",
            operatingaddress: "",
            maritalstatus: "",
            passportnumber: null,
            dateofissue: null,
            nationality: null,
            dateofbirth: null,
            gender: "M",
            religion: null,
            subreligion: null,
            caste: null,
            subsect: null,
            numberofcomputations: 0,
            blocked: "NO",
            blockedtime: null,
            deviceToken :"",
            modified: "",
          ));
          ServicePersonList.addAll(value);
        });
      }
    });

     Future.delayed(Duration.zero,() async {
       final SharedPreferences  sharedpreferences = await SharedPreferences.getInstance();
       setState(() {
         isPrivateOffer = widget.OfferData.offerData!.privacy.toString().toUpperCase() == "PRIVATE" ?true:false;
         final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${ widget.OfferData.offerData!.createdAt}');
         final currentTime = DateTime.now();
         diff_dy = currentTime.difference(startTime).inDays;
         years = diff_dy ~/ 365;
         months = (diff_dy-years*365) ~/ 30;
         diff_mi = currentTime.difference(startTime).inMinutes;
         diff_s = currentTime.difference(startTime).inSeconds;
         diff_hr = currentTime.difference(startTime).inHours;

         selectedItems = widget.OfferData.offerData!.offerConditions!.servicepersons!.map((e) =>e).toList();
         widget.OfferData.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?isOfferOwner = true :isOfferOwner = false;
         List serviceTemp = jsonDecode("${widget.OfferData.offerData!.offerareas!.toString()}");
         serviceAreaList = serviceTemp.map((e) => ServiceAreaModel.fromJson(e)).toList();
         DisplayName = sharedpreferences.getString("UserDisplayName")??"";
         saveAddress = widget.OfferData.offerData!.addres;
         saveAddressTitle = "";
         _currentTapindex =widget.OfferData.offerData!.buyORsell == "DELIVER_SELL"?0 :widget.OfferData.offerData!.buyORsell == "DELIVER_BUY"?1: widget.OfferData.offerData!.buyORsell == "BUY"? 1 : 0;
         selectedTap = widget.OfferData.offerData!.buyORsell == "BUY"? "Answer": "Query";
         selectedPeriodicityValue =widget.OfferData.offerData!.offerConditions!.periodicity==null?"": widget.OfferData.offerData!.offerConditions!.periodicity.toString().trim();
         selectedValuePriority = widget.OfferData.offerData!.offerConditions!.priority ==null?"": widget.OfferData.offerData!.offerConditions!.priority.toString().trim();
         final fromPeriodDate = widget.OfferData.offerData!.offerConditions!.fromperiod== null ?"":widget.OfferData.offerData!.offerConditions!.fromperiod.toString();
         final fromPeriodTime =widget.OfferData.offerData!.offerConditions!.fromperiodtime==null?"": widget.OfferData.offerData!.offerConditions!.fromperiodtime.toString();
         final toPeriodDate = widget.OfferData.offerData!.offerConditions!.toperiod == null ?"": widget.OfferData.offerData!.offerConditions!.toperiod.toString();
         final toPeriodTime =widget.OfferData.offerData!.offerConditions!.toperiodtime == null?"": widget.OfferData.offerData!.offerConditions!.toperiodtime.toString();
         OfferPeriodController.text =fromPeriodTime=="" && fromPeriodDate=="" && toPeriodDate=="" && toPeriodTime==""?"": toPeriodDate != "" && toPeriodTime != ""?"From "+ fromPeriodDate+" " +  fromPeriodTime +" To " + toPeriodDate +" "+toPeriodTime :"From "+ fromPeriodDate+" " +  fromPeriodTime;
         OfferDurationController.text = widget.OfferData.offerData!.offerConditions!.duration==null?"": widget.OfferData.offerData!.offerConditions!.duration.toString();
         OfferExpiryController.text = widget.OfferData.offerData!.offerConditions!.expiry==null?"": widget.OfferData.offerData!.offerConditions!.expiry.toString();
         OfferFromLocationController.text = widget.OfferData.offerData!.offerConditions!.fromlocation == null ?"": widget.OfferData.offerData!.offerConditions!.fromlocation.toString();
         OfferToLocationController.text =  widget.OfferData.offerData!.offerConditions!.tolocation == null ? "": widget.OfferData.offerData!.offerConditions!.tolocation.toString();
         OfferAtLocationController.text = widget.OfferData.offerData!.offerConditions!.atlocation == null ? "": widget.OfferData.offerData!.offerConditions!.atlocation.toString();
         adressLocationController.text = widget.OfferData.offerData!.addres.toString();
         offerPeriodFromDate = widget.OfferData.offerData!.offerConditions!.fromperiod == null ?"":widget.OfferData.offerData!.offerConditions!.fromperiod.toString();
         offerPeriodFromTime =widget.OfferData.offerData!.offerConditions!.fromperiodtime == null?"": widget.OfferData.offerData!.offerConditions!.fromperiodtime.toString();
         offerPeriodToDate = widget.OfferData.offerData!.offerConditions!.toperiod == null ?"": widget.OfferData.offerData!.offerConditions!.toperiod.toString();
         offerPeriodToTime = widget.OfferData.offerData!.offerConditions!.toperiodtime == null?"": widget.OfferData.offerData!.offerConditions!.toperiodtime.toString();
         offerExpiryDateTime = widget.OfferData.offerData!.offerConditions!.expiry == null?"": widget.OfferData.offerData!.offerConditions!.expiry.toString();
       //  serviceAreaList  =  jsonDecode("${widget.OfferData.offerareas!.toString()}").map((e) => ServiceAreaModel.fromJson(e)).toList();

       });
       for(var i = 0 ;i<widget.OfferData.offerData!.offerConditions!.servicepersons!.length ; i++) {
         setState(() {
           servicePersonCountList.add(TextEditingController(text: widget.OfferData.offerData!.offerConditions!.servicepersons![i].toString()));
         });
       }

       for(var i = 0 ; i<widget.OfferData.offerData!.offerItems!.length; i++){
         final imageMedia = [];
         final fileUrls = [];
         for(var j = 0 ; j< widget.OfferData.offerData!.offerItems![i].itemMedia!.length ; j++){
           print(widget.OfferData.offerData!.offerItems![i].itemMedia!.length);
           print(widget.OfferData.offerData!.offerItems![i].itemMedia![j].file);
           imageMedia.add({
             "file":"${ widget.OfferData.offerData!.offerItems![i].itemMedia![j].id}",
             "name": "${widget.OfferData.offerData!.offerItems![i].itemMedia![j].name}"
           });
           fileUrls.add(
             "${widget.OfferData.offerData!.offerItems![i].itemMedia![j].file}",
           );
         }
         List selectedItemsList = widget.OfferData.offerData!.offerItems![i].offerItemConditions!.servicepersons!.map((e) =>e).toList();
         List<UnitListData> TempUnitList = [];

         final fromPeriodDate = widget.OfferData.offerData!.offerItems![i].offerItemConditions!.fromperiod== null ?"":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.fromperiod.toString();
         final fromPeriodTime = widget.OfferData.offerData!.offerItems![i].offerItemConditions!.fromperiodtime==null?"": widget.OfferData.offerData!.offerItems![i].offerItemConditions!.fromperiodtime.toString();
         final toPeriodDate = widget.OfferData.offerData!.offerItems![i].offerItemConditions!.toperiod == null ?"": widget.OfferData.offerData!.offerItems![i].offerItemConditions!.toperiod.toString();
         final toPeriodTime = widget.OfferData.offerData!.offerItems![i].offerItemConditions!.toperiodtime == null?"": widget.OfferData.offerData!.offerItems![i].offerItemConditions!.toperiodtime.toString();
         widget.OfferData.offerData!.offerItems!.length == 1 ?isRequiredItemSelect.add(true) : widget.OfferData.offerData!.offerItems![i].required.toString() == "true"||widget.OfferData.offerData!.offerItems![i].required == true?isRequiredItemSelect.add(false):isRequiredItemSelect.add(true);
         if(  widget.OfferData.offerData!.offerItems!.length == 1){
            if(  widget.OfferData.offerData!.offerItems![i].price.toString() == "null" ||   widget.OfferData.offerData!.offerItems![i].price.toString() == ""){
              requiredItemPriceIsEmpty.add(true);
            }else{
              requiredItemPriceIsEmpty.add(false);
            }
          }else{
             if(widget.OfferData.offerData!.offerItems![i].required.toString() == "true"){
                 if(  widget.OfferData.offerData!.offerItems![i].price.toString() == "null" ||   widget.OfferData.offerData!.offerItems![i].price.toString() == "" ||
                     widget.OfferData.offerData!.offerItems![i].price.toString()[0] == "0"
                 ){
                   requiredItemPriceIsEmpty.add(true);
                 }else{
                   requiredItemPriceIsEmpty.add(false);
                 }
             }else{
               requiredItemPriceIsEmpty.add(false);
             }
          }
       ItemsList.add({
         "itemType" :"Old",
       "name":TextEditingController(text: widget.OfferData.offerData!.offerItems![i].name.toString()),
       "desc":TextEditingController(text: widget.OfferData.offerData!.offerItems![i].desc.toString()),

         "price":TextEditingController(text:  widget.OfferData.offerData!.offerItems![i].price.toString() == "null" ?"": widget.OfferData.offerData!.offerItems![i].price.toString()),
         "unit":TextEditingController(text: widget.OfferData.offerData!.offerItems![i].unit!.name.toString() == "null"?"": widget.OfferData.offerData!.offerItems![i].unit!.name.toString()),
         "AdvancePrice" : TextEditingController(text :widget.OfferData.offerData!.offerItems![i].advancePrice == null ? "":  widget.OfferData.offerData!.offerItems![i].advancePrice.toString()),
         "AdvanceUnit" : TextEditingController(text :widget.OfferData.offerData!.offerItems![i].advanceUnit!.name == null ? "" :  widget.OfferData.offerData!.offerItems![i].advanceUnit!.name.toString()),
         "MaintenancePrice" : TextEditingController(text :  widget.OfferData.offerData!.offerItems![i].maintenancePrice == null ? "": widget.OfferData.offerData!.offerItems![i].maintenancePrice.toString()),
         "MaintenanceUnit" : TextEditingController(text : widget.OfferData.offerData!.offerItems![i].maintenanceUnit!.name == null ? "" : widget.OfferData.offerData!.offerItems![i].maintenanceUnit!.name.toString()),
         "filterGetUnitList" : TempUnitList,
         "showOtherUnit" : false,
         "isLoadNewUnit" : false,
         "selectedUnitIndex" : -1,
         "SelectedUnitId" : widget.OfferData.offerData!.offerItems![i].unit == null ? null : widget.OfferData.offerData!.offerItems![i].unit!.id.toString() ,
         "filterGetUnitListMain" : TempUnitList,
         "showOtherUnitMain" : false,
         "isLoadNewUnitMain" : false,
         "selectedUnitIndexMain" : -1,
         "SelectedUnitIdMain" : widget.OfferData.offerData!.offerItems![i].maintenanceUnit == null ? null :widget.OfferData.offerData!.offerItems![i].maintenanceUnit!.id.toString(),
         "filterGetUnitListAdva" : TempUnitList,
         "showOtherUnitAdva" : false,
         "isLoadNewUnitAdva" : false,
         "selectedUnitIndexAdva" : -1,
         "SelectedUnitIdAdva" :  widget.OfferData.offerData!.offerItems![i].advanceUnit == null ? null :widget.OfferData.offerData!.offerItems![i].advanceUnit!.id.toString(),
         "fillSelectedPerson" : selectedItemsList,
         "type" : "old",
         "quantity":int.parse(widget.OfferData.offerData!.offerItems![i].quantity.toString()),
         "FixQty" : int.parse(widget.OfferData.offerData!.offerItems![i].quantity.toString()),
         "currency":"INR",
         "addon":widget.OfferData.offerData!.offerItems![i].addon,
         "required":widget.OfferData.offerData!.offerItems![i].required,
         "toggle_state": widget.OfferData.offerData!.offerItems!.length == 1?true: false,
         "media":imageMedia,
         "isLoadingFile":false,
         "fileUrl":fileUrls,
         "itemConditionView" :true,
         "create_date":  widget.OfferData.offerData!.createdAt.toString(),
         "CreatorUserId" :  widget.OfferData.offerData!.subscribers!.id.toString(),
         "showItemPrice2":false,
         "showItemPrice3":false,
         "item_condition": {
           "isServicePersonView": widget.OfferData.offerData!.offerItems![i].offerItemConditions!.servicepersons!.isEmpty ? false:true,
       "periodicityView":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.periodicity.toString() == "" ?false: true,
       "periodView":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.fromperiod == null?false: true,
       "durationView": widget.OfferData.offerData!.offerItems![i].offerItemConditions!.duration == null ?false: true,
       "priorityView":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.priority == null?false: true,
       "expiryView":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.expiry == null?false: true,
       "fromlocationView":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.fromlocation == null?false: true,
       "tolocationView":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.tolocation == null?false: true,
       "atlocationView":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.atlocation == null?false: true,
       "servicepersons":selectedItemsList,
       "periodicity":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.periodicity == null ?"":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.periodicity,
       "period":TextEditingController(text:fromPeriodTime=="" && fromPeriodDate=="" && toPeriodDate=="" && toPeriodTime==""?"": toPeriodDate != "" && toPeriodTime != ""?"From "+ fromPeriodDate+" " +  fromPeriodTime +" To " + toPeriodDate +" "+toPeriodTime :"From "+ fromPeriodDate+" " +  fromPeriodTime),
       "fromperiod":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.fromperiod==null?"":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.fromperiod,
       "toperiod":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.toperiod==null?"":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.toperiod,
       "duration": TextEditingController(text: widget.OfferData.offerData!.offerItems![i].offerItemConditions!.duration==null?"": widget.OfferData.offerData!.offerItems![i].offerItemConditions!.duration),
       "fromperiodtime":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.fromperiodtime == null ?"":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.fromperiodtime,
       "toperiodtime":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.toperiodtime == null ? "":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.toperiodtime,
       "durationoftime":"",
       "fromlocation":TextEditingController(text:  widget.OfferData.offerData!.offerItems![i].offerItemConditions!.fromlocation==null?"":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.fromlocation.toString()),
       "tolocation":TextEditingController(text:  widget.OfferData.offerData!.offerItems![i].offerItemConditions!.tolocation==null?"":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.tolocation.toString()),
       "atlocation":TextEditingController(text: widget.OfferData.offerData!.offerItems![i].offerItemConditions!.atlocation==null?"":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.atlocation.toString()),
       "priority": widget.OfferData.offerData!.offerItems![i].offerItemConditions!.priority==null?"":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.priority.toString(),
       "expiry":TextEditingController(text: widget.OfferData.offerData!.offerItems![i].offerItemConditions!.expiry==null?"":widget.OfferData.offerData!.offerItems![i].offerItemConditions!.expiry.toString())
       }
       });
     }
     },).whenComplete(() {
       Future.delayed(Duration(seconds: 3),() {
         if(mounted){
           setState(() {
             cateLoader = true;
           });
         }
       },);
     });
  }
  List<KYCDocData> KycDataList = [];
  bool isLoadKycData = false;
  getKYCList(){
    var body = {
      "user_id" : DataManager.getInstance().getuserId().toString().trim()
    };
    DrawAuraAPi.GetListData(body: body,ApiEndPoint: "getSubscriberKYCList").then((value) {
      if(mounted){
        setState(() {
          var data = GetKycListModel.fromJson(value);
          KycDataList = data.result!;
          isLoadKycData = true;
        });
      }
    });
  }
  @override


  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var height = MediaQuery.of(context).size.height;
    var isMobile= ResponsiveHelper.isMobile(context);
    return Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Scaffold(
            appBar:AppBar(
              backgroundColor: const Color(0xFFE7E6E6),
              toolbarHeight: 40,
              elevation: 0,
              leading:   InkWell(
                  onTap:(){Navigator.pop(context);},
                  child: const Icon(Icons.arrow_back,size: 24,)),
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              title: cateLoader==false?const SizedBox():
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(saveAddressTitle==""?"":"${saveAddressTitle}", style: BlackTitleStyle),
                  Flexible(
                    child: Container(
                      height: 30,
                      margin: EdgeInsets.only(right:5),
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:TextFormField(
                        controller: adressLocationController,
                        onTap:() async {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => ManageAddressScreen(from: "Home")));
                        },
                        readOnly:true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(hintText:"Location loading..", fillColor:  Colors.white, hintStyle: greyHintStyle,
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                          border: const OutlineInputBorder(),
                        ),
                        style: Black87HintStyle,
                      ),
                    ),
                  )
                ],
              ),
            ),
            body:
            cateLoader==false?const Center(child: LoadingWidget()):
            Stack(
              children:[
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Column  (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height:10),
                            SizedBox(
                              height:25,
                              child: Row(
                                children: [

                                  Flexible(
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      children: [

                                        const SizedBox(width: 10,),
                                        Container(
                                                width: 100,
                                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                            decoration: BoxDecoration(
                                                color: Constants.primaryColor20,
                                                // boxShadow: [
                                                //   BoxShadow(
                                                //       blurRadius: 2.0,
                                                //       color: Colors.grey,
                                                //       offset: Offset(0.0, 0.5) ),
                                                // ],
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) )
                                            ),
                                            child:Center(
                                                child:Text("${widget.OfferData.offerData!.subscribers!.displayname.toString()}",overflow: TextOverflow.ellipsis,)
                                            )
                                        ),
                                        SizedBox(
                                          height: 25,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                                  shape:  RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) )),
                                                  backgroundColor: Constants.primaryColor1,
                                                  elevation: 1
                                              ),
                                              onPressed: () {},
                                              child:  Text("${DisplayName}",style: WhiteHeadingStyle,)),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height:15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text("Offering location", style: BlackTitleStyle),
                                Spacer(),

                                Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  decoration:  BoxDecoration(
                                    color: const Color(0xfffDFEAE4),
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color: Constants.primaryColor1),
                                  ),
                                  textStyle: BlackSubCardTitle,
                                  message: "${widget.OfferData.offerData!.offerresponses} - Responses",
                                  child:  Column(
                                    children: [
                                      Text("${widget.OfferData.offerData!.offerresponses}",style: BlackCardTitle,),
                                      Image(image: AssetImage("assets/greenpeople.png"),width: 24,height: 20,color: primaryColor),
                                    ],
                                  ), //Text
                                ),
                                Spacer(),
                                Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  decoration:  BoxDecoration(
                                    color: const Color(0xfffDFEAE4),
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color:Constants.primaryColor1),
                                  ),
                                  textStyle: BlackSubCardTitle,
                                  message: "${widget.OfferData.offerData!.offerviewcount!.length} - Views",
                                  child: Column(
                                      children: [
                                        Text("${widget.OfferData.offerData!.offerviewcount!.length}",style: BlackCardTitle,),
                                        Icon(Icons.visibility_outlined,size:22,color:primaryColor)
                                      ]), //Text
                                ),
                                Spacer(),
                                Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  decoration:  BoxDecoration(
                                    color: const Color(0xfffDFEAE4),
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color: Constants.primaryColor1),
                                  ),
                                  textStyle: BlackSubCardTitle,
                                  message: widget.OfferData.offerData!.offerfavoritecount == null ? "0 Favourite count":'${widget.OfferData.offerData!.offerfavoritecount} - Favourite count',
                                  child: Column(
                                    children: [
                                      Text("${widget.OfferData.offerData!.offerfavoritecount == null ? "0 ":widget.OfferData.offerData!.offerfavoritecount}",style: BlackCardTitle,),
                                      Icon(Icons.favorite,size:21,color:primaryColor)
                                    ],
                                  ), //Text
                                ),
                                Spacer(),
                                Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  // showDuration: const Duration(milliseconds: 500),
                                  decoration:  BoxDecoration(
                                    color: const Color(0xfffDFEAE4),
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color: Constants.primaryColor1),
                                  ),
                                  textStyle: BlackSubCardTitle,
                                  message: "${diff_s <= 60? "$diff_s""s":
                                  diff_mi <= 60 ?"$diff_mi""m":
                                  diff_hr <= 24 ? "$diff_hr""h":
                                  diff_dy <= 30 ? "$diff_dy""d":
                                  months <= 12 ? "$months""mo":
                                  "$years"} - Time of posting",
                                  child:Column(
                                    children: [
                                      Text( diff_s <= 60? "$diff_s""s":
                                      diff_mi <= 60 ?"$diff_mi""m":
                                      diff_hr <= 24 ? "$diff_hr""h":
                                      diff_dy <= 30 ? "$diff_dy""d":
                                      months <= 12 ? "$months""mo":
                                      "$years",style: BlackCardTitle,),
                                      const Icon(Icons.access_time,color: Constants.primaryColor1,size: 21,),
                                    ],
                                  ), //Text
                                ),
                                Spacer(),
                                SizedBox(
                                  width:42,
                                  child: Column(
                                    children: [
                                      Text( isPrivateOffer ?"Private":"Public",style: BlackCardTitle,),
                                      3.height,
                                      InkWell(
                                          onTap:(){

                                          },
                                          child: isPrivateOffer ? Image(image: AssetImage("assets/secured_lock.png"),width: 22,height: 22,color: primaryColor):Image(image: AssetImage("assets/world.png"),width: 22,height: 20,color: primaryColor,)),
                                    ],
                                  ),
                                ),
                                3.width
                                // 10.width,
                                // // Tooltip(
                                // //   triggerMode: TooltipTriggerMode.tap,
                                // //   decoration:  BoxDecoration(
                                // //     color: const Color(0xfffDFEAE4),
                                // //     borderRadius: const BorderRadius.all(Radius.circular(5)),
                                // //     border: Border.all(color: Constants.primaryColor),
                                // //   ),
                                // //   textStyle: BlackSubCardTitle,
                                // //   message: "${widget.OfferData.offerData!.offercopycount} - Offer copy count",
                                // //   child: Column(
                                // //     children: [
                                // //       Text("${widget.OfferData.offerData!.offercopycount}",style: BlackCardTitle,),
                                // //       Image(image: AssetImage("assets/greenearth.png"),width: 30,height: 20,),
                                // //     ],
                                // //   ), //Text
                                // // ),
                                // Tooltip(
                                //   triggerMode: TooltipTriggerMode.tap,
                                //   decoration:  BoxDecoration(
                                //     color: const Color(0xfffDFEAE4),
                                //     borderRadius: const BorderRadius.all(Radius.circular(5)),
                                //     border: Border.all(color: Constants.primaryColor1),
                                //   ),
                                //   textStyle: BlackSubCardTitle,
                                //   message: "${widget.OfferData.offerData!.offerresponses} - Responses",
                                //   child:  Column(
                                //     children: [
                                //       Text("${widget.OfferData.offerData!.offerresponses}",style: BlackCardTitle,),
                                //       Image(image: AssetImage("assets/greenpeople.png"),width: 30,height: 20,),
                                //     ],
                                //   ), //Text
                                // ),
                                // Tooltip(
                                //   triggerMode: TooltipTriggerMode.tap,
                                //   decoration:  BoxDecoration(
                                //     color: const Color(0xfffDFEAE4),
                                //     borderRadius: const BorderRadius.all(Radius.circular(5)),
                                //     border: Border.all(color:Constants.primaryColor1),
                                //   ),
                                //   textStyle: BlackSubCardTitle,
                                //   message: "${widget.OfferData.offerData!.offerviewcount!.length} - Views",
                                //   child: Column(
                                //       children: [
                                //         Text("${widget.OfferData.offerData!.offerviewcount!.length}",style: BlackCardTitle,),
                                //         Image(image: AssetImage("assets/greeneye.png"),width: 30,height: 20,)]), //Text
                                // ),
                                // Tooltip(
                                //   triggerMode: TooltipTriggerMode.tap,
                                //   decoration:  BoxDecoration(
                                //     color: const Color(0xfffDFEAE4),
                                //     borderRadius: const BorderRadius.all(Radius.circular(5)),
                                //     border: Border.all(color: Constants.primaryColor1),
                                //   ),
                                //   textStyle: BlackSubCardTitle,
                                //   message: '${widget.OfferData.offerData!.offerfavoritecount} - Favourite count',
                                //   child: Column(
                                //     children: [
                                //       Text("${widget.OfferData.offerData!.offerfavoritecount}",style: BlackCardTitle,),
                                //       Image(image: AssetImage("assets/greenheart.png"),width: 30,height: 20),
                                //     ],
                                //   ), //Text
                                // ),
                                // Tooltip(
                                //   triggerMode: TooltipTriggerMode.tap,
                                //   // showDuration: const Duration(milliseconds: 500),
                                //   decoration:  BoxDecoration(
                                //     color: const Color(0xfffDFEAE4),
                                //     borderRadius: const BorderRadius.all(Radius.circular(5)),
                                //     border: Border.all(color: Constants.primaryColor1),
                                //   ),
                                //   textStyle: BlackSubCardTitle,
                                //   message: "${diff_s <= 60? "$diff_s""s":
                                //   diff_mi <= 60 ?"$diff_mi""m":
                                //   diff_hr <= 24 ? "$diff_hr""h":
                                //   diff_dy <= 30 ? "$diff_dy""d":
                                //   months <= 12 ? "$months""months":
                                //   "$years"} - Time of posting",
                                //   child:Column(
                                //     children: [
                                //       Text( diff_s <= 60? "$diff_s""s":
                                //       diff_mi <= 60 ?"$diff_mi""m":
                                //       diff_hr <= 24 ? "$diff_hr""h":
                                //       diff_dy <= 30 ? "$diff_dy""d":
                                //       months <= 12 ? "$months""months":
                                //       "$years",style: BlackCardTitle,),
                                //       const Icon(Icons.access_time,color: Constants.primaryColor1,size: 21,),
                                //     ],
                                //   ), //Text
                                // ),

                              ],
                            ),
                            serviceAreaList[0].address==""?Container(
                                height: 35,
                                width: 170,
                                margin:EdgeInsets.only(top:10,bottom: 5),
                                padding: EdgeInsets.only(left:8,right: 8),
                                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2.0,
                                      color: Colors.black54,
                                      offset: Offset(0.0, 0.5) ),
                                ], borderRadius: BorderRadius.circular(5)),
                                //width: ResponsiveHelper.isMobile(context)?width*0.45:tabWidth*0.45,
                                child: Center(child: Text("Offering Location not added",style: Black87DescStyle,))
                            ):  SizedBox(
                              height: 55,
                              child: ListView.builder (
                                scrollDirection: Axis.horizontal,
                                itemCount: serviceAreaList.length,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var data = serviceAreaList[index];
                                  return Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0,top:8,bottom: 5,left: 1),
                                        child: Container(
                                            height: 35,
                                            padding: EdgeInsets.only(left:8,right: 8),
                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 2.0,
                                                  color: Colors.black54,
                                                  offset: Offset(0.0, 0.5) ),
                                            ], borderRadius: BorderRadius.circular(5)),
                                            //  width: ResponsiveHelper.isMobile(context)?width*0.45:tabWidth*0.45,
                                            child: Center(child: Text("${data.address}"))
                                          // TextFormField(
                                          //   controller: serviceAreaList[index],
                                          //   onTap:() async {
                                          //     LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlacePicker("${ApiUrls.mapKey}")));
                                          //     setState((){
                                          //       serviceAreaList[index].text=result!.formattedAddress.toString();
                                          //     });
                                          //   },
                                          //   readOnly:true,
                                          //   keyboardType: TextInputType.text,
                                          //   decoration: InputDecoration(hintText:"Offer Location", fillColor:  Colors.white, hintStyle: greyHintStyle,
                                          //     focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                          //     enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                          //     floatingLabelBehavior: FloatingLabelBehavior.never,
                                          //     contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                          //     border: const OutlineInputBorder(),
                                          //   ),
                                          //   style: Black87HintStyle,
                                          // ),
                                        ),
                                      ),
                                      // Positioned(
                                      //     bottom:12,left:2,
                                      //     child: InkWell(
                                      //       onTap:(){
                                      //         setState((){
                                      //           serviceAreaList.removeAt(index);
                                      //         });
                                      //       },
                                      //       child: CircleAvatar(
                                      //         radius:9,
                                      //         backgroundColor: Color(
                                      //             0x3389F6B9) ,
                                      //         child: Center(
                                      //             child:Icon(Icons.close,color: Colors.black,size:14,)
                                      //         ),
                                      //       ),
                                      //     )),
                                      // serviceAreaList.length-1 == index?   Positioned(
                                      //     top:1,right:2,
                                      //     child: InkWell(
                                      //       onTap:(){
                                      //         setState((){
                                      //           serviceAreaList.add(TextEditingController()) ;
                                      //         });
                                      //       },
                                      //       child: CircleAvatar(
                                      //         radius:9,
                                      //         backgroundColor: Constants.primaryColor ,
                                      //         child: Center(
                                      //             child:Icon(Icons.add,color: Colors.white,size:14,)
                                      //         ),
                                      //       ),
                                      //     )):SizedBox()
                                    ],
                                  );
                                },),
                            ),
                            const SizedBox(height:5),
                          ],
                        ),
                      ),
                      Container(
                        // color: Colors.black12,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color:  Color(0xFFD2D0D0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFFD2D0D0),
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    offset: Offset(0,4)
                                )
                              ]
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          height: 32,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap:(){
                                    // setState(() {
                                    //   selectedTap = "Deliver";
                                    // });
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:  BoxDecoration(
                                      color:  selectedTap == "Deliver"? Constants.primaryColor1:Constants.unActiveTabBg,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Deliver',style:  selectedTap == "Deliver"?WhiteSubTitleStyle:unActiveTabStyle,)),),
                                ),
                                InkWell(
                                  onTap:(){
                                    // setState(() {
                                    //   selectedTap = "Cancel";
                                    // });
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color:  selectedTap == "Cancel"? Constants.primaryColor1:Constants.unActiveTabBg,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Cancel',style:  selectedTap == "Cancel"?WhiteSubTitleStyle:unActiveTabStyle,)),),
                                ),
                                InkWell(
                                  onTap:(){
                                    setState(() {
                                      selectedTap = "Confirm";
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color:  selectedTap == "Confirm"? Constants.primaryColor1:Colors.transparent,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Confirm',style:  selectedTap == "Confirm"?WhiteSubTitleStyle:BlackSubTitleStyle,)),),
                                ),
                                widget.OfferData.offerData!.buyORsell == "SELL"?    InkWell(
                                  onTap:(){
                                    setState(() {
                                      selectedTap = "Query";
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:  BoxDecoration(
                                      color:  selectedTap == "Query"? Constants.primaryColor1:Colors.transparent,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Query',style:  selectedTap == "Query"?WhiteSubTitleStyle:BlackSubTitleStyle,)),),
                                ): InkWell(
                                  onTap:(){
                                    setState(() {
                                      selectedTap = "Answer";
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:  BoxDecoration(
                                      color:  selectedTap == "Answer"? Constants.primaryColor1:Colors.transparent,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Answer',style:  selectedTap == "Answer"?WhiteSubTitleStyle:BlackSubTitleStyle,)),),
                                ),
                                InkWell(
                                  onTap:(){
                                    setState(() {
                                      selectedTap = "Duplicate";
                                    });
                                  },
                                  child: Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        color:  selectedTap == "Duplicate"? Constants.primaryColor1:Colors.transparent,
                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                      ),
                                      child:  Center(child: Text('Duplicate',style:  selectedTap == "Duplicate"?WhiteSubTitleStyle:BlackSubTitleStyle,))
                                  ),
                                ),
                                InkWell(
                                  onTap:(){
                                    // setState(() {
                                    //   selectedTap = "Modify";
                                    // });
                                  },
                                  child: Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        color:  selectedTap == "Modify"? Constants.primaryColor1:Constants.unActiveTabBg,
                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                      ),
                                      child:  Center(child: Text('Modify',style:  selectedTap == "Modify"?WhiteSubTitleStyle:unActiveTabStyle,))
                                  ),
                                ),


                                InkWell(
                                  onTap:(){
                                    // setState(() {
                                    //   selectedTap = "New";
                                    // });
                                  },
                                  child: Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        color:  selectedTap == "New"? Constants.primaryColor1:Constants.unActiveTabBg,
                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(8),topLeft:Radius.circular(8) ),
                                      ),
                                      child:  Center(child: Text('New',style:  selectedTap == "New"?WhiteSubTitleStyle:unActiveTabStyle,))
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),

                      Container(
                          height: 80,
                          width: MediaQuery.sizeOf(context).width,
                          decoration:  const BoxDecoration(color: Color(0xFFE7E6E6),),
                          child: Center(
                            child: ListView.builder(
                              itemCount: 2,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    // setState(() {
                                    //   _currentTapindex = index;
                                    // });
                                  },
                                  child: Container(
                                    height: 60,
                                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: _currentTapindex == index
                                            ? Constants.primaryColor1
                                            : Constants.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              blurRadius: 0.5,
                                              spreadRadius: 0.5,
                                              offset: const Offset(1, 4))
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Constants.lightGreen,width: 1)
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget.OfferData.offerData!.buyORsell == "DELIVER_SELL" ||widget.OfferData.offerData!.buyORsell == "DELIVER_BUY"?
                                        index == 0 ? "Deliver Buy" : "Deliver Sell":
                                        index == 0 ? "Buy" : "Sell",
                                        style:_currentTapindex == index?WhiteTitleStyle:BlackFieldStyleBold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )),
                      Expanded(
                          child: ListView(
                            shrinkWrap: false,
                            children: [
                              Container(
                                color: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Text("Category",style: BlackDescStyle,),
                                        Text(" > ",style: BlackDescStyle,),
                                        Text("Segment ",style: BlackDescStyle,),
                                        Text(" > ",style: BlackDescStyle,),
                                        Text("Type ",style: BlackDescStyle,),
                                      ],
                                    ),
                                    const SizedBox(height: 5,),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children:  [
                                          Text("${widget.OfferData.offerData!.category!.name}",style: BlackFieldStyleBold,),
                                          Text("  >  ",style: BlackFieldStyleBold,),
                                          Text("${widget.OfferData.offerData!.segment!.name}",style: BlackFieldStyleBold,),
                                          Text("  >  ",style: BlackFieldStyleBold,),
                                          Text("${widget.OfferData.offerData!.subsegment!.name}",style: BlackFieldStyleBold,),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE7E6E6),
                                  // borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Offer’s Conditions",
                                          style: BlackTitleBoldStyle,
                                        )),
                                    const SizedBox(height: 10,),
                                    SizedBox(
                                        height: 60,
                                        width: double.infinity,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          physics:  ClampingScrollPhysics(),
                                          shrinkWrap: false,
                                          children: [
                                            selectedPeriodicityValue == ""?SizedBox():  Padding(
                                              padding: EdgeInsets.only(right:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      DropdownButtonHideUnderline(
                                                        child: DropdownButton2(
                                                          isExpanded: true,

                                                          items:periodicityList.map((item) => DropdownMenuItem (
                                                            value: item,
                                                            child: Text(item, style:  BlackSubHeadingStyle, overflow: TextOverflow.ellipsis,),
                                                          )).toList(),
                                                          value: selectedPeriodicityValue==""?null:selectedPeriodicityValue,
                                                          // onChanged: (newValue) {
                                                          //   setState(() {
                                                          //     selectedPeriodicityValue = newValue!;
                                                          //   });
                                                          // },
                                                          onChanged: null,
                                                          hint: const Text(
                                                              "Periodicity",
                                                              style:greyHintStyle
                                                          ),
                                                          iconStyleData: const IconStyleData(
                                                            icon: Icon(Icons.keyboard_arrow_down_sharp,),
                                                            iconSize: 10,
                                                            iconEnabledColor: Colors.white,
                                                            iconDisabledColor:Colors.white,
                                                          ),
                                                          buttonStyleData: ButtonStyleData(
                                                              height:  35,
                                                              width: ResponsiveHelper.isMobile(context)?width*0.38:tabWidth*0.38,
                                                              padding: const EdgeInsets.only(left: 22, right: 3),
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white),
                                                              elevation:  1,
                                                              overlayColor: MaterialStateProperty.all(Colors.white)
                                                          ),
                                                          menuItemStyleData: MenuItemStyleData(
                                                            height: 33,
                                                            selectedMenuItemBuilder: (context, child) {
                                                              return     Container(
                                                                padding: const EdgeInsets.only(left: 0, right: 0),
                                                                width: ResponsiveHelper.isMobile(context)?width*0.38:tabWidth*0.38,
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
                                                            width: ResponsiveHelper.isMobile(context)?width*0.38:tabWidth*0.38,
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

                                                          style: BlackFieldStyle,

                                                        ),
                                                      ),
                                                      // Positioned(
                                                      //     bottom:1,left:2,
                                                      //     child: InkWell(
                                                      //       onTap:(){
                                                      //         setState((){
                                                      //           isPeriodicityVisible = false;
                                                      //         });
                                                      //       },
                                                      //       child: CircleAvatar(
                                                      //         radius:8,
                                                      //         backgroundColor: Color(
                                                      //             0x3389F6B9) ,
                                                      //         child: Center(
                                                      //             child:Icon(Icons.close,color: Colors.black,size:14,)
                                                      //         ),
                                                      //       ),
                                                      //     ))
                                                    ],
                                                  ),
                                                  const SizedBox(height:5,),
                                                  const Padding(
                                                    padding: EdgeInsets.only(left:8.0),
                                                    child: Text("Periodicity", style: BlackDescStyle,),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            OfferPeriodController.text != ""? Padding(
                                              padding: EdgeInsets.only(right:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        padding:EdgeInsets.only(left:12),
                                                        decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                          BoxShadow(
                                                              blurRadius: 2.0,
                                                              color: Colors.black54,
                                                              offset: Offset(0.0, 0.5) ),
                                                        ], borderRadius: BorderRadius.circular(5)),
                                                        width: ResponsiveHelper.isMobile(context)?width*0.55:tabWidth*0.55,
                                                        child: TextFormField(
                                                          controller: OfferPeriodController,
                                                          readOnly: true,
                                                          // onTap:(){
                                                          //   if(selectedPeriodicityValue==null){
                                                          //     Constants.showToast("Please select periodicity first");
                                                          //   }else{
                                                          //     if(selectedPeriodicityValue == "Today" || selectedPeriodicityValue == "Tomorrow"){
                                                          //       DateTimeRangePicker(
                                                          //           startText: "From",
                                                          //           endText: "To",
                                                          //           doneText: "Done",
                                                          //           cancelText: "Cancel",
                                                          //           interval: 1,
                                                          //           mode: DateTimeRangePickerMode.time,
                                                          //           minimumTime: DateTime.now(),
                                                          //           maximumTime: DateTime.now().add(Duration(days: 25)),
                                                          //           use24hFormat: false,
                                                          //           onConfirm: (start, end) {
                                                          //             print(start);
                                                          //             print(end);
                                                          //             if(end == "NotPick"){
                                                          //               setState((){
                                                          //                 OfferDurationController.clear();
                                                          //                 isSinglePeriodSelect =true;
                                                          //                 final  STime = DateFormat('HH:mm a').format(start);
                                                          //                 OfferPeriodController.text = "From ${STime}";
                                                          //                 offerPeriodFromTime="";
                                                          //                 offerPeriodFromDate="";
                                                          //                 offerPeriodToDate="";
                                                          //                 offerPeriodToTime="";
                                                          //                 final  STime24 = DateFormat('HH:mm').format(start);
                                                          //                 offerPeriodFromTime = STime24.toString();
                                                          //               });
                                                          //
                                                          //             }else{
                                                          //               setState((){
                                                          //                 isSinglePeriodSelect =false;
                                                          //                 Duration diff = DateTime.parse(end).difference(start);
                                                          //                 print("diff");
                                                          //                 print(diff);
                                                          //                 diff.inHours !=0?  OfferDurationController.text = "${diff.inHours.toString()} Hours": diff.inSeconds !=00?OfferDurationController.text = "${diff.inMinutes.toString()} Minutes" :OfferDurationController.text = "${diff.inSeconds.toString()} Seconds";
                                                          //                 final  FTime = DateFormat('HH:mm a').format(start);
                                                          //                 final  ToTime = DateFormat('HH:mm a').format(DateTime.parse(end));
                                                          //                 OfferPeriodController.text = "${FTime} - ${ToTime}";
                                                          //                 offerPeriodFromTime="";
                                                          //                 offerPeriodFromDate="";
                                                          //                 offerPeriodToDate="";
                                                          //                 offerPeriodToTime="";
                                                          //                 final  FTime24 = DateFormat('HH:mm').format(start);
                                                          //                 final  ToTime24 = DateFormat('HH:mm').format(DateTime.parse(end));
                                                          //                 offerPeriodFromTime = FTime24.toString();
                                                          //                 offerPeriodToTime = ToTime24.toString();
                                                          //               });
                                                          //             }
                                                          //           }).showPicker(context);
                                                          //     }else{
                                                          //       DateTimeRangePicker(
                                                          //           startText: "From",
                                                          //           endText: "To",
                                                          //           doneText: "Done",
                                                          //           cancelText: "Cancel",
                                                          //           interval: 1,
                                                          //           mode: DateTimeRangePickerMode.dateAndTime,
                                                          //           minimumTime: DateTime.now(),
                                                          //           maximumTime: DateTime.now().add(Duration(days: 25)),
                                                          //           use24hFormat: false,
                                                          //           onConfirm: (start, end) {
                                                          //             if(end == "NotPick"){
                                                          //               setState((){
                                                          //                 OfferDurationController.clear();
                                                          //                 isSinglePeriodSelect =true;
                                                          //                 final  STime = DateFormat('dd-MMM-yyyy HH:mm a').format(start);
                                                          //                 OfferPeriodController.text = "From ${STime}";
                                                          //                 final  SDate = DateFormat('dd-MM-yyyy').format(start);
                                                          //                 final  STime24 = DateFormat('HH:mm').format(start);
                                                          //                 offerPeriodFromTime="";
                                                          //                 offerPeriodFromDate="";
                                                          //                 offerPeriodToDate="";
                                                          //                 offerPeriodToTime="";
                                                          //                 offerPeriodFromTime = STime24.toString();
                                                          //                 offerPeriodFromDate = SDate.toString();
                                                          //
                                                          //               });
                                                          //
                                                          //             }else{
                                                          //               setState((){
                                                          //                 isSinglePeriodSelect =false;
                                                          //                 Duration diff = DateTime.parse(end).difference(start);
                                                          //                 diff.inDays/30 >12 ?  OfferDurationController.text = "${(diff.inDays/365).toStringAsFixed(2)} Years": diff.inDays > 30 ? OfferDurationController.text = "${(diff.inDays/30).toStringAsFixed(2)} Months":    diff.inHours >23 ?OfferDurationController.text = "${diff.inDays.toString()} Days":  diff.inHours !=0?  OfferDurationController.text = "${diff.inHours.toString()} Hours": diff.inSeconds !=00?OfferDurationController.text = "${diff.inMinutes.toString()} Minutes" :OfferDurationController.text = "${diff.inSeconds.toString()} Seconds";
                                                          //                 final  FTime = DateFormat('dd-MMM-yyyy').format(start);
                                                          //                 final  ToTime = DateFormat('dd-MMM-yyyy').format(DateTime.parse(end));
                                                          //                 OfferPeriodController.text = "${FTime}-${ToTime}";
                                                          //                 final  SDate = DateFormat('dd-MM-yyyy').format(start);
                                                          //                 final  STime24 = DateFormat('HH:mm').format(start);
                                                          //                 offerPeriodFromTime = STime24.toString();
                                                          //                 offerPeriodFromDate = SDate.toString();
                                                          //                 final  EDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(end));
                                                          //                 final  ETime24 = DateFormat('HH:mm').format(DateTime.parse(end));
                                                          //                 offerPeriodToTime = ETime24.toString();
                                                          //                 offerPeriodToDate = EDate.toString();
                                                          //               });
                                                          //             }
                                                          //           }).showPicker(context);
                                                          //     }
                                                          //   }
                                                          // },
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(hintText: "Period", fillColor:  Colors.white, hintStyle: greyHintStyle,
                                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                            border: const OutlineInputBorder(),
                                                          ),
                                                          style: Black87HintStyle,
                                                        ),
                                                      ),
                                                      // Positioned(
                                                      //     bottom:1,left:2,
                                                      //     child: InkWell(
                                                      //       onTap:(){
                                                      //         setState((){
                                                      //           isPeriodVisible = false;
                                                      //         });
                                                      //       },
                                                      //       child: CircleAvatar(
                                                      //         radius:8,
                                                      //         backgroundColor: Color(
                                                      //             0x3389F6B9) ,
                                                      //         child: Center(
                                                      //             child:Icon(Icons.close,color: Colors.black,size:14,)
                                                      //         ),
                                                      //       ),
                                                      //     ))
                                                    ],
                                                  ),
                                                  const SizedBox(height:5,),
                                                  const Padding(
                                                    padding: EdgeInsets.only(left:8.0),
                                                    child: Text("Period", style: BlackDescStyle,),
                                                  ),
                                                ],
                                              ),
                                            ):SizedBox(),

                                            OfferDurationController.text != "" ?   Padding(
                                              padding: EdgeInsets.only(right:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        padding:EdgeInsets.only(left:12),
                                                        decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                          BoxShadow(
                                                              blurRadius: 2.0,
                                                              color: Colors.black54,
                                                              offset: Offset(0.0, 0.5) ),
                                                        ], borderRadius: BorderRadius.circular(5)),
                                                        width: ResponsiveHelper.isMobile(context)?width*0.5:tabWidth*0.5,
                                                        child: TextFormField(
                                                          inputFormatters: [maskFormatter],
                                                          controller: OfferDurationController,
                                                          keyboardType: TextInputType.number,
                                                          readOnly: true,
                                                          //  readOnly: isSinglePeriodSelect==true?false:true,
                                                          decoration: InputDecoration(hintText: "YY : MM : DD : HH : MI", fillColor:  Colors.white, hintStyle: greyHintStyle,
                                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                            border: const OutlineInputBorder(),
                                                            // hintText: 'Enter Query',hintStyle: hintstyle,
                                                          ),
                                                          style: Black87HintStyle,                                                  ),
                                                      ),
                                                      // Positioned(
                                                      //     bottom:1,left:2,
                                                      //     child: InkWell(
                                                      //       onTap:(){
                                                      //         setState((){
                                                      //           isDurationVisible = false;
                                                      //         });
                                                      //       },
                                                      //       child: CircleAvatar(
                                                      //         radius:8,
                                                      //         backgroundColor: Color(
                                                      //             0x3389F6B9) ,
                                                      //         child: Center(
                                                      //             child:Icon(Icons.close,color: Colors.black,size:14,)
                                                      //         ),
                                                      //       ),
                                                      //     ))
                                                    ],
                                                  ),
                                                  const SizedBox(height:5,),
                                                  const Padding(
                                                    padding: EdgeInsets.only(left:5.0),
                                                    child: Text("Duration(YY:MM:DD:HH:MI)", style: BlackDescStyle,),
                                                  ),
                                                ],
                                              ),
                                            ):SizedBox(),
                                            selectedItems.isEmpty?SizedBox():  Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      height:40,
                                                      decoration:BoxDecoration(
                                                        color:Colors.transparent,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              blurRadius: 1.0,
                                                              color: Colors.black12,
                                                              offset: Offset(0.0, 0.5) ),
                                                        ],
                                                      ),
                                                      width:isMobile?width:tabWidth,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(0.0),
                                                        child: CustomSearchableDropDownForUs(
                                                          initialValue:  selectedItems ,
                                                          items: ServicePersonList,
                                                          menuHeight: 30.0,
                                                          label: 'Select Service/Delivery person',
                                                          multiSelectTag: 'Names',
                                                          labelStyle: WhiteHintStyle,
                                                          multiSelectValuesAsWidget: true,
                                                          dropdownItemStyle: darkGrey14400,

                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(5),
                                                          ),
                                                          multiSelect: true,
                                                          dropDownMenuItems: ServicePersonList.map((item) {
                                                            return item.displayname.toString();
                                                          }).toList() ?? [],
                                                          onChanged: (value){

                                                            if(value!=null)
                                                            {
                                                              setState(() {
                                                                selectedItems =   jsonDecode(value).map((e) =>e["id"] ).toList();
                                                                print(selectedItems.where((e)=> e.toString() == "-1").toString() == "(-1)");
                                                                print(selectedItems.where((e)=> e.toString() == "0").toString() == "(0)" );
                                                                for(var i = 0 ;i< ItemsList.length ; i++){
                                                                  ItemsList[i]["item_condition"]["servicepersons"]  =jsonDecode(value).map((e) =>e["id"] ).toList();
                                                                }
                                                              });
                                                            }
                                                            else{
                                                              //selectedItems!.clear();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(child: Container( width:isMobile?width:tabWidth,height:40,color: Colors.transparent,))

                                                  ],
                                                ),
                                                const SizedBox(height:3,),
                                                const Padding(
                                                  padding: EdgeInsets.only(left:4.0),
                                                  child: Text("Service/Delivery person", style: BlackDescStyle,),
                                                ),
                                              ],
                                            ),
                                            // Column(
                                            //   mainAxisAlignment: MainAxisAlignment.start,
                                            //   crossAxisAlignment:CrossAxisAlignment.start,
                                            //   children: [
                                            //     Stack(
                                            //       children: [
                                            //         Container(
                                            //           height:40,
                                            //           decoration:BoxDecoration(
                                            //             color:Colors.transparent,
                                            //             boxShadow: [
                                            //               BoxShadow(
                                            //                   blurRadius: 1.0,
                                            //                   color: Colors.black26,
                                            //                   offset: Offset(0.0, 0.5) ),
                                            //             ],
                                            //           ),
                                            //
                                            //           width: ResponsiveHelper.isMobile(context)?width*0.10:tabWidth*0.10,
                                            //           child: Padding(
                                            //             padding: const EdgeInsets.all(0.0),
                                            //             child: CustomSearchableDropDownForUs(
                                            //               initialValue:  selectedItems ,
                                            //               items: ServicePersonList,
                                            //               menuHeight: 30.0,
                                            //               label: 'Select Service/Delivery person',
                                            //               multiSelectTag: 'Names',
                                            //               multiSelectValuesAsWidget: true,
                                            //               decoration: BoxDecoration(
                                            //                 color: Colors.white,
                                            //                 borderRadius: BorderRadius.circular(5),
                                            //               ),
                                            //               multiSelect: true,
                                            //               dropDownMenuItems: ServicePersonList.map((item) {
                                            //                 return item.username;
                                            //               }).toList() ?? [],
                                            //               onChanged: (value){
                                            //                 print(value);
                                            //                 if(value!=null)
                                            //                 {
                                            //                   setState(() {
                                            //                     selectedItems =   jsonDecode(value).map((e) =>e["id"] ).toList();
                                            //                   });
                                            //                 }
                                            //                 else{
                                            //                   //selectedItems!.clear();
                                            //                 }
                                            //               },
                                            //             ),
                                            //           ),
                                            //         ),
                                            //         Container(
                                            //             width: ResponsiveHelper.isMobile(context)?width*0.10:tabWidth*0.10,
                                            //             height:40,color:Colors.transparent
                                            //         )
                                            //       ],
                                            //     ),
                                            //     const SizedBox(height:3,),
                                            //     const Padding(
                                            //       padding: EdgeInsets.only(left:4.0),
                                            //       child: Text("Service/Delivery person", style: BlackDescStyle,),
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        )),
                                    const SizedBox(height: 10,),
                                    SizedBox(
                                        height: 60,
                                        width: double.infinity,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          physics: const ClampingScrollPhysics(),
                                          shrinkWrap: false,
                                          children: [
                                            selectedValuePriority != ""?    Padding(
                                              padding: EdgeInsets.only(right:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      DropdownButtonHideUnderline(
                                                        child: DropdownButton2(
                                                          isExpanded: true,
                                                          items:priority.map((item) => DropdownMenuItem (
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style: BlackSubHeadingStyle,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          )).toList(),
                                                          value: selectedValuePriority==""?null:selectedValuePriority,
                                                          // onChanged: (newValue) {
                                                          //   setState(() {
                                                          //     selectedValuePriority = newValue!;
                                                          //   });
                                                          // },
                                                          onChanged: null,
                                                          hint: const Text(
                                                              "Priority",
                                                              style:greyHintStyle
                                                          ),
                                                          iconStyleData: const IconStyleData(
                                                            icon: Icon(Icons.keyboard_arrow_down_sharp,),
                                                            iconSize: 10,
                                                            iconEnabledColor: Colors.white,
                                                            iconDisabledColor:Colors.white,
                                                          ),
                                                          buttonStyleData: ButtonStyleData(
                                                              height:  35,
                                                              width:isMobile?width*0.3:tabWidth*0.3,
                                                              padding: const EdgeInsets.only(left: 20, right: 3),
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white),
                                                              elevation:  1,
                                                              overlayColor: MaterialStateProperty.all(Colors.white)
                                                          ),
                                                          menuItemStyleData: MenuItemStyleData(
                                                            height: 33,
                                                            selectedMenuItemBuilder: (context, child) {
                                                              return     Container(
                                                                padding: const EdgeInsets.only(left: 0, right: 0),
                                                                width:isMobile?width*0.3:tabWidth*0.3,
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
                                                            width:isMobile?width*0.3:tabWidth*0.3,
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

                                                          style: BlackFieldStyle,

                                                        ),
                                                      ),
                                                      // Positioned(
                                                      //     bottom:1,left:2,
                                                      //     child: InkWell(
                                                      //       onTap:(){
                                                      //         setState((){
                                                      //           isPriorityVisible = false;
                                                      //         });
                                                      //       },
                                                      //       child: CircleAvatar(
                                                      //         radius:8,
                                                      //         backgroundColor: Color(0x3389F6B9) ,
                                                      //         child: Center(
                                                      //             child:Icon(Icons.close,color: Colors.black,size:14,)
                                                      //         ),
                                                      //       ),
                                                      //     )),
                                                    ],
                                                  ),
                                                  const SizedBox(height:5,),
                                                  const Padding(
                                                    padding: EdgeInsets.only(left:8.0),
                                                    child: Text("Priority", style: BlackDescStyle,),
                                                  ),
                                                ],
                                              ),
                                            ):SizedBox(),
                                            OfferExpiryController.text != ""? Padding(
                                              padding: EdgeInsets.only(right:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        padding: EdgeInsets.only(left:12),
                                                        decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                          BoxShadow(
                                                              blurRadius: 2.0,
                                                              color: Colors.black54,
                                                              offset: Offset(0.0, 0.5) ),
                                                        ], borderRadius: BorderRadius.circular(5)),
                                                        width: ResponsiveHelper.isMobile(context)?width*0.35:tabWidth*0.35,
                                                        child: TextFormField(
                                                          onTap:(){
                                                            // showGeneralDialog(
                                                            //     barrierColor: Colors.black.withOpacity(0.5),
                                                            //     transitionBuilder: (context, a1, a2, widget) {
                                                            //       return Transform.scale(
                                                            //         scale: a1.value,
                                                            //         child: Opacity(
                                                            //             opacity: a1.value,
                                                            //             child: Dialog(
                                                            //                 clipBehavior: Clip.hardEdge,
                                                            //                 shape: RoundedRectangleBorder(
                                                            //                   borderRadius: BorderRadius.circular(15),
                                                            //                 ),
                                                            //                 insetPadding: const EdgeInsets.symmetric(horizontal: 25),
                                                            //                 backgroundColor: Colors.white,
                                                            //                 child:SizedBox(
                                                            //                   height: MediaQuery.of(context).size.height*0.3,
                                                            //                   child:  Column(
                                                            //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            //                     children: [
                                                            //                       Flexible(
                                                            //                         child: Padding(
                                                            //                             padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                                            //                             child: CupertinoDatePicker(
                                                            //                               mode: CupertinoDatePickerMode.dateAndTime,
                                                            //                               dateOrder: DatePickerDateOrder.dmy,
                                                            //                               use24hFormat: false,
                                                            //                               minuteInterval: 1,
                                                            //                               minimumDate:DateTime.now(),
                                                            //                               initialDateTime: DateTime.now(),
                                                            //                               onDateTimeChanged: (DateTime newDateTime) {
                                                            //                                 setState((){
                                                            //                                   ExDTime = newDateTime;
                                                            //                                 });
                                                            //                               },
                                                            //                               maximumDate: DateTime.now().add(const Duration(days: 25)),
                                                            //                             )
                                                            //                         ),
                                                            //                       ),
                                                            //                       Padding(
                                                            //                         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                                            //                         child: ElevatedButton(
                                                            //                           style: ButtonStyle(
                                                            //                               backgroundColor: MaterialStateProperty.all(Constants.primaryColor ),
                                                            //                               elevation: MaterialStateProperty.all(0),
                                                            //                               foregroundColor: MaterialStateProperty.all(Colors.transparent),
                                                            //                               overlayColor: MaterialStateProperty.all(Colors.transparent),
                                                            //                               shadowColor: MaterialStateProperty.all(Colors.transparent),
                                                            //                               shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                            //                                 borderRadius: BorderRadius.circular(8),
                                                            //                               ),)
                                                            //                           ),
                                                            //                           onPressed: () {
                                                            //                             setState((){
                                                            //                               final  STime = DateFormat('dd-MMM-yyyy HH:mm a').format(ExDTime!);
                                                            //                               OfferExpiryController.text =STime ;
                                                            //                               final  SDateTime = DateFormat('dd-MM-yyyy HH:mm').format(ExDTime!);
                                                            //                               offerExpiryDateTime = SDateTime;
                                                            //                             });
                                                            //                             Navigator.pop(context);
                                                            //                           },
                                                            //                           child: const Padding(
                                                            //                             padding: EdgeInsets.all(12.0),
                                                            //                             child: Center(
                                                            //                               child: Text(
                                                            //                                 'Save',
                                                            //                                 style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                                                            //                                 textAlign: TextAlign.center,
                                                            //                               ),
                                                            //                             ),
                                                            //                           ),
                                                            //                         ),
                                                            //                       ),
                                                            //                     ],
                                                            //                   ),
                                                            //                 )
                                                            //             )),
                                                            //       );
                                                            //     },
                                                            //     transitionDuration: const Duration(milliseconds: 300),
                                                            //     barrierDismissible: true,
                                                            //     barrierLabel: '',
                                                            //     context: context,
                                                            //     pageBuilder: (BuildContext context, Animation<double> animation,
                                                            //         Animation<double> secondaryAnimation) {
                                                            //       return const Text('');
                                                            //     }
                                                            // );
                                                          },
                                                          readOnly: true,
                                                          controller: OfferExpiryController,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(hintText: "Expiry", fillColor:  Colors.white, hintStyle: greyHintStyle,
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
                                                      // Positioned(
                                                      //     bottom:1,left:2,
                                                      //     child: InkWell(
                                                      //       onTap:(){
                                                      //         setState((){
                                                      //           isExpiryVisible = false;
                                                      //         });
                                                      //       },
                                                      //       child: CircleAvatar(
                                                      //         radius:8,
                                                      //         backgroundColor: Color(0x3389F6B9) ,
                                                      //         child: Center(
                                                      //             child:Icon(Icons.close,color: Colors.black,size:14,)
                                                      //         ),
                                                      //       ),
                                                      //     )),
                                                    ],
                                                  ),
                                                  const SizedBox(height:5,),
                                                  const Padding(
                                                    padding: EdgeInsets.only(left:8.0),
                                                    child: Text("Expiry", style: BlackDescStyle,),
                                                  ),
                                                ],
                                              ),
                                            ):SizedBox(),
                                            OfferFromLocationController.text.isEmpty ||  OfferFromLocationController.text==""?SizedBox():    Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      height: 35,margin: EdgeInsets.only(right:12) ,
                                                      padding: EdgeInsets.only(left:12),
                                                      decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 2.0,
                                                            color: Colors.black54,
                                                            offset: Offset(0.0, 0.5) ),
                                                      ], borderRadius: BorderRadius.circular(5)),
                                                      width: ResponsiveHelper.isMobile(context)?width*0.45:tabWidth*0.45,
                                                      child: TextFormField(
                                                        controller: OfferFromLocationController,
                                                        // onTap:() async {
                                                        //   LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlacePicker("${ApiUrls.mapKey}")));
                                                        //   setState((){
                                                        //     OfferLocationCountList[index].text=result!.formattedAddress.toString();
                                                        //   });
                                                        //   //  Navigator.push(context, MaterialPageRoute(builder: (context) => placepick(title: "Place picker"),));
                                                        // },
                                                        readOnly:true,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(hintText:"From location", fillColor:  Colors.white, hintStyle: greyHintStyle,
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

                                                  ],
                                                ),
                                                const SizedBox(height:5,),
                                                Padding(
                                                  padding: EdgeInsets.only(left:4.0),
                                                  child: Text("From location", style: BlackDescStyle,),
                                                ),
                                              ],
                                            ),
                                            OfferToLocationController.text.isEmpty ||  OfferToLocationController.text==""?SizedBox():      Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      margin: EdgeInsets.only(right:12) ,
                                                      padding: EdgeInsets.only(left:12),
                                                      decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 2.0,
                                                            color: Colors.black54,
                                                            offset: Offset(0.0, 0.5) ),
                                                      ], borderRadius: BorderRadius.circular(5)),
                                                      width: ResponsiveHelper.isMobile(context)?width*0.45:tabWidth*0.45,
                                                      child: TextFormField(
                                                        controller: OfferToLocationController,
                                                        // onTap:() async {
                                                        //   LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlacePicker("${ApiUrls.mapKey}")));
                                                        //   setState((){
                                                        //     OfferLocationCountList[index].text=result!.formattedAddress.toString();
                                                        //   });
                                                        //   //  Navigator.push(context, MaterialPageRoute(builder: (context) => placepick(title: "Place picker"),));
                                                        // },
                                                        readOnly:true,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(hintText:"To location", fillColor:  Colors.white, hintStyle: greyHintStyle,
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
                                                    // Positioned(
                                                    //     bottom:1,left:2,
                                                    //     child: InkWell(
                                                    //       onTap:(){
                                                    //         setState((){
                                                    //           OfferLocationCountList.removeAt(index);
                                                    //         });
                                                    //       },
                                                    //       child: CircleAvatar(
                                                    //         radius:8,
                                                    //         backgroundColor: Color(
                                                    //             0x3389F6B9) ,
                                                    //         child: Center(
                                                    //             child:Icon(Icons.close,color: Colors.black,size:14,)
                                                    //         ),
                                                    //       ),
                                                    //     )),
                                                    // OfferLocationCountList.length-1 == index?   Positioned(
                                                    //     top:1,right:2,
                                                    //     child: InkWell(
                                                    //       onTap:(){
                                                    //         setState((){
                                                    //           OfferLocationCountList.length==3?Constants.showToast("From Location,To Location and At Location are allowed"): OfferLocationCountList.add(TextEditingController()) ;
                                                    //         });
                                                    //       },
                                                    //       child: CircleAvatar(
                                                    //         radius:8,
                                                    //         backgroundColor: Constants.primaryColor ,
                                                    //         child: Center(
                                                    //             child:Icon(Icons.add,color: Colors.white,size:14,)
                                                    //         ),
                                                    //       ),
                                                    //     )):SizedBox()
                                                  ],
                                                ),
                                                const SizedBox(height:5,),
                                                Padding(
                                                  padding: EdgeInsets.only(left:4.0),
                                                  child: Text("To location", style: BlackDescStyle,),
                                                ),
                                              ],
                                            ),
                                            OfferAtLocationController.text.isEmpty ||  OfferAtLocationController.text==""?SizedBox():   Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      height: 35,margin: EdgeInsets.only(right:12) ,
                                                      padding: EdgeInsets.only(left:12),
                                                      decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 2.0,
                                                            color: Colors.black54,
                                                            offset: Offset(0.0, 0.5) ),
                                                      ], borderRadius: BorderRadius.circular(5)),
                                                      width: ResponsiveHelper.isMobile(context)?width*0.45:tabWidth*0.45,
                                                      child: TextFormField(
                                                        controller:OfferAtLocationController,
                                                        // onTap:() async {
                                                        //   LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlacePicker("${ApiUrls.mapKey}")));
                                                        //   setState((){
                                                        //     OfferLocationCountList[index].text=result!.formattedAddress.toString();
                                                        //   });
                                                        //   //  Navigator.push(context, MaterialPageRoute(builder: (context) => placepick(title: "Place picker"),));
                                                        // },
                                                        readOnly:true,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(hintText:"At location", fillColor:  Colors.white, hintStyle: greyHintStyle,
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
                                                    // Positioned(
                                                    //     bottom:1,left:2,
                                                    //     child: InkWell(
                                                    //       onTap:(){
                                                    //         setState((){
                                                    //           OfferLocationCountList.removeAt(index);
                                                    //         });
                                                    //       },
                                                    //       child: CircleAvatar(
                                                    //         radius:8,
                                                    //         backgroundColor: Color(
                                                    //             0x3389F6B9) ,
                                                    //         child: Center(
                                                    //             child:Icon(Icons.close,color: Colors.black,size:14,)
                                                    //         ),
                                                    //       ),
                                                    //     )),
                                                    // OfferLocationCountList.length-1 == index?   Positioned(
                                                    //     top:1,right:2,
                                                    //     child: InkWell(
                                                    //       onTap:(){
                                                    //         setState((){
                                                    //           OfferLocationCountList.length==3?Constants.showToast("From Location,To Location and At Location are allowed"): OfferLocationCountList.add(TextEditingController()) ;
                                                    //         });
                                                    //       },
                                                    //       child: CircleAvatar(
                                                    //         radius:8,
                                                    //         backgroundColor: Constants.primaryColor ,
                                                    //         child: Center(
                                                    //             child:Icon(Icons.add,color: Colors.white,size:14,)
                                                    //         ),
                                                    //       ),
                                                    //     )):SizedBox()
                                                  ],
                                                ),
                                                const SizedBox(height:5,),
                                                Padding(
                                                  padding: EdgeInsets.only(left:4.0),
                                                  child: Text("At location", style: BlackDescStyle,),
                                                ),
                                              ],
                                            ),
                                            // OfferLocationCountList.length==0?SizedBox():  SizedBox(
                                            //   height: 60,
                                            //   width:OfferLocationCountList.length == 1?
                                            //   MediaQuery.of(context).size.width*0.47:
                                            //   OfferLocationCountList.length == 2?
                                            //   MediaQuery.of(context).size.width*0.95:
                                            //   MediaQuery.of(context).size.width*1.45 ,
                                            //   child: ListView.builder(
                                            //     scrollDirection: Axis.horizontal,
                                            //     itemCount: OfferLocationCountList.length,
                                            //     physics: const NeverScrollableScrollPhysics(),
                                            //     itemBuilder: (context, index) {
                                            //       return  Padding(
                                            //         padding: EdgeInsets.only(right:10),
                                            //         child: Column(
                                            //           crossAxisAlignment: CrossAxisAlignment.start,
                                            //           children: [
                                            //             Stack(
                                            //               children: [
                                            //                 Container(
                                            //                   height: 35,
                                            //                   padding: EdgeInsets.only(left:12),
                                            //                   decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                            //                     BoxShadow(
                                            //                         blurRadius: 2.0,
                                            //                         color: Colors.black54,
                                            //                         offset: Offset(0.0, 0.5) ),
                                            //                   ], borderRadius: BorderRadius.circular(5)),
                                            //                   width: ResponsiveHelper.isMobile(context)?width*0.45:tabWidth*0.45,
                                            //                   child: TextFormField(
                                            //                     controller: OfferLocationCountList[index],
                                            //                     // onTap:() async {
                                            //                     //   LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlacePicker("${ApiUrls.mapKey}")));
                                            //                     //   setState((){
                                            //                     //     OfferLocationCountList[index].text=result!.formattedAddress.toString();
                                            //                     //   });
                                            //                     //   //  Navigator.push(context, MaterialPageRoute(builder: (context) => placepick(title: "Place picker"),));
                                            //                     // },
                                            //                     readOnly:true,
                                            //                     keyboardType: TextInputType.text,
                                            //                     decoration: InputDecoration(hintText:index == 0 ?"From location":index == 1 ?"To location":"At location", fillColor:  Colors.white, hintStyle: greyHintStyle,
                                            //                       focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                            //                       enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                            //                       floatingLabelBehavior: FloatingLabelBehavior.never,
                                            //                       contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                            //                       border: const OutlineInputBorder(),
                                            //                       // hintText: 'Enter Query',hintStyle: hintstyle,
                                            //                     ),
                                            //                     style: Black87HintStyle,
                                            //                   ),
                                            //                 ),
                                            //                 // Positioned(
                                            //                 //     bottom:1,left:2,
                                            //                 //     child: InkWell(
                                            //                 //       onTap:(){
                                            //                 //         setState((){
                                            //                 //           OfferLocationCountList.removeAt(index);
                                            //                 //         });
                                            //                 //       },
                                            //                 //       child: CircleAvatar(
                                            //                 //         radius:8,
                                            //                 //         backgroundColor: Color(
                                            //                 //             0x3389F6B9) ,
                                            //                 //         child: Center(
                                            //                 //             child:Icon(Icons.close,color: Colors.black,size:14,)
                                            //                 //         ),
                                            //                 //       ),
                                            //                 //     )),
                                            //                 // OfferLocationCountList.length-1 == index?   Positioned(
                                            //                 //     top:1,right:2,
                                            //                 //     child: InkWell(
                                            //                 //       onTap:(){
                                            //                 //         setState((){
                                            //                 //           OfferLocationCountList.length==3?Constants.showToast("From Location,To Location and At Location are allowed"): OfferLocationCountList.add(TextEditingController()) ;
                                            //                 //         });
                                            //                 //       },
                                            //                 //       child: CircleAvatar(
                                            //                 //         radius:8,
                                            //                 //         backgroundColor: Constants.primaryColor ,
                                            //                 //         child: Center(
                                            //                 //             child:Icon(Icons.add,color: Colors.white,size:14,)
                                            //                 //         ),
                                            //                 //       ),
                                            //                 //     )):SizedBox()
                                            //               ],
                                            //             ),
                                            //             const SizedBox(height:5,),
                                            //             Padding(
                                            //               padding: EdgeInsets.only(left:4.0),
                                            //               child: Text(index == 0 ?"From location":index == 1 ?"To location":"At location", style: blackSText,),
                                            //             ),
                                            //           ],
                                            //         ),
                                            //       );
                                            //     },
                                            //   ),
                                            // ),
                                            const SizedBox(width: 8,),
                                          ],
                                        )),
                                    // selectedValuePriority ==null? SizedBox(
                                    //   height: 45, width: double.infinity,
                                    //   child: ListView.builder(
                                    //     itemCount: offer.length,
                                    //     physics: const ClampingScrollPhysics(),
                                    //     scrollDirection: Axis.horizontal,
                                    //     shrinkWrap: true,
                                    //     itemBuilder: (BuildContext context, int index) {
                                    //       var datas = offer[index];
                                    //       return  Stack(
                                    //         children: [
                                    //           Center(
                                    //             child: index==0?DropdownButtonHideUnderline(
                                    //               child: DropdownButton2(
                                    //                 hint: const Padding(
                                    //                   padding: EdgeInsets.only(left: 22.0),
                                    //                   child: Text(
                                    //                     'Priority',
                                    //                     style: TextStyle(
                                    //                       fontSize: 14,
                                    //                       color: Colors.black,
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //                 iconStyleData: const IconStyleData(iconDisabledColor: Colors.white,iconEnabledColor: Colors.white,iconSize: 0),
                                    //                 items: priority
                                    //                     .map((item) => DropdownMenuItem<String>(
                                    //                   value: item,
                                    //                   child: Padding(
                                    //                     padding: const EdgeInsets.only(left: 22.0),
                                    //                     child: Text(
                                    //                       item,
                                    //                       style: const TextStyle(
                                    //                         fontSize: 14,
                                    //                       ),textAlign: TextAlign.center,
                                    //                     ),
                                    //                   ),
                                    //                 ))
                                    //                     .toList(),
                                    //                 value: selectedValuePriority,
                                    //                 onChanged: (value) {
                                    //                   setState(() {
                                    //                     selectedValuePriority = value as String;
                                    //                   });
                                    //                 },
                                    //                 buttonStyleData: const ButtonStyleData(
                                    //                   height: 35,
                                    //                   width: 100,
                                    //                   decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8))),
                                    //                 ),
                                    //                 dropdownStyleData:  DropdownStyleData(
                                    //                     maxHeight: 200,
                                    //                     offset: const Offset(0, 0),
                                    //                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Constants.primaryColor)),
                                    //                     width: 200),
                                    //                 menuItemStyleData: const MenuItemStyleData(
                                    //                   height: 40,
                                    //                 ),
                                    //               ),
                                    //             ):
                                    //             Container(
                                    //               padding: const EdgeInsets.only(top:10,right: 20,left: 10),
                                    //               margin: const EdgeInsets.only(left: 10),
                                    //               height: 35,
                                    //               decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8))),
                                    //               child: Text(datas.toString(),textAlign: TextAlign.center,),
                                    //             ),
                                    //           ),
                                    //           const SizedBox(width: 5,),
                                    //           Positioned(
                                    //               bottom: 2,
                                    //               left:index==0?0:5,
                                    //               child: CircleAvatar(
                                    //                 radius: 8,
                                    //                 backgroundColor: const Color(0x8052B46B),
                                    //                 child: Center(
                                    //                   child: InkWell(
                                    //                     onTap: (){
                                    //                       setState(() {
                                    //                         offer.removeAt(index);
                                    //                       });
                                    //                     },
                                    //                     child: const Icon(Icons.close,
                                    //                         color: Colors.white, size: 13),
                                    //                   ),
                                    //                 ),
                                    //               )),
                                    //           const SizedBox(width: 5,),
                                    //           index==0 || index== 1 || index == 2 ?const SizedBox():Positioned(
                                    //               top: 2,
                                    //               right: 3,
                                    //               child: InkWell(
                                    //                 onTap: (){
                                    //                   setState(() {
                                    //                     offers.add("At Location");
                                    //                     // offer.add("To Location");
                                    //                   });
                                    //                 },
                                    //                 child: const CircleAvatar(
                                    //                   radius: 10,
                                    //                   backgroundColor:primaryColor,
                                    //                   child: Center(
                                    //                     child: Icon(Icons.add, color: Colors.white, size: 20),
                                    //                   ),
                                    //                 ),
                                    //               )),
                                    //         ],
                                    //       );
                                    //     },
                                    //     // children: [
                                    //     //
                                    //     //   const SizedBox(width: 5,),
                                    //     //   Stack(children: [
                                    //     //     Container(
                                    //     //       margin:
                                    //     //           const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                    //     //       padding:
                                    //     //           const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                    //     //       width: 80,
                                    //     //       decoration: BoxDecoration(
                                    //     //           color: const Color(0xfffFFFFFF),
                                    //     //           borderRadius: const BorderRadius.only(
                                    //     //               topRight: Radius.circular(8),
                                    //     //               topLeft: Radius.circular(8)),
                                    //     //           border: Border.all(color: Colors.white),
                                    //     //           boxShadow: const [
                                    //     //             BoxShadow(
                                    //     //                 color: Color(0xfffDADADA),
                                    //     //                 spreadRadius: 0.5,
                                    //     //                 blurRadius: 0.5,
                                    //     //                 blurStyle: BlurStyle.solid)
                                    //     //           ]),
                                    //     //       child:  Center(
                                    //     //         child: Text(
                                    //     //           selectedValuePriority==null?"Expiry":"10:50 Am",
                                    //     //           style: blackSText,
                                    //     //         ),
                                    //     //       ),
                                    //     //     ),
                                    //     //     const Positioned(
                                    //     //         bottom: 2,
                                    //     //         left: 2,
                                    //     //         child: CircleAvatar(
                                    //     //           radius: 8,
                                    //     //           backgroundColor: Color(0x8052B46B),
                                    //     //           child: Center(
                                    //     //             child: Icon(Icons.close,
                                    //     //                 color: Colors.white, size: 13),
                                    //     //           ),
                                    //     //         ))
                                    //     //   ]),
                                    //     //
                                    //     //   Stack(children: [
                                    //     //     Container(
                                    //     //       margin:
                                    //     //           const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                    //     //       padding:
                                    //     //           const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                    //     //       width: 120,
                                    //     //       decoration: BoxDecoration(
                                    //     //           color: const Color(0xfffFFFFFF),
                                    //     //           borderRadius: const BorderRadius.only(
                                    //     //               topRight: Radius.circular(8),
                                    //     //               topLeft: Radius.circular(8)),
                                    //     //           border: Border.all(color: Colors.white),
                                    //     //           boxShadow: const [
                                    //     //             BoxShadow(
                                    //     //                 color: Color(0xfffDADADA),
                                    //     //                 spreadRadius: 0.5,
                                    //     //                 blurRadius: 0.5,
                                    //     //                 blurStyle: BlurStyle.solid)
                                    //     //           ]),
                                    //     //       child: const Center(
                                    //     //         child: Text(
                                    //     //           "From Location",
                                    //     //           style: blackSText,
                                    //     //         ),
                                    //     //       ),
                                    //     //     ),
                                    //     //     const Positioned(
                                    //     //         bottom: 2,
                                    //     //         left: 2,
                                    //     //         child: CircleAvatar(
                                    //     //           radius: 8,
                                    //     //           backgroundColor: Color(0x8052B46B),
                                    //     //           child: Center(
                                    //     //             child: Icon(Icons.close,
                                    //     //                 color: Colors.white, size: 13),
                                    //     //           ),
                                    //     //         ))
                                    //     //   ]),
                                    //     //   Stack(children: [
                                    //     //     Container(
                                    //     //       margin:
                                    //     //           const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                    //     //       padding:
                                    //     //           const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                    //     //       width: 120,
                                    //     //       decoration: BoxDecoration(
                                    //     //           color: const Color(0xfffFFFFFF),
                                    //     //           borderRadius: const BorderRadius.only(
                                    //     //               topRight: Radius.circular(8),
                                    //     //               topLeft: Radius.circular(8)),
                                    //     //           border: Border.all(color: Colors.white),
                                    //     //           boxShadow: const [
                                    //     //             BoxShadow(
                                    //     //                 color: Color(0xfffDADADA),
                                    //     //                 spreadRadius: 0.5,
                                    //     //                 blurRadius: 0.5,
                                    //     //                 blurStyle: BlurStyle.solid)
                                    //     //           ]),
                                    //     //       child: const Center(
                                    //     //         child: Text(
                                    //     //           "To Location",
                                    //     //           style: blackSText,
                                    //     //         ),
                                    //     //       ),
                                    //     //     ),
                                    //     //     const Positioned(
                                    //     //         top: 2,
                                    //     //         right: 3,
                                    //     //         child: CircleAvatar(
                                    //     //           radius: 10,
                                    //     //           backgroundColor: primaryColor,
                                    //     //           child: Center(
                                    //     //             child: Icon(Icons.add,
                                    //     //                 color: Colors.white, size: 20),
                                    //     //           ),
                                    //     //         )),
                                    //     //     const Positioned(
                                    //     //         bottom: 2,
                                    //     //         left: 2,
                                    //     //         child: CircleAvatar(
                                    //     //           radius: 8,
                                    //     //           backgroundColor: Color(0x8052B46B),
                                    //     //           child: Center(
                                    //     //             child: Icon(Icons.close,
                                    //     //                 color: Colors.white, size: 13),
                                    //     //           ),
                                    //     //         ))
                                    //     //   ]),
                                    //     // ],
                                    //   ),
                                    // ):
                                    // SizedBox(
                                    //   height: 60, width: double.infinity,
                                    //   child: ListView(
                                    //     physics: const ClampingScrollPhysics(),
                                    //     scrollDirection: Axis.horizontal,
                                    //     shrinkWrap: true,
                                    //     children: [
                                    //       Column(
                                    //         crossAxisAlignment: CrossAxisAlignment.start,
                                    //         children: [
                                    //           Center(
                                    //             child: DropdownButtonHideUnderline(
                                    //               child: DropdownButton2(
                                    //                 hint: const Padding(
                                    //                   padding: EdgeInsets.only(left: 22.0),
                                    //                   child: Text(
                                    //                     'Priority',
                                    //                     style: TextStyle(
                                    //                       fontSize: 14,
                                    //                       color: Colors.black,
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //                 iconStyleData: const IconStyleData(iconDisabledColor: Colors.white,iconEnabledColor: Colors.white,iconSize: 0),
                                    //                 items: priority
                                    //                     .map((item) => DropdownMenuItem<String>(
                                    //                   value: item,
                                    //                   child: Padding(
                                    //                     padding: const EdgeInsets.only(left: 22.0),
                                    //                     child: Text(
                                    //                       item,
                                    //                       style: const TextStyle(
                                    //                         fontSize: 14,
                                    //                       ),textAlign: TextAlign.center,
                                    //                     ),
                                    //                   ),
                                    //                 ))
                                    //                     .toList(),
                                    //                 value: selectedValuePriority,
                                    //                 onChanged: (value) {
                                    //                   setState(() {
                                    //                     selectedValuePriority = value as String;
                                    //                   });
                                    //                 },
                                    //                 buttonStyleData:  ButtonStyleData(
                                    //                   height: 40,
                                    //                   width: 100,
                                    //                   decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                                    //                 ),
                                    //                 dropdownStyleData:  DropdownStyleData(
                                    //                     maxHeight: 200,
                                    //                     offset: const Offset(0, 0),
                                    //                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Constants.primaryColor)),
                                    //                     width: 200),
                                    //                 menuItemStyleData: const MenuItemStyleData(
                                    //                   height: 40,
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //           const Text("Priority", style: blackSText,),
                                    //         ],
                                    //       ),
                                    //       const SizedBox(width: 8,),
                                    //       Column(
                                    //         crossAxisAlignment: CrossAxisAlignment.start,
                                    //         children: [
                                    //           Container(
                                    //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                    //             child: TimePickerSpinnerPopUp(
                                    //               mode: CupertinoDatePickerMode.time,
                                    //               initTime: DateTime.now(),
                                    //               minTime: DateTime.now().subtract(const Duration(hours: 10)),
                                    //               maxTime: DateTime.now().add(const Duration(hours: 10)),
                                    //               barrierColor: Colors.black12, //Barrier Color when pop up show
                                    //               onChange: (dateTime) {
                                    //                 // Implement your logic with select dateTime
                                    //               },
                                    //               // Customize your time widget
                                    //               // timeWidgetBuilder: (dateTime) {},
                                    //
                                    //               // Customize your time format
                                    //               // timeFormat: 'dd/MM/yyyy',
                                    //
                                    //               // Customize your time format
                                    //               // timeFormat: 'dd/MM/yyyy',
                                    //             ),
                                    //           ),
                                    //           const Text("Expiry", style: blackSText,),
                                    //         ],
                                    //       ),
                                    //       const SizedBox(width: 8,),
                                    //       Column(
                                    //         crossAxisAlignment: CrossAxisAlignment.start,
                                    //         children: [
                                    //           Stack(
                                    //             children: [
                                    //               Center(
                                    //                 child: DropdownButtonHideUnderline(
                                    //                   child: DropdownButton2(
                                    //                     hint: const Padding(
                                    //                       padding: EdgeInsets.only(left: 20.0),
                                    //                       child: Text(
                                    //                         'At Location',
                                    //                         style: TextStyle(
                                    //                           fontSize: 14,
                                    //                           color: Colors.black,
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                     iconStyleData: const IconStyleData(iconDisabledColor: Colors.white,iconEnabledColor: Colors.white,iconSize: 0),
                                    //                     items: location
                                    //                         .map((item) => DropdownMenuItem<String>(
                                    //                       value: item,
                                    //                       child: Padding(
                                    //                         padding: const EdgeInsets.only(left: 22.0),
                                    //                         child: Text(
                                    //                           item,
                                    //                           style: const TextStyle(
                                    //                             fontSize: 14,
                                    //                           ),textAlign: TextAlign.center,
                                    //                         ),
                                    //                       ),
                                    //                     ))
                                    //                         .toList(),
                                    //                     value: selectedLocation,
                                    //                     onChanged: (value) {
                                    //                       setState(() {
                                    //                         selectedLocation = value as String;
                                    //                       });
                                    //                     },
                                    //                     buttonStyleData:  ButtonStyleData(
                                    //                       height: 40,
                                    //                       width: 100,
                                    //                       decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                                    //                     ),
                                    //                     dropdownStyleData:  DropdownStyleData(
                                    //                         maxHeight: 200,
                                    //                         offset: const Offset(0, 0),
                                    //                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Constants.primaryColor)),
                                    //                         width: 200),
                                    //                     menuItemStyleData: const MenuItemStyleData(
                                    //                       height: 40,
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //               const Positioned(
                                    //                   bottom: 0,
                                    //                   child: CircleAvatar(
                                    //                     radius: 8,
                                    //                     backgroundColor: Color(0x8052B46B),
                                    //                     child: Center(
                                    //                       child: Icon(Icons.close,
                                    //                           color: Colors.white, size: 13),
                                    //                     ),
                                    //                   ))
                                    //             ],
                                    //           ),
                                    //           Text(selectedLocation==null?"":"At Location", style: blackSText,),
                                    //         ],
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                itemCount:ItemsList.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var data = ItemsList[index];

                                  return
                                    data["quantity"] == 0 ?SizedBox():
                                  Container(
                                    color:  Colors.white,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      height: data["name"].text.length < 15 ?35:null,
                                                      decoration: BoxDecoration(
                                                          color: Constants.white,
                                                          borderRadius: BorderRadius.circular(5)),
                                                      width: ResponsiveHelper.isMobile(context)?width*0.4:tabWidth*0.4,
                                                      margin: EdgeInsets.only(left: 5,right:5,top: 10),
                                                      child: ConstrainedBox(
                                                        constraints: BoxConstraints(
                                                            maxHeight: 150.0
                                                        ),
                                                        child: TextFormField(
                                                            maxLines: null,
                                                            controller: data["name"],
                                                            readOnly: index <= widget.OfferData.offerData!.offerItems!.length-1? true:false,
                                                            decoration: InputDecoration(
                                                              hintText: "Enter Item Name",
                                                              fillColor:  Colors.white,
                                                              hintStyle: Constants.hintStyle,
                                                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                              enabledBorder: OutlineInputBorder(borderSide:  BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                              floatingLabelBehavior: FloatingLabelBehavior.never,
                                                              contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                              border: const OutlineInputBorder(),
                                                              // hintText: 'Enter Query',hintStyle: hintstyle,
                                                            ),
                                                            style:BlackSubTitleStyle),
                                                      ),
                                                    ),
                                                    index==0?Positioned(
                                                      top:10,right:0,
                                                      child: InkWell(
                                                        onTap:(){

                                                          setState((){
                                                            List selectedItemsPersonList = [];
                                                            List<UnitListData> TempUnitList = [];
                                                            ItemsList.add({
                                                              "itemType" :"New",
                                                              "name":TextEditingController(),
                                                              "desc":TextEditingController(),
                                                              "price":TextEditingController(),
                                                              "unit":TextEditingController(),
                                                              "AdvancePrice" : TextEditingController(text : ""),
                                                              "AdvanceUnit" : TextEditingController(text : ""),
                                                              "MaintenancePrice" : TextEditingController(text : ""),
                                                              "MaintenanceUnit" : TextEditingController(text : ""),


                                                              "filterGetUnitList" : TempUnitList,
                                                              "showOtherUnit" : false,
                                                              "isLoadNewUnit" : false,
                                                              "selectedUnitIndex" : -1,
                                                              "SelectedUnitId" : "",

                                                              "filterGetUnitListMain" : TempUnitList,
                                                              "showOtherUnitMain" : false,
                                                              "isLoadNewUnitMain" : false,
                                                              "selectedUnitIndexMain" : -1,
                                                              "SelectedUnitIdMain" : "",

                                                              "filterGetUnitListAdva" : TempUnitList,
                                                              "showOtherUnitAdva" : false,
                                                              "isLoadNewUnitAdva" : false,
                                                              "selectedUnitIndexAdva" : -1,
                                                              "SelectedUnitIdAdva" : "",
                                                              "quantity":1,
                                                              "currency":"INR",
                                                              "addon":false,
                                                              "required":false,
                                                              "toggle_state":true,
                                                              "media":[],
                                                              "isLoadingFile":false,
                                                              "fileUrl":[],
                                                              "image":"",
                                                              "itemConditionView" :false,
                                                              "create_date": "new",
                                                              "CreatorUserId" : DataManager.getInstance().userId.toString(),
                                                              "showItemPrice2":false,
                                                              "showItemPrice3":false,
                                                              "item_condition":{
                                                                "isServicePersonView" :true,
                                                                "periodicityView": true,
                                                                "periodView": true,
                                                                "durationView": true,
                                                                "priorityView": true,
                                                                "expiryView": true,
                                                                "fromlocationView": true,
                                                                "tolocationView": true,
                                                                "atlocationView": true,
                                                                "servicepersons": selectedItemsPersonList,
                                                                "period":TextEditingController(),
                                                                "periodicity":"",
                                                                "fromperiod":"",
                                                                "toperiod":"",
                                                                "duration":TextEditingController(),
                                                                "fromperiodtime":"",
                                                                "toperiodtime":"",
                                                                "durationoftime":"",
                                                                "fromlocation":TextEditingController(),
                                                                "tolocation":TextEditingController(),
                                                                "atlocation":TextEditingController(),
                                                                "priority":"",
                                                                "expiry":TextEditingController(text: "")
                                                              }
                                                            });
                                                            requiredItemPriceIsEmpty.add(false);
                                                          });
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor:primaryColor,
                                                          child: Center(
                                                            child: Icon(Icons.add, color: Colors.white, size: 20),
                                                          ),
                                                        ),
                                                      ),
                                                    ): Positioned(
                                                      top:10,right:0,
                                                      child: InkWell(
                                                        onTap:(){
                                                          setState((){
                                                            ItemsList.removeAt(index);
                                                          });
                                                        },
                                                        child:index <= widget.OfferData.offerData!.offerItems!.length-1? SizedBox(): CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor:primaryColor,
                                                          child: Center(
                                                            child: Icon(Icons.remove, color: Colors.white, size: 20),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxHeight: 150.0
                                                  ),
                                                  child: Container(
                                                    height: data["desc"].text.length < 15 ?35:null,
                                                    decoration: BoxDecoration(
                                                        color: Constants.white,
                                                        borderRadius: BorderRadius.circular(5)),
                                                    width: ResponsiveHelper.isMobile(context)?width*0.4:tabWidth*0.4,
                                                    margin: EdgeInsets.only(left: 5,right:5,top: 10),
                                                    child: TextFormField(
                                                      controller: data["desc"],
                                                      maxLines: null,
                                                      readOnly:  index <= widget.OfferData.offerData!.offerItems!.length-1? true:false,
                                                      decoration: InputDecoration(
                                                        hintText: "Enter Description",
                                                        fillColor:  Colors.white,
                                                        hintStyle: Constants.hintStyle,
                                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                        enabledBorder: OutlineInputBorder(borderSide:  BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                        border: const OutlineInputBorder(),
                                                        // hintText: 'Enter Query',hintStyle: hintstyle,
                                                      ),
                                                      style: Black87HintStyle,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:[
                                                SizedBox(height: 10,),
                                                data["itemType"] == "Old"? data["required"] == true? Text("REQUIRED", style: PrimaryColorTitleStyle,):SizedBox() :
                                                InkWell(
                                                    onTap:(){
                                                      setState(() {
                                                        data["required"] = !data["required"];
                                                        Constants.showToast( data["required"]  == true ?"REQUIRED Enabled":"REQUIRED Disabled");
                                                      });
                                                    },
                                                    child: Text("REQUIRED", style: TextStyle(color:data["required"] ==true?primaryColor: Colors.black38, fontWeight:data["required"] ==true ?FontWeight.w700:FontWeight.w500, fontSize: 14),)),

                                                data["itemType"] == "Old"?  data["required"] == true?  SizedBox(height: 10,):SizedBox(): SizedBox(height: 10,),
                                                data["itemType"] == "Old"?  data["addon"] == true?   Text("ADD ON", style: PrimaryColorTitleStyle, ):SizedBox():
                                                InkWell(
                                                    onTap:(){
                                                      setState(() {
                                                        data["addon"] = !data["addon"];
                                                        Constants.showToast( data["addon"]  == true ?"ADDON Enabled":"ADDON Disabled");
                                                      });
                                                    },
                                                    child: Text("ADD ON", style: TextStyle(color: data["addon"] == true?primaryColor: Colors.black38, fontWeight:data["addon"] ==true ?FontWeight.w700: FontWeight.w500, fontSize: 14), )),
                                                data["addon"] == true?   SizedBox(height: 7,):SizedBox(),
                                                data["itemType"] == "Old"? Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: FlutterSwitch(
                                                      showOnOff: false,
                                                      value: data["toggle_state"],
                                                      toggleSize: 20,
                                                      padding: 1,
                                                      height: 22,
                                                      width: 42,valueFontSize: 14,
                                                      activeColor:SwitchButtonActiveColor,
                                                      inactiveColor: Color(0xD0DCDCDC),
                                                      onToggle: (newVal) async {
                                                        setState(() {
                                                          print("Required Item Select Opration");

                                                          data["toggle_state"] = newVal;
                                                          if(newVal == true){
                                                            isRequiredItemSelect[index]=true;
                                                          }else{
                                                            isRequiredItemSelect[index]=false;
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ):SizedBox(),
                                              ],
                                            ),
                                            const SizedBox(width: 10,),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                data["itemType"] == "Old"?
                                                DottedBorder(
                                                  dashPattern: const [6, 2],
                                                  strokeWidth: 1.5,
                                                  color: Constants.primaryColor1,
                                                  borderType: BorderType.RRect,
                                                  radius: const Radius.circular(2),
                                                  child: Stack(

                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          data["media"].isEmpty?  Constants.showToast("Media file not available"):   Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryScreen(MediaList: data["media"],UrlList: data["fileUrl"],)));
                                                        },
                                                        child: data["media"].isEmpty
                                                            ?  Image.asset("assets/image1.png",height: 84,width: 84,fit: BoxFit.fill)
                                                            : SizedBox(
                                                          height: 84,
                                                          width: 84, child: "${data["media"][0]["name"].toString().substring( data["media"][0]["name"].toString().lastIndexOf('.'))}" == ".mp4"?Image.asset("assets/mp4placeholder.png",fit: BoxFit.cover):
                                                          Image.network(data["fileUrl"][0], fit: BoxFit.fill),
                                                        ),
                                                      ),
                                                      data["media"].isEmpty ||  data["media"].length == 1 ?SizedBox():
                                                      InkWell(
                                                        onTap:(){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryScreen(MediaList: data["media"],UrlList: data["fileUrl"],)));
                                                        },
                                                        child: Container(
                                                            height: 84,
                                                            width: 84,
                                                            padding: const EdgeInsets.all(0),
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                                color: Constants.closeOfferCard,
                                                                borderRadius: BorderRadius.circular(5)),
                                                            child:Center(
                                                                child:Text("+${data["media"].length -1}",style: BlackTitles400height,)
                                                            )
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ) :
                                                Row(
                                                  children: [
                                                    DottedBorder(
                                                      dashPattern: const [6, 2],
                                                      strokeWidth: 1.5,
                                                      color: Constants.primaryColor1,
                                                      borderType: BorderType.RRect,
                                                      radius: const Radius.circular(2),
                                                      child: Stack(

                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              data["media"].isEmpty?
                                                              ShowPickerBottomSheet(context,
                                                                  GalleryOnTap: () async{
                                                                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                                      type: FileType.custom,
                                                                      allowMultiple: false,
                                                                      allowedExtensions: ['jpg', 'png', 'mp4',"jpeg"],
                                                                    );
                                                                    if (result != null) {
                                                                      PlatformFile file = result.files.first;
                                                                      setState(() {
                                                                        data["isLoadingFile"] = true;
                                                                      },);
                                                                      ThatZalApis.UploadFile(file: file.path).then((value)  {
                                                                        if(value != null){
                                                                          if(value["status"] == true){
                                                                            setState(() {
                                                                              data["isLoadingFile"] = false;
                                                                              data["media"] = [{
                                                                                "file":"${value["result"]["id"]}",
                                                                                "name" : "${value["result"]["name"]}"
                                                                              }];
                                                                              data["fileUrl"] = ["${value["result"]["file"]}"];
                                                                            });
                                                                          }
                                                                        }
                                                                      });
                                                                    } else {
                                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nothing is selected')));
                                                                    }

                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  CameraOnTap: ()async{
                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageCameraScreen())).then((value) {
                                                                      Navigator.of(context).pop();
                                                                      if (value != null) {
                                                                        ConstantFun.imageProfileCropper(path: value).then((file) async {
                                                                          setState(() {
                                                                            data["isLoadingFile"] = true;
                                                                          },);
                                                                          ThatZalApis.UploadFile(file: file.path).then((UploadImage)  {
                                                                            if(UploadImage != null){
                                                                              if(UploadImage["status"] == true){
                                                                                setState(() {
                                                                                  data["isLoadingFile"] = false;
                                                                                  data["media"] = [{
                                                                                    "file":"${UploadImage["result"]["id"]}",
                                                                                    "name" : "${UploadImage["result"]["name"]}"
                                                                                  }];
                                                                                  data["fileUrl"] = ["${UploadImage["result"]["file"]}"];
                                                                                });
                                                                              }
                                                                            }
                                                                          });
                                                                        });
                                                                      }else{
                                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nothing is selected')));
                                                                      }
                                                                    });
                                                                  }
                                                              ):   Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryScreen(MediaList: data["media"],UrlList: data["fileUrl"],)));
                                                            },
                                                            child: data["media"].isEmpty
                                                                ? Container(
                                                                height: 84,
                                                                width:  data["media"].isEmpty?84: 45,
                                                                padding: const EdgeInsets.all(0),
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                    color: Colors.white,
                                                                    borderRadius: BorderRadius.circular(5)),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children:  [
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      "UPLOAD MEDIA",
                                                                      style: uploadMetaStyle,
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                    data["isLoadingFile"] == true ?
                                                                    LoadingWidgetWithoutBox()
                                                                        : SizedBox()
                                                                  ],
                                                                ))
                                                                : SizedBox(
                                                              height: 84,
                                                              width: 45, child:
                                                            "${data["media"][0]["name"].toString().substring( data["media"][0]["name"].toString().lastIndexOf('.'))}" == ".mp4"?Image.asset("assets/mp4placeholder.png",fit: BoxFit.cover):
                                                            Image.network(data["fileUrl"][0], fit: BoxFit.fill),
                                                            ),
                                                          ),
                                                          data["media"].isEmpty ||  data["media"].length == 1 ?SizedBox():
                                                          InkWell(
                                                            onTap:(){
                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryScreen(MediaList: data["media"],UrlList: data["fileUrl"])));
                                                            },
                                                            child: Container(
                                                                height: 84,
                                                                width:  data["media"].isEmpty?84: 45,
                                                                padding: const EdgeInsets.all(0),
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                    color: Constants. closeOfferCard,
                                                                    borderRadius: BorderRadius.circular(5)),
                                                                child:Center(
                                                                    child:Text("+${data["media"].length -1}",style: BlackTitles400height,)
                                                                )
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    data["media"].isEmpty?SizedBox():  DottedBorder(
                                                      dashPattern: const [6, 2],
                                                      strokeWidth: 1.5,
                                                      color: Constants.primaryColor1,
                                                      borderType: BorderType.Rect,
                                                      radius: const Radius.circular(2),
                                                      child: InkWell(
                                                          onTap: () async {
                                                            if(data["media"].length == 4){
                                                              Constants.showToast("Max 4 files are allowed for select");
                                                            }else{
                                                              ShowPickerBottomSheet(
                                                                  context,
                                                                  GalleryOnTap: () async{
                                                                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                                      type: FileType.custom,
                                                                      allowMultiple: false,
                                                                      allowedExtensions: ['jpg', 'png', 'mp4',"jpeg"],
                                                                    );
                                                                    if(result != null){
                                                                      PlatformFile file = result.files.first;
                                                                      setState(() {
                                                                        data["isLoadingFile"] = true;
                                                                      },);
                                                                      ThatZalApis.UploadFile(file: file.path).then((value)  {
                                                                        if(value != null){
                                                                          if(value["status"] == true){
                                                                            setState(() {
                                                                              data["isLoadingFile"] = false;
                                                                              data["media"].add({
                                                                                "file":"${value["result"]["id"]}",
                                                                                "name" : "${value["result"]["name"]}"
                                                                              });
                                                                              data["fileUrl"].add("${value["result"]["file"]}");
                                                                            });
                                                                          }
                                                                        }
                                                                      });
                                                                    }else {
                                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nothing is selected')));
                                                                    }
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  CameraOnTap: ()async{

                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageCameraScreen())).then((value) {
                                                                      Navigator.of(context).pop();
                                                                      if (value != null) {
                                                                        ConstantFun.imageProfileCropper(path: value).then((file) async {

                                                                          setState(() {
                                                                            data["isLoadingFile"] = true;
                                                                          },);
                                                                          ThatZalApis.UploadFile(file: file.path).then((UploadImage)  {
                                                                            print("UploadImage");
                                                                            print(UploadImage);
                                                                            if(UploadImage != null){
                                                                              if(UploadImage["status"] == true){
                                                                                setState(() {
                                                                                  data["isLoadingFile"] = false;
                                                                                  data["media"].add({
                                                                                    "file":"${UploadImage["result"]["id"]}",
                                                                                    "name" :"${UploadImage["result"]["name"]}"
                                                                                  });
                                                                                  data["fileUrl"].add("${UploadImage["result"]["file"]}");
                                                                                });
                                                                              }
                                                                            }
                                                                          });
                                                                        });
                                                                      }else{
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar( // is this context <<<
                                                                            const SnackBar(content: Text(
                                                                                'Nothing is selected')));
                                                                      }
                                                                    });

                                                                    // final ImagePicker picker = ImagePicker();
                                                                    // final pickedFile = await picker.pickImage(source: ImageSource.camera);
                                                                    // XFile? xfilePick = pickedFile;
                                                                    // setState(
                                                                    //       () {
                                                                    //     if (xfilePick != null) {
                                                                    //
                                                                    //     } else {
                                                                    //       ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
                                                                    //           const SnackBar(content: Text('Nothing is selected')));
                                                                    //     }
                                                                    //   },
                                                                    // );
                                                                    // Navigator.of(context).pop();
                                                                  }
                                                              );
                                                            }
                                                          },
                                                          child: Container(
                                                              height: 84,
                                                              width: 35,
                                                              padding: const EdgeInsets.all(0),
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(5)),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children:  [
                                                                  data["isLoadingFile"] == true ?
                                                                  LoadingWidgetWithoutBox(): Icon(
                                                                    Icons.add,
                                                                    color: primaryColor,
                                                                    size: 35,
                                                                  ),
                                                                ],
                                                              ))

                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // data["media"].isEmpty?SizedBox():
                                                // Padding(
                                                //   padding: const EdgeInsets.only(left:8.0,top:5),
                                                //   child: Text(
                                                //     "Upload Meta",
                                                //     style: BlackDescStyle,
                                                //   ),
                                                // ),

                                              ],
                                            ),
                                            const SizedBox(width: 15,),
                                          ],
                                        ),
                                        SizedBox(height: 15,),
                                        Stack(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(width: 13,),
                                                Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                  width: ResponsiveHelper.isMobile(context)?width*0.39:tabWidth*0.39,
                                                  margin: EdgeInsets.only(left: 5,top: 10),
                                                  child: TextFormField(
                                                    controller: data["price"],
                                                    keyboardType: TextInputType.number,
                                                    decoration: InputDecoration(hintText: "Enter Price", fillColor:  Colors.white,
                                                      hintStyle: Constants.hintStyle,
                                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                      enabledBorder: OutlineInputBorder(borderSide:  BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),

                                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                                      contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                      border: const OutlineInputBorder(),
                                                      // hintText: 'Enter Query',hintStyle: hintstyle,
                                                    ),
                                                    onChanged: (v){
                                                      if(v.toString() == "" || v.isEmpty || v.toString()[0] == "0"){
                                                        setState((){
                                                          requiredItemPriceIsEmpty[index]= true;
                                                        });
                                                      }else{
                                                        setState((){
                                                          requiredItemPriceIsEmpty[index]= false;
                                                        });
                                                      }
                                                    },
                                                    style: Black87HintStyle,
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      decoration: BoxDecoration(color: Colors.white,
                                                          borderRadius: BorderRadius.circular(5)),
                                                      width: ResponsiveHelper.isMobile(context)?width*0.39:tabWidth*0.39,
                                                      margin: EdgeInsets.only(left: 1,right:0,top: 10),
                                                      child: TextFormField(
                                                        controller: data["unit"],
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(hintText: "Enter Unit", fillColor:  Colors.white,
                                                          hintStyle: Constants.hintStyle,
                                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                          enabledBorder: OutlineInputBorder(borderSide:  BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),

                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                          border: const OutlineInputBorder(),

                                                          // hintText: 'Enter Query',hintStyle: hintstyle,
                                                        ),
                                                        onChanged: (String value) async {
                                                          setState(() {
                                                            data["filterGetUnitList"] = getUnitList.where((name) => name.name!.toLowerCase().contains(value.toLowerCase())).toList();
                                                            data["filterGetUnitList"].isEmpty ?  data["showOtherUnit"]=true:data["showOtherUnit"]=false;
                                                          });
                                                          // _searchFilterUnit(value);
                                                        },

                                                        style: Black87HintStyle,
                                                      ),
                                                    ),
                                                    (data["filterGetUnitList"].isEmpty) ? SizedBox()
                                                        :SizedBox(
                                                      width: ResponsiveHelper.isMobile(context)?width*0.39:tabWidth*0.39,
                                                      height: data["filterGetUnitList"].length >= 5 ?  MediaQuery.sizeOf(context).height*0.25 :null,
                                                      child: Card(
                                                        elevation: 2,
                                                        color: Colors.white,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                        child: Scrollbar(
                                                          thumbVisibility: data["filterGetUnitList"].length >= 5? true:false,
                                                          radius: Radius.circular(5),
                                                          thickness: 4,
                                                          child: ListView.builder(
                                                            itemCount:data["filterGetUnitList"].length,
                                                            shrinkWrap: true,
                                                            physics: ClampingScrollPhysics(),
                                                            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                            itemBuilder: (context, index) {
                                                              var Unitdata = data["filterGetUnitList"][index];
                                                              return  Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                                                                child: InkWell(
                                                                    onTap: (){
                                                                      setState(() {
                                                                        data["unit"].text = Unitdata.name.toString() ;
                                                                        data["SelectedUnitId"] =  Unitdata.id.toString();
                                                                        data["filterGetUnitList"].clear();
                                                                        // segmentLoader=true;
                                                                        data["selectedUnitIndex"] = index;
                                                                      });
                                                                      // DrawAuraAPi.getSegmentListApi(catId: Unitdata.id.toString()).then((value) {
                                                                      //   setState(() {
                                                                      //     getSegmentList=value.result!;
                                                                      //     segmentLoader=false;
                                                                      //   });
                                                                      // });

                                                                    },
                                                                    child: Text("${Unitdata.name.toString()}",style: Black87HintStyle,overflow: TextOverflow.ellipsis)),
                                                              );
                                                            },),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                data["filterGetUnitList"].isEmpty &&  data["showOtherUnit"]==true?
                                                InkWell(
                                                    onTap:(){
                                                      setState((){
                                                        data["isLoadNewUnit"]= true;
                                                      });
                                                      var dataParam ={"name": data["unit"].text.toString()};
                                                      DrawAuraAPi().createUnitApi(
                                                          data: dataParam).then((value) {
                                                        if (value["status"] == 200) {
                                                          setState((){
                                                            data["SelectedUnitId"] = value["result"]["id"].toString();
                                                          });
                                                          Fluttertoast.showToast(
                                                              msg: value["message"],
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              timeInSecForIosWeb: 2,
                                                              backgroundColor: Constants.primaryColor1,
                                                              textColor: Colors.white,
                                                              fontSize: 18.0
                                                          );
                                                          setState(() {
                                                            data["isLoadNewUnit"] = false;
                                                            data["showOtherUnit"] =false;
                                                          });
                                                          DrawAuraAPi.getUnitList().then((value) {
                                                            setState((){
                                                              getUnitList.clear();
                                                              getUnitList = value.result!;
                                                            });
                                                          });
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg: value["message"],
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              timeInSecForIosWeb: 2,
                                                              backgroundColor:Constants.primaryColor1,
                                                              textColor: Colors.white,
                                                              fontSize: 18.0
                                                          );
                                                          setState(() {
                                                            data["isLoadNewUnit"] = false;
                                                            data["showOtherUnit"] =false;
                                                          });
                                                        }
                                                      },);
                                                    },
                                                    child: Container(
                                                        height: 35,
                                                        width:  ResponsiveHelper.isMobile(context)?width*0.12:tabWidth*0.12,
                                                        margin: EdgeInsets.only(left: 0,right:0,top: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            color:Constants.primaryColor1
                                                        ),
                                                        child:Center(child: data["isLoadNewUnit"] == false?Text("Other",style: WhiteHeadingStyle,):SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)))
                                                    )):SizedBox(),

                                                const SizedBox(width: 15,)
                                              ],
                                            ),
                                            Positioned(
                                              top: 2,
                                              left: ResponsiveHelper.isMobile(context)?width*0.42:tabWidth*0.41,
                                              child: InkWell(
                                                onTap:(){
                                                  setState(() {
                                                    //isMaintancePriceShow == false ?isMaintancePriceShow=true:isAdvancePriceShow =true;
                                                    data["showItemPrice2"] == false ? data["showItemPrice2"] =true : data["showItemPrice3"] = true;
                                                  });
                                                },
                                                child: const CircleAvatar(
                                                  radius: 9,
                                                  backgroundColor: primaryColor,
                                                  child: Center(
                                                    child: Icon(Icons.add, color: Colors.white, size: 18),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height:data["showItemPrice2"] ==true? 10:0,),
                                        data["showItemPrice2"] ==true? Stack(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(width: 13,),
                                                Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                  width:ResponsiveHelper.isMobile(context)?width*0.39:tabWidth*0.39,
                                                  margin: EdgeInsets.only(left: 5,top: 10),
                                                  child: TextFormField(
                                                    controller: data["MaintenancePrice"],
                                                    keyboardType: TextInputType.number,
                                                    decoration: InputDecoration(hintText: "Enter Price 2", fillColor:  Colors.white,
                                                      hintStyle: Constants.hintStyle,
                                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                      enabledBorder: OutlineInputBorder(borderSide:  BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                                      contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                      border: const OutlineInputBorder(),
                                                      // hintText: 'Enter Query',hintStyle: hintstyle,
                                                    ),
                                                    style: Black87HintStyle,
                                                  ),
                                                ),

                                                Column(
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
                                                      width: ResponsiveHelper.isMobile(context)?width*0.39:tabWidth*0.39,
                                                      margin: EdgeInsets.only(left: 1,right:0,top: 10),
                                                      child: TextFormField(
                                                        controller: data["MaintenanceUnit"],
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(hintText: "Enter Unit 2", fillColor:  Colors.white,
                                                          hintStyle: Constants.hintStyle,
                                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                          enabledBorder: OutlineInputBorder(borderSide:  BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                          border: const OutlineInputBorder(),

                                                          // hintText: 'Enter Query',hintStyle: hintstyle,
                                                        ),
                                                        onChanged: (String value) async {
                                                          setState(() {
                                                            data["filterGetUnitListMain"] = getUnitList.where((name) => name.name!.toLowerCase().contains(value.toLowerCase())).toList();
                                                            data["filterGetUnitListMain"].isEmpty ?  data["showOtherUnitMain"]=true:data["showOtherUnitMain"]=false;
                                                          });
                                                          // _searchFilterUnit(value);
                                                        },

                                                        style: Black87HintStyle,
                                                      ),
                                                    ),
                                                    (data["filterGetUnitListMain"].isEmpty) ? SizedBox()
                                                        :SizedBox(
                                                      width:ResponsiveHelper.isMobile(context)?width*0.39:tabWidth*0.39,
                                                      height: data["filterGetUnitListMain"].length >= 5 ?  MediaQuery.sizeOf(context).height*0.25 :null,
                                                      child: Card(
                                                        elevation: 2,
                                                        color: Colors.white,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                        child: Scrollbar(
                                                          thumbVisibility: data["filterGetUnitListMain"].length >= 5? true:false,
                                                          radius: Radius.circular(5),
                                                          thickness: 4,
                                                          child: ListView.builder(
                                                            itemCount:data["filterGetUnitListMain"].length,
                                                            shrinkWrap: true,
                                                            physics: ClampingScrollPhysics(),
                                                            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                            itemBuilder: (context, index) {
                                                              var Unitdata = data["filterGetUnitListMain"][index];
                                                              return  Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                                                                child: InkWell(
                                                                    onTap: (){
                                                                      setState(() {
                                                                        data["MaintenanceUnit"].text = Unitdata.name.toString() ;
                                                                        data["SelectedUnitIdMain"] =  Unitdata.id.toString();
                                                                        data["filterGetUnitListMain"].clear();
                                                                        // segmentLoader=true;
                                                                        data["selectedUnitIndexMain"] = index;
                                                                      });
                                                                      // DrawAuraAPi.getSegmentListApi(catId: Unitdata.id.toString()).then((value) {
                                                                      //   setState(() {
                                                                      //     getSegmentList=value.result!;
                                                                      //     segmentLoader=false;
                                                                      //   });
                                                                      // });

                                                                    },
                                                                    child: Text("${Unitdata.name.toString()}",style: Black87HintStyle,overflow: TextOverflow.ellipsis)),
                                                              );
                                                            },),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                data["filterGetUnitListMain"].isEmpty &&  data["showOtherUnitMain"]==true?
                                                InkWell(
                                                    onTap:(){
                                                      setState((){
                                                        data["isLoadNewUnitMain"]= true;
                                                      });
                                                      var dataParam ={"name": data["MaintenanceUnit"].text.toString()};
                                                      DrawAuraAPi().createUnitApi(
                                                          data: dataParam).then((value) {
                                                        if (value["status"] == 200) {
                                                          setState((){
                                                            data["SelectedUnitIdMain"] = value["result"]["id"].toString();
                                                          });
                                                          Fluttertoast.showToast(
                                                              msg: value["message"],
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              timeInSecForIosWeb: 2,
                                                              backgroundColor: Constants.primaryColor1,
                                                              textColor: Colors.white,
                                                              fontSize: 18.0
                                                          );
                                                          setState(() {
                                                            data["isLoadNewUnitMain"] = false;
                                                            data["showOtherUnitMain"] =false;
                                                          });
                                                          DrawAuraAPi.getUnitList().then((value) {
                                                            setState((){
                                                              getUnitList.clear();
                                                              getUnitList = value.result!;
                                                            });
                                                          });
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg: value["message"],
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              timeInSecForIosWeb: 2,
                                                              backgroundColor: Constants.primaryColor1,
                                                              textColor: Colors.white,
                                                              fontSize: 18.0
                                                          );
                                                          setState(() {
                                                            data["isLoadNewUnitMain"] = false;
                                                            data["showOtherUnitMain"] =false;
                                                          });
                                                        }
                                                      },);
                                                    },
                                                    child: Container(
                                                        height: 35,
                                                        width: ResponsiveHelper.isMobile(context)?width*0.12:tabWidth*0.12,
                                                        margin: EdgeInsets.only(left: 0,right:0,top: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            color:Constants.primaryColor1
                                                        ),
                                                        child:Center(child: data["isLoadNewUnitMain"]==false?Text("Other",style: WhiteHeadingStyle,):SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)))
                                                    )):SizedBox(),

                                                const SizedBox(width: 15,)
                                              ],
                                            ),
                                            Positioned(
                                              top: 2,
                                              left: ResponsiveHelper.isMobile(context)?width*0.42:tabWidth*0.41,
                                              child: InkWell(
                                                onTap:(){
                                                  setState(() {
                                                    data["showItemPrice2"] = false;
                                                  });
                                                },
                                                child: const CircleAvatar(
                                                  radius: 9,
                                                  backgroundColor: primaryColor,
                                                  child: Center(
                                                    child: Icon(Icons.remove, color: Colors.white, size: 18),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ):SizedBox(),
                                        SizedBox(height:data["showItemPrice3"] ==true?10:0,),
                                        data["showItemPrice3"] ==true?  Stack(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(width: 13,),
                                                Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(color: Colors.white,  borderRadius: BorderRadius.circular(5)),
                                                  width:ResponsiveHelper.isMobile(context)?width*0.39:tabWidth*0.39,
                                                  margin: EdgeInsets.only(left: 5,top: 10),
                                                  child: TextFormField(
                                                    controller: data["AdvancePrice"],
                                                    keyboardType: TextInputType.number,
                                                    decoration: InputDecoration(hintText: "Enter Price 3", fillColor:  Colors.white,
                                                      hintStyle: Constants.hintStyle,
                                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                      enabledBorder: OutlineInputBorder(borderSide:  BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                                      contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                      border: const OutlineInputBorder(),
                                                      // hintText: 'Enter Query',hintStyle: hintstyle,
                                                    ),
                                                    style: Black87HintStyle,
                                                  ),
                                                ),

                                                Column(
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      decoration: BoxDecoration(color: Colors.white,  borderRadius: BorderRadius.circular(5)),
                                                      width: ResponsiveHelper.isMobile(context)?width*0.39:tabWidth*0.39,
                                                      margin: EdgeInsets.only(left: 1,right:0,top: 10),
                                                      child: TextFormField(
                                                        controller: data["AdvanceUnit"],
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(hintText: "Enter Unit 3", fillColor:  Colors.white,hintStyle: greyHintStyle,
                                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                          border: const OutlineInputBorder(),

                                                          // hintText: 'Enter Query',hintStyle: hintstyle,
                                                        ),
                                                        onChanged: (String value) async {
                                                          setState(() {
                                                            data["filterGetUnitListAdva"] = getUnitList.where((name) => name.name!.toLowerCase().contains(value.toLowerCase())).toList();
                                                            data["filterGetUnitListAdva"].isEmpty ?  data["showOtherUnitAdva"]=true:data["showOtherUnitAdva"]=false;
                                                          });
                                                          // _searchFilterUnit(value);
                                                        },
                                                        style: Black87HintStyle,
                                                      ),
                                                    ),
                                                    (data["filterGetUnitListAdva"].isEmpty) ? SizedBox()
                                                        :SizedBox(
                                                      width:ResponsiveHelper.isMobile(context)?width*0.39:tabWidth*0.39,
                                                      height: data["filterGetUnitListAdva"].length >= 5 ?  MediaQuery.sizeOf(context).height*0.25 :null,
                                                      child: Card(
                                                        elevation: 2,
                                                        color: Colors.white,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                        child: Scrollbar(
                                                          thumbVisibility: data["filterGetUnitListAdva"].length >= 5? true:false,
                                                          radius: Radius.circular(5),
                                                          thickness: 4,
                                                          child: ListView.builder(
                                                            itemCount:data["filterGetUnitListAdva"].length,
                                                            shrinkWrap: true,
                                                            physics: ClampingScrollPhysics(),
                                                            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                            itemBuilder: (context, index) {
                                                              var Unitdata = data["filterGetUnitListAdva"][index];
                                                              return  Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                                                                child: InkWell(
                                                                    onTap: (){
                                                                      setState(() {
                                                                        data["AdvanceUnit"].text = Unitdata.name.toString() ;
                                                                        data["SelectedUnitIdAdva"] =  Unitdata.id.toString();
                                                                        data["filterGetUnitListAdva"].clear();
                                                                        data["selectedUnitIndexAdva"] = index;
                                                                      });
                                                                    },
                                                                    child: Text("${Unitdata.name.toString()}",style: Black87HintStyle,overflow: TextOverflow.ellipsis)),
                                                              );
                                                            },),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                data["filterGetUnitListAdva"].isEmpty &&  data["showOtherUnitAdva"]==true?
                                                InkWell(
                                                    onTap:(){
                                                      setState((){
                                                        data["isLoadNewUnitAdva"]= true;
                                                      });
                                                      var dataParam ={"name": data["AdvanceUnit"].text.toString()};
                                                      DrawAuraAPi().createUnitApi(
                                                          data: dataParam).then((value) {
                                                        if (value["status"] == 200) {
                                                          setState((){
                                                            data["SelectedUnitIdAdva"] = value["result"]["id"].toString();
                                                          });
                                                          Fluttertoast.showToast(
                                                              msg: value["message"],
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              timeInSecForIosWeb: 2,
                                                              backgroundColor: Constants.primaryColor1,
                                                              textColor: Colors.white,
                                                              fontSize: 18.0
                                                          );
                                                          setState(() {
                                                            data["isLoadNewUnitAdva"] = false;
                                                            data["showOtherUnitAdva"] =false;
                                                          });
                                                          DrawAuraAPi.getUnitList().then((value) {
                                                            setState((){
                                                              getUnitList.clear();
                                                              getUnitList = value.result!;
                                                            });
                                                          });
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg: value["message"],
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              timeInSecForIosWeb: 2,
                                                              backgroundColor:Constants.primaryColor1,
                                                              textColor: Colors.white,
                                                              fontSize: 18.0
                                                          );
                                                          setState(() {
                                                            data["isLoadNewUnitAdva"] = false;
                                                            data["showOtherUnitAdva"] =false;
                                                          });
                                                        }
                                                      },);
                                                    },
                                                    child: Container(
                                                        height: 35,
                                                        width:  ResponsiveHelper.isMobile(context)?width*0.12:tabWidth*0.12,
                                                        margin: EdgeInsets.only(left: 0,right:0,top: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            color:Constants.primaryColor1
                                                        ),
                                                        child:Center(child: data["isLoadNewUnitAdva"]==false?Text("Other",style: WhiteHeadingStyle,):SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)))
                                                    )):SizedBox(),

                                              ],
                                            ),
                                            Positioned(
                                              top: 2,
                                              left:ResponsiveHelper.isMobile(context)?width*0.42:tabWidth*0.41,
                                              child: InkWell(
                                                onTap:(){
                                                  setState(() {
                                                    setState(() {
                                                      data["showItemPrice3"] = false;
                                                    });
                                                  });
                                                },
                                                child: const CircleAvatar(
                                                  radius: 9,
                                                  backgroundColor: primaryColor,
                                                  child: Center(
                                                    child: Icon(Icons.remove, color: Colors.white, size: 18),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ):SizedBox(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            15.width,
                                            InkWell(
                                              onTap:  (){
                                                setState((){
                                                  data["quantity"]==1? Constants.showToast("Minimum QTY is 1"):  data["quantity"] --;
                                                });
                                              },
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                margin: EdgeInsets.only(top: 10),
                                                decoration: BoxDecoration(color:Color(0xFFeefaf7),borderRadius: BorderRadius.circular(5),border: Border.all(width: 0.5,color:  Constants.primaryColor1)),
                                                child: Center(
                                                  child: Icon(Icons.remove_circle_outline,color: Constants.primaryColor1),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            Container(
                                              width: 80,
                                              height: 35,  margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(color:Color(0xFFeefaf7),borderRadius: BorderRadius.circular(5),border: Border.all(width: 0.5,color:  Constants.primaryColor1)),
                                              child:
                                              Center(child: Text( data["quantity"]==0?"Qty":"${data["quantity"]}",style: BlackBottomHeadStyle18500,)),
                                            ),
                                            SizedBox(width: 5,),
                                            InkWell(
                                              onTap: (){
                                                setState((){
                                                  if( data["quantity"] == data["FixQty"]){
                                                    Constants.showToast("Max Qty is ${data["FixQty"]}");
                                                  }else{
                                                    data["quantity"] ++;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                width: 35,
                                                height: 35,margin: EdgeInsets.only(top: 10),
                                                decoration: BoxDecoration(color:Color(0xFFeefaf7),borderRadius: BorderRadius.circular(5),border: Border.all(width: 0.5,color:  Constants.primaryColor1)),
                                                child: Center(
                                                  child: Icon(Icons.add_circle_outline,color:  Constants.primaryColor1,),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                        const SizedBox(height: 15,),
                                        data["item_condition"]["isServicePersonView"]==false &&
                                            data["item_condition"]["durationView"]==false &&
                                            data["item_condition"]["periodView"] == false &&
                                            data["item_condition"]["periodicityView"] ==false &&
                                            data["item_condition"]["priorityView"]==false&&
                                            data["item_condition"]["expiryView"]==false&&
                                            data["item_condition"]["fromlocationView"]==false&&
                                            data["item_condition"]["tolocationView"]==false &&
                                            data["item_condition"]["atlocationView"]==false?SizedBox():
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          child: Row(
                                            children:  [
                                              const Text(" Add Offer’s conditions for this item", style: BlackSubTitleItalicStyle,),
                                              const SizedBox(width: 5,),
                                              InkWell(
                                                onTap:(){
                                                  setState(() {
                                                    data["itemConditionView"] =! data["itemConditionView"];
                                                  });
                                                },
                                                child: data["itemConditionView"] == false?  CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:primaryColor,
                                                  child: Center(
                                                      child: Icon(Icons.add, color: Colors.white, size: 20)
                                                  ),
                                                ):index <= widget.OfferData.offerData!.offerItems!.length-1? SizedBox(): CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:primaryColor,
                                                  child: Center(
                                                      child: Icon(Icons.remove, color: Colors.white, size: 20)
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        data["item_condition"]["isServicePersonView"]==false &&
                                            data["item_condition"]["durationView"]==false &&
                                            data["item_condition"]["periodView"] == false &&
                                            data["item_condition"]["periodicityView"] ==false ?
                                        SizedBox():
                                        data["itemConditionView"]==true?
                                        SizedBox(
                                            height: 65,
                                            width: double.infinity,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              physics: const ScrollPhysics(),
                                              shrinkWrap: false,
                                              padding: EdgeInsets.only(top:5),
                                              children: [
                                                const SizedBox(width: 12,),
                                                data["item_condition"]["periodicityView"] ==true?  Padding(
                                                  padding: EdgeInsets.only(right:10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          DropdownButtonHideUnderline(
                                                            child: DropdownButton2(
                                                                isExpanded: true,
                                                                items: selectedPeriodicityValue == "Daily" ?
                                                                periodicityDailyList.map((item) => DropdownMenuItem (
                                                                  value: item,
                                                                  child: Text(
                                                                    item,
                                                                    style:  BlackSubHeadingStyle,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                )).toList():
                                                                selectedPeriodicityValue == "Weekends" ?
                                                                periodicityWeekendsList.map((item) => DropdownMenuItem (
                                                                  value: item,
                                                                  child: Text(
                                                                    item,
                                                                    style:  BlackSubHeadingStyle,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                )).toList():
                                                                selectedPeriodicityValue == "Weekdays" ?
                                                                periodicityWeekDaysList.map((item) => DropdownMenuItem (
                                                                  value: item,
                                                                  child: Text(
                                                                    item,
                                                                    style: BlackSubHeadingStyle,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                )).toList():
                                                                periodicityList.map((item) => DropdownMenuItem (
                                                                  value: item,
                                                                  child: Text(
                                                                    item,
                                                                    style:  BlackSubHeadingStyle,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                )).toList(),
                                                                // items:periodicityList.map((item) => DropdownMenuItem (
                                                                //   value: item,
                                                                //   child: Text(
                                                                //     item,
                                                                //     style: BlackSubHeadingStyle,
                                                                //     overflow: TextOverflow.ellipsis,
                                                                //   ),
                                                                // )).toList(),
                                                                value: data["item_condition"]["periodicity"]==""?null:data["item_condition"]["periodicity"],
                                                                onChanged:index <= widget.OfferData.offerData!.offerItems!.length-1? null: (newValue) {
                                                                  setState(() {
                                                                    data["item_condition"]["periodicity"] = newValue!;
                                                                  });
                                                                },
                                                                hint: const Text(
                                                                    "Periodicity",
                                                                    style:greyHintStyle
                                                                ),
                                                                iconStyleData: const IconStyleData(
                                                                  icon: Icon(Icons.keyboard_arrow_down_sharp,),
                                                                  iconSize: 10,
                                                                  iconEnabledColor: Colors.white,
                                                                  iconDisabledColor:Colors.white,
                                                                ),
                                                                buttonStyleData: ButtonStyleData(
                                                                    height:  35,
                                                                    width: ResponsiveHelper.isMobile(context)?width*0.38:tabWidth*0.38,
                                                                    padding: const EdgeInsets.only(left: 22, right: 3),
                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white),
                                                                    elevation:  1,
                                                                    overlayColor: MaterialStateProperty.all(Colors.white)
                                                                ),
                                                                menuItemStyleData: MenuItemStyleData(
                                                                  height: 33,
                                                                  selectedMenuItemBuilder: (context, child) {
                                                                    return     Container(
                                                                      padding: const EdgeInsets.only(left: 0, right: 0),
                                                                      width: ResponsiveHelper.isMobile(context)?width*0.38:tabWidth*0.38,
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
                                                                  width: ResponsiveHelper.isMobile(context)?width*0.38:tabWidth*0.38,
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
                                                          index <= widget.OfferData.offerData!.offerItems!.length-1? SizedBox():   Positioned(
                                                              bottom:1,left:2,
                                                              child: InkWell(
                                                                onTap:(){
                                                                  setState((){
                                                                    data["item_condition"]["periodicityView"]  = false;
                                                                  });
                                                                },
                                                                child: CircleAvatar(
                                                                  radius:8,
                                                                  backgroundColor: Color(
                                                                      0x3389F6B9) ,
                                                                  child: Center(
                                                                      child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                  ),
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                      const SizedBox(height:5,),
                                                      const Padding(
                                                        padding: EdgeInsets.only(left:8.0),
                                                        child: Text("Periodicity", style: BlackDescStyle,),
                                                      ),
                                                    ],
                                                  ),
                                                ):SizedBox(),

                                                data["item_condition"]["periodView"] == true? Padding(
                                                  padding: EdgeInsets.only(right:10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            height: 35,
                                                            padding:EdgeInsets.only(left:12),
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius: 2.0,
                                                                  color: Colors.black54,
                                                                  offset: Offset(0.0, 0.5) ),
                                                            ], borderRadius: BorderRadius.circular(5)),
                                                            width: ResponsiveHelper.isMobile(context)?width*0.55:tabWidth*0.55,
                                                            child: TextFormField(
                                                              controller: data["item_condition"]["period"],
                                                              readOnly: true,
                                                              onTap:index <= widget.OfferData.offerData!.offerItems!.length-1? null:(){
                                                                if(data["item_condition"]["periodicity"]==null){
                                                                  Constants.showToast("Please select periodicity first");
                                                                }else{
                                                                  if(data["item_condition"]["periodicity"] == "Today" ||data["item_condition"]["periodicity"] == "Tomorrow"){
                                                                    DateTimeRangePicker(
                                                                        startText: "From",
                                                                        endText: "To",
                                                                        doneText: "Done",
                                                                        cancelText: "Cancel",
                                                                        interval: 1,
                                                                        mode: DateTimeRangePickerMode.time,
                                                                        minimumTime: DateTime.now(),
                                                                        maximumTime: DateTime.now().add(Duration(days: 25)),
                                                                        use24hFormat: false,
                                                                        onConfirm: (start, end) {

                                                                          if(end == "NotPick"){
                                                                            setState((){
                                                                              data["item_condition"]["duration"].clear();
                                                                              isItemSinglePeriodSelect =true;
                                                                              final  STime = DateFormat('hh:mm a').format(start);
                                                                              data["item_condition"]["period"].text = "From ${STime}";
                                                                              data["item_condition"]["fromperiod"]="";
                                                                              data["item_condition"]["toperiod"]="";
                                                                              data["item_condition"]["fromperiodtime"]="";
                                                                              data["item_condition"]["toperiodtime"]="";
                                                                              final  STime24 = DateFormat('HH:mm').format(start);
                                                                              data["item_condition"]["fromperiodtime"] = STime24.toString();

                                                                            });

                                                                          }else{
                                                                            setState((){
                                                                              isItemSinglePeriodSelect =false;
                                                                              int totalDays = DateTime.parse(end).difference(start).inDays;
                                                                              int years = totalDays ~/ 365;
                                                                              int months = (totalDays-years*365) ~/ 30;
                                                                              int days = totalDays-years*365-months*30;
                                                                              // int hours =24- DateTime.parse(end).difference(start).inHours % 24 == 24? 0: 24- DateTime.parse(end).difference(start).inHours % 24;
                                                                              // int min =60 - DateTime.parse(end).difference(start).inMinutes % 60 == 60?0: 60 - DateTime.parse(end).difference(start).inMinutes % 60;
                                                                              // int seconds = 60- DateTime.parse(end).difference(start).inSeconds % 60 == 60 ?0:60- DateTime.parse(end).difference(start).inSeconds % 60;
                                                                              data["item_condition"]["duration"].text  =
                                                                              years != 0 && months != 0 && days !=0?
                                                                              "$years Years $months Months  $days Days":
                                                                              months != 0 && days !=0 ? "$months Months  $days Days":
                                                                              years != 0 && months == 0 && days !=0? "$years Years  $days Days":
                                                                              years != 0 && months != 0 && days ==0? "$years Years  $months Months":
                                                                              years != 0 && months == 0 && days !=0? "$years Years  $days Days":"$days Days";
                                                                              // Duration diff = DateTime.parse(end).difference(start);
                                                                              // diff.inHours !=0?     data["item_condition"]["duration"].text = "${diff.inHours.toString()} Hours": diff.inSeconds !=00?   data["item_condition"]["duration"].text = "${diff.inMinutes.toString()} Minutes" :   data["item_condition"]["duration"].text = "${diff.inSeconds.toString()} Seconds";
                                                                              final  FTime = DateFormat('hh:mm a').format(start);
                                                                              final  ToTime = DateFormat('hh:mm a').format(DateTime.parse(end));
                                                                              data["item_condition"]["period"].text = "${FTime} - ${ToTime}";
                                                                              data["item_condition"]["fromperiod"]="";
                                                                              data["item_condition"]["toperiod"]="";
                                                                              data["item_condition"]["fromperiodtime"]="";
                                                                              data["item_condition"]["toperiodtime"]="";
                                                                              final  FTime24 = DateFormat('HH:mm').format(start);
                                                                              final  ToTime24 = DateFormat('HH:mm').format(DateTime.parse(end));
                                                                              data["item_condition"]["fromperiodtime"] = FTime24.toString();
                                                                              data["item_condition"]["toperiodtime"] = ToTime24.toString();
                                                                            });
                                                                          }
                                                                        }).showPicker(context);
                                                                  }else{
                                                                    DateTimeRangePicker(
                                                                        startText: "From",
                                                                        endText: "To",
                                                                        doneText: "Done",
                                                                        cancelText: "Cancel",
                                                                        interval: 1,
                                                                        mode: DateTimeRangePickerMode.dateAndTime,
                                                                        minimumTime: DateTime.now(),
                                                                        maximumTime: DateTime.now().add(Duration(days: 25)),
                                                                        use24hFormat: false,
                                                                        onConfirm: (start, end) {
                                                                          if(end == "NotPick"){
                                                                            setState((){
                                                                              data["item_condition"]["duration"].clear();
                                                                              isItemSinglePeriodSelect =true;
                                                                              final  STime = DateFormat('dd-MMM-yyyy hh:mm a').format(start);
                                                                              data["item_condition"]["period"].text = "From ${STime}";
                                                                              data["item_condition"]["fromperiod"]="";
                                                                              data["item_condition"]["toperiod"]="";
                                                                              data["item_condition"]["fromperiodtime"]="";
                                                                              data["item_condition"]["toperiodtime"]="";
                                                                              final  SDate = DateFormat('dd-MM-yyyy').format(start);
                                                                              final  STime24 = DateFormat('HH:mm').format(start);
                                                                              data["item_condition"]["fromperiodtime"] = STime24.toString();
                                                                              data["item_condition"]["fromperiod"] = SDate.toString();
                                                                            });

                                                                          }else{
                                                                            setState((){
                                                                              isItemSinglePeriodSelect = false;
                                                                              // print(end);print(start);
                                                                              int totalDays = DateTime.parse(end).difference(start).inDays;
                                                                              int years = totalDays ~/ 365;
                                                                              int months = (totalDays-years*365) ~/ 30;
                                                                              int days = totalDays-years*365-months*30;
                                                                              int doneHours = years*365*24;
                                                                              int hours = DateTime.parse(end).difference(start).inHours  -(doneHours) -(months*30*24) - (days*24);
                                                                              int min = (((DateTime.parse(end).difference(start).inMinutes - (years*365*24*60)) -(months*30*24*60)) - (days*24*60) )-hours*60;
                                                                              String empty = "";
                                                                              data["item_condition"]["duration"].text = "";
                                                                              data["item_condition"]["fromperiod"]="";
                                                                              data["item_condition"]["toperiod"]="";
                                                                              data["item_condition"]["fromperiodtime"]="";
                                                                              data["item_condition"]["toperiodtime"]="";
                                                                              data["item_condition"]["duration"].text ="${years != 0 ? '${years} Year(s)': empty} ${ months != 0 ? '${months} Month(s)': empty } ${days != 0 ?'${days} Day(s)': empty } ${ hours != 0 ?'${hours} Hour(s)': empty } ${ min != 0 ?'${min} Minute(s)': empty}";
                                                                              final  FTime = DateFormat('dd-MMM-yyyy').format(start);
                                                                              final  ToTime = DateFormat('dd-MMM-yyyy').format(DateTime.parse(end));
                                                                              data["item_condition"]["period"].text = "${FTime}-${ToTime}";
                                                                              final  SDate = DateFormat('dd-MM-yyyy').format(start);
                                                                              final  STime24 = DateFormat('HH:mm').format(start);
                                                                              data["item_condition"]["fromperiodtime"] = STime24.toString();
                                                                              data["item_condition"]["fromperiod"] = SDate.toString();
                                                                              final  EDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(end));
                                                                              final  ETime24 = DateFormat('HH:mm').format(DateTime.parse(end));
                                                                              data["item_condition"]["toperiodtime"] = ETime24.toString();
                                                                              data["item_condition"]["toperiod"] = EDate.toString();
                                                                            });

                                                                          }
                                                                        }).showPicker(context);
                                                                  }
                                                                }

                                                              },
                                                              keyboardType: TextInputType.text,
                                                              decoration: InputDecoration(hintText: "Period", fillColor:  Colors.white, hintStyle: greyHintStyle,
                                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                                border: const OutlineInputBorder(),
                                                              ),
                                                              style: Black87HintStyle,
                                                            ),
                                                          ),
                                                          index <= widget.OfferData.offerData!.offerItems!.length-1?SizedBox():     Positioned(
                                                              bottom:1,left:2,
                                                              child: InkWell(
                                                                onTap:(){
                                                                  setState((){
                                                                    data["item_condition"]["periodView"] = false;
                                                                  });
                                                                },
                                                                child: CircleAvatar(
                                                                  radius:8,
                                                                  backgroundColor: Color(
                                                                      0x3389F6B9) ,
                                                                  child: Center(
                                                                      child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                  ),
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                      const SizedBox(height:5,),
                                                      const Padding(
                                                        padding: EdgeInsets.only(left:8.0),
                                                        child: Text("Period", style: BlackDescStyle,),
                                                      ),
                                                    ],
                                                  ),
                                                ):SizedBox(),

                                                data["item_condition"]["durationView"]==true?   Padding(
                                                  padding: EdgeInsets.only(right:10),
                                                  child: Column (
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            height: 35,
                                                            padding:EdgeInsets.only(left:12),
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius: 2.0,
                                                                  color: Colors.black54,
                                                                  offset: Offset(0.0, 0.5) ),
                                                            ], borderRadius: BorderRadius.circular(5)),
                                                            width: ResponsiveHelper.isMobile(context)?width*0.45:tabWidth*0.45,
                                                            child: TextFormField(
                                                              inputFormatters: [maskFormatter],
                                                              controller:  data["item_condition"]["duration"],
                                                              keyboardType: TextInputType.number,
                                                              onTap:(){
                                                                if(index <= widget.OfferData.offerData!.offerItems!.length-1){

                                                                }else if(isItemSinglePeriodSelect){
                                                                  showDurationPicker(context,setState,data["item_condition"]["duration"]);
                                                                }
                                                              },
                                                              // readOnly: true,
                                                              // onFieldSubmitted: (value){
                                                              //   print(value);
                                                              //   String empty = "";
                                                              //   int years =  value!.length < 2 ?int.parse(value) :int.parse(value.split(":").first);
                                                              //   int months =  value.length > 3 ?int.parse(value.split(":")[1]):0;
                                                              //   int days =  value.length > 5 ?int.parse(value.split(":")[2]):0;
                                                              //   int hours =  value.length > 7 ?int.parse(value.split(":")[3]):0;
                                                              //   int min =  value.length > 9 ?int.parse(value.split(":")[4]):0;
                                                              //   setState(() {
                                                              //     data["item_condition"]["duration"].text ="${years != 0 ? '${years} Years': empty} ${ months != 0 ? '${months} Months': empty } ${days != 0 ?'${days} Days': empty } ${ hours != 0 ?'${hours} Hours': empty } ${ min != 0 ?'${min} Minutes': empty}";
                                                              //   });
                                                              //   print( data["item_condition"]["duration"].text);
                                                              // },
                                                              readOnly:index <= widget.OfferData.offerData!.offerItems!.length-1? true: true,
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
                                                          index <= widget.OfferData.offerData!.offerItems!.length-1?SizedBox():     Positioned(
                                                              bottom:1,left:2,
                                                              child: InkWell(
                                                                onTap:(){
                                                                  setState((){
                                                                    data["item_condition"]["durationView"] = false;
                                                                  });
                                                                },
                                                                child: CircleAvatar(
                                                                  radius:8,
                                                                  backgroundColor: Color(
                                                                      0x3389F6B9) ,
                                                                  child: Center(
                                                                      child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                  ),
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                      const SizedBox(height:5,),
                                                      const Padding(
                                                        padding: EdgeInsets.only(left:8.0),
                                                        child: Text("Duration(YY:MM:DD:HH:MI)", style: BlackDescStyle,),
                                                      ),
                                                    ],
                                                  ),
                                                ):SizedBox(),
                                                data["item_condition"]["isServicePersonView"]==true?
                                                data["fillSelectedPerson"].isEmpty && data["itemType"] == "Old" ?SizedBox():  Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          height:40,
                                                          decoration:BoxDecoration(
                                                            color:Colors.transparent,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius: 1.0,
                                                                  color: Colors.black12,
                                                                  offset: Offset(0.0, 0.5) ),
                                                            ],
                                                          ),
                                                          width:isMobile?width:tabWidth,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(0.0),
                                                            child: CustomSearchableDropDownForUs(
                                                              initialValue:   data["itemType"] == "Old" ? data["fillSelectedPerson"]:[],
                                                              items: ServicePersonList,
                                                              menuHeight: 30.0,
                                                              label: 'Select Service/Delivery person',
                                                              multiSelectTag: 'Names',
                                                              labelStyle: WhiteHintStyle,
                                                              multiSelectValuesAsWidget: true,
                                                              dropdownItemStyle: darkGrey14400,

                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(5),
                                                              ),
                                                              multiSelect: true,
                                                              dropDownMenuItems: ServicePersonList.map((item) {
                                                                return item.displayname.toString();
                                                              }).toList() ?? [],
                                                              onChanged: (value){

                                                                if(value!=null)
                                                                {
                                                                  setState(() {
                                                                    data["item_condition"]["servicepersons"] =   jsonDecode(value).map((e) =>e["id"] ).toList();

                                                                  });
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        data["itemType"]=="Old" ? Positioned(child: Container( width:isMobile?width:tabWidth,height:40,color: Colors.transparent,)):SizedBox()

                                                      ],
                                                    ),
                                                    const SizedBox(height:3,),
                                                    const Padding(
                                                      padding: EdgeInsets.only(left:4.0),
                                                      child: Text("Service/Delivery person", style: BlackDescStyle,),
                                                    ),
                                                  ],
                                                ) :SizedBox(),

                                                //     Column(
                                                //   mainAxisAlignment: MainAxisAlignment.start,
                                                //   crossAxisAlignment:CrossAxisAlignment.start,
                                                //   children: [
                                                //     Stack(
                                                //       children: [
                                                //         Container(
                                                //           height:40,
                                                //           decoration:BoxDecoration(
                                                //             color:Colors.transparent,
                                                //             boxShadow: [
                                                //               BoxShadow(
                                                //                   blurRadius: 1.0,
                                                //                   color: Colors.black26,
                                                //                   offset: Offset(0.0, 0.5) ),
                                                //             ],
                                                //           ),
                                                //
                                                //           width: ResponsiveHelper.isMobile(context)?width*0.10:tabWidth*0.10,
                                                //           child: Padding(
                                                //             padding: const EdgeInsets.all(0.0),
                                                //             child: CustomSearchableDropDownForUs(
                                                //               initialValue:  data["itemType"] == "Old" ? data["fillSelectedPerson"]:[],
                                                //               items: ServicePersonList,
                                                //               menuHeight: 30.0,
                                                //               label: 'Select Service/Delivery person',
                                                //               multiSelectTag: 'Names',
                                                //               multiSelectValuesAsWidget: true,
                                                //               decoration: BoxDecoration(
                                                //                 color: Colors.white,
                                                //                 borderRadius: BorderRadius.circular(5),
                                                //               ),
                                                //               multiSelect: true,
                                                //               dropDownMenuItems: ServicePersonList.map((item) {
                                                //                 return item.username;
                                                //               }).toList() ??
                                                //                   [],
                                                //               onChanged: (value){
                                                //                 if(value!=null)
                                                //                 {
                                                //                   setState(() {
                                                //                     data["item_condition"]["servicepersons"] =   jsonDecode(value).map((e) =>e["id"] ).toList();
                                                //
                                                //                   });
                                                //                 }
                                                //               },
                                                //             ),
                                                //           ),
                                                //         ),
                                                //         data["itemType"]=="Old" ? Container(
                                                //             width: ResponsiveHelper.isMobile(context)?width*0.10:tabWidth*0.10,
                                                //             height:40,color:Colors.transparent):SizedBox()
                                                //       ],
                                                //     ),
                                                //     const SizedBox(height:3,),
                                                //     const Padding(
                                                //       padding: EdgeInsets.only(left:4.0),
                                                //       child: Text("Service/Delivery person", style: BlackDescStyle,),
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            )):SizedBox(),
                                        data["item_condition"]["priorityView"]==false&&
                                            data["item_condition"]["expiryView"]==false&&
                                            data["item_condition"]["fromlocationView"]==false&&
                                            data["item_condition"]["tolocationView"]==false &&
                                            data["item_condition"]["atlocationView"]==false?SizedBox(): data["itemConditionView"]==true?SizedBox(
                                            height: 90,
                                            width: double.infinity,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              physics: const ClampingScrollPhysics(),
                                              shrinkWrap: false,
                                              padding: EdgeInsets.only(top:15,bottom: 15),
                                              children: [
                                                const SizedBox(width: 12,),
                                                data["item_condition"]["priorityView"]==true?  Padding(
                                                  padding: EdgeInsets.only(right:10), child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        DropdownButtonHideUnderline(
                                                          child: DropdownButton2(
                                                            isExpanded: true,
                                                            items:priority.map((item) => DropdownMenuItem (
                                                              value: item,
                                                              child: Text(
                                                                item,
                                                                style:  BlackSubHeadingStyle,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            )).toList(),
                                                            value:  data["item_condition"]["priority"]==""?null: data["item_condition"]["priority"],
                                                            onChanged:index <= widget.OfferData.offerData!.offerItems!.length-1? null: (newValue) {
                                                              setState(() {
                                                                data["item_condition"]["priority"] = newValue!;
                                                              });
                                                            },
                                                            hint: const Text(
                                                                "Priority",
                                                                style:greyHintStyle
                                                            ),
                                                            iconStyleData: const IconStyleData(
                                                              icon: Icon(Icons.keyboard_arrow_down_sharp,),
                                                              iconSize: 10,
                                                              iconEnabledColor: Colors.white,
                                                              iconDisabledColor:Colors.white,
                                                            ),
                                                            buttonStyleData: ButtonStyleData(
                                                                height:  35,
                                                                width:isMobile?width*0.35:tabWidth*0.35,
                                                                padding: const EdgeInsets.only(left: 20, right: 3),
                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white),
                                                                elevation:  1,
                                                                overlayColor: MaterialStateProperty.all(Colors.white)
                                                            ),
                                                            menuItemStyleData: MenuItemStyleData(
                                                              height: 33,
                                                              selectedMenuItemBuilder: (context, child) {
                                                                return     Container(
                                                                  padding: const EdgeInsets.only(left: 0, right: 0),
                                                                  width:isMobile?width*0.3:tabWidth*0.3,
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
                                                              width: isMobile?width*0.35:tabWidth*0.35,
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

                                                            style:BlackFieldStyle,

                                                          ),
                                                        ),
                                                        index <= widget.OfferData.offerData!.offerItems!.length-1?SizedBox():     Positioned(
                                                            bottom:1,left:2,
                                                            child: InkWell(
                                                              onTap:(){
                                                                setState((){
                                                                  data["item_condition"]["priorityView"] = false;
                                                                });
                                                              },
                                                              child: CircleAvatar(
                                                                radius:8,
                                                                backgroundColor: Color(0x3389F6B9) ,
                                                                child: Center(
                                                                    child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                ),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                    const SizedBox(height:5,),
                                                    const Padding(
                                                      padding: EdgeInsets.only(left:8.0),
                                                      child: Text("Priority", style: BlackDescStyle,),
                                                    ),
                                                  ],
                                                ),):SizedBox(),
                                                data["item_condition"]["expiryView"]==true? Padding(
                                                  padding: EdgeInsets.only(right:10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            height: 35,
                                                            padding: EdgeInsets.only(left:12),
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius: 2.0,
                                                                  color: Colors.black54,
                                                                  offset: Offset(0.0, 0.5) ),
                                                            ], borderRadius: BorderRadius.circular(5)),
                                                            width: ResponsiveHelper.isMobile(context)?width*0.35:tabWidth*0.35,
                                                            child: TextFormField(
                                                              onTap:index <= widget.OfferData.offerData!.offerItems!.length-1? null:(){
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
                                                                                  height: ResponsiveHelper.isMobile(context)?height*0.3:tabWidth*0.4,
                                                                                  width: ResponsiveHelper.isMobile(context)?null:tabWidth,
                                                                                  child:  Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    children: [
                                                                                      Flexible(
                                                                                        child: Padding(
                                                                                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                                                                            child: CupertinoTheme(
                                                                                              data: CupertinoThemeData(
                                                                                                textTheme: CupertinoTextThemeData(
                                                                                                    dateTimePickerTextStyle: BlackBottomHeadStyle18500
                                                                                                ),
                                                                                              ),
                                                                                              child: CupertinoDatePicker(
                                                                                                mode: CupertinoDatePickerMode.dateAndTime,
                                                                                                dateOrder: DatePickerDateOrder.dmy,
                                                                                                use24hFormat: false,
                                                                                                minuteInterval: 1,
                                                                                                minimumDate:DateTime.now(),
                                                                                                initialDateTime: DateTime.now(),
                                                                                                onDateTimeChanged: (DateTime newDateTime) {
                                                                                                  setState((){
                                                                                                    ItemExDTime = newDateTime;
                                                                                                  });
                                                                                                },
                                                                                                maximumDate: DateTime.now().add(const Duration(days: 25)),
                                                                                              ),
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
                                                                                              final  STime = DateFormat('dd-MM-yyyy HH:mm').format(ItemExDTime!);
                                                                                              data["item_condition"]["expiry"].text =STime ;
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
                                                              controller:  data["item_condition"]["expiry"],
                                                              keyboardType: TextInputType.text,
                                                              decoration: InputDecoration(hintText: "Expiry", fillColor:  Colors.white, hintStyle: greyHintStyle,
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
                                                          index <= widget.OfferData.offerData!.offerItems!.length-1?SizedBox():    Positioned(
                                                              bottom:1,left:2,
                                                              child: InkWell(
                                                                onTap:(){
                                                                  setState((){
                                                                    data["item_condition"]["expiryView"] = false;
                                                                  });
                                                                },
                                                                child: CircleAvatar(
                                                                  radius:8,
                                                                  backgroundColor: Color(0x3389F6B9) ,
                                                                  child: Center(
                                                                      child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                  ),
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                      const SizedBox(height:5,),
                                                      const Padding(
                                                        padding: EdgeInsets.only(left:8.0),
                                                        child: Text("Expiry", style: BlackDescStyle,),
                                                      ),
                                                    ],
                                                  ),
                                                ):SizedBox(),
                                                data["item_condition"]["fromlocationView"]==true? Padding(
                                                  padding: EdgeInsets.only(right:10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            height: 35,
                                                            padding: EdgeInsets.only(left:12),
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius: 2.0,
                                                                  color: Colors.black54,
                                                                  offset: Offset(0.0, 0.5) ),
                                                            ], borderRadius: BorderRadius.circular(5)),
                                                            width: ResponsiveHelper.isMobile(context)?width*0.45:tabWidth*0.45,
                                                            child: TextFormField(
                                                              controller:  data["item_condition"]["fromlocation"],
                                                              onTap:index <= widget.OfferData.offerData!.offerItems!.length-1? null:() async {
                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201) ,isAppPlaceView: true,isTitleSelectAsAddress: true))).then((value) {
                                                                  setState(() {
                                                                    data["item_condition"]["fromlocation"].text=value.toString();
                                                                  });
                                                                });

                                                                //  Navigator.push(context, MaterialPageRoute(builder: (context) => placepick(title: "Place picker"),));
                                                              },
                                                              readOnly:true,
                                                              keyboardType: TextInputType.text,
                                                              decoration: InputDecoration(hintText:"From location", fillColor:  Colors.white, hintStyle: greyHintStyle,
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
                                                          index <= widget.OfferData.offerData!.offerItems!.length-1?SizedBox():      Positioned(
                                                              bottom:1,left:2,
                                                              child: InkWell(
                                                                onTap:(){
                                                                  setState((){
                                                                    data["item_condition"]["fromlocationView"] = false;
                                                                  });
                                                                },
                                                                child: CircleAvatar(
                                                                  radius:8,
                                                                  backgroundColor: Color(
                                                                      0x3389F6B9) ,
                                                                  child: Center(
                                                                      child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                  ),
                                                                ),
                                                              )),
                                                          index <= widget.OfferData.offerData!.offerItems!.length-1?SizedBox():    data["item_condition"]["tolocationView"]==true?SizedBox():    Positioned(
                                                              top:1,right:2,
                                                              child: InkWell(
                                                                onTap:(){
                                                                  setState((){
                                                                    data["item_condition"]["tolocationView"]==true?SizedBox(): data["item_condition"]["tolocationView"] =true ;
                                                                  });
                                                                },
                                                                child: CircleAvatar(
                                                                  radius:8,
                                                                  backgroundColor: Constants.primaryColor1 ,
                                                                  child: Center(
                                                                      child:Icon(Icons.add,color: Colors.white,size:14,)
                                                                  ),
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                      const SizedBox(height:5,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left:4.0),
                                                        child: Text("From location", style: BlackDescStyle,),
                                                      ),
                                                    ],
                                                  ),
                                                ):SizedBox(),
                                                data["item_condition"]["tolocationView"]==true?  Padding(
                                                  padding: EdgeInsets.only(right:10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            height: 35,
                                                            padding: EdgeInsets.only(left:12),
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius: 2.0,
                                                                  color: Colors.black54,
                                                                  offset: Offset(0.0, 0.5) ),
                                                            ], borderRadius: BorderRadius.circular(5)),
                                                            width: ResponsiveHelper.isMobile(context)?width*0.45:tabWidth*0.45,
                                                            child: TextFormField(
                                                              controller:  data["item_condition"]["tolocation"],
                                                              onTap:index <= widget.OfferData.offerData!.offerItems!.length-1? null:() async {

                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201) ,isAppPlaceView: true,isTitleSelectAsAddress: true))).then((value) {
                                                                  setState(() {
                                                                    data["item_condition"]["tolocation"].text=value.toString();
                                                                  });
                                                                });

                                                                //  Navigator.push(context, MaterialPageRoute(builder: (context) => placepick(title: "Place picker"),));
                                                              },
                                                              readOnly:true,
                                                              keyboardType: TextInputType.text,
                                                              decoration: InputDecoration(hintText:"To location", fillColor:  Colors.white, hintStyle: greyHintStyle,
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
                                                          index <= widget.OfferData.offerData!.offerItems!.length-1?SizedBox():   Positioned(
                                                              bottom:1,left:2,
                                                              child: InkWell(
                                                                onTap:(){
                                                                  setState((){
                                                                    data["item_condition"]["atlocationView"] = false;
                                                                  });
                                                                },
                                                                child: CircleAvatar(
                                                                  radius:8,
                                                                  backgroundColor: Color(
                                                                      0x3389F6B9) ,
                                                                  child: Center(
                                                                      child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                  ),
                                                                ),
                                                              )),
                                                          index <= widget.OfferData.offerData!.offerItems!.length-1?SizedBox():   data["item_condition"]["atlocationView"] ==true?SizedBox():  Positioned(
                                                              top:1,right:2,
                                                              child: InkWell(
                                                                onTap:(){
                                                                  setState((){
                                                                    data["item_condition"]["atlocationView"]  =true ;
                                                                  });
                                                                },
                                                                child: CircleAvatar(
                                                                  radius:8,
                                                                  backgroundColor: Constants.primaryColor1 ,
                                                                  child: Center(
                                                                      child:Icon(Icons.add,color: Colors.white,size:14,)
                                                                  ),
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                      const SizedBox(height:5,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left:4.0),
                                                        child: Text("To location", style: BlackDescStyle,),
                                                      ),
                                                    ],
                                                  ),
                                                ):SizedBox(),
                                                data["item_condition"]["atlocationView"]==true?  Padding(
                                                  padding: EdgeInsets.only(right:10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            height: 35,
                                                            padding: EdgeInsets.only(left:12),
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius: 2.0,
                                                                  color: Colors.black54,
                                                                  offset: Offset(0.0, 0.5) ),
                                                            ], borderRadius: BorderRadius.circular(5)),
                                                            width: ResponsiveHelper.isMobile(context)?width*0.45:tabWidth*0.45,
                                                            child: TextFormField(
                                                              controller:  data["item_condition"]["atlocation"],
                                                              onTap:index <= widget.OfferData.offerData!.offerItems!.length-1? null:() async {

                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201) ,isAppPlaceView: true,isTitleSelectAsAddress: true))).then((value) {
                                                                  setState(() {
                                                                    data["item_condition"]["atlocation"].text=value.toString();
                                                                  });
                                                                });

                                                                //  Navigator.push(context, MaterialPageRoute(builder: (context) => placepick(title: "Place picker"),));
                                                              },
                                                              readOnly:true,
                                                              keyboardType: TextInputType.text,
                                                              decoration: InputDecoration(hintText:"At location", fillColor:  Colors.white, hintStyle: greyHintStyle,
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
                                                          index <= widget.OfferData.offerData!.offerItems!.length-1?SizedBox():   Positioned(
                                                              bottom:1,left:2,
                                                              child: InkWell(
                                                                onTap:(){
                                                                  setState((){
                                                                    data["item_condition"]["atlocationView"]  = false;
                                                                  });
                                                                },
                                                                child: CircleAvatar(
                                                                  radius:8,
                                                                  backgroundColor: Color(
                                                                      0x3389F6B9) ,
                                                                  child: Center(
                                                                      child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                  ),
                                                                ),
                                                              )),
                                                          index <= widget.OfferData.offerData!.offerItems!.length-1?SizedBox():    Positioned(
                                                              top:1,right:2,
                                                              child: InkWell(
                                                                onTap:(){
                                                                  setState((){
                                                                    Constants.showToast("From Location,To Location and At Location are allowed");
                                                                  });
                                                                },
                                                                child: CircleAvatar(
                                                                  radius:8,
                                                                  backgroundColor: Constants.primaryColor1 ,
                                                                  child: Center(
                                                                      child:Icon(Icons.add,color: Colors.white,size:14,)
                                                                  ),
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                      const SizedBox(height:5,),
                                                      Padding(
                                                        padding: EdgeInsets.only(left:4.0),
                                                        child: Text("At location", style: BlackDescStyle,),
                                                      ),
                                                    ],
                                                  ),
                                                ):SizedBox(),

                                                const SizedBox(width: 8,),
                                              ],
                                            )):SizedBox(),
                                        const Divider(height: 2,thickness: 2),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Container(
                                width: ResponsiveHelper.isMobile(context)?width:tabWidth,
                                padding: const EdgeInsets.only(bottom: 10),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE7E6E6),
                                  // borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Offer Instruction & bids",
                                            style: BlackFieldStyleBold,
                                          )),
                                    ),
                                    ListView.builder(
                                      itemCount:widget.OfferData.offerData!.offerBids!.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var data = widget.OfferData.offerData!.offerBids![index];
                                        return Row(
                                          mainAxisAlignment:data.fromCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()? MainAxisAlignment.start:MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: ResponsiveHelper.isMobile(context)?width*0.80:tabWidth*0.80,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right:10.0,bottom: 5),
                                                    child: Text("${data.fromCounter!.displayname.toString()}",style: BlackTitleItalicStyle,),
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.only(left:8,right:5,top:5,bottom: 5),
                                                      margin: EdgeInsets.only(left:13,right:10),
                                                      decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 0.0,
                                                            color: Colors.black54,
                                                            offset: Offset(0.0, 0.5) ),
                                                      ], borderRadius: BorderRadius.circular(5)),
                                                      child:Center(
                                                          child:Text("${data.comment}",style: BlackDescStyle,)
                                                      ) ),

                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },),
                                    OfferInstruction1Visible==true?  Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 15.0,top:8,bottom: 5,left: 15),
                                          child: Container(
                                            height: 37,
                                            padding: EdgeInsets.only(left:12),
                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 2.0,
                                                  color: Colors.black54,
                                                  offset: Offset(0.0, 0.5) ),
                                            ], borderRadius: BorderRadius.circular(5)),
                                            child: TextFormField(
                                              controller: OfferInstruction1Controller,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(hintText:"Offer Instruction Remarks Bits Counter & details", fillColor:  Colors.white, hintStyle: greyHintStyle,
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
                                        ),
                                        Positioned(
                                            bottom:4,left:17,
                                            child: InkWell(
                                              onTap:(){
                                                setState((){
                                                  OfferInstruction1Visible = false;
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
                                        OfferInstruction2Visible==true?SizedBox(): Positioned(
                                            top:5,right:12,
                                            child: InkWell(
                                              onTap:(){
                                                setState((){
                                                  OfferInstruction2Visible = true;
                                                });
                                              },
                                              child: CircleAvatar(
                                                radius:9,
                                                backgroundColor: Constants.primaryColor1 ,
                                                child: Center(
                                                    child:Icon(Icons.add,color: Colors.white,size:14,)
                                                ),
                                              ),
                                            )),
                                      ],
                                    ):SizedBox(),
                                    SizedBox(height: 10,),
                                    OfferInstruction2Visible==true?   Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 15.0,top:8,bottom: 5,left: 15),
                                          child: Container(
                                            height: 37,
                                            padding: EdgeInsets.only(left:12),
                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 2.0,
                                                  color: Colors.black54,
                                                  offset: Offset(0.0, 0.5) ),
                                            ], borderRadius: BorderRadius.circular(5)),
                                            child: TextFormField(
                                              controller: OfferInstruction2Controller,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(hintText:"Enter Offer Instruction Remarks", fillColor:  Colors.white, hintStyle: greyHintStyle,
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
                                        ),
                                        Positioned(
                                            bottom:4,left:17,
                                            child: InkWell(
                                              onTap:(){
                                                setState((){
                                                  OfferInstruction2Visible = false;
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

                                      ],
                                    ):SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                segmentLoader==true?
                Container(
                  color: Colors.black12,
                  height: MediaQuery.of(context).size.height,
                  width:isMobile?width:tabWidth,
                  child: const Center(
                    child: ButtonLoaderGreen(),
                  ),
                ):const SizedBox()
              ],),
            bottomNavigationBar: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black38, spreadRadius: 0.5, blurRadius: .5),],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width :ResponsiveHelper.isMobile(context)?width*0.2:tabWidth*0.2,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            backgroundColor: requiredItemPriceIsEmpty.contains(true) || isRequiredItemSelect.contains(false) ||  OfferInstruction1Controller.text.isEmpty && OfferInstruction2Controller.text.isEmpty?
                            nullBtnColor
                            :Constants.primaryColor1,
                            elevation: 1),
                        onPressed: 
                        DataManager.getInstance().getuserId().toString() == "1"?
                            (){GuestLoginDialog(context);} :


                        (KycDataList.isEmpty || KycDataList.length == 1) && DataManager.getInstance().getUserIsPlaceType().toString() == "false" ?
                        (){
                          isLoadKycData == false?Constants.showToast("Please wait loading your kyc data..") :
                          MessageShowDialogWithText(context,
                              Text("You are not added any document in your profile.Please add at least two document then publish the counter offer.",textAlign: TextAlign.center,style: BlackTitle500height,)
                              ,(){
                                Navigator.pop(context);
                              });
                        }
                            :
                            
                            
                        selectedTap.toString().toUpperCase().trim() == "DUPLICATE" ?
                            (){
                          List<PrefillOfferBids>  FillBids = [];
                          List<PrefillOfferItems>  FillItmsList = [];
                          for(var j  = 0 ; j<ItemsList.length ;j++){
                            final ImageData = [];
                            for(var k = 0 ; k< ItemsList[j]["media"]!.length ; k++){
                              ImageData.add({
                                "id": "${ItemsList[j]["media"]![k]["file"]}",
                                "file":"${ItemsList[j]["fileUrl"][k]}",
                                "name": "${ItemsList[j]["media"]![k]["name"]}",
                              });
                            }
                            FillItmsList.add(
                                PrefillOfferItems(

                                    name: "${ItemsList[j]["name"].text.toString()}" ,
                                    addon: ItemsList[j]["addon"],
                                    desc: "${ItemsList[j]["desc"].text.toString()}",
                                    itemMedia: ItemsList[j]["media"].isEmpty ? []: ImageData,
                                    offerItemConditions: PrefillOfferItemConditions(
                                      fromperiod: ItemsList[j]["item_condition"]["fromperiod"].toString() == ""?null:ItemsList[j]["item_condition"]["fromperiod"].toString(),
                                      toperiod: ItemsList[j]["item_condition"]["toperiod"].toString() == ""?null:ItemsList[j]["item_condition"]["toperiod"].toString(),
                                      fromperiodtime: ItemsList[j]["item_condition"]["fromperiodtime"].toString()==""?null:ItemsList[j]["item_condition"]["fromperiodtime"].toString(),
                                      toperiodtime: ItemsList[j]["item_condition"]["toperiodtime"].toString() == ""?null:ItemsList[j]["item_condition"]["toperiodtime"].toString(),

                                      priority: "${ItemsList[j]["item_condition"]["priority"].toString().trim()}",
                                      periodicity:"${ItemsList[j]["item_condition"]["periodicity"].toString().trim()}",
                                      duration: ItemsList[j]["item_condition"]["duration"].text.toString(),
                                      fromlocation: "${ItemsList[j]["item_condition"]["fromlocation"].text.toString()}",
                                      tolocation: "${ItemsList[j]["item_condition"]["tolocation"].text.toString()}",
                                      atlocation: "${ItemsList[j]["item_condition"]["atlocation"].text.toString()}",
                                      expiry: "${ItemsList[j]["item_condition"]["expiry"].text.toString()}",
                                      servicepersons: ItemsList[j]["item_condition"]["servicepersons"],
                                      timePeriod:  "${ItemsList[j]["item_condition"]["period"].text.toString()}",
                                    ),
                                    price:ItemsList[j]["price"].text.toString() == "" || ItemsList[j]["price"].text.toString() == "null" ? null: num.parse(ItemsList[j]["price"].text.toString()),
                                    unit: ItemsList[j]["SelectedUnitId"].toString()=="" || ItemsList[j]["unit"].text.isEmpty  || ItemsList[j]["SelectedUnitId"].toString() == "null" ?PrefillUnit(): PrefillUnit(id: num.parse(ItemsList[j]["SelectedUnitId"].toString()) ,name: ItemsList[j]["unit"].text.toString()),
                                    quantity: num.parse(ItemsList[j]["quantity"].toString()),
                                    required: ItemsList[j]["required"],
                                    toggleState: ItemsList[j]["toggle_state"],
                                    advancePrice:  ItemsList[j]["AdvancePrice"].text==""?null:"${ItemsList[j]["AdvancePrice"].text}",
                                    maintenancePrice: ItemsList[j]["MaintenancePrice"].text==""?null:"${ItemsList[j]["MaintenancePrice"].text}",
                                    advanceUnit: ItemsList[j]["SelectedUnitIdAdva"].toString()=="" ||  ItemsList[j]["AdvanceUnit"].text.isEmpty  || ItemsList[j]["SelectedUnitIdAdva"].toString()  == "null"?FillAdvanceUnit():  FillAdvanceUnit(id: ItemsList[j]["SelectedUnitIdAdva"].toString()==""?null:"${ ItemsList[j]["SelectedUnitIdAdva"]}",name:ItemsList[j]["AdvanceUnit"].text.toString()),
                                    maintenanceUnit:ItemsList[j]["SelectedUnitIdMain"].toString()=="" ||  ItemsList[j]["MaintenanceUnit"].text.isEmpty  || ItemsList[j]["SelectedUnitIdMain"].toString()  == "null"?FillMaintenanceUnit():  FillMaintenanceUnit(id:  ItemsList[j]["SelectedUnitIdMain"].toString()==""?null:"${ItemsList[j]["SelectedUnitIdMain"]}",name:ItemsList[j]["MaintenanceUnit"].text.toString()) ));
                          }
                          var preFillDetails = PrefillOfferDataModel(
                              offerId:  widget.OfferData.offerData!.id.toString(),
                            addres: widget.OfferData.offerData!.addres.toString(),
                            buyORsell:  widget.OfferData.offerData!.buyORsell.toString(),
                            category: FillCategory(
                              id:   widget.OfferData.offerData!.category!.id,
                              name:    widget.OfferData.offerData!.category!.name,
                            ),
                            segment: FillSegment(
                              name:widget.OfferData.offerData!.segment!.name,
                              id: widget.OfferData.offerData!.segment!.id,
                              category: widget.OfferData.offerData!.segment!.category,
                            ),
                            subsegment: FillSubsegment(
                              id:    widget.OfferData.offerData!.subsegment!.id,
                              name: widget.OfferData.offerData!.subsegment!.name,
                              segment:  widget.OfferData.offerData!.subsegment!.segment,
                            ),
                            offerConditions: PrefillOfferConditions(
                                id:  widget.OfferData.offerData!.offerConditions!.id.toString(),
                                fromPeriod:  offerPeriodFromDate==""?null:"${offerPeriodFromDate}",
                                toPeriodTime: offerPeriodToTime==""?null:"${offerPeriodToTime}",
                                fromPeriodTime: offerPeriodFromTime==""?null:offerPeriodFromTime,
                                toPeriod: offerPeriodToDate==""?null:offerPeriodToDate,
                                priority: selectedValuePriority.toString().trim(),
                                periodicity: selectedPeriodicityValue.toString().trim(),
                                duration: OfferDurationController.text,
                                fromlocation: OfferFromLocationController.text,
                                tolocation: OfferToLocationController.text,
                                atlocation: OfferAtLocationController.text,
                                expiry: OfferExpiryController.text,
                                servicepersons:  widget.OfferData.offerData!.offerConditions!.servicepersons,
                                timePeriod: OfferPeriodController.text
                            ),
                            tabactivity: "New",
                            offerareas:  serviceAreaList,
                            offerBids: FillBids,
                            offerItems: FillItmsList,
                              privacy:  widget.OfferData.offerData!.privacy.toString()
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewOfferCreateScreen(Address: "",AddressTitle: "",From: "Fill",PrefillOfferData:preFillDetails ,Type: "Duplicate",OfferId:  widget.OfferData.offerData!.id.toString(),SubId:  widget.OfferData.offerData!.subscribers!.id.toString()),));
                        } :
                        requiredItemPriceIsEmpty.contains(true) || isRequiredItemSelect.contains(false) ||  OfferInstruction1Controller.text.isEmpty && OfferInstruction2Controller.text.isEmpty?(){
                          if(isRequiredItemSelect.contains(false)){
                            Constants.showToastAtBottom("${Url.isRequiredItemSelectMessage}");
                          }else if(requiredItemPriceIsEmpty.contains(true)){
                            Constants.showToastAtBottom("${Url.isRequiredItemPriceSelectMessage}");
                          }else if(OfferInstruction1Controller.text.isEmpty && OfferInstruction2Controller.text.isEmpty){
                            Constants.showToastAtBottom("${Url.BidsMessage}");
                          }
                        }:
                            (){
                          setState(() {
                            PublishLoader = true;
                          });
                          String ErrorMessage = "NoError";
                          for(var i=0; i<ItemsList.length ;i++){
                            if(ItemsList[i]["name"].text.toString()==""||ItemsList[i]["name"].text.toString()=="null"||ItemsList[i]["name"].text.isEmpty){
                              ErrorMessage = "Please enter item name";
                              break ;
                            }

                          }

                          Future.delayed(Duration(milliseconds: 500),() {
                            if(ErrorMessage != "NoError"){
                              setState(() {
                                PublishLoader = false;
                              });
                              Constants.MessageShowDialog(context, RichText(
                                textAlign: TextAlign.center,
                                text:  TextSpan(
                                    children: [
                                      TextSpan(text: '$ErrorMessage', style: BlackTitle700height),
                                      TextSpan(text: " \nfor publish", style: BlackTitle500height),
                                    ]
                                ),
                              ),(){
                                Navigator.pop(context);
                              });
                            }

                            else{
                              setState((){
                                PublishLoader =true;
                              });
                              bool offerPublishOn=true;

                              final List<dynamic> ItemsFinalList = [];
                              List bids = [];

                              OfferInstruction1Controller.text != ""?bids.add({"comment": "${OfferInstruction1Controller.text}"}):null;
                              OfferInstruction2Controller.text != ""?bids.add({"comment": "${OfferInstruction2Controller.text}"}):null;
                              String TextModeration = "${OfferInstruction1Controller.text} ${OfferInstruction2Controller.text}";
                              int confirm_steps = 0;
                              String confirm_by = "";
                              if( selectedTap.toUpperCase().toString().toUpperCase() == "QUERY" ||  selectedTap.toUpperCase().toString().toUpperCase() == "ANSWER" ){
                                confirm_steps = 0;
                                confirm_by = "";
                              }else if( selectedTap.toUpperCase().toString().toUpperCase() == "CONFIRM"){
                                confirm_by = _currentTapindex == 0 ?"B":"S";
                                confirm_steps =1;
                              }
                              for(var i=0; i<ItemsList.length ;i++){

                                if( ItemsList[i]["itemType"] == "Old"){
                                  // if(ItemsList[i]["required"].toString() == "true" && ItemsList[i]["toggle_state"].toString() == "false" ){
                                  //   offerPublishOn = false;
                                  //   setState((){
                                  //     PublishLoader = false;
                                  //   });
                                  // }
                                  // if(ItemsList[i]["toggle_state"].toString() == "false"){
                                  //   AtListOneItemSelect.add(false);
                                  // }else{
                                  //   AtListOneItemSelect.add(true);
                                  // }
                                }else{
                                  TextModeration = "${TextModeration} ${ItemsList[i]["name"].text.toString()} ${ItemsList[i]["desc"].text.toString()}";
                                }

                                if(ItemsList[i]["toggle_state"].toString() == "true"){
                                  ItemsFinalList.add(
                                      {
                                        "name":ItemsList[i]["name"].text.toString()=="null"?"":"${ItemsList[i]["name"].text.toString()}",
                                        "desc":ItemsList[i]["desc"].text.toString()=="null"?"":"${ItemsList[i]["desc"].text.toString()}",
                                        "price":ItemsList[i]["price"].text==""?null:"${ItemsList[i]["price"].text}",
                                        "unit":ItemsList[i]["SelectedUnitId"].toString()==""?null:"${ItemsList[i]["SelectedUnitId"].toString()}",
                                        "advance_price" : ItemsList[i]["AdvancePrice"].text==""?null:"${ItemsList[i]["AdvancePrice"].text}",
                                        "maintenance_price" : ItemsList[i]["MaintenancePrice"].text==""?null:"${ItemsList[i]["MaintenancePrice"].text}",
                                        "advance_unit" : ItemsList[i]["SelectedUnitIdAdva"].toString()==""?null:"${ ItemsList[i]["SelectedUnitIdAdva"]}",
                                        "maintenance_unit" : ItemsList[i]["SelectedUnitIdMain"].toString()==""?null:"${ItemsList[i]["SelectedUnitIdMain"]}",
                                        "quantity":"${ItemsList[i]["quantity"].toString()}",
                                        "currency":"INR",
                                        "addon":"${ItemsList[i]["addon"].toString()}",
                                        "required":"${ItemsList[i]["required"].toString()}",
                                        "toggle_state":ItemsList[i]["toggle_state"].toString(),
                                        "media":ItemsList[i]["media"],
                                        "user":ItemsList[i]["CreatorUserId"],
                                        "create_date":ItemsList[i]["create_date"] == "new"?DateFormat("dd-MM-yyyy HH:mm").format(DateTime.now()).toString():ItemsList[i]["create_date"],
                                        "item_condition":{
                                          "periodicity":"${ItemsList[i]["item_condition"]["periodicity"].toString()}",
                                          "fromperiod":ItemsList[i]["item_condition"]["fromperiod"] == ""?null: "${ItemsList[i]["item_condition"]["fromperiod"].toString()}",
                                          "toperiod":ItemsList[i]["item_condition"]["toperiod"] ==""?null: "${ItemsList[i]["item_condition"]["toperiod"].toString()}",
                                          "duration": ItemsList[i]["item_condition"]["duration"].text.toString() == "null"?"":isItemSinglePeriodSelect==false?ItemsList[i]["item_condition"]["duration"].text.toString():ItemsList[i]["item_condition"]["duration"].text.toString()==3?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00:00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==6?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==9?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==12?ItemsList[i]["item_condition"]["duration"].text.toString()+"00":ItemsList[i]["item_condition"]["duration"].text.toString(),
                                          "fromperiodtime": ItemsList[i]["item_condition"]["fromperiodtime"] ==""?null: "${ItemsList[i]["item_condition"]["fromperiodtime"].toString()}",
                                          "toperiodtime":ItemsList[i]["item_condition"]["toperiodtime"] == ""?null: "${ItemsList[i]["item_condition"]["toperiodtime"].toString()}",
                                          "durationoftime":null,
                                          "fromlocation":"${ItemsList[i]["item_condition"]["fromlocation"].text.toString()}",
                                          "tolocation":"${ItemsList[i]["item_condition"]["tolocation"].text.toString()}",
                                          "atlocation":"${ItemsList[i]["item_condition"]["atlocation"].text.toString()}",
                                          "servicepersons": ItemsList[i]["item_condition"]["servicepersons"].where((e)=> e.toString() == "-1" || e.toString() == "0").length >= 1 ? [] : ItemsList[i]["item_condition"]["servicepersons"],
                                          "priority":"${ItemsList[i]["item_condition"]["priority"].toString().toUpperCase()}",
                                          "expiry":ItemsList[i]["item_condition"]["expiry"].text == ""? null: "${ItemsList[i]["item_condition"]["expiry"].text.toString()}"
                                        }
                                      }
                                  );
                                }
                              }
                              Map<String, dynamic> CreateOfferParam = {
                                "offer":widget.OfferData.offerData!.id,
                                "parent":"",
                                "to_counter":widget.OfferData.offerData!.subscribers!.id.toString(),
                                "from_counter":"${DataManager.getInstance().userId.toString()}",
                                "counteringstatus":"OPEN",
                                "tabactivity":selectedTap.toUpperCase().toString().toUpperCase(),
                                "periodicity":selectedPeriodicityValue,
                                "priority":selectedValuePriority!.toUpperCase().toString(),
                                "fromperiod":offerPeriodFromDate==""?null: "${offerPeriodFromDate}",
                                "toperiod":offerPeriodToDate==""?null: "${offerPeriodToDate}",
                                "duration":isSinglePeriodSelect==false?OfferDurationController.text.toString():OfferDurationController.text.length==3?OfferDurationController.text+"00:00:00:00":OfferDurationController.text.length==6?OfferDurationController.text+"00:00:00":OfferDurationController.text.length==9?OfferDurationController.text+"00:00":OfferDurationController.text.length==12?OfferDurationController.text+"00":OfferDurationController.text,
                                "fromperiodtime":offerPeriodFromTime== ""?null: offerPeriodFromTime,
                                "toperiodtime":offerPeriodToTime == "" ?null: offerPeriodToTime,
                                "durationoftime":"",
                                "fromlocation":OfferFromLocationController.text,
                                "tolocation":OfferToLocationController.text,
                                "atlocation":OfferAtLocationController.text,
                                "servicepersons":selectedItems,
                                "expiry":offerExpiryDateTime== ""?null:offerExpiryDateTime.toString(),
                                "bids": bids,
                                "confirm_steps": confirm_steps,
                                "confirm_by" : confirm_by,
                                "items":ItemsFinalList
                              };
                              Future.delayed(Duration(seconds: 2),() {

                                var TextModerationBody = {
                                  "text": TextModeration,
                                  "lang":"en",
                                  "mode":"ml",
                                  "api_user":"1460174402",
                                  "api_secret":"T4dJ3z9fvFNTwHJCRaKDTvFhhd"
                                };
                                DrawAuraAPi.TextModeration(body:TextModerationBody ).then((value) {
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
                                });

                                DrawAuraAPi().createOfferCounter(CreateOfferParam).then((response){
                                  if (response.statusCode == 200) {
                                    if(selectedTap.toString().toUpperCase().trim() == "CONFIRM"){
                                      Constants.showToast("Please wait counter offer updating..");
                                      Future.delayed(Duration(milliseconds: 0),() {
                                        var body = {
                                          "offer_id": widget.OfferData.offerData!.id.toString(),
                                          "user_id" :DataManager.getInstance().getuserId().toString()
                                        };
                                        DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "addConfirmUser").then((value) {});
                                        var Userbody = {
                                          "offer_id": widget.OfferData.offerData!.id.toString(),
                                          "user_id" :  widget.OfferData.offerData!.subscribers!.id.toString()
                                        };
                                        DrawAuraAPi.CreateDataApi(body: Userbody,ApiEndPoint: "addConfirmUser").then((value) {});


                                        if(_currentTapindex == 1 && selectedTap.toUpperCase().toString().toUpperCase() == "CONFIRM"){
                                          setState((){
                                            PublishLoader =false;
                                          });
                                          Constants.showToastAtBottom("Offer Updated");
                                           Navigator.pop(context,false);

                                         //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => lastCounterScreen(OferId: widget.OfferData.offerData!.id.toString(),to_Couter_Id: widget.OfferData.offerData!.subscribers!.id.toString()),));
                                        }else{

                                          var data = json.decode(response.body);
                                          Constants.showToastAtBottom("Offer Updated");
                                          Navigator.pop(context,false);
                                        }

                                      });
                                    }else{
                                      var data = json.decode(response.body);
                                      Constants.showToastAtBottom("Offer Updated");
                                      Navigator.pop(context,false);
                                    }


                                  }else if(response.statusCode == 500){
                                    // Fluttertoast.showToast(
                                    //     msg: "${response.body}",
                                    //     toastLength: Toast.LENGTH_SHORT,
                                    //     gravity: ToastGravity.BOTTOM,
                                    //     timeInSecForIosWeb: 2,
                                    //     backgroundColor: primaryColor,
                                    //     textColor: Colors.white,
                                    //     fontSize: 18.0
                                    // );
                                    Navigator.pop(context);
                                  }
                                  else{
                                    // Fluttertoast.showToast(
                                    //     msg: "${response.body}",
                                    //     toastLength: Toast.LENGTH_SHORT,
                                    //     gravity: ToastGravity.BOTTOM,
                                    //     timeInSecForIosWeb: 2,
                                    //     backgroundColor: primaryColor,
                                    //     textColor: Colors.white,
                                    //     fontSize: 18.0
                                    // );
                                    Navigator.pop(context);
                                  }
                                }).then((value) {
                                  setState((){
                                    PublishLoader =false;
                                  });
                                });
                              },);
                              // if(offerPublishOn && AtListOneItemSelect.contains(true)){
                              //
                              // }else{
                              //   setState((){
                              //     PublishLoader =false;
                              //   });
                              //   showDialog(context: context,
                              //     builder: (context) {
                              //       return  StatefulBuilder(builder: (context, setState) {
                              //         return Dialog(
                              //           alignment: Alignment.center,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                              //           elevation: BorderSide.strokeAlignOutside,
                              //           child: Container(
                              //             padding: EdgeInsets.only( top: 0,bottom: 0),
                              //             width: ResponsiveHelper.isMobile(context)?width*0.85:tabWidth*0.85,
                              //             decoration:  BoxDecoration(color: Color(0x1A52B46B),
                              //                 borderRadius: BorderRadius.circular(7),
                              //                 border: Border.all(color: Constants.greyDark,width: 0.5)
                              //             ),
                              //             child: ListView(
                              //               shrinkWrap: true,
                              //               children: [
                              //                 Padding(
                              //                   padding: const EdgeInsets.only(top: 30),
                              //                   child: SizedBox(
                              //                     width: ResponsiveHelper.isMobile(context)?width*0.55:tabWidth*0.55,
                              //                     child: Center(
                              //                       child: RichText(
                              //                         textAlign: TextAlign.center,
                              //                         text:  TextSpan(
                              //                             children: [
                              //                               TextSpan(text:offerPublishOn == false? 'Required' :'At least one', style: BlackTitle700height),
                              //                               TextSpan(text: " items \nNeed To Be", style: BlackTitle500height),
                              //                               TextSpan(text: ' Chosen\n', style: BlackTitle700height),
                              //                               TextSpan(text: "To Confirm / Execute \nThe", style:BlackTitle500height),
                              //                               TextSpan(text: ' Offer.', style: BlackTitle700height),
                              //                             ]
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //                 SizedBox(height: 10,),
                              //                 Row(
                              //                   mainAxisAlignment: MainAxisAlignment.center,
                              //                   children: [
                              //                     Padding(
                              //                       padding: const EdgeInsets.only(bottom: 20),
                              //                       child: ElevatedButton(
                              //                           style: ElevatedButton.styleFrom(
                              //                               padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 2),
                              //                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor:Constants.primaryColor1, elevation: 1),
                              //                           onPressed: () {
                              //                             Navigator.pop(context);
                              //                           },
                              //                           child: Text("OK",style: BlackBottomHeadStyleBold,)),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         );
                              //       },);
                              //     },);
                              // }

                              // var body = {
                              //   "offer_id" :widget.OfferData.offerData!.id.toString()
                              // };
                              // DrawAuraAPi.CrateDataApi(body: body,ApiEndPoint: "checkOfferStatus").then((value) {
                              //   if(value["offer_status"] == "LIVE"){
                              //
                              //
                              //   }else{
                              //     showDialog(context: context,
                              //       builder: (context) {
                              //         return  StatefulBuilder(builder: (context, setState) {
                              //           return Dialog(
                              //             alignment: Alignment.center,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                              //             elevation: BorderSide.strokeAlignOutside,
                              //             child: Container(
                              //               padding: EdgeInsets.only( top: 0,bottom: 0),
                              //               width: ResponsiveHelper.isMobile(context)?width*0.85:tabWidth*0.85,
                              //               decoration:  BoxDecoration(color: Color(0x1A52B46B),
                              //                   borderRadius: BorderRadius.circular(7),
                              //                   border: Border.all(color: Constants.greyDark,width: 0.5)
                              //               ),
                              //               child: ListView(
                              //                 shrinkWrap: true,
                              //                 children: [
                              //                   Padding(
                              //                     padding: const EdgeInsets.only(top: 30),
                              //                     child: SizedBox(
                              //                       width: ResponsiveHelper.isMobile(context)?width*0.55:tabWidth*0.55,
                              //                       child: Center(
                              //                         child: RichText(
                              //                           textAlign: TextAlign.center,
                              //                           text:  TextSpan(
                              //                               children: [
                              //                                 TextSpan(text: 'This Offer is Closed', style: BlackTitle700height),
                              //                               ]
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                   SizedBox(height: 10,),
                              //                   Row(
                              //                     mainAxisAlignment: MainAxisAlignment.center,
                              //                     children: [
                              //                       Padding(
                              //                         padding: const EdgeInsets.only(bottom: 20),
                              //                         child: ElevatedButton(
                              //                             style: ElevatedButton.styleFrom(
                              //                                 padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 2),
                              //                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor:Constants.primaryColor, elevation: 1),
                              //                             onPressed: () {
                              //                               Navigator.pop(context);
                              //                             },
                              //                             child: Text("OK",style: BlackBottomHeadStyleBold,)),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           );
                              //         },);
                              //       },);
                              //   }
                              // });
                            }
                          },);
                        },
                        child:PublishLoader == true?SizedBox(height:15,width: 15,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2.5,)):    Text("PUBLISH",style: WhiteButtonStyle16500,
                        )),
                    Container(
                      height: 45,
                      width: 45,
                      margin: const EdgeInsets.only(bottom: 5,right: 20),
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Constants.greyDark
                      ),
                      child:Center(child: Container(
                        height: 35,width: 35,
                        decoration:DataManager.getInstance().getuserImage().toString() == "null" ||  DataManager.getInstance().getuserImage() == null ||DataManager.getInstance().getuserImage()=="" ? BoxDecoration(
                          // border: Border.all(color: Constants.white,width: 4),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg"),)
                        ): BoxDecoration(
                            border: Border.all(color: Constants.white,width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${DataManager.getInstance().getuserImage()}"),fit: BoxFit.fill)
                        ),
                      )),
                    ),
                  ],
                )),
          )),
    );
  }

}
