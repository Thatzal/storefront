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
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/CounterNotifyModel.dart';
import 'package:socialapps/model/MainOfferBidesModel.dart';
import 'package:socialapps/model/PrefillOfferDataModel.dart';
import 'package:socialapps/model/ServicePersonListModel.dart';
import 'package:socialapps/model/UnitListModel.dart';
import 'package:socialapps/model/serviceAreaModel.dart';
import 'package:socialapps/model/lastCounterModel.dart';
import 'package:socialapps/screens/Dashboard/dashboard_screen.dart';
import 'package:socialapps/screens/ViewFileListing.dart';
import 'package:socialapps/screens/newOfferPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapps/screens/widgets/ImagePickeBottomSheet.dart';
import 'package:socialapps/screens/widgets/RatingDialogAfterOfferDone.dart';
import 'package:socialapps/screens/widgets/ReportAbuseWarningDialog.dart';
import 'package:socialapps/screens/widgets/ShowDurationPicker.dart';
import 'package:socialapps/screens/widgets/SimmerLoadingBuilder.dart';
import 'package:socialapps/screens/widgets/upload_image_camera.dart';
import '../common/style.dart';
import '../constant/loading.dart';
import '../model/CounterOfferDetailsModel.dart';
import '../model/OfferItemConditionModel.dart';
import 'package:simple_rich_text/simple_rich_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'widgets/NewAddressPickers/NewAddressPickerList.dart';

class lastCounterScreen extends StatefulWidget {

  String to_Couter_Id;
  String OferId;

  lastCounterScreen({Key? key,required this.to_Couter_Id,required this.OferId}) : super(key: key);

  @override
  State<lastCounterScreen> createState() => _lastCounterScreenState();
}

class _lastCounterScreenState extends State<lastCounterScreen> {
  bool cateLoader=false;
  // bool segmentLoader=false;
  bool addOfferHide = true;
  int _currentTapindex = 0;


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

  List<String> CouterBid = [];

  TextEditingController OfferDurationController = TextEditingController();
  TextEditingController OfferPeriodController = TextEditingController();
  TextEditingController OfferExpiryController = TextEditingController();
  TextEditingController OfferFromLocationController = TextEditingController();
  TextEditingController OfferToLocationController = TextEditingController();
  TextEditingController OfferAtLocationController = TextEditingController();

  var maskFormatter = new MaskTextInputFormatter(mask: '##:##:##:##:##', filter: {"#": RegExp(r'[0-9]')});
  int Qty = 0;

  List<ServiceAreaModel> serviceAreaList =[];
  List<dynamic> ItemsList = [];

  List<UnitListData> getUnitList = [];
  List<ServicePersonListModel> ServicePersonList = [];
  List selectedItems = [];
  List <bool> requiredItemPriceIsEmpty = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLastCounter();
    RefreshAfter8Sec();
  }
  RefreshAfter8Sec(){
    Future.delayed(Duration(seconds: 8),() {
      if(mounted){
        setState(() {});
      }
    },);
  }


  lastCounterData ?OfferCounterData;
  List <CounterNotifyModel> ExecuteNotificationList = [];
  loadLastCounter() async{
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


    DrawAuraAPi().getLastCounterOffer(offer_id: widget.OferId.toString(),to_counter: widget.to_Couter_Id.toString()).then((Response) {
      var res = json.decode(utf8.decode(Response.bodyBytes));
      print(res);
      print("LastCounterOfferScreen");
      if (Response.statusCode == 200) {
        if (res["status"] == "200") {
         if(mounted){
           setState(() {
             OfferCounterData = lastCounterData.fromJson(res["result"]);
             ExecuteNotificationList = List.from(res["result"]["offer_notify"]).map<CounterNotifyModel>((item) => CounterNotifyModel.fromJson(item)).toList();
             getSaveData();
           });
         }
        }
       else {
          Constants.showToast("Server error");
        }
      }
    }).then((value) {

    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  TextEditingController adressLocationController = TextEditingController();
  TextEditingController OfferInstruction1Controller = TextEditingController();
  TextEditingController OfferInstruction2Controller = TextEditingController();
  String bids1 = "";
  String bids2 = "";
  String selectedTap = "";

  bool isSinglePeriodSelect = true;
  DateTime  ? ExDTime;
  bool isAdvancePriceShow = false;
  bool isMaintancePriceShow =false;
  ///Item Offer
  bool isItemDurationVisible = true;
  bool isItemPeriodVisible = true;
  bool isItemPriorityVisible = true;
  bool isItemServicePersonVisible = true;
  bool isItemExpiryVisible = true;
  bool isItemSinglePeriodSelect = true;
  DateTime  ? ItemExDTime;
  String? selectedValueItemPriority;
  String? selectedItemPeriodicityValue;
  bool isVisibleItemFromLocation = true;
  bool isVisibleItemToLocation = false;
  bool isVisibleItemAtLocation = false;
  bool OfferInstruction1Visible = true;
  bool OfferInstruction2Visible = false;
  bool PublishLoader = false;
  var saveAddress;
  var saveAddressTitle;
  var saveAddressId;
  var DisplayName;
  bool isOfferOwner = false;
  bool LastIsConfirm = false;
  int  isCurrentTab = -1;
 // List <OfferBid> offerBidsList = [];
  List <Counters> offerCounterList = [];
  var months ;
  var diff_mi ;
  var diff_s;
  var diff_hr ;
  var years ;
  var diff_dy ;
  bool waitForResponse =  false;
  bool isConfirmModify = false;
  List<bool> ExecutionReddy = [];
  getSaveData()  {
    Future.delayed(Duration.zero,() async {

      final SharedPreferences  sharedpreferences = await SharedPreferences.getInstance();
      setState(() {
        isPrivateOffer = OfferCounterData!.offer!.privacy.toString().toUpperCase() == "PRIVATE" ? true:false;
        final startTime = DateFormat('dd-MM-yyyy HH:mm').parse('${OfferCounterData!.offer!.createdAt}');
        final currentTime = DateTime.now();
         diff_dy = currentTime.difference(startTime).inDays;
         years = diff_dy ~/ 365;
         months = (diff_dy-years*365) ~/ 30;
         diff_mi = currentTime.difference(startTime).inMinutes;
         diff_s = currentTime.difference(startTime).inSeconds;
         diff_hr = currentTime.difference(startTime).inHours;
         offerCounterList.add(
            Counters(
              id:  OfferCounterData!.offer!.id,
              fromCounter: OfferCounterData!.offer!.subscribers!.displayname.toString(),
              fromCounterId:  OfferCounterData!.offer!.subscribers!.id,
              toCounter: "",
              toCounterId: 0,
            )
        );
        for(var d = 0 ; d<OfferCounterData!.counters!.length ; d++){
          offerCounterList.add(OfferCounterData!.counters![d]);
        }
        if(OfferCounterData!.offer!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
          isOfferOwner = true;
          _currentTapindex = OfferCounterData!.offer!.buyORsell == "DELIVER_SELL"?1 :OfferCounterData!.offer!.buyORsell == "DELIVER_BUY"?0: OfferCounterData!.offer!.buyORsell == "BUY"? 0 : 1;
        } else{
          isOfferOwner = false;
          _currentTapindex = OfferCounterData!.offer!.buyORsell == "DELIVER_SELL"?0 :OfferCounterData!.offer!.buyORsell == "DELIVER_BUY"?1: OfferCounterData!.offer!.buyORsell == "BUY"? 1 : 0;
        }

        if(OfferCounterData!.tabactivity.toString().toUpperCase().trim() == "CONFIRM"){
          if(OfferCounterData!.confirmSteps.toString() == "1" && OfferCounterData!.confirmBy.toString().toUpperCase().trim() == "B"){
            if( _currentTapindex == 0 ){
              selectedTap = "Confirm";
              isConfirmModify = true;
              waitForResponse = true;
            }else{
              selectedTap = "Confirm";
              waitForResponse = false;
            }
          }else if(OfferCounterData!.confirmSteps.toString() == "1" && OfferCounterData!.confirmBy.toString().toUpperCase().trim() == "S"){
            if( _currentTapindex == 0 ){
              selectedTap = "Confirm";
              waitForResponse = false;
            }else{
              selectedTap = "Confirm";
              isConfirmModify = true;
              waitForResponse = true;
            }
          }else if(OfferCounterData!.confirmSteps.toString() == "2" ){
            if( _currentTapindex == 0 ){
              selectedTap = "Confirm";
              // isConfirmModify = true;
              waitForResponse = true;
            }else{
              selectedTap = "Execute";
              waitForResponse = false;
            }
          }else if(OfferCounterData!.confirmSteps.toString() == "3"){
            selectedTap = "Sign-Off";
          }
        }else if(OfferCounterData!.tabactivity.toString().toUpperCase().trim() == "EXECUTE" ){
          if(OfferCounterData!.confirmSteps.toString() == "2"){
            if( _currentTapindex == 1 ){
              selectedTap = "Sign-Off";
              waitForResponse = true;
            }else{
              selectedTap = "Confirm";
            }
          }else if(OfferCounterData!.confirmSteps.toString() == "3"){
            selectedTap = "Sign-Off";
          }
        }else if(OfferCounterData!.tabactivity.toString().toUpperCase().trim() == "SIGN-OFF" ){
          selectedTap = "Sign-Off";
        }else if(OfferCounterData!.fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
          isModifyCounterOffer = true;
          selectedTap = "Modify";
          int terms = 1;
          for(var i = 0 ; i<OfferCounterData!.offerBid!.length; i++){
            if(OfferCounterData!.modified.toString().trim() == OfferCounterData!.offerBid![i].modified.toString().trim()){
              terms++;
              terms == 2 ? OfferInstruction1Controller.text = OfferCounterData!.offerBid![i].comment.toString(): OfferInstruction2Controller.text = OfferCounterData!.offerBid![i].comment.toString();
              terms == 2 ? OfferInstruction1Visible = true: OfferInstruction2Visible = true;
            }
          }
        }else if( OfferCounterData!.tabactivity.toString().toUpperCase().trim() == "ANSWER"){
          if(OfferCounterData!.fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
            selectedTap = "Answer";
          }else{
            selectedTap = "Query";
          }
        }else if(OfferCounterData!.tabactivity.toString().toUpperCase().trim() == "QUERY"){
          if(OfferCounterData!.fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
            selectedTap = "Query";
          }else{
            selectedTap = "Answer";
          }
        }

        OfferCounterData!.offer!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?isOfferOwner = true :isOfferOwner = false;
        List serviceTemp = jsonDecode("${OfferCounterData!.offer!.offerareas!.toString()}");
        serviceAreaList = serviceTemp.map((e) => ServiceAreaModel.fromJson(e)).toList();
        DisplayName = sharedpreferences.getString("UserDisplayName")??"";
        saveAddress = OfferCounterData!.offer!.addres;
        saveAddressTitle =   "";
        selectedPeriodicityValue =OfferCounterData!.offerConditions!.periodicity==null?"": OfferCounterData!.offerConditions!.periodicity.toString().trim();
        selectedValuePriority = OfferCounterData!.offerConditions!.priority ==null?"": OfferCounterData!.offerConditions!.priority.toString().trim();
        final fromPeriodDate = OfferCounterData!.offerConditions!.fromperiod== null ?"":OfferCounterData!.offerConditions!.fromperiod.toString();
        final fromPeriodTime = OfferCounterData!.offerConditions!.fromperiodtime==null?"": OfferCounterData!.offerConditions!.fromperiodtime.toString();
        final toPeriodDate = OfferCounterData!.offerConditions!.toperiod == null ?"": OfferCounterData!.offerConditions!.toperiod.toString();
        final toPeriodTime = OfferCounterData!.offerConditions!.toperiodtime == null?"": OfferCounterData!.offerConditions!.toperiodtime.toString();
        OfferPeriodController.text =fromPeriodTime=="" && fromPeriodDate=="" && toPeriodDate=="" && toPeriodTime==""?"": toPeriodDate != "" && toPeriodTime != ""?"From "+ fromPeriodDate+" " +  fromPeriodTime +" To " + toPeriodDate +" "+toPeriodTime :"From "+ fromPeriodDate+" " +  fromPeriodTime;
        OfferDurationController.text = OfferCounterData!.offerConditions!.duration==null?"": OfferCounterData!.offerConditions!.duration.toString();
        OfferExpiryController.text = OfferCounterData!.offerConditions!.expiry==null?"": OfferCounterData!.offerConditions!.expiry.toString();
        OfferFromLocationController.text = OfferCounterData!.offerConditions!.fromlocation == null ?"": OfferCounterData!.offerConditions!.fromlocation.toString();
        OfferToLocationController.text = OfferCounterData!.offerConditions!.tolocation == null ? "": OfferCounterData!.offerConditions!.tolocation.toString();
        OfferAtLocationController.text = OfferCounterData!.offerConditions!.atlocation == null ? "": OfferCounterData!.offerConditions!.atlocation.toString();
        adressLocationController.text = OfferCounterData!.offer!.addres.toString();
        offerPeriodFromDate = OfferCounterData!.offerConditions!.fromperiod== null ?"":OfferCounterData!.offerConditions!.fromperiod.toString();
        offerPeriodFromTime =OfferCounterData!.offerConditions!.fromperiodtime==null?"": OfferCounterData!.offerConditions!.fromperiodtime.toString();
        offerPeriodToDate = OfferCounterData!.offerConditions!.toperiod == null ?"": OfferCounterData!.offerConditions!.toperiod.toString();
        offerPeriodToTime =OfferCounterData!.offerConditions!.toperiodtime == null?"": OfferCounterData!.offerConditions!.toperiodtime.toString();
        offerExpiryDateTime = OfferCounterData!.offerConditions!.expiry == null?"": OfferCounterData!.offerConditions!.expiry.toString();
        selectedItems = OfferCounterData!.offerConditions!.servicepersons!.map((e) =>e).toList();
        //  serviceAreaList  =  jsonDecode("${widget.OfferData.offerareas!.toString()}").map((e) => ServiceAreaModel.fromJson(e)).toList();
      });

      for(var i = 0 ; i<OfferCounterData!.offerItems!.length ; i++){
        if(selectedTap.toString().toUpperCase().trim() == "EXECUTE"){
          
          if(OfferCounterData!.offerItems![i].isExicuted == false){
            setState((){
              ExecutionReddy.add(false);
            });
          }else{
            setState((){
              ExecutionReddy.add(true);
            });
          }
        }
        final imageMedia = [];
        final fileUrls = [];
        for(var j = 0 ; j< OfferCounterData!.offerItems![i].itemMedia!.length; j++){
          imageMedia.add({
            "file":"${OfferCounterData!.offerItems![i].itemMedia![j].id}",
            "name": "${OfferCounterData!.offerItems![i].itemMedia![j].name}"
          });
          fileUrls.add(
            "${ OfferCounterData!.offerItems![i].itemMedia![j].file}",
          );
        }

        List selectedItemsList = OfferCounterData!.offerItems![i].offerItemConditions!.servicepersons!.isEmpty?[]: OfferCounterData!.offerItems![i].offerItemConditions!.servicepersons!.map((e) =>e).toList();
        List<UnitListData> TempUnitList = [];
        final fromPeriodDate = OfferCounterData!.offerItems![i].offerItemConditions!.fromperiod== null ?"":OfferCounterData!.offerItems![i].offerItemConditions!.fromperiod.toString();
        final fromPeriodTime =OfferCounterData!.offerItems![i].offerItemConditions!.fromperiodtime==null?"": OfferCounterData!.offerItems![i].offerItemConditions!.fromperiodtime.toString();
        final toPeriodDate = OfferCounterData!.offerItems![i].offerItemConditions!.toperiod == null ?"": OfferCounterData!.offerItems![i].offerItemConditions!.toperiod.toString();
        final toPeriodTime =OfferCounterData!.offerItems![i].offerItemConditions!.toperiodtime == null?"": OfferCounterData!.offerItems![i].offerItemConditions!.toperiodtime.toString();
        //final image64 = widget.OfferData.offerItems![i].itemMedia!.isEmpty?[]: await ["${networkImageToBase64('${Url.IMAGE_URL}${widget.OfferData.offerItems![0].itemMedia![0].media}')}"];
        if(  OfferCounterData!.offerItems!.length == 1){
          if(  OfferCounterData!.offerItems![i].price.toString() == "null" ||   OfferCounterData!.offerItems![i].price.toString() == ""){
            requiredItemPriceIsEmpty.add(true);
          }else{
            requiredItemPriceIsEmpty.add(false);
          }
        }else{
          if(OfferCounterData!.offerItems![i].required.toString() == "true"){
            if(  OfferCounterData!.offerItems![i].price.toString() == "null" ||   OfferCounterData!.offerItems![i].price.toString() == ""){
              requiredItemPriceIsEmpty.add(true);
            }else{
              requiredItemPriceIsEmpty.add(false);
            }
          }else{
            requiredItemPriceIsEmpty.add(false);
          }
        }
        ItemsList.add({
          "ExecuteSwitch": OfferCounterData!.offerItems![i].isExicuted,
          "itemType" :"Old",
          "ItemId": OfferCounterData!.offerItems![i].id.toString(),
          "name":TextEditingController(text: OfferCounterData!.offerItems![i].name.toString()),
          "desc":TextEditingController(text: OfferCounterData!.offerItems![i].desc.toString()),
          "price":TextEditingController(text:  OfferCounterData!.offerItems![i].price.toString() == "null" ?"" :OfferCounterData!.offerItems![i].price.toString()),
          "unit":TextEditingController(text: OfferCounterData!.offerItems![i].unit!.name.toString() == "null"?"" : OfferCounterData!.offerItems![i].unit!.name.toString()),
          "AdvancePrice" : TextEditingController(text :OfferCounterData!.offerItems![i].advancePrice == null ? "" :  OfferCounterData!.offerItems![i].advancePrice.toString()),
          "AdvanceUnit" : TextEditingController(text :OfferCounterData!.offerItems![i].advanceUnit!.name == null ? "" :  OfferCounterData!.offerItems![i].advanceUnit!.name.toString()),
          "MaintenancePrice" : TextEditingController(text :  OfferCounterData!.offerItems![i].maintenancePrice == null ? "": OfferCounterData!.offerItems![i].maintenancePrice.toString()),
          "MaintenanceUnit" : TextEditingController(text : OfferCounterData!.offerItems![i].maintenanceUnit!.name == null ? "" :OfferCounterData!.offerItems![i].maintenanceUnit!.name.toString()),
          "filterGetUnitList" : TempUnitList,
          "showOtherUnit" : false,
          "isLoadNewUnit" : false,
          "selectedUnitIndex" : -1,
          "SelectedUnitId" : OfferCounterData!.offerItems![i].unit == null ? null : OfferCounterData!.offerItems![i].unit!.id.toString() ,
          "filterGetUnitListMain" : TempUnitList,
          "showOtherUnitMain" : false,
          "isLoadNewUnitMain" : false,
          "selectedUnitIndexMain" : -1,
          "SelectedUnitIdMain" : OfferCounterData!.offerItems![i].maintenanceUnit!.id == null ? null :OfferCounterData!.offerItems![i].maintenanceUnit!.id.toString(),

          "filterGetUnitListAdva" : TempUnitList,
          "showOtherUnitAdva" : false,
          "isLoadNewUnitAdva" : false,
          "selectedUnitIndexAdva" : -1,
          "SelectedUnitIdAdva" :  OfferCounterData!.offerItems![i].advanceUnit!.id == null ? null :OfferCounterData!.offerItems![i].advanceUnit!.id.toString(),
          "fillSelectedPerson" : selectedItemsList,
          "type" : "old",
          "quantity":int.parse(OfferCounterData!.offerItems![i].quantity.toString()),
          "currency":"INR",
          "addon":OfferCounterData!.offerItems![i].addon,
          "required":OfferCounterData!.offerItems![i].required,
          "toggle_state": OfferCounterData!.offerItems![i].toggleState,
          "media":imageMedia,
          "isLoadingFile":false,
          "fileUrl":fileUrls,
          "itemConditionView" :false,
          "showItemPrice2":false,
          "showItemPrice3":false,
          "item_condition":{
            "ItemConditionId": OfferCounterData!.offerItems![i].offerItemConditions!.id.toString(),
            "isServicePersonView":isModifyCounterOffer?
            OfferCounterData!.offerItems![i].createdAt.toString().trim() == OfferCounterData!.createdAt.toString().trim() ?true:
            OfferCounterData!.offerItems![i].offerItemConditions!.servicepersons!.isEmpty ? false:true:
            OfferCounterData!.offerItems![i].offerItemConditions!.servicepersons!.isEmpty ? false:true,

            "periodicityView":
            isModifyCounterOffer?
            OfferCounterData!.offerItems![i].createdAt.toString().trim() == OfferCounterData!.createdAt.toString().trim() ?true:
            OfferCounterData!.offerItems![i].offerItemConditions!.periodicity.toString() == "" || OfferCounterData!.offerItems![i].offerItemConditions!.periodicity == null ?false: true:
            OfferCounterData!.offerItems![i].offerItemConditions!.periodicity.toString() == "" || OfferCounterData!.offerItems![i].offerItemConditions!.periodicity == null ?false: true,

            "periodView":
            isModifyCounterOffer?
            OfferCounterData!.offerItems![i].createdAt.toString().trim() == OfferCounterData!.createdAt.toString().trim() ?true:
            OfferCounterData!.offerItems![i].offerItemConditions!.fromperiod == null || OfferCounterData!.offerItems![i].offerItemConditions!.fromperiod.toString() == ""?false: true:
            OfferCounterData!.offerItems![i].offerItemConditions!.fromperiod == null || OfferCounterData!.offerItems![i].offerItemConditions!.fromperiod.toString() == ""?false: true,

            "durationView":
            isModifyCounterOffer?
            OfferCounterData!.offerItems![i].createdAt.toString().trim() == OfferCounterData!.createdAt.toString().trim() ?true:
            OfferCounterData!.offerItems![i].offerItemConditions!.duration.toString() == "" ||  OfferCounterData!.offerItems![i].offerItemConditions!.duration == null ?false: true:
            OfferCounterData!.offerItems![i].offerItemConditions!.duration.toString() == "" ||  OfferCounterData!.offerItems![i].offerItemConditions!.duration == null ?false: true,

            "priorityView":
            isModifyCounterOffer?
            OfferCounterData!.offerItems![i].createdAt.toString().trim() == OfferCounterData!.createdAt.toString().trim() ?true:
            OfferCounterData!.offerItems![i].offerItemConditions!.priority.toString() == "" || OfferCounterData!.offerItems![i].offerItemConditions!.priority == null?false: true:
            OfferCounterData!.offerItems![i].offerItemConditions!.priority.toString() == "" || OfferCounterData!.offerItems![i].offerItemConditions!.priority == null?false: true,

            "expiryView":
            isModifyCounterOffer?
            OfferCounterData!.offerItems![i].createdAt.toString().trim() == OfferCounterData!.createdAt.toString().trim() ?true:
            OfferCounterData!.offerItems![i].offerItemConditions!.expiry == null || OfferCounterData!.offerItems![i].offerItemConditions!.expiry.toString() == ""?false: true:
            OfferCounterData!.offerItems![i].offerItemConditions!.expiry == null || OfferCounterData!.offerItems![i].offerItemConditions!.expiry.toString() == ""?false: true,

            "fromlocationView":
            isModifyCounterOffer?
            OfferCounterData!.offerItems![i].createdAt.toString().trim() == OfferCounterData!.createdAt.toString().trim() ?true:
            OfferCounterData!.offerItems![i].offerItemConditions!.fromlocation.toString() == "" || OfferCounterData!.offerItems![i].offerItemConditions!.fromlocation == null?false: true:
            OfferCounterData!.offerItems![i].offerItemConditions!.fromlocation.toString() == "" || OfferCounterData!.offerItems![i].offerItemConditions!.fromlocation == null?false: true,

            "tolocationView":
            isModifyCounterOffer?
            OfferCounterData!.offerItems![i].createdAt.toString().trim() == OfferCounterData!.createdAt.toString().trim() ?true:
            OfferCounterData!.offerItems![i].offerItemConditions!.tolocation.toString() == "" || OfferCounterData!.offerItems![i].offerItemConditions!.tolocation == null?false: true:
            OfferCounterData!.offerItems![i].offerItemConditions!.tolocation.toString() == "" || OfferCounterData!.offerItems![i].offerItemConditions!.tolocation == null?false: true,

            "atlocationView":
            isModifyCounterOffer?
            OfferCounterData!.offerItems![i].createdAt.toString().trim() == OfferCounterData!.createdAt.toString().trim() ?true:
            OfferCounterData!.offerItems![i].offerItemConditions!.atlocation.toString() == "" || OfferCounterData!.offerItems![i].offerItemConditions!.atlocation == null ?false: true:
            OfferCounterData!.offerItems![i].offerItemConditions!.atlocation.toString() == "" || OfferCounterData!.offerItems![i].offerItemConditions!.atlocation == null ?false: true,

            "servicepersons": selectedItemsList,
            "periodicity": OfferCounterData!.offerItems![i].offerItemConditions!.periodicity == null ?"":OfferCounterData!.offerItems![i].offerItemConditions!.periodicity,
            "period":TextEditingController(text:fromPeriodTime=="" && fromPeriodDate=="" && toPeriodDate=="" && toPeriodTime==""?"": toPeriodDate != "" && toPeriodTime != ""?"From "+ fromPeriodDate+" " +  fromPeriodTime +" To " + toPeriodDate +" "+toPeriodTime :"From "+ fromPeriodDate+" " +  fromPeriodTime),
            "fromperiod":OfferCounterData!.offerItems![i].offerItemConditions!.fromperiod==null?"":OfferCounterData!.offerItems![i].offerItemConditions!.fromperiod,
            "toperiod":OfferCounterData!.offerItems![i].offerItemConditions!.toperiod==null?"":OfferCounterData!.offerItems![i].offerItemConditions!.toperiod,
            "duration": TextEditingController(text: OfferCounterData!.offerItems![i].offerItemConditions!.duration==null?"": OfferCounterData!.offerItems![i].offerItemConditions!.duration),
            "fromperiodtime":OfferCounterData!.offerItems![i].offerItemConditions!.fromperiodtime == null ?"":OfferCounterData!.offerItems![i].offerItemConditions!.fromperiodtime,
            "toperiodtime":OfferCounterData!.offerItems![i].offerItemConditions!.toperiodtime == null ? "":OfferCounterData!.offerItems![i].offerItemConditions!.toperiodtime,
            "durationoftime":"",
            "fromlocation":TextEditingController(text:  OfferCounterData!.offerItems![i].offerItemConditions!.fromlocation==null?"":OfferCounterData!.offerItems![i].offerItemConditions!.fromlocation.toString()),
            "tolocation":TextEditingController(text:  OfferCounterData!.offerItems![i].offerItemConditions!.tolocation==null?"":OfferCounterData!.offerItems![i].offerItemConditions!.tolocation.toString()),
            "atlocation":TextEditingController(text: OfferCounterData!.offerItems![i].offerItemConditions!.atlocation==null?"":OfferCounterData!.offerItems![i].offerItemConditions!.atlocation.toString()),
            "priority": OfferCounterData!.offerItems![i].offerItemConditions!.priority==null?"":OfferCounterData!.offerItems![i].offerItemConditions!.priority.toString(),
            "expiry":TextEditingController(text: OfferCounterData!.offerItems![i].offerItemConditions!.expiry==null?"":OfferCounterData!.offerItems![i].offerItemConditions!.expiry,),},
            "create_date": OfferCounterData!.offerItems![i].createdAt,
            "CreatorUserId" : OfferCounterData!.offerItems![i].user,
        });
      }
    },).then((value) {
      Future.delayed(Duration(seconds: 3),() {
        if(mounted){
          setState(() {
            cateLoader = true;
          });
        }
      },);
    });
  }

  ///  Old Counters Details Prefill Parameters

  bool IsOldCounterDataLoader = false;
  bool isViewingOldCounters = false;

  CounterOfferDetailsModelResult ? CounterOfferDetails;
  List<OfferItemConditionModel> MainOfferItemCondition = [];
  List<MainOfferBidesModel> MainOfferBids = [];

  bool isModifyCounterOffer = false;
  bool isBuyOffer = true;
  int NewCurrentIndex = 0;
  bool isPrivateOffer = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    var isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
        backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
        body: responsiveContainer(context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Scaffold(
            appBar:AppBar(
              backgroundColor: const Color(0xFFE7E6E6),
              toolbarHeight: 40,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading:   InkWell(
                  onTap:(){Navigator.pop(context);},
                  child: const Icon(Icons.arrow_back,size: 24,)),
              titleSpacing: 0,
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
                              height:28,
                              child:isModifyCounterOffer == false? Row(
                                children: [
                                  10.width,
                                  Flexible(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: offerCounterList.length,
                                      itemBuilder: (context, index) {
                                        var data = offerCounterList[index];
                                        return  InkWell(
                                          onTap: (){

                                            if(data.fromCounterId.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                                              NewCurrentIndex = _currentTapindex;
                                            } else{
                                              _currentTapindex == 0?  NewCurrentIndex = 1:NewCurrentIndex = 0;
                                            }

                                            if(index == 0){
                                              {
                                                setState(() {
                                                  isViewingOldCounters = false;
                                                  IsOldCounterDataLoader = true;
                                                });
                                                DrawAuraAPi.getOfferDetails(offer_id: OfferCounterData!.offer!.id.toString()).then((OfferDetails) {
                                                  setState(() {
                                                    isCurrentTab = index;
                                                    MainOfferItemCondition = List.from( OfferDetails["result"]["offer_items"]).map<OfferItemConditionModel>((item) => OfferItemConditionModel.fromJson(item)).toList() ;
                                                    MainOfferBids = List.from( OfferDetails["result"]["offer_bids"]).map<MainOfferBidesModel>((item) => MainOfferBidesModel.fromJson(item)).toList() ;
                                                    IsOldCounterDataLoader = false;
                                                    isViewingOldCounters = true;
                                                  });
                                                });
                                              }
                                            }else
                                            {
                                              setState(() {
                                                isViewingOldCounters = false;
                                                IsOldCounterDataLoader = true;
                                              });

                                              DrawAuraAPi.getCounterOfferDetails(offer_id: data.id.toString()).then((value) {
                                                setState(() {
                                                  isCurrentTab = index;
                                                  CounterOfferDetails = CounterOfferDetailsModelResult.fromJson(value["result"]);
                                                  IsOldCounterDataLoader = false;
                                                  isViewingOldCounters = true;
                                                });
                                              });
                                            }
                                          },
                                          child:  Container(
                                              width:80,
                                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                              margin: EdgeInsets.symmetric(vertical: 1),
                                              decoration: BoxDecoration(
                                                  border:   isCurrentTab == index ? Border.all(color: Colors.grey,width: 1.5):Border.fromBorderSide(BorderSide.none),
                                                  color:data.fromCounterId.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?Constants.primaryColor1: Constants.primaryColor20,
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) )
                                              ),
                                              child:Center(
                                                  child:Text("${data.fromCounter.toString()}",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color:data.fromCounterId.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?Colors.white:Colors.black ),overflow: TextOverflow.ellipsis)
                                              )
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  InkWell(
                                    onTap:(){
                                      setState((){

                                        isCurrentTab = -1;
                                        isViewingOldCounters = false;
                                      });
                                    },
                                    child: Container(
                                            width:70,
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        margin: EdgeInsets.only(left: 5,),
                                        decoration: BoxDecoration(
                                            border:  Border.all(color: Constants.primaryColor1,width: 1.5),
                                            color: isViewingOldCounters == false ?Constants.primaryColor1:Constants.white,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) )
                                        ),
                                        child:Center(
                                            child:Text("Current",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: isViewingOldCounters == false ?Constants.white:Constants.primaryColor1),overflow: TextOverflow.ellipsis)
                                        )
                                    ),
                                  )
                                ],
                              ):
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: offerCounterList.length,
                                itemBuilder: (context, index) {
                                  var data = offerCounterList[index];
                                  return  InkWell(
                                    onTap: (){
                                      if(data.fromCounterId.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                                        NewCurrentIndex = _currentTapindex;
                                      } else{
                                        _currentTapindex == 0?  NewCurrentIndex = 1:NewCurrentIndex = 0;
                                      }
                                      if(index == 0){
                                        {
                                          setState(() {
                                            isViewingOldCounters = false;
                                            IsOldCounterDataLoader = true;
                                          });
                                          DrawAuraAPi.getOfferDetails(offer_id: OfferCounterData!.offer!.id.toString()).then((OfferDetails) {
                                            print("1St Offer details ");
                                            log(OfferDetails.toString());

                                            setState(() {
                                              isCurrentTab = index;
                                              MainOfferItemCondition = List.from( OfferDetails["result"]["offer_items"]).map<OfferItemConditionModel>((item) => OfferItemConditionModel.fromJson(item)).toList() ;
                                              MainOfferBids = List.from( OfferDetails["result"]["offer_bids"]).map<MainOfferBidesModel>((item) => MainOfferBidesModel.fromJson(item)).toList() ;
                                              IsOldCounterDataLoader = false;
                                              isViewingOldCounters = true;
                                            });
                                          });
                                        }
                                      }else if(index == offerCounterList.length-1 ){
                                        setState(() {
                                          isCurrentTab = -1;
                                          isViewingOldCounters = false;
                                        });
                                      }
                                      else
                                      {
                                        setState(() {
                                          isViewingOldCounters = false;
                                          IsOldCounterDataLoader = true;
                                        });
                                        DrawAuraAPi.getCounterOfferDetails(offer_id: data.id.toString()).then((value) {
                                          setState(() {
                                            isCurrentTab = index;
                                            CounterOfferDetails = CounterOfferDetailsModelResult.fromJson(value["result"]);
                                            IsOldCounterDataLoader = false;
                                            isViewingOldCounters = true;
                                          });
                                        });
                                      }
                                    },
                                    child:  Container(
                                      width:80,
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        margin: EdgeInsets.symmetric(vertical: 1),
                                        decoration: BoxDecoration(
                                            border:   isCurrentTab == index ? Border.all(color: Colors.grey,width: 1.5):Border.fromBorderSide(BorderSide.none),
                                            color:data.fromCounterId.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?Constants.primaryColor1: Constants.primaryColor20,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) )
                                        ),
                                        child:Center(
                                            child:Text("${data.fromCounter.toString()}",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color:data.fromCounterId.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?Colors.white:Colors.black ),overflow: TextOverflow.ellipsis)
                                        )
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height:15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  message: "${OfferCounterData!.offer!.offerresponses} - Responses",
                                  child:  Column(
                                    children: [
                                      Text("${OfferCounterData!.offer!.offerresponses}",style: BlackCardTitle,),
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
                                  message: "${OfferCounterData!.offer!.offerviewcount!.length} - Views",
                                  child: Column(
                                      children: [
                                        Text("${OfferCounterData!.offer!.offerviewcount!.length}",style: BlackCardTitle,),
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
                                  message: OfferCounterData!.offer!.offerfavoritecount == null ? "0 Favourite count":'${OfferCounterData!.offer!.offerfavoritecount} - Favourite count',
                                  child: Column(
                                    children: [
                                      Text("${OfferCounterData!.offer!.offerfavoritecount == null ? "0 ":OfferCounterData!.offer!.offerfavoritecount}",style: BlackCardTitle,),
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
                                            if(OfferCounterData!.confirmSteps.toString() == "5"){
                                              setState(() {
                                                isPrivateOffer = !isPrivateOffer;
                                              });
                                            }
                                          },
                                          child: isPrivateOffer ? Image(image: AssetImage("assets/secured_lock.png"),width: 22,height: 22,color: primaryColor):Image(image: AssetImage("assets/world.png"),width: 22,height: 20,color: primaryColor,)),
                                    ],
                                  ),
                                ),
                                 3.width
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
                                //width: isMobile?width*0.45:tabWidth*0.45,
                                child: Center(child: Text("Offering Location not added",style: Black87DescStyle,))

                            ): SizedBox(
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
                                            //width: isMobile?width*0.45:tabWidth*0.45,
                                            child: Center(child: Text("${data.address}"))

                                        ),
                                      ),
                                    ],
                                  );
                                },),
                            ),
                            const SizedBox(height:5),
                          ],
                        ),
                      ),
                      isCurrentTab == 0?
                      Container(
                        // color: Colors.black12,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color:  Constants.unActiveTabBg,
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
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration:  BoxDecoration(
                                    color:  OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "DELIVER"? Constants.primaryColor1:Colors.transparent,
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                  ),
                                  child:  Center(child: Text('Deliver',style: OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "DELIVER"?WhiteSubTitleStyle:unActiveTabStyle,)),),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color:  OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "CANCEL"? Constants.primaryColor1:Colors.transparent,
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                  ),
                                  child:  Center(child: Text('Cancel',style: OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "CANCEL"?WhiteSubTitleStyle:unActiveTabStyle,)),),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color:   OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "CONFIRM"?Constants.primaryColor1:Colors.transparent,
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                  ),
                                  child:  Center(child: Text('Confirm',style: OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "CONFIRM"?WhiteSubTitleStyle:unActiveTabStyle,)),),

                                OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "QUERY"?
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration:  BoxDecoration(
                                    color:   OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "QUERY"? Constants.primaryColor1:Colors.transparent,
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                  ),
                                  child:  Center(child: Text('Query',style:  OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "QUERY"?WhiteSubTitleStyle:unActiveTabStyle,)),):
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration:  BoxDecoration(
                                    color:  OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "ANSWER"? Constants.primaryColor1:Colors.transparent,
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                  ),
                                  child:  Center(child: Text('Answer',style: OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "ANSWER"?WhiteSubTitleStyle:unActiveTabStyle,)),),
                                Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color:   OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "MODIFY"? Constants.primaryColor1:Colors.transparent,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Modify',style:   OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "MODIFY"?WhiteSubTitleStyle:unActiveTabStyle,))
                                ),

                                Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color:   OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "NEW"? Constants.primaryColor1:Colors.transparent,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(8),topLeft:Radius.circular(8) ),
                                    ),
                                    child:  Center(child: Text('New',style: OfferCounterData!.offer!.tabactivity.toString().toUpperCase().trim() == "NEW"?WhiteSubTitleStyle:unActiveTabStyle,))
                                ),
                              ],
                            ),
                          )
                      ):
                      isViewingOldCounters == true ?
                      Container(
                        // color: Colors.black12,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color:  Constants.unActiveTabBg,
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
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration:  BoxDecoration(
                                    color:  CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "DELIVER"? Constants.primaryColor1:Colors.transparent,
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                  ),
                                  child:  Center(child: Text('Deliver',style: CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "DELIVER"?WhiteSubTitleStyle:unActiveTabStyle,)),),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color:  CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "CANCEL"? Constants.primaryColor1:Colors.transparent,
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                  ),
                                  child:  Center(child: Text('Cancel',style: CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "CANCEL"?WhiteSubTitleStyle:unActiveTabStyle,)),),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color:   CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "CONFIRM"?Constants.primaryColor1:Colors.transparent,
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                  ),
                                  child:  Center(child: Text('Confirm',style: CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "CONFIRM"?WhiteSubTitleStyle:unActiveTabStyle,)),),
                                CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "EXECUTE"?
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration:  BoxDecoration(
                                    color: CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "EXECUTE"? Constants.primaryColor1:Colors.transparent,
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                  ),
                                  child:  Center(child: Text('Execute',style:  CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "EXECUTE"?WhiteSubTitleStyle:unActiveTabStyle,)),):
                                CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "SIGN-OFF"?
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration:  BoxDecoration(
                                    color: CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "SIGN-OFF"? Constants.primaryColor1:Colors.transparent,
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                  ),
                                  child:  Center(child: Text('Sign-Off',style:  CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "SIGN-OFF"?WhiteSubTitleStyle:unActiveTabStyle,)),):
                                CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "QUERY"?
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration:  BoxDecoration(
                                    color:   CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "QUERY"? Constants.primaryColor1:Colors.transparent,
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                  ),
                                  child:  Center(child: Text('Query',style:  CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "QUERY"?WhiteSubTitleStyle:unActiveTabStyle,)),):
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration:  BoxDecoration(
                                    color:  CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "ANSWER"? Constants.primaryColor1:Colors.transparent,
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                  ),
                                  child:  Center(child: Text('Answer',style: CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "ANSWER"?WhiteSubTitleStyle:unActiveTabStyle,)),),
                                Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color:   CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "Modify"? Constants.primaryColor1:Colors.transparent,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Modify',style:   CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "Modify"?WhiteSubTitleStyle:unActiveTabStyle,))
                                ),

                                Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color:   CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "NEW"? Constants.primaryColor1:Colors.transparent,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(8),topLeft:Radius.circular(8) ),
                                    ),
                                    child:  Center(child: Text('New',style: CounterOfferDetails!.tabactivity.toString().toUpperCase().trim() == "NEW"?WhiteSubTitleStyle:unActiveTabStyle,))
                                ),
                              ],
                            ),
                          )
                      ):
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

                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:  BoxDecoration(
                                      color:  selectedTap == "Deliver"? Constants.primaryColor1:Colors.transparent,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Deliver',style:  selectedTap == "Deliver"?WhiteSubTitleStyle:BlackSubTitleStyle,)),),
                                ),
                                InkWell(
                                  onTap: () {

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
                                      isModifyCounterOffer == false ? selectedTap = "Confirm" : null;
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color:  selectedTap == "Confirm"? Constants.primaryColor1:isModifyCounterOffer == false ?Colors.transparent:Constants.unActiveTabBg,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Confirm',style:  selectedTap == "Confirm"?WhiteSubTitleStyle:isModifyCounterOffer == false ?BlackSubTitleStyle:unActiveTabStyle,)),),
                                ),
                                OfferCounterData!.tabactivity.toString().toUpperCase().trim() == "SIGN-OFF" ||
                                    OfferCounterData!.tabactivity.toString().toUpperCase().trim() == "EXECUTE" ||
                                selectedTap.toString().toUpperCase().trim()  == "SIGN-OFF" ?
                                InkWell(
                                  onTap:(){
                                    setState(() {
                                      isModifyCounterOffer == false ? selectedTap = "Sign-Off" : null;
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:  BoxDecoration(
                                      color:  selectedTap == "Sign-Off"? Constants.primaryColor1:isModifyCounterOffer == false ?Colors.transparent:Constants.unActiveTabBg,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Sign-Off',style:  selectedTap == "Sign-Off"?WhiteSubTitleStyle:isModifyCounterOffer == false ?BlackSubTitleStyle:unActiveTabStyle,)),),
                                ):
                                selectedTap.toString().toUpperCase().trim()  == "EXECUTE" ?
                                InkWell(
                                  onTap:(){
                                    setState(() {
                                      isModifyCounterOffer == false ? selectedTap = "Execute" : null;

                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:  BoxDecoration(
                                      color:  selectedTap == "Execute"? Constants.primaryColor1:isModifyCounterOffer == false ?Colors.transparent:Constants.unActiveTabBg,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Execute',style:  selectedTap == "Execute"?WhiteSubTitleStyle:isModifyCounterOffer == false ?BlackSubTitleStyle:unActiveTabStyle,)),),
                                )
                                    : isConfirmModify == true && _currentTapindex == 0?  InkWell(
                                  onTap:(){
                                    setState(() {
                                      isModifyCounterOffer == false ? selectedTap = "Query" : null;
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:  BoxDecoration(
                                      color:  selectedTap == "Query"? Constants.primaryColor1:isModifyCounterOffer == false ?Colors.transparent:Constants.unActiveTabBg,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Query',style:  selectedTap == "Query"?WhiteSubTitleStyle:isModifyCounterOffer == false ?BlackSubTitleStyle:unActiveTabStyle,)),),
                                ):
                                isConfirmModify == true && _currentTapindex == 1?   InkWell(
                                  onTap:(){
                                    setState(() {
                                      isModifyCounterOffer == false ? selectedTap = "Answer" : null;
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:  BoxDecoration(
                                      color:  selectedTap == "Answer"? Constants.primaryColor1: isModifyCounterOffer == false ?Colors.transparent:Constants.unActiveTabBg,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Answer',style:  selectedTap == "Answer"?WhiteSubTitleStyle: isModifyCounterOffer == false ?BlackSubTitleStyle:unActiveTabStyle,)),),
                                ):
                                _currentTapindex == 0?  InkWell(
                                  onTap:(){
                                    setState(() {
                                      isModifyCounterOffer == false ? selectedTap = "Query" : null;
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:  BoxDecoration(
                                      color:  selectedTap == "Query"? Constants.primaryColor1:isModifyCounterOffer == false ?Colors.transparent:Constants.unActiveTabBg,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Query',style:  selectedTap == "Query"?WhiteSubTitleStyle:isModifyCounterOffer == false ?BlackSubTitleStyle:unActiveTabStyle,)),),
                                ) :
                                InkWell(
                                  onTap:(){
                                    setState(() {
                                      isModifyCounterOffer == false ? selectedTap = "Answer" : null;
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:  BoxDecoration(
                                      color:  selectedTap == "Answer"? Constants.primaryColor1: isModifyCounterOffer == false ?Colors.transparent:Constants.unActiveTabBg,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                    ),
                                    child:  Center(child: Text('Answer',style:  selectedTap == "Answer"?WhiteSubTitleStyle: isModifyCounterOffer == false ?BlackSubTitleStyle:unActiveTabStyle,)),),
                                ),
                                InkWell(
                                  onTap:(){
                                    setState(() {
                                      isModifyCounterOffer == true ? selectedTap = "Modify" : null;
                                    });
                                  },
                                  child: Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        color:  selectedTap == "Modify"? Constants.primaryColor1: isModifyCounterOffer == true ?  Colors.transparent:Constants.unActiveTabBg,
                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                      ),
                                      child:  Center(child: Text('Modify',style:  selectedTap == "Modify"? WhiteSubTitleStyle:isModifyCounterOffer == true ? BlackSubTitleStyle:unActiveTabStyle,))
                                  ),
                                ),
                                InkWell(
                                  onTap:(){
                                    setState(() {
                                      //isModifyCounterOffer == false ? selectedTap = "Duplicate" : null;
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
                      ///Buy Sell

                      isViewingOldCounters == true ?
                      Container(
                          height: 80,
                          width: isMobile?width:tabWidth,
                          decoration:  const BoxDecoration(color: Color(0xFFE7E6E6),
                          ),
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
                                        color: NewCurrentIndex == index
                                            ? Constants.primaryColor1
                                            : Constants.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              blurRadius: 1.5,
                                              spreadRadius: 1.5,
                                              offset: const Offset(1, 4))
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Constants.lightGreen,width: 1)
                                    ),
                                    child: Center(
                                      child: Text(index == 0 ? "Buy" : "Sell", style:NewCurrentIndex == index?WhiteTitleStyle:BlackFieldStyleBold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )):
                      Container(
                          height: 80,
                          width: isMobile?width:tabWidth,
                          decoration:  const BoxDecoration(color: Color(0xFFE7E6E6),
                          ),
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
                                        OfferCounterData!.offer!.buyORsell == "DELIVER_SELL" ||  OfferCounterData!.offer!.buyORsell == "DELIVER_BUY"?
                                        index == 0 ? "Deliver Buy" : "Deliver Sell":
                                        index == 0 ? "Buy" : "Sell"
                                        , style:_currentTapindex == index?WhiteTitleStyle:BlackFieldStyleBold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )),
                      Expanded(
                          child: RefreshIndicator(
                              onRefresh: () async{
                                DrawAuraAPi().getLastCounterOffer(offer_id: widget.OferId.toString(),to_counter: widget.to_Couter_Id.toString()).then((Response) {
                                  var res = json.decode(utf8.decode(Response.bodyBytes));
                                  print(res);
                                  print("LastCounterOfferScreen");
                                  if (Response.statusCode == 200) {
                                    if (res["status"] == "200") {
                                      if(mounted){
                                        setState(() {
                                          ExecuteNotificationList = List.from(res["result"]["offer_notify"]).map<CounterNotifyModel>((item) => CounterNotifyModel.fromJson(item)).toList();
                                        });
                                      }
                                    }
                                  }
                                });
                                return Future.value();
                              },
                            child:  ListView(
                              shrinkWrap: false,
                              physics: AlwaysScrollableScrollPhysics(),
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
                                          Text("Subsegment ",style: BlackDescStyle,),
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      SingleChildScrollView(

                                        scrollDirection: Axis.horizontal,

                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:  [
                                            Text("${OfferCounterData!.offer!.category!.name}",style: BlackFieldStyleBold,),
                                            Text("  >  ",style: BlackFieldStyleBold,),
                                            Text("${OfferCounterData!.offer!.segment!.name}",style: BlackFieldStyleBold,),
                                            Text("  >  ",style: BlackFieldStyleBold,),
                                            Text("${OfferCounterData!.offer!.subsegment!.name}",style: BlackFieldStyleBold,),
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
                                          height: 65,
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
                                                              child: Text(item, style:  BlackSubHeadingStyle, overflow: TextOverflow.ellipsis,
                                                              ),
                                                            )).toList(),
                                                            value: selectedPeriodicityValue==""?null:selectedPeriodicityValue,
                                                            // onChanged: (newValue) {
                                                            //   setState(() {
                                                            //     selectedPeriodicityValue = newValue!;
                                                            //   });
                                                            // },
                                                            onChanged: null,
                                                            hint: const Text("Periodicity", style:greyHintStyle),
                                                            iconStyleData: const IconStyleData(
                                                              icon: Icon(Icons.keyboard_arrow_down_sharp,),
                                                              iconSize: 10,
                                                              iconEnabledColor: Colors.white,
                                                              iconDisabledColor:Colors.white,
                                                            ),
                                                            buttonStyleData: ButtonStyleData(
                                                                height:  35,
                                                                width: isMobile?width * 0.38:tabWidth*0.38,
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
                                                                  width: isMobile?width * 0.38:tabWidth*0.38,
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
                                                              width: isMobile?width * 0.38:tabWidth*0.38,
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
                                                          width: isMobile?width*0.55:tabWidth*0.55,
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
                                                          width: isMobile?width*0.50:tabWidth*0.50,
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
                                                            style: Black87HintStyle,
                                                          ),
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
                                                                blurRadius: 2.0,
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
                                                                child: Text(item, style: BlackSubHeadingStyle, overflow: TextOverflow.ellipsis,),
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
                                                                  width: isMobile?width * 0.3:tabWidth*0.3,
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
                                                                    width: isMobile?width * 0.3:tabWidth*0.3,
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
                                                                width: isMobile?width * 0.3:tabWidth*0.3,
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

                                                              style:BlackFieldStyle

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
                                                          width: isMobile?width*0.35:tabWidth*0.35,
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
                                                        width: isMobile?width*0.45:tabWidth*0.45,
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
                                                        width: isMobile?width*0.45:tabWidth*0.45,
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
                                                        width: isMobile?width*0.45:tabWidth*0.45,
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

                                              const SizedBox(width: 8,),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                isCurrentTab == 0?
                                ListView.builder(
                                  itemCount: MainOfferItemCondition.length,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    print("MainOfferItemsShowing");
                                    var data = MainOfferItemCondition[index];

                                    final fromPeriodDate = data.offerItemConditions!.fromperiod== null ?"":data.offerItemConditions!.fromperiod.toString();
                                    final fromPeriodTime =data.offerItemConditions!.fromperiodtime==null?"": data.offerItemConditions!.fromperiodtime.toString();
                                    final toPeriodDate =data.offerItemConditions!.toperiod == null ?"": data.offerItemConditions!.toperiod.toString();
                                    final toPeriodTime =data.offerItemConditions!.toperiodtime == null?"": data.offerItemConditions!.toperiodtime.toString();
                                    var period = fromPeriodTime=="" && fromPeriodDate=="" && toPeriodDate=="" && toPeriodTime==""?"": toPeriodDate != "" && toPeriodTime != ""?"From "+ fromPeriodDate+" " +  fromPeriodTime +" To " + toPeriodDate +" "+toPeriodTime :"From "+ fromPeriodDate+" " +  fromPeriodTime;
                                    return Container(
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
                                                children: [
                                                  Container(
                                                    // height: 40,
                                                      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 10),
                                                      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(8)),
                                                      width: isMobile?width*0.4:tabWidth*0.4,
                                                      margin: EdgeInsets.only(left: 5,right:5,top: 10),
                                                      child: Center(child: Text("${data.name}",style: Black87HintStyle,))
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 10),
                                                      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(8)),
                                                      width: isMobile?width*0.4:tabWidth*0.4,
                                                      margin: EdgeInsets.only(left: 5,right:5,top: 10),
                                                      child: Center(child: Text("${data.desc}",style: Black87HintStyle,))
                                                  ),
                                                ],
                                              ),

                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:[
                                                  SizedBox(height: 10,),
                                                  data.required == true? Text("REQUIRED", style: PrimaryColorTitleStyle,):SizedBox() ,

                                                  data.addon == true? Padding(
                                                    padding: const EdgeInsets.only(top: 10.0),
                                                    child: Text("ADD ON", style: PrimaryColorTitleStyle,),
                                                  ):SizedBox() ,
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: Card(
                                                      elevation: 2,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: FlutterSwitch(
                                                          showOnOff: false,
                                                          value: true,
                                                          toggleSize: 20,
                                                          padding: 1,
                                                          height: 22,
                                                          width: 42,valueFontSize: 14,
                                                          activeColor: SwitchButtonActiveColor,
                                                          inactiveColor: Color(0xD0DCDCDC),
                                                          onToggle: (newVal) async {
                                                            // setState(() {
                                                            //   data["toggle_state"] == true?null: data["toggle_state"] = newVal;
                                                            // });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 10,),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 10,),
                                                  DottedBorder(
                                                      dashPattern:  [6, 2],
                                                      strokeWidth: 1.5,
                                                      color: Constants.primaryColor1,
                                                      borderType: BorderType.RRect,
                                                      radius:  Radius.circular(2),
                                                      child:
                                                      data.itemMedia!.isEmpty ?
                                                      Image.asset("assets/image1.png",height: 84,width: 84,fit: BoxFit.fill,):
                                                      SizedBox(
                                                        height: 80,
                                                        width: 80,
                                                        child: Image.network("${Url.IMAGE_URL}${data.itemMedia!.first.file}", fit: BoxFit.fill,),
                                                      )
                                                  ),
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
                                                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
                                                    width:isMobile?width*0.39:tabWidth*0.39,
                                                    margin: EdgeInsets.only(left: 5,top: 10),
                                                    child: TextFormField(
                                                      controller: TextEditingController(text:data.price== null ?"": data.price.toString()),
                                                      readOnly: true,
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
                                                      style: Black87HintStyle,
                                                    ),
                                                  ),

                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        decoration: BoxDecoration(color: Colors.white,  borderRadius: BorderRadius.circular(5)),
                                                        width: isMobile?width*0.39:tabWidth*0.39,
                                                        margin: EdgeInsets.only(left: 1,right:0,top: 10),
                                                        child: TextFormField(
                                                          controller:  TextEditingController(text: data.unit!.name == null ?"":data.unit!.name.toString()),
                                                          readOnly: true,
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

                                                            // _searchFilterUnit(value);
                                                          },

                                                          style: Black87HintStyle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                          SizedBox(height:data.maintenancePrice != null? 10:0,),
                                          data.maintenancePrice == null || data.maintenancePrice.toString()   == ""? SizedBox():Stack(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(width: 13,),
                                                  Container(
                                                    height: 35,
                                                    decoration: BoxDecoration(color: Colors.white,  borderRadius: BorderRadius.circular(5)),
                                                    width:isMobile?width*0.39:tabWidth*0.39,
                                                    margin: EdgeInsets.only(left: 5,top: 10),
                                                    child: TextFormField(
                                                      controller: TextEditingController(text: data.maintenancePrice == null ?"":data.maintenancePrice.toString()),
                                                      readOnly: true,
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
                                                        decoration: BoxDecoration(color: Colors.white,  borderRadius: BorderRadius.circular(5)),
                                                        width: isMobile?width*0.39:tabWidth*0.39,
                                                        margin: EdgeInsets.only(left: 1,right:0,top: 10),
                                                        child: TextFormField(
                                                          controller: TextEditingController(text: data.maintenanceUnit!.name == null ?"":data.maintenanceUnit!.name.toString()),
                                                          readOnly: true,
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

                                                            // _searchFilterUnit(value);
                                                          },

                                                          style: Black87HintStyle,
                                                        ),
                                                      ),

                                                    ],
                                                  ),

                                                ],
                                              ),

                                            ],
                                          ),
                                          SizedBox(height:data.advancePrice != null ?10:0,),
                                          data.advancePrice   == null ||      data.advancePrice.toString()   == ""?  SizedBox():Stack(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(width: 13,),
                                                  Container(
                                                    height: 35,
                                                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
                                                    width:isMobile?width*0.39:tabWidth*0.39,
                                                    margin: EdgeInsets.only(left: 5,top: 10),
                                                    child: TextFormField(
                                                      controller: TextEditingController(text:data.advancePrice == null ?"": data.advancePrice!.toString()),
                                                      readOnly: true,
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
                                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                        width: isMobile?width*0.39:tabWidth*0.39,
                                                        margin: EdgeInsets.only(left: 1,right:0,top: 10),
                                                        child: TextFormField(
                                                          controller: TextEditingController(text: data.advanceUnit!.name == null ?"":data.advanceUnit!.name.toString()),
                                                          readOnly: true,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(hintText: "Enter Unit 3", fillColor:  Colors.white,
                                                            hintStyle: Constants.hintStyle,
                                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                            enabledBorder: OutlineInputBorder(borderSide:  BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),

                                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                            border: const OutlineInputBorder(),

                                                            // hintText: 'Enter Query',hintStyle: hintstyle,
                                                          ),
                                                          onChanged: (String value) async {

                                                            // _searchFilterUnit(value);
                                                          },

                                                          style: Black87HintStyle,
                                                        ),
                                                      ),

                                                    ],
                                                  ),


                                                ],
                                              ),

                                            ],
                                          ),
                                          10.height,
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap:  (){
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
                                                  width: 50,
                                                  height: 35,  margin: EdgeInsets.only(top: 10),
                                                  decoration: BoxDecoration(color:Color(0xFFeefaf7),borderRadius: BorderRadius.circular(5),border: Border.all(width: 0.5,color:  Constants.primaryColor1)),
                                                  child:
                                                  Center(child: Text( "${data.quantity}",style: BlackBottomHeadStyle18500,)),
                                                ),
                                                SizedBox(width: 5,),
                                                InkWell(
                                                  onTap: (){

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
                                          ),
                                          data.offerItemConditions!.periodicity.toString() == "" &&
                                              period == "" &&  data.offerItemConditions!.servicepersons!.isEmpty &&
                                              data.offerItemConditions!.duration.toString() == "null"|| data.offerItemConditions!.duration.toString() == "" || data.offerItemConditions!.duration == null &&
                                              data.offerItemConditions!.expiry == null &&
                                              data.offerItemConditions!.priority.toString() == "null"|| data.offerItemConditions!.priority.toString() == "" || data.offerItemConditions!.priority == null &&
                                              data.offerItemConditions!.fromlocation.toString() == "null"|| data.offerItemConditions!.fromlocation.toString() == "" || data.offerItemConditions!.fromlocation == null &&
                                              data.offerItemConditions!.tolocation.toString() == "null"|| data.offerItemConditions!.tolocation.toString() == "" || data.offerItemConditions!.tolocation == null &&
                                              data.offerItemConditions!.atlocation.toString() == "null"|| data.offerItemConditions!.atlocation.toString() == "" || data.offerItemConditions!.atlocation == null ?
                                          SizedBox(height: 12,):
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15,top:10),
                                            child: Row(
                                              children:  [
                                                const Text(" Offer’s conditions for this item", style: BlackSubTitleItalicStyle,),
                                                const SizedBox(width: 5,),
                                              ],
                                            ),
                                          ),
                                          data.offerItemConditions!.periodicity.toString() == "" &&
                                              period == "" &&  data.offerItemConditions!.servicepersons!.isEmpty &&
                                              data.offerItemConditions!.duration.toString() == "null"|| data.offerItemConditions!.duration.toString() == "" || data.offerItemConditions!.duration == null
                                              ?SizedBox():
                                          SizedBox(
                                              height: 70,
                                              width: double.infinity,
                                              child: ListView(
                                                scrollDirection: Axis.horizontal,
                                                physics: const ScrollPhysics(),
                                                shrinkWrap: false,
                                                padding: EdgeInsets.only(top:2),
                                                children: [
                                                  const SizedBox(width: 12,),
                                                  data.offerItemConditions!.periodicity.toString() == "" ?SizedBox() :   Padding(
                                                    padding: EdgeInsets.only(right:10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            margin: EdgeInsets.only(left: 5,top: 10),
                                                            child: Center(child: Text("${data.offerItemConditions!.periodicity}",style: Black87HintStyle,))
                                                        ),
                                                        const SizedBox(height:5,),
                                                        const Padding(
                                                          padding: EdgeInsets.only(left:8.0),
                                                          child: Text("Periodicity", style: BlackDescStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  period == "" ?SizedBox() :   Padding(
                                                    padding: EdgeInsets.only(right:10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            margin: EdgeInsets.only(left: 5,top: 10),
                                                            child: Center(child: Text("${period}",style: Black87HintStyle,))
                                                        ),
                                                        const SizedBox(height:5,),
                                                        const Padding(
                                                          padding: EdgeInsets.only(left:8.0),
                                                          child: Text("Period", style: BlackDescStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  data.offerItemConditions!.duration.toString() == "null"|| data.offerItemConditions!.duration.toString() == "" || data.offerItemConditions!.duration == null ? SizedBox():   Padding(
                                                    padding: EdgeInsets.only(right:10),
                                                    child: Column (
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            margin: EdgeInsets.only(left: 5,top: 10),
                                                            child: Center(child: Text("${data.offerItemConditions!.duration}",style: Black87HintStyle,))
                                                        ),
                                                        const SizedBox(height:5,),
                                                        const Padding(
                                                          padding: EdgeInsets.only(left:8.0),
                                                          child: Text("Duration(YY:MM:DD:HH:MI)", style: BlackDescStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // data.offerItemConditions!.servicepersons!.isEmpty ?SizedBox() :   Padding(
                                                  //     padding: EdgeInsets.only(right:10),
                                                  //     child:Column(
                                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                                  //       children: [
                                                  //         Container(
                                                  //             height: 35,
                                                  //             decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                  //             padding: EdgeInsets.symmetric(horizontal: 10),
                                                  //             margin: EdgeInsets.only(left: 5,top: 10),
                                                  //             child: Center(child: Text("${data.offerItemConditions!.servicepersons[0]["name"]}",style: Black87HintStyle,))
                                                  //         ),
                                                  //         const SizedBox(height:5,),
                                                  //         const Padding(
                                                  //           padding: EdgeInsets.only(left:4.0),
                                                  //           child: Text("Service/Delivery person", style: blackSText,),
                                                  //         ),
                                                  //       ],
                                                  //     )
                                                  // )
                                                ],
                                              )),

                                          data.offerItemConditions!.expiry == null &&
                                              data.offerItemConditions!.priority.toString() == "null"|| data.offerItemConditions!.priority.toString() == "" || data.offerItemConditions!.priority == null &&
                                              data.offerItemConditions!.fromlocation.toString() == "null"|| data.offerItemConditions!.fromlocation.toString() == "" || data.offerItemConditions!.fromlocation == null &&
                                              data.offerItemConditions!.tolocation.toString() == "null"|| data.offerItemConditions!.tolocation.toString() == "" || data.offerItemConditions!.tolocation == null &&
                                              data.offerItemConditions!.atlocation.toString() == "null"|| data.offerItemConditions!.atlocation.toString() == "" || data.offerItemConditions!.atlocation == null ?
                                          SizedBox():
                                          SizedBox(
                                              height: 85,
                                              width: double.infinity,
                                              child: ListView(
                                                scrollDirection: Axis.horizontal,
                                                physics: const ClampingScrollPhysics(),
                                                shrinkWrap: false,
                                                padding: EdgeInsets.only(top:2,bottom: 15),
                                                children: [
                                                  const SizedBox(width: 12,),
                                                  data.offerItemConditions!.priority.toString() == "null"|| data.offerItemConditions!.priority.toString() == "" || data.offerItemConditions!.priority == null ?SizedBox() :  Padding(padding: EdgeInsets.only(right:10), child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          height: 35,
                                                          decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                                          margin: EdgeInsets.only(left: 5,top: 10),
                                                          child: Center(child: Text("${data.offerItemConditions!.priority}",style: Black87HintStyle,))
                                                      ),
                                                      const SizedBox(height:5,),
                                                      const Padding(
                                                        padding: EdgeInsets.only(left:8.0),
                                                        child: Text("Priority", style: BlackDescStyle,),
                                                      ),
                                                    ],
                                                  ),),
                                                  data.offerItemConditions!.expiry == null ?SizedBox() :  Padding(
                                                    padding: EdgeInsets.only(right:10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            margin: EdgeInsets.only(left: 5,top: 10),
                                                            child: Center(child: Text("${data.offerItemConditions!.expiry}",style: Black87HintStyle,))
                                                        ),
                                                        const SizedBox(height:5,),
                                                        const Padding(
                                                          padding: EdgeInsets.only(left:8.0),
                                                          child: Text("Expiry", style: BlackDescStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  data.offerItemConditions!.fromlocation.toString() == "null"|| data.offerItemConditions!.fromlocation.toString() == "" || data.offerItemConditions!.fromlocation == null ?SizedBox() :  Padding(
                                                    padding: EdgeInsets.only(right:10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            margin: EdgeInsets.only(left: 5,top: 10),
                                                            child: Center(child: Text("${data.offerItemConditions!.fromlocation}",style: Black87HintStyle,))
                                                        ),
                                                        const SizedBox(height:5,),
                                                        Padding(
                                                          padding: EdgeInsets.only(left:4.0),
                                                          child: Text("From location", style: BlackDescStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  data.offerItemConditions!.tolocation.toString() == "null"|| data.offerItemConditions!.tolocation.toString() == "" || data.offerItemConditions!.tolocation == null ?SizedBox() :   Padding(
                                                    padding: EdgeInsets.only(right:10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            margin: EdgeInsets.only(left: 5,top: 10),
                                                            child: Center(child: Text("${data.offerItemConditions!.tolocation}",style: Black87HintStyle,))
                                                        ),
                                                        const SizedBox(height:5,),
                                                        Padding(
                                                          padding: EdgeInsets.only(left:4.0),
                                                          child: Text("To location", style: BlackDescStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  data.offerItemConditions!.atlocation.toString() == "null"|| data.offerItemConditions!.atlocation.toString() == "" || data.offerItemConditions!.atlocation == null ?SizedBox() :   Padding(
                                                    padding: EdgeInsets.only(right:10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            margin: EdgeInsets.only(left: 5,top: 10),
                                                            child: Center(child: Text("${data.offerItemConditions!.atlocation}",style: Black87HintStyle,))
                                                        ),
                                                        const SizedBox(height:5,),
                                                        Padding(
                                                          padding: EdgeInsets.only(left:4.0),
                                                          child: Text("At location", style: BlackDescStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  const SizedBox(width: 8,),
                                                ],
                                              )),
                                          const Divider(height: 2,thickness: 2),

                                        ],
                                      ),
                                    );
                                  },
                                )
                                    :
                                isViewingOldCounters == true ?
                                ListView.builder(
                                  itemCount:CounterOfferDetails!.offerItems!.length,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var data = CounterOfferDetails!.offerItems![index];

                                    final fromPeriodDate = data.offerItemConditions!.fromperiod== null ?"":data.offerItemConditions!.fromperiod.toString();
                                    final fromPeriodTime =data.offerItemConditions!.fromperiodtime==null?"": data.offerItemConditions!.fromperiodtime.toString();
                                    final toPeriodDate =data.offerItemConditions!.toperiod == null ?"": data.offerItemConditions!.toperiod.toString();
                                    final toPeriodTime =data.offerItemConditions!.toperiodtime == null?"": data.offerItemConditions!.toperiodtime.toString();
                                    var period = fromPeriodTime=="" && fromPeriodDate=="" && toPeriodDate=="" && toPeriodTime==""?"": toPeriodDate != "" && toPeriodTime != ""?"From "+ fromPeriodDate+" " +  fromPeriodTime +" To " + toPeriodDate +" "+toPeriodTime :"From "+ fromPeriodDate+" " +  fromPeriodTime;
                                    return Container(
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
                                                children: [
                                                  Container(
                                                    // height: 40,
                                                      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 10),
                                                      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(8)),
                                                      width: isMobile?width*0.4:tabWidth*0.4,
                                                      margin: EdgeInsets.only(left: 5,right:5,top: 10),
                                                      child: Center(child: Text("${data.name}",style: Black87HintStyle,))
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 10),
                                                      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(8)),
                                                      width: isMobile?width*0.4:tabWidth*0.4,
                                                      margin: EdgeInsets.only(left: 5,right:5,top: 10),
                                                      child: Center(child: Text("${data.desc}",style: Black87HintStyle,))
                                                  ),
                                                ],
                                              ),

                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:[
                                                  SizedBox(height: 10,),
                                                  data.required == true? Text("REQUIRED", style: PrimaryColorTitleStyle,):SizedBox() ,

                                                  data.addon == true? Padding(
                                                    padding: const EdgeInsets.only(top: 10.0),
                                                    child: Text("ADD ON", style: PrimaryColorTitleStyle,),
                                                  ):SizedBox() ,
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: Card(
                                                      elevation: 2,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: FlutterSwitch(
                                                          showOnOff: false,
                                                          value: true,
                                                          toggleSize: 20,
                                                          padding: 1,
                                                          height: 22,
                                                          width: 42,valueFontSize: 14,
                                                          activeColor: SwitchButtonActiveColor,
                                                          inactiveColor: Color(0xD0DCDCDC),
                                                          onToggle: (newVal) async {
                                                            // setState(() {
                                                            //   data["toggle_state"] == true?null: data["toggle_state"] = newVal;
                                                            // });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 10,),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 10,),
                                                  DottedBorder(
                                                      dashPattern:  [6, 2],
                                                      strokeWidth: 1.5,
                                                      color: Constants.primaryColor1,
                                                      borderType: BorderType.RRect,
                                                      radius:  Radius.circular(2),
                                                      child:
                                                      data.itemMedia!.isEmpty ?
                                                      Image.asset("assets/image1.png",height: 84,width: 84,fit: BoxFit.fill,):
                                                      SizedBox(
                                                        height: 80,
                                                        width: 80,
                                                        child: Image.network("${Url.IMAGE_URL}${data.itemMedia!.first.file}", fit: BoxFit.fill,),
                                                      )
                                                  ),
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
                                                    decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                    width:isMobile?width*0.39:tabWidth*0.39,
                                                    margin: EdgeInsets.only(left: 5,top: 10),
                                                    child: TextFormField(
                                                      controller: TextEditingController(text:data.price== null ?"": data.price.toString()),
                                                      readOnly: true,
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(hintText: "Enter Price", fillColor:  Colors.white, hintStyle: greyHintStyle,
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

                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                        width: isMobile?width*0.39:tabWidth*0.39,
                                                        margin: EdgeInsets.only(left: 1,right:0,top: 10),
                                                        child: TextFormField(
                                                          controller:  TextEditingController(text: data.unit!.name == null ?"":data.unit!.name.toString()),
                                                          readOnly: true,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(hintText: "Enter Unit", fillColor:  Colors.white,hintStyle: greyHintStyle,
                                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                            border: const OutlineInputBorder(),

                                                            // hintText: 'Enter Query',hintStyle: hintstyle,
                                                          ),
                                                          onChanged: (String value) async {

                                                            // _searchFilterUnit(value);
                                                          },

                                                          style: Black87HintStyle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                          SizedBox(height:data.maintenancePrice != null? 10:0,),
                                          data.maintenancePrice == null || data.maintenancePrice.toString()   == ""? SizedBox():Stack(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(width: 13,),
                                                  Container(
                                                    height: 35,
                                                    decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                    width:isMobile?width*0.39:tabWidth*0.39,
                                                    margin: EdgeInsets.only(left: 5,top: 10),
                                                    child: TextFormField(
                                                      controller: TextEditingController(text: data.maintenancePrice == null ?"":data.maintenancePrice.toString()),
                                                      readOnly: true,
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(hintText: "Enter maintenance Price", fillColor:  Colors.white, hintStyle: greyHintStyle,
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

                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                        width: isMobile?width*0.39:tabWidth*0.39,
                                                        margin: EdgeInsets.only(left: 1,right:0,top: 10),
                                                        child: TextFormField(
                                                          controller: TextEditingController(text: data.maintenanceUnit!.name == null ?"":data.maintenanceUnit!.name.toString()),
                                                          readOnly: true,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(hintText: "Enter maintenance Unit", fillColor:  Colors.white,hintStyle: greyHintStyle,
                                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                            border: const OutlineInputBorder(),

                                                            // hintText: 'Enter Query',hintStyle: hintstyle,
                                                          ),
                                                          onChanged: (String value) async {

                                                            // _searchFilterUnit(value);
                                                          },

                                                          style: Black87HintStyle,
                                                        ),
                                                      ),

                                                    ],
                                                  ),

                                                ],
                                              ),

                                            ],
                                          ),
                                          SizedBox(height:data.advancePrice != null ?10:0,),
                                          data.advancePrice   == null ||      data.advancePrice.toString()   == ""?  SizedBox():Stack(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(width: 13,),
                                                  Container(
                                                    height: 35,
                                                    decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                    width:isMobile?width*0.39:tabWidth*0.39,
                                                    margin: EdgeInsets.only(left: 5,top: 10),
                                                    child: TextFormField(
                                                      controller: TextEditingController(text:data.advancePrice == null ?"": data.advancePrice!.toString()),
                                                      readOnly: true,
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(hintText: "Enter advance Price", fillColor:  Colors.white, hintStyle: greyHintStyle,
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

                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                        width: isMobile?width*0.39:tabWidth*0.39,
                                                        margin: EdgeInsets.only(left: 1,right:0,top: 10),
                                                        child: TextFormField(
                                                          controller: TextEditingController(text: data.advanceUnit!.name == null ?"":data.advanceUnit!.name.toString()),
                                                          readOnly: true,
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(hintText: "Enter advance Unit", fillColor:  Colors.white,hintStyle: greyHintStyle,
                                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                                            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                            border: const OutlineInputBorder(),

                                                            // hintText: 'Enter Query',hintStyle: hintstyle,
                                                          ),
                                                          onChanged: (String value) async {

                                                            // _searchFilterUnit(value);
                                                          },

                                                          style: Black87HintStyle,
                                                        ),
                                                      ),

                                                    ],
                                                  ),


                                                ],
                                              ),

                                            ],
                                          ),
                                          10.height,
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap:  (){
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
                                                  width: 50,
                                                  height: 35,  margin: EdgeInsets.only(top: 10),
                                                  decoration: BoxDecoration(color:Color(0xFFeefaf7),borderRadius: BorderRadius.circular(5),border: Border.all(width: 0.5,color:  Constants.primaryColor1)),
                                                  child:
                                                  Center(child: Text( "${data.quantity}",style: BlackBottomHeadStyle18500,)),
                                                ),
                                                SizedBox(width: 5,),
                                                InkWell(
                                                  onTap: (){

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
                                          ),
                                          data.offerItemConditions!.periodicity.toString() == "" &&
                                              period == "" &&  data.offerItemConditions!.servicepersons!.isEmpty &&
                                              data.offerItemConditions!.duration.toString() == "null"|| data.offerItemConditions!.duration.toString() == "" || data.offerItemConditions!.duration == null &&
                                              data.offerItemConditions!.expiry == null &&
                                              data.offerItemConditions!.priority.toString() == "null"|| data.offerItemConditions!.priority.toString() == "" || data.offerItemConditions!.priority == null &&
                                              data.offerItemConditions!.fromlocation.toString() == "null"|| data.offerItemConditions!.fromlocation.toString() == "" || data.offerItemConditions!.fromlocation == null &&
                                              data.offerItemConditions!.tolocation.toString() == "null"|| data.offerItemConditions!.tolocation.toString() == "" || data.offerItemConditions!.tolocation == null &&
                                              data.offerItemConditions!.atlocation.toString() == "null"|| data.offerItemConditions!.atlocation.toString() == "" || data.offerItemConditions!.atlocation == null ?
                                          SizedBox(height: 12,):

                                          Padding(
                                            padding: const EdgeInsets.only(left: 15,top:10),
                                            child: Row(
                                              children:  [
                                                const Text(" Offer’s conditions for this item", style: BlackSubTitleItalicStyle,),
                                                const SizedBox(width: 5,),
                                              ],
                                            ),
                                          ),
                                          data.offerItemConditions!.periodicity.toString() == "" &&
                                              period == "" &&  data.offerItemConditions!.servicepersons!.isEmpty &&
                                              data.offerItemConditions!.duration.toString() == "null"|| data.offerItemConditions!.duration.toString() == "" || data.offerItemConditions!.duration == null
                                              ?SizedBox():


                                          SizedBox(
                                              height: 70,
                                              width: double.infinity,
                                              child: ListView(
                                                scrollDirection: Axis.horizontal,
                                                physics: const ScrollPhysics(),
                                                shrinkWrap: false,
                                                padding: EdgeInsets.only(top:2),
                                                children: [
                                                  const SizedBox(width: 12,),
                                                  data.offerItemConditions!.periodicity.toString() == "" ?SizedBox() :   Padding(
                                                    padding: EdgeInsets.only(right:10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            margin: EdgeInsets.only(left: 5,top: 10),
                                                            child: Center(child: Text("${data.offerItemConditions!.periodicity}",style: Black87HintStyle,))
                                                        ),
                                                        const SizedBox(height:5,),
                                                        const Padding(
                                                          padding: EdgeInsets.only(left:8.0),
                                                          child: Text("Periodicity", style: BlackDescStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  period == "" ?SizedBox() :   Padding(
                                                    padding: EdgeInsets.only(right:10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            margin: EdgeInsets.only(left: 5,top: 10),
                                                            child: Center(child: Text("${period}",style: Black87HintStyle,))
                                                        ),
                                                        const SizedBox(height:5,),
                                                        const Padding(
                                                          padding: EdgeInsets.only(left:8.0),
                                                          child: Text("Period", style: BlackDescStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  data.offerItemConditions!.duration.toString() == "null"|| data.offerItemConditions!.duration.toString() == "" || data.offerItemConditions!.duration == null ?SizedBox():   Padding(
                                                    padding: EdgeInsets.only(right:10),
                                                    child: Column (
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            margin: EdgeInsets.only(left: 5,top: 10),
                                                            child: Center(child: Text("${data.offerItemConditions!.duration}",style: Black87HintStyle,))
                                                        ),
                                                        const SizedBox(height:5,),
                                                        const Padding(
                                                          padding: EdgeInsets.only(left:8.0),
                                                          child: Text("Duration(YY:MM:DD:HH:MI)", style: BlackDescStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // data.offerItemConditions!.servicepersons!.isEmpty ?SizedBox() :   Padding(
                                                  //     padding: EdgeInsets.only(right:10),
                                                  //     child:Column(
                                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                                  //       children: [
                                                  //          Container(
                                                  //             height: 35,
                                                  //             decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                  //             padding: EdgeInsets.symmetric(horizontal: 10),
                                                  //             margin: EdgeInsets.only(left: 5,top: 10),
                                                  //             child: Center(child: Text("${data.offerItemConditions!.servicepersons[0]["name"]}",style: Black87HintStyle,))
                                                  //         ),
                                                  //         const SizedBox(height:5,),
                                                  //         const Padding(
                                                  //           padding: EdgeInsets.only(left:4.0),
                                                  //           child: Text("Service/Delivery person", style: blackSText,),
                                                  //         ),
                                                  //       ],
                                                  //     )
                                                  // )
                                                ],
                                              )),

                                          data.offerItemConditions!.expiry == null &&
                                              data.offerItemConditions!.priority.toString() == "null"|| data.offerItemConditions!.priority.toString() == "" || data.offerItemConditions!.priority == null &&
                                              data.offerItemConditions!.fromlocation.toString() == "null"|| data.offerItemConditions!.fromlocation.toString() == "" || data.offerItemConditions!.fromlocation == null &&
                                              data.offerItemConditions!.tolocation.toString() == "null"|| data.offerItemConditions!.tolocation.toString() == "" || data.offerItemConditions!.tolocation == null &&
                                              data.offerItemConditions!.atlocation.toString() == "null"|| data.offerItemConditions!.atlocation.toString() == "" || data.offerItemConditions!.atlocation == null ?
                                          SizedBox():
                                          SizedBox(
                                              height: 85,
                                              width: double.infinity,
                                              child: ListView(
                                                scrollDirection: Axis.horizontal,
                                                physics: const ClampingScrollPhysics(),
                                                shrinkWrap: false,
                                                padding: EdgeInsets.only(top:2,bottom: 15),
                                                children: [
                                                  const SizedBox(width: 12,),
                                                  data.offerItemConditions!.priority.toString() == "null"|| data.offerItemConditions!.priority.toString() == "" || data.offerItemConditions!.priority == null ?SizedBox() :  Padding(padding: EdgeInsets.only(right:10), child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          height: 35,
                                                          decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                                          margin: EdgeInsets.only(left: 5,top: 10),
                                                          child: Center(child: Text("${data.offerItemConditions!.priority}",style: Black87HintStyle,))
                                                      ),
                                                      const SizedBox(height:5,),
                                                      const Padding(
                                                        padding: EdgeInsets.only(left:8.0),
                                                        child: Text("Priority", style: BlackDescStyle,),
                                                      ),
                                                    ],
                                                  ),),
                                                  data.offerItemConditions!.expiry == null ?SizedBox() :  Padding(
                                                    padding: EdgeInsets.only(right:10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            margin: EdgeInsets.only(left: 5,top: 10),
                                                            child: Center(child: Text("${data.offerItemConditions!.expiry}",style: Black87HintStyle,))
                                                        ),
                                                        const SizedBox(height:5,),
                                                        const Padding(
                                                          padding: EdgeInsets.only(left:8.0),
                                                          child: Text("Expiry", style: BlackDescStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  data.offerItemConditions!.fromlocation.toString() == "null"|| data.offerItemConditions!.fromlocation.toString() == "" || data.offerItemConditions!.fromlocation == null ?SizedBox()  :  Padding(
                                                    padding: EdgeInsets.only(right:10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            margin: EdgeInsets.only(left: 5,top: 10),
                                                            child: Center(child: Text("${data.offerItemConditions!.fromlocation}",style: Black87HintStyle,))
                                                        ),
                                                        const SizedBox(height:5,),
                                                        Padding(
                                                          padding: EdgeInsets.only(left:4.0),
                                                          child: Text("From location", style: BlackDescStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  data.offerItemConditions!.tolocation.toString() == "null"|| data.offerItemConditions!.tolocation.toString() == "" || data.offerItemConditions!.tolocation == null ?SizedBox() :   Padding(
                                                    padding: EdgeInsets.only(right:10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            margin: EdgeInsets.only(left: 5,top: 10),
                                                            child: Center(child: Text("${data.offerItemConditions!.tolocation}",style: Black87HintStyle,))
                                                        ),
                                                        const SizedBox(height:5,),
                                                        Padding(
                                                          padding: EdgeInsets.only(left:4.0),
                                                          child: Text("To location", style: BlackDescStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  data.offerItemConditions!.atlocation.toString() == "null"|| data.offerItemConditions!.atlocation.toString() == "" || data.offerItemConditions!.atlocation == null ?SizedBox() :    Padding(
                                                    padding: EdgeInsets.only(right:10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 3.0, color: Colors.grey),], borderRadius: BorderRadius.circular(5)),
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            margin: EdgeInsets.only(left: 5,top: 10),
                                                            child: Center(child: Text("${data.offerItemConditions!.atlocation}",style: Black87HintStyle,))
                                                        ),
                                                        const SizedBox(height:5,),
                                                        Padding(
                                                          padding: EdgeInsets.only(left:4.0),
                                                          child: Text("At location", style: BlackDescStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  const SizedBox(width: 8,),
                                                ],
                                              )),
                                          const Divider(height: 2,thickness: 2),

                                        ],
                                      ),
                                    );
                                  },
                                ):
                                ListView.builder(
                                  itemCount:ItemsList.length,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var data = ItemsList[index];
                                    final startTime =data["create_date"].toString().trim() == "new" ?DateTime.now(): DateFormat('dd-MM-yyyy HH:mm').parse('${data["create_date"].toString().trim() }');
                                    final currentTime = DateFormat('dd-MM-yyyy HH:mm').parse('${OfferCounterData!.createdAt.toString().trim()}');
                                    final diff_dm = startTime.difference(currentTime).inMinutes;
                                    return data["quantity"] == 0 ?SizedBox():
                                    Container(
                                      color:data["ExecuteSwitch"]  == false?  Colors.white:primaryColor10,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 10,),
                                              Column(
                                                children: [
                                                  selectedTap.toString().toUpperCase().trim() == "EXECUTE" ||
                                                      selectedTap.toString().toUpperCase().trim() == "SIGN-OFF"?
                                                  Container(
                                                    margin: EdgeInsets.only(left: 5,right:5,top: 10),
                                                    width: isMobile?width*0.4:tabWidth*0.4,
                                                    child:Text("${data["name"].text}",style: BlackFieldStyleBold,) ,
                                                  )
                                                      :
                                                  Stack(
                                                    children: [
                                                      Container(

                                                        height: data["name"].text.length < 15 ?35:null,
                                                        decoration: BoxDecoration(
                                                            color: Constants.white,
                                                            borderRadius: BorderRadius.circular(5)), width: isMobile?width*0.4:tabWidth*0.4,
                                                        margin: EdgeInsets.only(left: 5,right:5,top: 10),
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints(
                                                              maxHeight: 150.0
                                                          ),
                                                          child: TextFormField(
                                                            controller: data["name"],
                                                            maxLines: null,
                                                            readOnly: isModifyCounterOffer?
                                                            data["create_date"].toString().trim() == "new"?false:
                                                            diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                            false:true
                                                                : index <= OfferCounterData!.offerItems!.length-1? true:false,
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
                                                            style: Black87HintStyle,),
                                                        ),
                                                      ),
                                                      index==0?Positioned(
                                                        top:10,right:0,
                                                        child: InkWell(
                                                          onTap:(){
                                                            setState((){
                                                              requiredItemPriceIsEmpty.add(false);
                                                              List selectedItemsPersonList = [];
                                                              List<UnitListData> TempUnitList = [];
                                                              ItemsList.add({
                                                                "itemType" :"New",
                                                                "ExecuteSwitch": false,
                                                                "ItemId": "",
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
                                                                "toggle_state":false,
                                                                "media":[],
                                                                "isLoadingFile":false,
                                                                "fileUrl":[],
                                                                "itemConditionView" :false,
                                                                "create_date": "new",
                                                                "CreatorUserId" : DataManager.getInstance().userId.toString(),
                                                                "showItemPrice2":false,
                                                                "showItemPrice3":false,
                                                                "item_condition":{
                                                                  "ItemConditionId": "",
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
                                                                  "period": TextEditingController(),
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
                                                                  "expiry":TextEditingController(text: ""),
                                                                }
                                                              });
                                                            });
                                                          },
                                                          child: CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor: primaryColor,
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
                                                          child:index <= OfferCounterData!.offerItems!.length-1? SizedBox(): CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor: primaryColor,
                                                            child: Center(
                                                              child: Icon(Icons.remove, color: Colors.white, size: 20),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  selectedTap.toString().toUpperCase().trim() == "EXECUTE" ||
                                                      selectedTap.toString().toUpperCase().trim() == "SIGN-OFF"?
                                                  Container(
                                                    margin: EdgeInsets.only(left: 5,right:5,top: 0),
                                                    width: isMobile?width*0.4:tabWidth*0.4,
                                                    child:Text("${data["desc"].text}",style: Black87DescStyle,) ,
                                                  )
                                                      :
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        maxHeight: 150.0
                                                    ),
                                                    child: Container(
                                                      height: data["desc"].text.length < 15 ?35:null,
                                                      width: isMobile?width*0.4:tabWidth*0.4,
                                                      decoration: BoxDecoration(
                                                          color: Constants.white,
                                                          borderRadius: BorderRadius.circular(5)),
                                                      margin: EdgeInsets.only(left: 0,right:5,top: 10),
                                                      child: TextFormField(
                                                        controller: data["desc"],
                                                        maxLines: null,
                                                        readOnly: isModifyCounterOffer?
                                                        data["create_date"].toString().trim() == "new"?false:
                                                        diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                        false:true
                                                            : index <= OfferCounterData!.offerItems!.length-1? true:false,
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
                                                  isModifyCounterOffer?
                                                  data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                  InkWell(
                                                      onTap:(){
                                                        setState(() {
                                                          data["required"] = !data["required"];
                                                          Constants.showToast( data["required"]  == true ?"REQUIRED Enabled":"REQUIRED Disabled");
                                                        });
                                                      },
                                                      child: Text("REQUIRED", style: TextStyle(color:data["required"] ==true?primaryColor: Colors.black38, fontWeight:data["required"] ==true ?FontWeight.w700:FontWeight.w500, fontSize: 14),)):
                                                  data["required"] == true? Text("REQUIRED", style: PrimaryColorTitleStyle,):SizedBox():
                                                  data["itemType"] == "Old"? data["required"] == true? Text("REQUIRED", style: PrimaryColorTitleStyle,):SizedBox() :
                                                  InkWell(
                                                      onTap:(){
                                                        setState(() {
                                                          data["required"] = !data["required"];
                                                          Constants.showToast( data["required"]  == true ?"REQUIRED Enabled":"REQUIRED Disabled");
                                                        });
                                                      },
                                                      child: Text("REQUIRED", style: TextStyle(color:data["required"] ==true?primaryColor: Colors.black38, fontWeight:data["required"] ==true ?FontWeight.w700:FontWeight.w500, fontSize: 14),)),

                                                  isModifyCounterOffer?
                                                  data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                  InkWell(
                                                      onTap:(){
                                                        setState(() {
                                                          data["addon"] = !data["addon"];
                                                          Constants.showToast( data["addon"]  == true ?"ADDON Enabled":"ADDON Disabled");
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 10.0),
                                                        child: Text("ADD ON", style: TextStyle(color: data["addon"] == true?primaryColor: Colors.black38, fontWeight:data["addon"] ==true ?FontWeight.w700: FontWeight.w500, fontSize: 14), ),
                                                      )):data["addon"] == true?   Padding(
                                                    padding: const EdgeInsets.only(top: 10.0),
                                                    child: Text("ADD ON", style: PrimaryColorTitleStyle, ),
                                                  ):SizedBox():
                                                  data["itemType"] == "Old"?  data["addon"] == true?   Padding(
                                                    padding: const EdgeInsets.only(top: 10.0),
                                                    child: Text("ADD ON", style: PrimaryColorTitleStyle, ),
                                                  ):SizedBox():
                                                  InkWell(
                                                      onTap:(){
                                                        setState(() {
                                                          data["addon"] = !data["addon"];
                                                          Constants.showToast( data["addon"]  == true ?"ADDON Enabled":"ADDON Disabled");
                                                        });
                                                      },
                                                      child: Text("ADD ON", style: TextStyle(color: data["addon"] == true?primaryColor: Colors.black38, fontWeight:data["addon"] ==true ?FontWeight.w700: FontWeight.w500, fontSize: 14), )),
                                                  data["addon"] == true?   SizedBox(height: 7,):SizedBox(),

                                                  selectedTap.toString().toUpperCase().trim() == "EXECUTE" ?SizedBox():
                                                  isModifyCounterOffer?
                                                  data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?  SizedBox():
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: Card(
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
                                                          activeColor: SwitchButtonActiveColor,
                                                          inactiveColor: Color(0xD0DCDCDC),
                                                          onToggle: (newVal) async {
                                                            setState(() {
                                                              data["toggle_state"] == true?null: data["toggle_state"] = newVal;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ):
                                                  data["itemType"] == "Old"?
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: Card(
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
                                                          activeColor: SwitchButtonActiveColor,
                                                          inactiveColor: Color(0xD0DCDCDC),
                                                          onToggle: (newVal) async {
                                                            setState(() {
                                                              data["toggle_state"] == true?null: data["toggle_state"] = newVal;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ):SizedBox(),

                                                  selectedTap.toString().toUpperCase().trim() == "EXECUTE" ?
                                                  data["ExecuteSwitch"]  == false ?
                                                  InkWell(
                                                      onTap:(){
                                                                print( OfferCounterData!.offerConditions!.fromperiod );
                                                                print(OfferCounterData!.offerConditions!.fromperiodtime);
                                                             if( OfferCounterData!.offerConditions!.fromperiod == null || OfferCounterData!.offerConditions!.fromperiod.toString() == "null" || OfferCounterData!.offerConditions!.fromperiod.toString() == ""){
                                                               ExecutionReddy[index] = true;
                                                               var ExecuteItemParam = {
                                                                 "counter_id": OfferCounterData!.id.toString(),
                                                                 "item_id": data["ItemId"],
                                                               };
                                                               DrawAuraAPi.CreateDataApi(ApiEndPoint: "exicuteOfferItem",body: ExecuteItemParam);
                                                               var body = {
                                                                 "message" : "ALERT: ",
                                                                 "from_user" : DataManager.getInstance().getuserId().toString(),
                                                                 "to_user" : OfferCounterData!.toCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() ? OfferCounterData!.toCounter!.id.toString().trim(): OfferCounterData!.fromCounter!.id.toString().trim(),
                                                                 "offer_id" : OfferCounterData!.offer!.id.toString(),
                                                                 "counter_id" : OfferCounterData!.id.toString(),
                                                                 "type" : "ItemSelected",
                                                                 "message" : "Checked ${data["name"].text}",
                                                               };
                                                               DrawAuraAPi.CreateDataApi(ApiEndPoint: "sendPushNotification",body: body).then((value) {
                                                                 if(value["status"] == "200"){
                                                                   Constants.showToast("Item Checked!");
                                                                 }
                                                               });
                                                               setState(() {
                                                                 data["ExecuteSwitch"] = true;
                                                               });
                                                             }else{
                                                               DateTime OPeriodDate = OfferCounterData!.offerConditions!.fromperiodtime == null || OfferCounterData!.offerConditions!.fromperiodtime.toString() == "null" || OfferCounterData!.offerConditions!.fromperiodtime.toString() == ""?
                                                               DateFormat('dd/MM/yyyy HH:mm:ss').parse('${  OfferCounterData!.offerConditions!.fromperiod.toString().replaceAll("-","/")} 00:00:00'):
                                                               DateFormat('dd/MM/yyyy HH:mm:ss').parse('${  OfferCounterData!.offerConditions!.fromperiod.toString().replaceAll("-","/")} ${OfferCounterData!.offerConditions!.fromperiodtime}');
                                                               bool isOldDate = OPeriodDate.isBefore(DateTime.now());
                                                               print("isOldDate");
                                                               print(isOldDate);
                                                               if(isOldDate){
                                                                 ExecutionReddy[index] = true;
                                                                 var ExecuteItemParam = {
                                                                   "counter_id": OfferCounterData!.id.toString(),
                                                                   "item_id": data["ItemId"],
                                                                 };
                                                                 DrawAuraAPi.CreateDataApi(ApiEndPoint: "exicuteOfferItem",body: ExecuteItemParam);
                                                                 var body = {
                                                                   "message" : "ALERT: ",
                                                                   "from_user" : DataManager.getInstance().getuserId().toString(),
                                                                   "to_user" : OfferCounterData!.toCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() ? OfferCounterData!.toCounter!.id.toString().trim(): OfferCounterData!.fromCounter!.id.toString().trim(),
                                                                   "offer_id" : OfferCounterData!.offer!.id.toString(),
                                                                   "counter_id" : OfferCounterData!.id.toString(),
                                                                   "type" : "ItemSelected",
                                                                   "message" : "Checked ${data["name"].text}",
                                                                 };
                                                                 DrawAuraAPi.CreateDataApi(ApiEndPoint: "sendPushNotification",body: body).then((value) {
                                                                   if(value["status"] == "200"){
                                                                     Constants.showToast("Item Checked!");
                                                                   }
                                                                 });
                                                                 setState(() {
                                                                   data["ExecuteSwitch"] = true;
                                                                 });
                                                               }else{
                                                                 Constants.showToast("${Url.NotExecuteMessage}");
                                                               }
                                                             }


                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(top:15),
                                                        padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 4),
                                                        decoration: BoxDecoration(
                                                            color:primaryColor,
                                                            borderRadius: BorderRadius.circular(5)
                                                        ),
                                                        child: Text( "EXECUTE",style: WhiteSubTitleStyle,),
                                                      )) :
                                                  InkWell(
                                                      onTap:(){
                                                        Constants.showToastAtBottom("Already Executed");
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top:15.0),
                                                        child: Text( "EXECUTED",style: grey14700,),
                                                      )):SizedBox()
                                                  // Card(
                                                  //   elevation: 2,
                                                  //   shape: RoundedRectangleBorder(
                                                  //       borderRadius: BorderRadius.circular(5)
                                                  //   ),
                                                  //   child: Padding(
                                                  //     padding: const EdgeInsets.all(5.0),
                                                  //     child: FlutterSwitch(
                                                  //       showOnOff: false,
                                                  //       value: data["ExecuteSwitch"] ,
                                                  //       toggleSize: 20,
                                                  //       padding: 1,
                                                  //       height: 22,
                                                  //       width: 42,valueFontSize: 14,
                                                  //       activeColor: SwitchButtonActiveColor,
                                                  //       inactiveColor: Color(0xD0DCDCDC),
                                                  //       onToggle: (newVal) async {
                                                  //
                                                  //         if(data["ExecuteSwitch"] == true){
                                                  //           // setState(() {
                                                  //           //   data["ExecuteSwitch"] = newVal;
                                                  //           //   TempAlertNotify.clear();
                                                  //           // });
                                                  //         }else{
                                                  //           var ExecuteItemParam = {
                                                  //
                                                  //             "counter_id": OfferCounterData!.id.toString(),
                                                  //             "item_id": data["ItemId"],
                                                  //
                                                  //           };
                                                  //           print(ExecuteItemParam);
                                                  //           DrawAuraAPi.CreateDataApi(ApiEndPoint: "exicuteOfferItem",body: ExecuteItemParam).then((value) {
                                                  //
                                                  //             if(value["status"] == "200"){
                                                  //
                                                  //             }
                                                  //           });
                                                  //
                                                  //           var body = {
                                                  //             "from_user" : DataManager.getInstance().getuserId().toString(),
                                                  //             "to_user" : OfferCounterData!.toCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() ? OfferCounterData!.toCounter!.id.toString().trim(): OfferCounterData!.fromCounter!.id.toString().trim(),
                                                  //             "offer_id" : OfferCounterData!.offer!.id.toString(),
                                                  //             "counter_id" : OfferCounterData!.id.toString(),
                                                  //             "type" : "ItemSelected",
                                                  //             "message" : "Checked ${data["name"].text}",
                                                  //           };
                                                  //           print(body);
                                                  //           DrawAuraAPi.CreateDataApi(ApiEndPoint: "sendPushNotification",body: body).then((value) {
                                                  //
                                                  //             if(value["status"] == "200"){
                                                  //               setState(() {
                                                  //                 TempAlertNotify.add("Checked ${data["name"].text}");
                                                  //               });
                                                  //               Constants.showToast("Item Checked!");
                                                  //             }
                                                  //           });
                                                  //           setState(() {
                                                  //             data["ExecuteSwitch"] = newVal;
                                                  //           });
                                                  //
                                                  //         }
                                                  //
                                                  //
                                                  //       },
                                                  //     ),
                                                  //   ),
                                                  // ):SizedBox(),
                                                ],
                                              ),
                                              const SizedBox(width: 10,),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 10,),
                                                  isModifyCounterOffer?
                                                  data["create_date"].toString().trim() == "new"?
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
                                                                      color: Constants.closeOfferCard,
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
                                                  ):
                                                  diff_dm == 0 || diff_dm == -1 || diff_dm == 1?
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
                                                                          :SizedBox()
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
                                                                      color: Constants.closeOfferCard,
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
                                                  ):
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
                                                  )
                                                      : index <= OfferCounterData!.offerItems!.length-1?
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
                                                                      color: Constants.closeOfferCard,
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

                                                ],
                                              ),
                                              const SizedBox(width: 15,),
                                            ],
                                          ),

                                          selectedTap.toString().toUpperCase().trim() == "EXECUTE" ||
                                              selectedTap.toString().toUpperCase().trim() == "SIGN-OFF"?
                                          Container(
                                            margin: EdgeInsets.only(left: 15,right:5,top: 0),
                                            width: isMobile?width:tabWidth,
                                            child:Text("Rs. ${data["price"].text} ${ data["unit"].text}",style: BlackFieldStyleBold,) ,
                                          )
                                              :
                                          Padding(
                                            padding: const EdgeInsets.only(top:15.0),
                                            child: Stack(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(width: 13,),
                                                    Container(
                                                      height: 35,
                                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                      width:isMobile?width*0.39:tabWidth*0.39,
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
                                                        style: Black87HintStyle,
                                                        onChanged: (v){
                                                          if(v.toString() == "" || v.isEmpty){
                                                            setState((){
                                                              requiredItemPriceIsEmpty[index] = true;
                                                            });
                                                          }else{
                                                            setState((){
                                                              requiredItemPriceIsEmpty[index] = false;
                                                            });
                                                          }
                                                        },
                                                      ),
                                                    ),

                                                    Column(
                                                      children: [
                                                        Container(
                                                          height: 35,
                                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                          width: isMobile?width*0.39:tabWidth*0.39,
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
                                                          width:isMobile?width*0.39:tabWidth*0.39,
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
                                                            width: isMobile?width*0.12:tabWidth*0.12,
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
                                                  left: isMobile?width*0.42:tabWidth*0.41,
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
                                          ),
                                          selectedTap.toString().toUpperCase().trim() == "EXECUTE" ||
                                              selectedTap.toString().toUpperCase().trim() == "SIGN-OFF"?
                                          data["MaintenancePrice"].text.isEmpty ?SizedBox():
                                          Container(
                                            margin: EdgeInsets.only(left: 15,right:5,top: 5),
                                            width: isMobile?width:tabWidth,
                                            child:Text("Rs. ${data["MaintenancePrice"].text} ${ data["MaintenanceUnit"].text}",style: BlackFieldStyleBold,) ,
                                          )
                                              :

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
                                                    width:isMobile?width*0.39:tabWidth*0.39,
                                                    margin: EdgeInsets.only(left: 5,top: 10),
                                                    child: TextFormField(
                                                      controller: data["MaintenancePrice"],
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(hintText: "Enter Price 2", fillColor:  Colors.white, hintStyle: Constants.hintStyle,
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
                                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                        width: isMobile?width*0.39:tabWidth*0.39,
                                                        margin: EdgeInsets.only(left: 1,right:0,top: 10),
                                                        child: TextFormField(
                                                          controller: data["MaintenanceUnit"],
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(hintText: "Enter Unit 2", fillColor:  Colors.white,hintStyle: Constants.hintStyle,
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
                                                        width:isMobile?width*0.39:tabWidth*0.39,
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
                                                                backgroundColor:Constants.primaryColor1,
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
                                                          width: isMobile?width*0.12:tabWidth*0.12,
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
                                                left: isMobile?width*0.42:tabWidth*0.41,
                                                child: InkWell(
                                                  onTap:(){
                                                    setState(() {
                                                      data["showItemPrice2"] = false;
                                                    });
                                                  },
                                                  child: const CircleAvatar(
                                                    radius: 9,
                                                    backgroundColor:primaryColor,
                                                    child: Center(
                                                      child: Icon(Icons.remove, color: Colors.white, size: 18),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox(),

                                          selectedTap.toString().toUpperCase().trim() == "EXECUTE" ||
                                              selectedTap.toString().toUpperCase().trim() == "SIGN-OFF"?
                                          data["AdvancePrice"].text.isEmpty ?SizedBox():
                                          Container(
                                            margin: EdgeInsets.only(left: 15,right:5,top: 5),
                                            width: isMobile?width:tabWidth,
                                            child:Text("Rs. ${data["AdvancePrice"].text} ${ data["AdvanceUnit"].text}",style: BlackFieldStyleBold,) ,
                                          ):
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
                                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                    width:isMobile?width*0.39:tabWidth*0.39,
                                                    margin: EdgeInsets.only(left: 5,top: 10),
                                                    child: TextFormField(
                                                      controller: data["AdvancePrice"],
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(hintText: "Enter Price 3", fillColor:  Colors.white,hintStyle: Constants.hintStyle,
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
                                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                        width: isMobile?width*0.39:tabWidth*0.39,
                                                        margin: EdgeInsets.only(left: 1,right:0,top: 10),
                                                        child: TextFormField(
                                                          controller: data["AdvanceUnit"],
                                                          keyboardType: TextInputType.text,
                                                          decoration: InputDecoration(hintText: "Enter Unit 3", fillColor:  Colors.white,hintStyle: Constants.hintStyle,
                                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                            enabledBorder: OutlineInputBorder(borderSide:  BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),

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
                                                        width:isMobile?width*0.39:tabWidth*0.39,
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
                                                          width: isMobile?width*0.12:tabWidth*0.12,
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
                                                left:isMobile?width*0.42:tabWidth*0.41,
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
                                          selectedTap.toString().toUpperCase().trim() == "EXECUTE" ||
                                              selectedTap.toString().toUpperCase().trim() == "SIGN-OFF"?
                                          Container(
                                            margin: EdgeInsets.only(left: 15,right:5,top: 5),
                                            width: isMobile?width:tabWidth,
                                            child:Text("Qty : ${data["quantity"]}",style: BlackFieldStyleBold,) ,
                                          )
                                              :
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
                                                    data["quantity"] ++;
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
                                          selectedTap.toString().toUpperCase().trim() == "EXECUTE" ||
                                              selectedTap.toString().toUpperCase().trim() == "SIGN-OFF"?SizedBox():
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
                                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
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
                                                  ):index <= OfferCounterData!.offerItems!.length-1? SizedBox(): CircleAvatar(
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
                                                  data["item_condition"]["periodicityView"] ==true ?  Padding(
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
                                                                value: data["item_condition"]["periodicity"]==""?null:data["item_condition"]["periodicity"],
                                                                onChanged:
                                                                isModifyCounterOffer?
                                                                data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                                    (newValue) {
                                                                  setState(() {
                                                                    data["item_condition"]["periodicity"] = newValue!;
                                                                  });
                                                                }:null:
                                                                index <= OfferCounterData!.offerItems!.length-1? null: (newValue) {
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
                                                                    width: isMobile?width * 0.38:tabWidth*0.38,
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
                                                                      width: isMobile?width * 0.38:tabWidth*0.38,
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
                                                                  width: isMobile?width * 0.38:tabWidth*0.38,
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
                                                            isModifyCounterOffer?
                                                            data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                            Positioned(
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
                                                                )):SizedBox():
                                                            index <= OfferCounterData!.offerItems!.length-1? SizedBox():   Positioned(
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
                                                              width: isMobile?width*0.55:tabWidth*0.55,
                                                              child: TextFormField(
                                                                controller: data["item_condition"]["period"],
                                                                readOnly: true,
                                                                onTap:
                                                                isModifyCounterOffer?
                                                                data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                                    (){
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
                                                                                data["item_condition"]["duration"].text  =
                                                                                years != 0 && months != 0 && days !=0?
                                                                                "$years Years $months Months  $days Days":
                                                                                months != 0 && days !=0 ? "$months Months  $days Days":
                                                                                years != 0 && months == 0 && days !=0? "$years Years  $days Days":
                                                                                years != 0 && months != 0 && days ==0? "$years Years  $months Months":
                                                                                years != 0 && months == 0 && days !=0? "$years Years  $days Days":"$days Days";
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

                                                                }:null:
                                                                index <= OfferCounterData!.offerItems!.length-1? null:(){
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
                                                                                data["item_condition"]["duration"].text  =
                                                                                years != 0 && months != 0 && days !=0?
                                                                                "$years Years $months Months  $days Days":
                                                                                months != 0 && days !=0 ? "$months Months  $days Days":
                                                                                years != 0 && months == 0 && days !=0? "$years Years  $days Days":
                                                                                years != 0 && months != 0 && days ==0? "$years Years  $months Months":
                                                                                years != 0 && months == 0 && days !=0? "$years Years  $days Days":"$days Days";
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
                                                            isModifyCounterOffer?
                                                            data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                            Positioned(
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
                                                                )):SizedBox():
                                                            index <= OfferCounterData!.offerItems!.length-1?SizedBox():     Positioned(
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
                                                              width: isMobile?width*0.45:tabWidth*0.45,
                                                              child: TextFormField(
                                                                inputFormatters: [maskFormatter],
                                                                controller:  data["item_condition"]["duration"],
                                                                keyboardType: TextInputType.number,
                                                                onTap:(){
                                                                  if(isModifyCounterOffer) {
                                                                    if (data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 || diff_dm == 1) {
                                                                      if (isItemSinglePeriodSelect == true) {
                                                                        showDurationPicker(context, setState, data["item_condition"]["duration"]);
                                                                      }
                                                                    }
                                                                  }else if(index <= OfferCounterData!.offerItems!.length-1){

                                                                  }else if(isItemSinglePeriodSelect==true){
                                                                    showDurationPicker(context, setState, data["item_condition"]["duration"]);
                                                                  }
                                                                },
                                                                //readOnly: isSinglePeriodSelect==true?false:true,
                                                                readOnly: true,
                                                                onFieldSubmitted: (value){
                                                                  print(value);
                                                                  String empty = "";
                                                                  int years =  value.length < 2 ?int.parse(value) :int.parse(value.split(":").first);
                                                                  int months =  value.length > 3 ?int.parse(value.split(":")[1]):0;
                                                                  int days =  value.length > 5 ?int.parse(value.split(":")[2]):0;
                                                                  int hours =  value.length > 7 ?int.parse(value.split(":")[3]):0;
                                                                  int min =  value.length > 9 ?int.parse(value.split(":")[4]):0;
                                                                  setState(() {
                                                                    data["item_condition"]["duration"].text ="${years != 0 ? '${years} Year(s)': empty} ${ months != 0 ? '${months} Month(s)': empty } ${days != 0 ?'${days} Day(s)': empty } ${ hours != 0 ?'${hours} Hour(s)': empty } ${ min != 0 ?'${min} Minute(s)': empty}";
                                                                  });
                                                                  print( data["item_condition"]["duration"].text);
                                                                },
                                                                // readOnly:
                                                                // isModifyCounterOffer?
                                                                // data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                                // isItemSinglePeriodSelect==true?false:true:true:
                                                                // index <= OfferCounterData!.offerItems!.length-1? true: isItemSinglePeriodSelect==true?false:true,
                                                                decoration: InputDecoration(hintText: "YY : MM : DD : HH : MI", fillColor:  Colors.white, hintStyle:greyHintStyle,
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
                                                            isModifyCounterOffer?
                                                            data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                            Positioned(
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
                                                                )):SizedBox():
                                                            index <= OfferCounterData!.offerItems!.length-1?SizedBox():     Positioned(
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
                                                  data["item_condition"]["isServicePersonView"]==true?    data["fillSelectedPerson"].isEmpty && data["itemType"] == "Old" ?SizedBox():  Column(
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
                                                  data["item_condition"]["priorityView"]==true?  Padding(padding: EdgeInsets.only(right:10), child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          DropdownButtonHideUnderline(
                                                            child: DropdownButton2(
                                                              isExpanded: true,
                                                              items:priority.map((item) => DropdownMenuItem (
                                                                value: item,
                                                                child: Text(item, style:  BlackSubHeadingStyle, overflow: TextOverflow.ellipsis,),
                                                              )).toList(),
                                                              value:  data["item_condition"]["priority"]==""?null: data["item_condition"]["priority"],
                                                              onChanged:
                                                              isModifyCounterOffer?
                                                              data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                                  (newValue) {
                                                                setState(() {
                                                                  data["item_condition"]["priority"] = newValue!;
                                                                });
                                                              }:null:
                                                              index <= OfferCounterData!.offerItems!.length-1? null: (newValue) {
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
                                                                  width: isMobile?width * 0.35:tabWidth*0.35,
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
                                                                    width: isMobile?width * 0.3:tabWidth*0.3,
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
                                                                width: isMobile?width * 0.35:tabWidth*0.35,
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

                                                          isModifyCounterOffer?
                                                          data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                          Positioned(
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
                                                              )):SizedBox():
                                                          index <= OfferCounterData!.offerItems!.length-1?SizedBox():     Positioned(
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
                                                              width: isMobile?width*0.35:tabWidth*0.35,
                                                              child: TextFormField(
                                                                onTap:
                                                                isModifyCounterOffer?
                                                                data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                                    (){
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
                                                                                                  style: BlackSubTitleStyle,
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
                                                                }:null:
                                                                index <= OfferCounterData!.offerItems!.length-1? null:(){
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
                                                                                                  style: BlackFieldStyle,
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
                                                            isModifyCounterOffer?
                                                            data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                            Positioned(
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
                                                                )):SizedBox():
                                                            index <= OfferCounterData!.offerItems!.length-1?SizedBox(): Positioned(
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
                                                              width: isMobile?width*0.45:tabWidth*0.45,
                                                              child: TextFormField(
                                                                controller:  data["item_condition"]["fromlocation"],
                                                                onTap:
                                                                isModifyCounterOffer?
                                                                data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                                    () async {
                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201),isAppPlaceView: true,isTitleSelectAsAddress: true ))).then((value) {
                                                                    setState(() {
                                                                      data["item_condition"]["fromlocation"].text=value.toString();
                                                                    });
                                                                  });

                                                                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => placepick(title: "Place picker"),));
                                                                }:null:
                                                                index <= OfferCounterData!.offerItems!.length-1? null:() async {

                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201),isAppPlaceView: true,isTitleSelectAsAddress: true ))).then((value) {
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
                                                            isModifyCounterOffer?
                                                            data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                            Positioned(
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
                                                                )):SizedBox():
                                                            index <= OfferCounterData!.offerItems!.length-1?SizedBox():      Positioned(
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

                                                            isModifyCounterOffer?
                                                            data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                            data["item_condition"]["tolocationView"]==true?SizedBox(): Positioned(
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
                                                                )):SizedBox():
                                                            index <= OfferCounterData!.offerItems!.length-1?SizedBox(): data["item_condition"]["tolocationView"]==true?SizedBox(): Positioned(
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
                                                              width: isMobile?width*0.45:tabWidth*0.45,
                                                              child: TextFormField(
                                                                controller:  data["item_condition"]["tolocation"],
                                                                onTap:
                                                                isModifyCounterOffer?
                                                                data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                                    () async {
                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201),isAppPlaceView: true ,isTitleSelectAsAddress: true))).then((value) {
                                                                    setState(() {
                                                                      data["item_condition"]["tolocation"].text=value.toString();
                                                                    });
                                                                  });


                                                                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => placepick(title: "Place picker"),));
                                                                }:null
                                                                    :index <= OfferCounterData!.offerItems!.length-1? null:() async {

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

                                                            isModifyCounterOffer?
                                                            data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                            Positioned(
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
                                                                )):SizedBox():
                                                            index <= OfferCounterData!.offerItems!.length-1?SizedBox():   Positioned(
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

                                                            isModifyCounterOffer?
                                                            data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                            data["item_condition"]["atlocationView"] ==true?SizedBox():  Positioned(
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
                                                                )):SizedBox():
                                                            index <= OfferCounterData!.offerItems!.length-1?SizedBox():   data["item_condition"]["atlocationView"] ==true?SizedBox():  Positioned(
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
                                                              width: isMobile?width*0.45:tabWidth*0.45,
                                                              child: TextFormField(
                                                                controller:  data["item_condition"]["atlocation"],
                                                                onTap:
                                                                isModifyCounterOffer?
                                                                data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                                    () async {

                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201),isAppPlaceView: true ,isTitleSelectAsAddress: true))).then((value) {
                                                                    setState(() {
                                                                      data["item_condition"]["atlocation"].text=value.toString();
                                                                    });
                                                                  });


                                                                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => placepick(title: "Place picker"),));
                                                                }:null:
                                                                index <=OfferCounterData!.offerItems!.length-1? null:() async {
                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201),isAppPlaceView: true ,isTitleSelectAsAddress: true))).then((value) {
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
                                                            isModifyCounterOffer?
                                                            data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                            Positioned(
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
                                                                )):SizedBox():
                                                            index <= OfferCounterData!.offerItems!.length-1?SizedBox():   Positioned(
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

                                                            isModifyCounterOffer?
                                                            data["create_date"].toString().trim() == "new" || diff_dm == 0 || diff_dm == -1 ||diff_dm == 1?
                                                            Positioned(
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
                                                                )):SizedBox():
                                                            index <= OfferCounterData!.offerItems!.length-1?SizedBox():    Positioned(
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

                                isCurrentTab == 0?
                                Container(
                                  width: isMobile ?width:tabWidth,
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
                                        itemCount:MainOfferBids.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var data = MainOfferBids[index];
                                          return Row(
                                            mainAxisAlignment:data.fromCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()? MainAxisAlignment.start:MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: isMobile?width*0.8:tabWidth*0.8,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(right:10.0,bottom: 5),
                                                      child: Text(data.fromCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()?"${data.fromCounter!.displayname.toString()}":"You",style: BlackTitleItalicStyle,),
                                                    ),
                                                    Container(
                                                        height: 35,
                                                        padding: EdgeInsets.only(left:8,right:8),
                                                        margin: EdgeInsets.only(left:10,right:10),
                                                        decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                          BoxShadow(
                                                              blurRadius: 0.0,
                                                              color: Colors.black54,
                                                              offset: Offset(0.0, 0.5) ),
                                                        ], borderRadius: BorderRadius.circular(5)),
                                                        child:Align(
                                                            alignment: data.fromCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()? Alignment.centerLeft: Alignment.centerRight,
                                                            child: Text("${data.comment}",style: BlackDescStyle,)) ),

                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },),

                                    ],
                                  ),
                                ):
                                isViewingOldCounters == true ?
                                Container(
                                  width: isMobile ?width:tabWidth,
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
                                        itemCount:CounterOfferDetails!.offerBid!.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var data = CounterOfferDetails!.offerBid![index];
                                          return Row(
                                            mainAxisAlignment:data.fromCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()? MainAxisAlignment.start:MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: isMobile?width*0.8:tabWidth*0.8,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(right:10.0,bottom: 5),
                                                      child: Text(data.fromCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()?"${data.fromCounter!.displayname.toString()}":"You",style: BlackTitleItalicStyle,),
                                                    ),
                                                    Container(
                                                        height: 35,
                                                        padding: EdgeInsets.only(left:8,right:8),
                                                        margin: EdgeInsets.only(left:10,right:10),
                                                        decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                          BoxShadow(
                                                              blurRadius: 0.0,
                                                              color: Colors.black54,
                                                              offset: Offset(0.0, 0.5) ),
                                                        ], borderRadius: BorderRadius.circular(5)),
                                                        child:Align(
                                                            alignment: data.fromCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()? Alignment.centerLeft: Alignment.centerRight,
                                                            child: Text("${data.comment}",style: BlackDescStyle,)) ),

                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },),

                                    ],
                                  ),
                                )
                                    :
                                Container(
                                  width: isMobile ?width:tabWidth,
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
                                        itemCount:OfferCounterData!.offerBid!.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var data = OfferCounterData!.offerBid![index];
                                          print(OfferCounterData!.modified.toString().trim());
                                          print(data.modified.toString().trim());
                                          print( OfferCounterData!.modified.toString().trim() != data.modified.toString().trim());
                                          if ( isModifyCounterOffer == false){
                                            return Row(
                                              mainAxisAlignment:data.fromCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()? MainAxisAlignment.start:MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: isMobile?width*0.8:tabWidth*0.8,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right:10.0,bottom: 5),
                                                        child: Text(data.fromCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()?"${data.fromCounter!.displayname.toString()}":"You",style: BlackTitleItalicStyle,),
                                                      ),
                                                      Container(
                                                          height: 35,
                                                          padding: EdgeInsets.only(left:8,right:8),
                                                          margin: EdgeInsets.only(left:10,right:10),
                                                          decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                            BoxShadow(
                                                                blurRadius: 0.0,
                                                                color: Colors.black54,
                                                                offset: Offset(0.0, 0.5) ),
                                                          ], borderRadius: BorderRadius.circular(5)),
                                                          child:Align(
                                                              alignment: data.fromCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()? Alignment.centerLeft: Alignment.centerRight,
                                                              child: Text("${data.comment}",style: BlackDescStyle,)) ),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }else{
                                            if( OfferCounterData!.modified.toString().trim() != data.modified.toString().trim()){
                                              return  Row(
                                                mainAxisAlignment:data.fromCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()? MainAxisAlignment.start:MainAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    width: isMobile?width*0.8:tabWidth*0.8,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(right:10.0,bottom: 5),
                                                          child: Text(data.fromCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()?"${data.fromCounter!.displayname.toString()}":"You",style: BlackTitleItalicStyle,),
                                                        ),
                                                        Container(
                                                            height: 35,
                                                            padding: EdgeInsets.only(left:8,right:8),
                                                            margin: EdgeInsets.only(left:10,right:10),
                                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius: 0.0,
                                                                  color: Colors.black54,
                                                                  offset: Offset(0.0, 0.5) ),
                                                            ], borderRadius: BorderRadius.circular(5)),
                                                            child:Align(
                                                                alignment: data.fromCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()? Alignment.centerLeft: Alignment.centerRight,
                                                                child: Text("${data.comment}",style: BlackDescStyle,)) ),

                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }else{

                                              return SizedBox();
                                            }
                                          }
                                        },),
                                      selectedTap.toString().toUpperCase().trim() == "EXECUTE" || selectedTap.toString().toUpperCase().trim() == "CONFIRM" || selectedTap.toString().toUpperCase().trim() == "SIGN-OFF" ?SizedBox():

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
                                      selectedTap.toString().toUpperCase().trim() == "EXECUTE" || selectedTap.toString().toUpperCase().trim() == "CONFIRM" || selectedTap.toString().toUpperCase().trim() == "SIGN-OFF" ?SizedBox():
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
                                                style:Black87HintStyle ,
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
                                // isViewingOldCounters ?SizedBox():   _currentTapindex == 1?
                                // TempAlertNotify.isEmpty ? SizedBox():
                                // Container(
                                //   width: isMobile ?width:tabWidth,
                                //   padding:EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                //   color:Colors.white,
                                //   child:  ListView.builder(
                                //     shrinkWrap: true,
                                //     physics: NeverScrollableScrollPhysics(),
                                //     itemCount: TempAlertNotify.length,
                                //     itemBuilder: (context, index) {
                                //
                                //       var NotificationData = TempAlertNotify[index];
                                //
                                //
                                //       return Padding(
                                //         padding: const EdgeInsets.only(top:5.0,bottom: 5),
                                //         child: Row(
                                //           mainAxisAlignment: MainAxisAlignment.start,
                                //           crossAxisAlignment:  CrossAxisAlignment.start,
                                //           children: [
                                //             Text(
                                //               "Now"
                                //               ,style: BlackDescStyle,
                                //             ),
                                //             15.width,
                                //             Flexible(child: SimpleRichText("${NotificationData.toString()}",style: BlackDescStyleItelicHeigth))
                                //           ],
                                //         ),
                                //       );
                                //     },),
                                // ):SizedBox(),
                                isViewingOldCounters ?SizedBox():
                                _currentTapindex == 1?SizedBox():
                                ExecuteNotificationList.isNotEmpty? Container(
                                  width: isMobile ?width:tabWidth,
                                  padding:EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                  color:Colors.white,
                                  child:  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: ExecuteNotificationList.length,
                                    itemBuilder: (context, index) {

                                      var NotificationData = ExecuteNotificationList[index];
                                      final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${NotificationData.notifyingTimestamp.toString()}');
                                      final currentTime = DateTime.now();
                                      final diff_dy = currentTime.difference(startTime).inDays;
                                      int years = diff_dy ~/ 365;
                                      int months = (diff_dy-years*365) ~/ 30;
                                      final diff_mi = currentTime.difference(startTime).inMinutes;
                                      final diff_s = currentTime.difference(startTime).inSeconds;
                                      final diff_hr = currentTime.difference(startTime).inHours;

                                      return Padding(
                                        padding: const EdgeInsets.only(top:5.0,bottom: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:  CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              diff_s <= 60? "$diff_s""s":
                                              diff_mi <= 60 ?"$diff_mi""m":
                                              diff_hr <= 24 ? "$diff_hr""h":
                                              diff_dy <= 30 ? "$diff_dy""d":
                                              months <= 12 ? "$months""months":
                                              "$years""y"
                                              ,style: BlackDescStyle,
                                            ),
                                            15.width,
                                            Container(
                                              width: isMobile?width*0.8:tabWidth*0.8,
                                              child: SimpleRichText("${NotificationData.notifyingMessage.toString()}",style: BlackDescStyleItelicHeigth),
                                              // Text("${NotificationData.notifyingMessage.toString()}",maxLines: 2,overflow: TextOverflow.ellipsis),
                                            )
                                          ],
                                        ),
                                      );
                                    },),
                                ):SizedBox()
                              ],
                            )
                          )
                      ),
                    ],
                  ),
                ),
                IsOldCounterDataLoader == true ?
                Container(
                    color: Colors.black12,
                    height: MediaQuery.of(context).size.height,
                    width: isMobile ?width:tabWidth,
                    child: Center(child: LoadingWidget())
                ):const SizedBox(),
              ],),
            bottomNavigationBar:isViewingOldCounters ?SizedBox(): Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration:  BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black38, spreadRadius: 1, blurRadius: 1),],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))),
                child:
                cateLoader == false?SizedBox():
                OfferCounterData!.confirmSteps.toString() == "5"?
                // TODO ReOffering Offer
                   Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 20),
                    cateLoader == false?SizedBox():
                    // OfferCounterData!.offer!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()?
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            backgroundColor:Constants.primaryColor1,
                            elevation: 1),
                        onPressed:
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
                                    itemMedia: ItemsList[j]["media"].isEmpty ? []:
                                    ImageData,
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
                                    price: num.parse(ItemsList[j]["price"].text.toString()),
                                    unit:  PrefillUnit(id: num.parse(ItemsList[j]["SelectedUnitId"].toString()) ,name: ItemsList[j]["unit"].text.toString()),
                                    quantity: num.parse(ItemsList[j]["quantity"].toString()),
                                    required: ItemsList[j]["required"],
                                    toggleState: ItemsList[j]["toggle_state"],
                                    advancePrice:  ItemsList[j]["AdvancePrice"].text==""?null:"${ItemsList[j]["AdvancePrice"].text}",
                                    maintenancePrice: ItemsList[j]["MaintenancePrice"].text==""?null:"${ItemsList[j]["MaintenancePrice"].text}",
                                    advanceUnit:FillAdvanceUnit(id: ItemsList[j]["SelectedUnitIdAdva"].toString()==""?null:"${ ItemsList[j]["SelectedUnitIdAdva"]}",name:ItemsList[j]["AdvanceUnit"].text.toString()),
                                    maintenanceUnit: FillMaintenanceUnit(id:  ItemsList[j]["SelectedUnitIdMain"].toString()==""?null:"${ItemsList[j]["SelectedUnitIdMain"]}",name:ItemsList[j]["MaintenanceUnit"].text.toString())
                                ));
                          }
                          var preFillDetails = PrefillOfferDataModel(
                            offerId:  OfferCounterData!.offer!.id.toString(),
                            addres: OfferCounterData!.offer!.addres.toString(),
                            buyORsell:   OfferCounterData!.offer!.buyORsell.toString(),
                            category: FillCategory(
                              id:   OfferCounterData!.offer!.category!.id,
                              name:    OfferCounterData!.offer!.category!.name,
                            ),
                            segment: FillSegment(
                              name: OfferCounterData!.offer!.segment!.name,
                              id: OfferCounterData!.offer!.segment!.id,
                              category: OfferCounterData!.offer!.segment!.category,
                            ),
                            subsegment: FillSubsegment(
                              id:     OfferCounterData!.offer!.subsegment!.id,
                              name: OfferCounterData!.offer!.subsegment!.name,
                              segment:  OfferCounterData!.offer!.subsegment!.segment,
                            ),
                            offerConditions: PrefillOfferConditions
                              (
                                id:  OfferCounterData!.offer!.offerConditions!.id.toString(),
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
                                servicepersons:  OfferCounterData!.offerConditions!.servicepersons,
                                timePeriod: OfferPeriodController.text
                            ),
                            tabactivity: "New",
                            offerareas:  serviceAreaList,
                            offerBids: FillBids,
                            offerItems: FillItmsList,
                              privacy: OfferCounterData!.offer!.privacy.toString()
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewOfferCreateScreen(Address: "",AddressTitle: "",From: "Fill",PrefillOfferData:preFillDetails ,Type: "Duplicate",OfferId: OfferCounterData!.offer!.id.toString(),SubId: OfferCounterData!.offer!.subscribers!.id.toString())));
                        }:
                            () async{
                          setState(() {
                            PublishLoader = true;
                          });
                          final List<dynamic> ItemsFinalList = [];
                          for(var i=0; i< OfferCounterData!.offer!.offerItems!.length;i++){
                          var itemData = OfferCounterData!.offer!.offerItems![i];
                          final imageMedia = [];


                          for(var j = 0 ; j< itemData.itemMedia!.length ; j++){
                            imageMedia.add({
                              "file":"${ itemData.itemMedia![j].id}",
                              "name": "${itemData.itemMedia![j].name}"
                            });
                          }
                            ItemsFinalList.add(
                                {
                                  "name":itemData.name.toString()=="null"?null:"${itemData.name.toString()}",
                                  "desc":itemData.desc.toString()=="null"?null:"${itemData.desc.toString()}",
                                  "price":itemData.price.toString() == "null"?null:"${itemData.price.toString()}",
                                  "unit":itemData.unit!.id.toString() =="null"?null: itemData.unit!.id.toString(),
                                  "advance_price" : itemData.advancePrice.toString()=="null"?null:"${itemData.advancePrice.toString()}",
                                  "maintenance_price" :itemData.maintenancePrice.toString()=="null"?null:"${itemData.maintenancePrice.toString()}",
                                  "advance_unit" : itemData.advanceUnit!.id.toString()=="null"?null:"${ itemData.advanceUnit!.id.toString()}",
                                  "maintenance_unit" : itemData.maintenanceUnit!.id.toString()=="null"?null:"${itemData.maintenanceUnit!.id.toString()}",
                                  "quantity":"${itemData.quantity.toString()}",
                                  "currency":"INR",
                                  "addon":"${itemData.addon.toString()}",
                                  "required":"${itemData.required.toString()}",
                                  "toggle_state":"false",
                                  "media": imageMedia,
                                  "item_condition":{
                                    "periodicity": "${itemData.offerItemConditions!.periodicity.toString()}",
                                    "fromperiod":"${itemData.offerItemConditions!.fromperiod.toString()}" == "null"?null:itemData.offerItemConditions!.fromperiod.toString(),
                                    "toperiod":itemData.offerItemConditions!.toperiod.toString() == "null"?null:itemData.offerItemConditions!.toperiod.toString(),
                                    "duration": itemData.offerItemConditions!.duration.toString() == "null"?null : itemData.offerItemConditions!.duration.toString(),
                                    "fromperiodtime":itemData.offerItemConditions!.fromperiodtime.toString()=="null"?null: "${itemData.offerItemConditions!.fromperiodtime.toString().split(":")[0]}:${itemData.offerItemConditions!.fromperiodtime.toString().split(":")[1]}",
                                    "toperiodtime":itemData.offerItemConditions!.toperiodtime.toString() == "null"?null:"${itemData.offerItemConditions!.toperiodtime.toString().split(":")[0]}:${itemData.offerItemConditions!.toperiodtime.toString().split(":")[1]}",
                                    "durationoftime":null,
                                    "fromlocation":itemData.offerItemConditions!.fromlocation.toString()=="null"?null:itemData.offerItemConditions!.fromlocation.toString(),
                                    "tolocation":itemData.offerItemConditions!.tolocation.toString()=="null"?null:itemData.offerItemConditions!.tolocation.toString(),
                                    "atlocation":itemData.offerItemConditions!.atlocation.toString()=="null"?null:itemData.offerItemConditions!.atlocation.toString(),
                                    "servicepersons": itemData.offerItemConditions!.servicepersons,
                                    "priority": itemData.offerItemConditions!.priority.toString()=="null"?null:"${itemData.offerItemConditions!.priority.toString()}",
                                    "expiry":itemData.offerItemConditions!.expiry.toString()=="null"?null:itemData.offerItemConditions!.expiry.toString()
                                  }
                                }
                                );
                          }
                          var offerDetails = OfferCounterData!.offer;
                          List bids = [];
                          offerDetails!.offerBids!.first.comment.toString() != ""?bids.add({"comment": "${offerDetails.offerBids!.first.comment.toString()}"}):null;
                          offerDetails.offerBids!.length == 2 ? offerDetails.offerBids![1].comment.toString() != ""?bids.add({"comment": "${offerDetails!.offerBids![1]!.comment.toString()}"}):null:null;

                          Map<String, dynamic> CreateOfferParam = {
                            "subscribers":"${DataManager.getInstance().userId.toString()}",
                            "category": "${offerDetails.category!.id}",
                            "segment": "${offerDetails.segment!.id}",
                            "subsegment": "${offerDetails.subsegment!.id}",
                            "addres":offerDetails.addres.toString(),
                            "offerareas":offerDetails.offerareas.toString(),
                            "privacy":  isPrivateOffer?"PRIVATE":"PUBLIC",
                            "offertemplate" : offerDetails.offertemplate,
                            "tabactivity": "NEW",
                            "buyORsell": offerDetails.buyORsell.toString(),
                            "offerexecutestart": null,
                            "offerexecuteend": null,
                            "periodicity": offerDetails.offerConditions!.periodicity,
                            "fromperiod":offerDetails.offerConditions!.fromperiod.toString()=="null"?null: offerDetails.offerConditions!.fromperiod.toString(),
                            "toperiod": offerDetails.offerConditions!.toperiod.toString()=="null"?null:"${offerDetails.offerConditions!.toperiod.toString()}",
                            "fromperiodtime":offerDetails.offerConditions!.fromperiodtime.toString()=="null"?null:"${offerDetails.offerConditions!.fromperiodtime.toString().split(":")[0]}:${offerDetails.offerConditions!.fromperiodtime.toString().split(":")[1]}",
                            "toperiodtime":offerDetails.offerConditions!.toperiodtime.toString()=="null"?null:"${offerDetails.offerConditions!.toperiodtime.toString().split(":")[0]}:${offerDetails.offerConditions!.toperiodtime.toString().split(":")[1]}",
                            "duration":offerDetails.offerConditions!.duration.toString() == "null"?null :offerDetails.offerConditions!.duration.toString(),
                            "durationoftime":null,
                            "fromlocation":offerDetails.offerConditions!.fromlocation.toString() == "null"?null:offerDetails.offerConditions!.fromlocation.toString(),
                            "tolocation":offerDetails.offerConditions!.tolocation.toString() == "null"?null:offerDetails.offerConditions!.tolocation.toString(),
                            "atlocation":offerDetails.offerConditions!.atlocation.toString() == "null"?null:offerDetails.offerConditions!.atlocation.toString(),
                            "servicepersons": offerDetails.offerConditions!.servicepersons,
                            "priority":offerDetails.offerConditions!.priority.toString(),
                            "expiry":offerDetails.offerConditions!.expiry.toString() == "null"? null: offerDetails.offerConditions!.expiry.toString(),
                            "bids": bids,
                            "items":ItemsFinalList
                          };
                          Future.delayed(Duration(seconds: 2),() {
                            DrawAuraAPi().createOffer(CreateOfferParam).then((response){
                              if (response.statusCode == 200) {
                                var data = json.decode(response.body);
                                Constants.showToastAtBottom("${data["message"]}");
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 4),), (route) => false);
                              }else if(response.statusCode == 500){
                                Navigator.pop(context,false);
                              }
                              else{
                                Navigator.pop(context,false);
                              }
                            });
                          },);
                        },

                        child:PublishLoader == true?SizedBox(height:15,width: 15,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2.5,)):    Text("REOFFER",style: WhiteButtonStyle16500,
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
                            image: DecorationImage(image: NetworkImage("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg"),)
                        ):  BoxDecoration(
                            border: Border.all(color: Constants.white,width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${DataManager.getInstance().getuserImage()}"),fit: BoxFit.fill)
                        ),
                      )),
                    ),
                  ],
                )
                // TODO  Offer Couter
                    :  Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    cateLoader == false?SizedBox():
                    // OfferCounterData!.offer!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()?
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor:Colors.red,
                              elevation: 1),
                          child:Text("Report",style:WhiteHeadingStyle),
                          onPressed:(){
                            AbuseContentReportWarning(context,() {
                              var body = {
                                "user" : OfferCounterData!.offer!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()?
                                OfferCounterData!.fromCounter!.id.toString():
                                OfferCounterData!.toCounter!.id.toString(),
                                "offer" :  OfferCounterData!.offer!.id.toString()
                              };
                              print(body);
                              String endPoint = "reportAbuseUser";
                              DrawAuraAPi.GetListData(body: body,ApiEndPoint: endPoint).then((value) {
                                if(value["status"] == "200"){
                                  Constants.showToast(value["message"]);
                                  Navigator.pop(context);
                                }else{
                                  Navigator.pop(context);
                                  Constants.showToast(value["message"]);
                                }
                              });
                            },);
                          }
                      ),
                    ),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            backgroundColor:
                            requiredItemPriceIsEmpty.contains(true)?nullBtnColor:
                            isModifyCounterOffer == true ||
                                (isConfirmModify == true && selectedTap.toString().toUpperCase().trim() == "ANSWER")||
                                (isConfirmModify == true && selectedTap.toString().toUpperCase().trim() == "QUERY")
                                ?Constants.primaryColor1:
                            selectedTap.toString().toUpperCase().trim() == "EXECUTE" && ExecutionReddy.contains(false) ?nullBtnColor:
                            OfferCounterData!.fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() && selectedTap.toString().toUpperCase().trim() != "EXECUTE" && selectedTap.toString().toUpperCase().trim() != "SIGN-OFF" ?nullBtnColor:
                            OfferInstruction1Controller.text.isEmpty && OfferInstruction2Controller.text.isEmpty &&
                                selectedTap.toString().toUpperCase().trim() != "CONFIRM" &&
                                selectedTap.toString().toUpperCase().trim() != "EXECUTE" &&
                                selectedTap.toString().toUpperCase().trim() != "SIGN-OFF"  ?nullBtnColor:
                                waitForResponse?nullBtnColor:
                                Constants.primaryColor1,
                            elevation: 1),
                        onPressed:
                           selectedTap.toString().toUpperCase().trim() == "DUPLICATE" ?
                            (){
                          print("Duplicate From Last counter offer");
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
                           print(ImageData);
                            print("DuplicatePerform");
                            FillItmsList.add(
                                PrefillOfferItems(
                                    name: "${ItemsList[j]["name"].text.toString()}" ,
                                    addon: ItemsList[j]["addon"],
                                    desc: "${ItemsList[j]["desc"].text.toString()}",
                                    itemMedia: ItemsList[j]["media"].isEmpty ? []: ImageData ,
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
                                    maintenanceUnit:ItemsList[j]["SelectedUnitIdMain"].toString()=="" ||  ItemsList[j]["MaintenanceUnit"].text.isEmpty  || ItemsList[j]["SelectedUnitIdMain"].toString()  == "null"?FillMaintenanceUnit():  FillMaintenanceUnit(id:  ItemsList[j]["SelectedUnitIdMain"].toString()==""?null:"${ItemsList[j]["SelectedUnitIdMain"]}",name:ItemsList[j]["MaintenanceUnit"].text.toString())
                                ));
                          }
                          var preFillDetails = PrefillOfferDataModel(
                            offerId:   OfferCounterData!.offer!.id.toString(),
                            addres: OfferCounterData!.offer!.addres.toString(),
                            buyORsell:   OfferCounterData!.offer!.buyORsell.toString(),
                            category: FillCategory(
                              id:   OfferCounterData!.offer!.category!.id,
                              name:    OfferCounterData!.offer!.category!.name,
                            ),
                            segment: FillSegment(
                              name: OfferCounterData!.offer!.segment!.name,
                              id: OfferCounterData!.offer!.segment!.id,
                              category: OfferCounterData!.offer!.segment!.category,
                            ),
                            subsegment: FillSubsegment(
                              id:     OfferCounterData!.offer!.subsegment!.id,
                              name: OfferCounterData!.offer!.subsegment!.name,
                              segment:  OfferCounterData!.offer!.subsegment!.segment,
                            ),
                            offerConditions: PrefillOfferConditions(
                                id: OfferCounterData!.offer!.offerConditions!.id.toString(),
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
                                servicepersons:  OfferCounterData!.offerConditions!.servicepersons,
                                timePeriod: OfferPeriodController.text
                            ),
                            tabactivity: "New",
                            offerareas:  serviceAreaList,
                            offerBids: FillBids,
                            offerItems: FillItmsList,
                              privacy: OfferCounterData!.offer!.privacy.toString()
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewOfferCreateScreen(Address: "",AddressTitle: "",From: "Fill",PrefillOfferData:preFillDetails ,Type: "Duplicate",OfferId: OfferCounterData!.offer!.id.toString(),SubId: OfferCounterData!.offer!.subscribers!.id.toString())));
                        }
                            :
                           requiredItemPriceIsEmpty.contains(true)?
                               (){
                                 Constants.showToastAtBottom("${Url.isRequiredItemPriceSelectMessage}");
                               } :
                           isModifyCounterOffer == true ||
                                   (isConfirmModify == true && selectedTap.toString().toUpperCase().trim() == "ANSWER")||
                               (isConfirmModify == true && selectedTap.toString().toUpperCase().trim() == "QUERY")?
                               () {
                                 if(OfferInstruction1Controller.text.isEmpty && OfferInstruction2Controller.text.isEmpty ){
                                     Constants.showToastAtBottom("${Url.BidsMessage}");
                                 }else{
                                   setState((){
                                     PublishLoader =true;
                                   });
                                   List bids = [];
                                   if(OfferCounterData!.modified.toString().trim() == OfferCounterData!.offerBid![OfferCounterData!.offerBid!.length-2].modified.toString().trim()){
                                     bids.add({"id":"${OfferCounterData!.offerBid![OfferCounterData!.offerBid!.length-2].id.toString()}","comment": "${OfferInstruction1Controller.text}"});
                                     if(OfferCounterData!.modified.toString().trim() == OfferCounterData!.offerBid![OfferCounterData!.offerBid!.length-1].modified.toString().trim()){
                                       bids.add({"id":"${OfferCounterData!.offerBid![OfferCounterData!.offerBid!.length-1].id.toString()}","comment": "${OfferInstruction2Controller.text}"});
                                     }
                                   }else if(OfferCounterData!.modified.toString().trim() == OfferCounterData!.offerBid![OfferCounterData!.offerBid!.length-1].modified.toString().trim()){
                                     bids.add({"id":"${OfferCounterData!.offerBid![OfferCounterData!.offerBid!.length-1].id.toString()}","comment": "${OfferInstruction1Controller.text}"});
                                   }
                                   final List<dynamic> ItemsFinalList = [];
                                   print(ItemsList.length);
                                   for(var i=0; i<ItemsList.length ;i++){
                                     ItemsFinalList.add(
                                         {
                                           "id":"${ItemsList[i]["ItemId"].toString()}",
                                           "name": ItemsList[i]["name"].text.toString()==""?null:"${ItemsList[i]["name"].text.toString()}",
                                           "desc": ItemsList[i]["desc"].text.toString()==""?null:"${ItemsList[i]["desc"].text.toString()}",
                                           "quantity":"${ItemsList[i]["quantity"].toString()}",
                                           "price":ItemsList[i]["price"].text==""?null:"${ItemsList[i]["price"].text}",
                                           "unit":ItemsList[i]["SelectedUnitId"].toString()==""?null:"${ItemsList[i]["SelectedUnitId"].toString()}",
                                           "advance_price" : ItemsList[i]["AdvancePrice"].text==""?null:"${ItemsList[i]["AdvancePrice"].text}",
                                           "maintenance_price" : ItemsList[i]["MaintenancePrice"].text==""?null:"${ItemsList[i]["MaintenancePrice"].text}",
                                           "advance_unit" : ItemsList[i]["SelectedUnitIdAdva"].toString()==""?null:"${ ItemsList[i]["SelectedUnitIdAdva"]}",
                                           "maintenance_unit" : ItemsList[i]["SelectedUnitIdMain"].toString()==""?null:"${ItemsList[i]["SelectedUnitIdMain"]}",
                                           "currency": "INR",
                                           "addon":"${ItemsList[i]["addon"].toString()}",
                                           "required": "${ItemsList[i]["required"].toString()}",
                                           "toggle_state":"${ItemsList[i]["toggle_state"].toString()}",
                                           "media": ItemsList[i]["media"],
                                           "user":ItemsList[i]["CreatorUserId"],
                                           "create_date":ItemsList[i]["create_date"] == "new"?DateFormat("dd-MM-yyyy HH:mm").format(DateTime.now()).toString():ItemsList[i]["create_date"],
                                           "item_condition":{
                                             "id":"${ItemsList[i]["item_condition"]["ItemConditionId"].toString()}",
                                             "periodicity":"${ItemsList[i]["item_condition"]["periodicity"].toString()}",
                                             "fromperiod":ItemsList[i]["item_condition"]["fromperiod"] == ""?null: "${ItemsList[i]["item_condition"]["fromperiod"].toString()}",
                                             "toperiod":ItemsList[i]["item_condition"]["toperiod"] == ""?null: "${ItemsList[i]["item_condition"]["toperiod"].toString()}",
                                             "duration": ItemsList[i]["item_condition"]["duration"].text.toString() == "null"?"":isItemSinglePeriodSelect==false?ItemsList[i]["item_condition"]["duration"].text.toString():ItemsList[i]["item_condition"]["duration"].text.toString()==3?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00:00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==6?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==9?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==12?ItemsList[i]["item_condition"]["duration"].text.toString()+"00":ItemsList[i]["item_condition"]["duration"].text.toString(),
                                             "fromperiodtime":ItemsList[i]["item_condition"]["fromperiodtime"] == ""?null: "${ItemsList[i]["item_condition"]["fromperiodtime"].toString()}",
                                             "toperiodtime":ItemsList[i]["item_condition"]["toperiodtime"] == "" ?null:"${ItemsList[i]["item_condition"]["toperiodtime"].toString()}",
                                             "durationoftime":null,
                                             "fromlocation":"${ItemsList[i]["item_condition"]["fromlocation"].text.toString()}",
                                             "tolocation":"${ItemsList[i]["item_condition"]["tolocation"].text.toString()}",
                                             "atlocation":"${ItemsList[i]["item_condition"]["atlocation"].text.toString()}",
                                             "servicepersons": ItemsList[i]["item_condition"]["servicepersons"],
                                             "priority":"${ItemsList[i]["item_condition"]["priority"].toString().toUpperCase()}",
                                             "expiry": ItemsList[i]["item_condition"]["expiry"].text == "" ?null:"${ItemsList[i]["item_condition"]["expiry"].text.toString()}"
                                           }});
                                   }

                                   Map<String, dynamic>  ModifyData = {

                                     "id": OfferCounterData!.id.toString(),
                                     "counteringstatus": "OPEN",
                                     "tabactivity":
                                     (isConfirmModify == true && selectedTap.toString().toUpperCase().trim() == "ANSWER")||
                                         (isConfirmModify == true && selectedTap.toString().toUpperCase().trim() == "QUERY")?
                                     selectedTap.toUpperCase().toString().toUpperCase():
                                     OfferCounterData!.tabactivity.toString().toUpperCase().trim(),
                                     "offer_condition": {
                                       "id": OfferCounterData!.offerConditions!.id,
                                       // "servicepersons":  OfferCounterData!.offerConditions!.servicepersons,
                                       "servicepersons":selectedItems,
                                       "periodicity": OfferCounterData!.offerConditions!.periodicity.toString().trim(),
                                       "fromperiod": OfferCounterData!.offerConditions!.fromperiod,
                                       "toperiod": OfferCounterData!.offerConditions!.toperiod,
                                       "duration": OfferCounterData!.offerConditions!.duration,
                                       "fromperiodtime":OfferCounterData!.offerConditions!.fromperiodtime,
                                       "toperiodtime":OfferCounterData!.offerConditions!.toperiodtime,
                                       "durationoftime": "",
                                       "fromlocation": OfferCounterData!.offerConditions!.fromlocation,
                                       "tolocation": OfferCounterData!.offerConditions!.tolocation,
                                       "atlocation":OfferCounterData!.offerConditions!.atlocation,
                                       "priority": OfferCounterData!.offerConditions!.priority.toString().trim(),
                                       "expiry": OfferCounterData!.offerConditions!.expiry,
                                       "offer": int.parse(OfferCounterData!.id.toString())
                                     },
                                     "confirm_steps": 0,
                                     "confirm_by" : "",
                                     "items": ItemsFinalList,
                                     "bids": bids

                                   };

                                   Future.delayed(Duration(seconds: 2),() {
                                     DrawAuraAPi().updateCounterOffer(ModifyData).then((response){


                                       if (response.statusCode == 200) {

                                         var data = json.decode(response.body);
                                         log(data.toString());
                                         print("ResOfModifyOffer");
                                         Constants.showToastAtBottom("${data["message"]}");
                                         Navigator.pop(context,false);
                                       }else if(response.statusCode == 500){
                                         Navigator.pop(context,false);
                                       }
                                       else{
                                         Navigator.pop(context,false);
                                       }
                                     }).then((value) {
                                       setState((){
                                         PublishLoader =false;
                                       });
                                     });
                                   },);
                                 }

                             }:
                           selectedTap.toString().toUpperCase().trim() == "EXECUTE" && ExecutionReddy.contains(false) ?(){
                             Constants.showToastAtBottom("${Url.selectItemExecute}");
                           }:
                            OfferCounterData!.fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() &&
                            selectedTap.toString().toUpperCase().trim() != "EXECUTE" && selectedTap.toString().toUpperCase().trim() != "SIGN-OFF"
                            ?(){
                              Constants.showToastAtBottom("${Url.waitForResponse}");
                            }:
                            OfferInstruction1Controller.text.isEmpty && OfferInstruction2Controller.text.isEmpty &&
                                selectedTap.toString().toUpperCase().trim() != "CONFIRM" &&
                                selectedTap.toString().toUpperCase().trim() != "EXECUTE" &&
                                selectedTap.toString().toUpperCase().trim() != "SIGN-OFF"  ?(){
                              Constants.showToastAtBottom("${Url.BidsMessage}");
                            }:
                            waitForResponse?(){
                              Constants.showToastAtBottom("${Url.waitForResponse}");
                            }:
                            () {

                          setState(() {
                            PublishLoader = true;
                          });
                          String ErrorMessage = "NoError";
                          for(var i=0; i<ItemsList.length ;i++){
                            if(ItemsList[i]["name"].text.toString()==""||ItemsList[i]["name"].text.toString()=="null"||ItemsList[i]["name"].text.isEmpty){
                              ErrorMessage = "Please enter item name";
                              break ;
                            }
                            if(ItemsList[i]["price"].text.toString()==""||ItemsList[i]["price"].text.toString()=="null"||ItemsList[i]["price"].text.isEmpty){
                              ErrorMessage = "Please enter item price";
                              break ;
                            }
                            if(ItemsList[i]["unit"].text.toString()==""||ItemsList[i]["unit"].text.toString()=="null"||ItemsList[i]["unit"].text.isEmpty){
                              ErrorMessage = "Please enter item unit";
                              break ;
                            }
                          }

                          if(ErrorMessage != "NoError"){
                            setState(() {
                              PublishLoader = false;
                            });
                            Constants.MessageShowDialog(context, RichText(
                              textAlign: TextAlign.center,
                              text:  TextSpan(
                                  children: [
                                    TextSpan(text: '$ErrorMessage', style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Colors.black,height: 1.5)),
                                    TextSpan(text: " \nfor publish", style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color:Colors.black,height: 1.5)),
                                  ]
                              ),
                            ),(){
                              Navigator.pop(context);
                            });
                          }else{

                            if(OfferCounterData!.fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() &&
                                selectedTap.toString().toUpperCase().trim() != "EXECUTE" && selectedTap.toString().toUpperCase().trim() != "SIGN-OFF"
                            ){
                              setState(() {
                                PublishLoader = false;
                              });
                              Constants.MessageShowDialog(
                                  context, RichText(
                                textAlign: TextAlign.center,
                                text:  TextSpan(
                                    children: [
                                      TextSpan(text: 'Please wait for ', style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Colors.black,height: 1.5)),
                                      TextSpan(text: " \nresponse", style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color:Colors.black,height: 1.5)),
                                    ]
                                ),
                              ),(){
                                Navigator.pop(context);
                              });

                            }
                            else if( OfferInstruction1Controller.text.isEmpty && OfferInstruction2Controller.text.isEmpty &&
                                selectedTap.toString().toUpperCase().trim() != "CONFIRM" &&
                                selectedTap.toString().toUpperCase().trim() != "EXECUTE" &&
                                selectedTap.toString().toUpperCase().trim() != "SIGN-OFF"
                            ){
                              setState(() {
                                PublishLoader = false;
                              });
                              Constants.MessageShowDialog(context, RichText(
                                textAlign: TextAlign.center,
                                text:  TextSpan(
                                    children: [
                                      TextSpan(text: 'Please enter counter', style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Colors.black,height: 1.5)),
                                      TextSpan(text: " \nbids", style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color:Colors.black,height: 1.5)),
                                    ]
                                ),
                              ),(){
                                Navigator.pop(context);
                              });

                            }else{
                              int confirm_steps = 0;
                              String confirm_by = "";
                              if( selectedTap.toUpperCase().toString().toUpperCase() == "QUERY" ||  selectedTap.toUpperCase().toString().toUpperCase() == "ANSWER" ){
                                confirm_steps = 0;
                                confirm_by = "";
                              }else if( selectedTap.toUpperCase().toString().toUpperCase() == "CONFIRM"){
                                confirm_by = _currentTapindex == 0 ?"B":"S";
                                OfferCounterData!.confirmSteps == 0 ? confirm_steps = 1 : confirm_steps = int.parse(OfferCounterData!.confirmSteps.toString()) + 1 ;
                              }else if(selectedTap.toUpperCase().toString(  ).toUpperCase() == "EXECUTE"){
                                confirm_by = "E";
                                OfferCounterData!.confirmSteps == 1 ? confirm_steps = 2 : confirm_steps = 3;
                              }else if(selectedTap.toUpperCase().toString().toUpperCase() == "SIGN-OFF"){
                                confirm_by = "";
                                OfferCounterData!.confirmSteps == 3 ? confirm_steps = 4 :confirm_steps = 5;
                              }
                              bool offerPublishOn = true;

                              setState((){
                                PublishLoader =true;
                              });
                              final List<dynamic> ItemsFinalList = [];
                              List bids = [];
                              OfferInstruction1Controller.text != ""?bids.add({"comment": "${OfferInstruction1Controller.text}"}):null;
                              OfferInstruction2Controller.text != ""?bids.add({"comment": "${OfferInstruction2Controller.text}"}):null;
                              String TextModeration = "${OfferInstruction1Controller.text} ${OfferInstruction2Controller.text}";
                              for(var i=0; i<ItemsList.length ;i++){
                                if(ItemsList[i]["itemType"].toString() == "Old"){
                                  if(ItemsList[i]["required"].toString() == "true" && ItemsList[i]["toggle_state"].toString() == "false"){
                                    print("SetFalse");
                                    offerPublishOn = false;
                                    setState((){
                                      PublishLoader = false;
                                    });
                                  }
                                }else{
                                  TextModeration = "${TextModeration} ${ItemsList[i]["name"].text.toString()} ${ItemsList[i]["desc"].text.toString()}";
                                }

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
                                      "toggle_state":"${ItemsList[i]["toggle_state"].toString()}",
                                      "media":ItemsList[i]["media"],
                                      "user":ItemsList[i]["CreatorUserId"],
                                      "create_date":ItemsList[i]["create_date"] == "new"?DateFormat("dd-MM-yyyy HH:mm").format(DateTime.now()).toString():ItemsList[i]["create_date"],
                                      "item_condition":{
                                        "periodicity":"${ItemsList[i]["item_condition"]["periodicity"].toString()}",
                                        "fromperiod":ItemsList[i]["item_condition"]["fromperiod"] == ""?null: "${ItemsList[i]["item_condition"]["fromperiod"].toString()}",
                                        "toperiod":ItemsList[i]["item_condition"]["toperiod"] == ""?null: "${ItemsList[i]["item_condition"]["toperiod"].toString()}",
                                        "duration": ItemsList[i]["item_condition"]["duration"].text.toString() == "null"?"":isItemSinglePeriodSelect==false?ItemsList[i]["item_condition"]["duration"].text.toString():ItemsList[i]["item_condition"]["duration"].text.toString()==3?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00:00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==6?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==9?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==12?ItemsList[i]["item_condition"]["duration"].text.toString()+"00":ItemsList[i]["item_condition"]["duration"].text.toString(),
                                        "fromperiodtime":ItemsList[i]["item_condition"]["fromperiodtime"] == ""?null: "${ItemsList[i]["item_condition"]["fromperiodtime"].toString()}",
                                        "toperiodtime":ItemsList[i]["item_condition"]["toperiodtime"] == "" ?null:"${ItemsList[i]["item_condition"]["toperiodtime"].toString()}",
                                        "durationoftime":null,
                                        "fromlocation":"${ItemsList[i]["item_condition"]["fromlocation"].text.toString()}",
                                        "tolocation":"${ItemsList[i]["item_condition"]["tolocation"].text.toString()}",
                                        "atlocation":"${ItemsList[i]["item_condition"]["atlocation"].text.toString()}",
                                        "servicepersons":ItemsList[i]["item_condition"]["servicepersons"].where((e)=> e.toString() == "-1" || e.toString() == "0").length >= 1 ? [] : ItemsList[i]["item_condition"]["servicepersons"],
                                        "priority":"${ItemsList[i]["item_condition"]["priority"].toString().toUpperCase()}",
                                        "expiry": ItemsList[i]["item_condition"]["expiry"].text == "" ?null:"${ItemsList[i]["item_condition"]["expiry"].text.toString()}"
                                      }
                                    });
                              }
                              Map<String, dynamic> CreateOfferParam = {
                                "offer":OfferCounterData!.offer!.id,
                                "parent":OfferCounterData!.id,
                                "to_counter": widget.to_Couter_Id == ""? OfferCounterData!.offer!.subscribers!.id.toString():widget.to_Couter_Id,
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
                                "bids":bids,
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
                                        Future.delayed(Duration(milliseconds: 100),() {
                                          var body = {
                                            "offer_id": OfferCounterData!.offer!.id.toString(),
                                            "user_id" :OfferCounterData!.toCounter!.id.toString()
                                          };
                                          DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "addConfirmUser").then((value) {});
                                          var Userbody = {
                                            "offer_id": OfferCounterData!.offer!.id.toString(),
                                            "user_id" :OfferCounterData!.fromCounter!.id.toString()
                                          };
                                          DrawAuraAPi.CreateDataApi(body: Userbody,ApiEndPoint: "addConfirmUser").then((value) {});

                                          if( confirm_steps == 2 || confirm_steps  == 3){
                                            for(var item = 0 ; item < OfferCounterData!.offer!.offerItems!.length ; item++){
                                              for(var CouterItem = 0 ; CouterItem < ItemsList.length ; CouterItem++){
                                                if(int.parse(OfferCounterData!.offer!.offerItems![item].quantity.toString()) >= 1 ){
                                                  if(OfferCounterData!.offer!.offerItems![item].name.toString().trim() == ItemsList[CouterItem]["name"].text.toString().trim() ){
                                                    var body = {
                                                      "item_id": OfferCounterData!.offer!.offerItems![item].id.toString(),
                                                      "quantity": "${int.parse(OfferCounterData!.offer!.offerItems![item].quantity.toString()) - int.parse(ItemsList[CouterItem]["quantity"].toString())}"
                                                    };
                                                    DrawAuraAPi.CreateDataApi(ApiEndPoint: "updateOfferItem",body: body);
                                                  }
                                                }
                                              }
                                            }
                                          }

                                        },).then((value) {
                                          Future.delayed(Duration(seconds: 2),() {
                                            if(confirm_steps >= 2){
                                              List isAllItemDone1 = [] ;
                                              DrawAuraAPi.getOfferDetails(offer_id: OfferCounterData!.offer!.id.toString()).then((OfferDetails) {
                                                for(var OfferItem = 0 ; OfferItem < OfferDetails["result"]["offer_items"].length ; OfferItem++){
                                                  if( OfferDetails["result"]["offer_items"][OfferItem]["quantity"].toString().trim() == "0"){
                                                    isAllItemDone1.add(true);
                                                  }else{
                                                    isAllItemDone1.add(false);
                                                  }
                                                }
                                                Future.delayed(Duration(seconds: 2),() {
                                                  if(isAllItemDone1.contains(false)){
                                                  }else{
                                                    DrawAuraAPi.changeOfferStatus(offerId:OfferCounterData!.offer!.id.toString() ,CLOSED: "CLOSED").then((value) {
                                                      if(value["status"] == "200"){
                                                        Constants.showToast(value["message"]);
                                                      }else{
                                                        Constants.showToast(value["message"]);
                                                      }
                                                    });
                                                  }
                                                },) ;
                                              });
                                            }
                                          },).then((value) {
                                            Future.delayed(Duration(seconds: 4),() {

                                              if(_currentTapindex == 1 && selectedTap.toUpperCase().toString().toUpperCase() == "CONFIRM"){
                                                setState((){
                                                  PublishLoader =false;
                                                });
                                                 if(confirm_steps == 2 ){
                                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => lastCounterScreen(OferId: widget.OferId.toString(),to_Couter_Id: widget.to_Couter_Id.toString()),));
                                                 }else{
                                                   Navigator.pop(context,false);
                                                 }

                                              }else{
                                                Navigator.pop(context,false);
                                              }
                                            },);
                                          });
                                        });
                                      }
                                      else if(selectedTap.toString().toUpperCase().trim() == "EXECUTE"){
                                        var body = {
                                          "from_user" : DataManager.getInstance().getuserId().toString(),
                                          "to_user" : OfferCounterData!.toCounter!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() ? OfferCounterData!.toCounter!.id.toString().trim(): OfferCounterData!.fromCounter!.id.toString().trim(),
                                          "offer_id" : OfferCounterData!.offer!.id.toString(),
                                          "counter_id" : OfferCounterData!.id.toString(),
                                          "type" : "ItemSelected",
                                          "message" : "Delivered all, please sign-off and rate them",
                                        };
                                        DrawAuraAPi.CreateDataApi(ApiEndPoint: "sendPushNotification",body: body).then((value) {
                                          Future.delayed(Duration(seconds: 1),() {
                                            var data = json.decode(response.body);
                                            Constants.showToastAtBottom("${data["message"]}");

                                            Navigator.pop(context,false);
                                          },);
                                        });
                                      }
                                      else if(selectedTap.toString().toUpperCase().trim() == "SIGN-OFF"){
                                        var body = {
                                          "offer_id": OfferCounterData!.offer!.id.toString(),
                                          "user_id" : DataManager.getInstance().getuserId().toString()
                                        };
                                        DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "removeConfirmUser").then((value) {
                                          RatingDialog(context,
                                                  (){

                                                Navigator.pop(context);
                                              }
                                          );
                                        });

                                      }
                                      else if(selectedTap.toString().toUpperCase().trim() == "SIGN-OFF" && isOfferOwner){
                                        List isAllItemDone = [] ;
                                        for(var m = 0 ; m< OfferCounterData!.offer!.offerItems!.length ; m++){
                                          if(OfferCounterData!.offer!.offerItems![m].quantity.toString().trim() == "0"){
                                            isAllItemDone.add(true);
                                          }else{
                                            isAllItemDone.add(false);
                                          }
                                        }
                                        Future.delayed(Duration(seconds: 2),() {
                                          if(isAllItemDone.contains(false)){
                                            print(isAllItemDone);
                                          }else{
                                            DrawAuraAPi.changeOfferStatus(offerId:OfferCounterData!.offer!.id.toString() ,CLOSED: "CLOSED").then((value) {
                                              if(value["status"] == "200"){
                                                Constants.showToast(value["message"]);
                                              }else{
                                                Constants.showToast(value["message"]);
                                              }
                                            });
                                          }
                                        }).then((value){
                                          RatingDialog(context,
                                                  (){
                                                    Navigator.pop(context,false);
                                              }
                                          );
                                        });
                                      }
                                      else{
                                        Future.delayed(Duration(seconds: 1),() {
                                          setState((){
                                            PublishLoader =false;
                                          });
                                          var data = json.decode(response.body);
                                          Constants.showToastAtBottom("${data["message"]}");

                                          Navigator.pop(context,false);
                                        },);
                                      }
                                    }else if(response.statusCode == 500){

                                      Navigator.pop(context);
                                    }
                                    else{
                                      Navigator.pop(context);
                                    }
                                  });
                                },);

                            }
                          }

                          // showDialog(context: context,
                          //   builder: (context) {
                          //     return  StatefulBuilder(builder: (context, setState) {
                          //       return Dialog(
                          //         alignment: Alignment.center,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                          //         elevation: BorderSide.strokeAlignOutside,
                          //         child: Container(
                          //           padding: EdgeInsets.only( top: 0,bottom: 0),
                          //           width: isMobile?width*0.85:tabWidth*0.85,
                          //           decoration:  BoxDecoration(color: Color(0x1A52B46B),
                          //               borderRadius: BorderRadius.circular(7),
                          //               border: Border.all(color: Constants.greyDark,width: 0.5)
                          //           ),
                          //           child: ListView(
                          //             shrinkWrap: true,
                          //             children: [
                          //               Padding(
                          //                 padding: const EdgeInsets.only(top: 30),
                          //                 child: SizedBox(
                          //                   width: isMobile?width*0.55:tabWidth*0.55,
                          //                   child: Center(
                          //                     child: RichText(
                          //                       textAlign: TextAlign.center,
                          //                       text:  TextSpan(
                          //                           children: [
                          //                             TextSpan(text: 'Required', style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Colors.black,height: 1.5)),
                          //                             TextSpan(text: " items \nNeed To Be", style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color:Colors.black,height: 1.5)),
                          //                             TextSpan(text: ' Chosen\n', style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Colors.black87,height: 1.5)),
                          //                             TextSpan(text: "To Confirm / Execute \nThe", style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color:Colors.black87,height: 1.5)),
                          //                             TextSpan(text: ' Offer.', style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Colors.black,height: 1.5)),
                          //                           ]
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //               SizedBox(height: 10,),
                          //               Row(
                          //                 mainAxisAlignment: MainAxisAlignment.center,
                          //                 children: [
                          //                   Padding(
                          //                     padding: const EdgeInsets.only(bottom: 20),
                          //                     child: ElevatedButton(
                          //                         style: ElevatedButton.styleFrom(
                          //                             padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 2),
                          //                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor:Constants.primaryColor1, elevation: 1),
                          //                         onPressed: () {
                          //                           Navigator.pop(context);
                          //                         },
                          //                         child: Text("OK",style: WhiteButtonStyle18900,)),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       );
                          //     },);
                          //   },);
                          // var body = {
                          //   "offer_id" : OfferCounterData!.offer!.id.toString()
                          // };
                          //  DrawAuraAPi.CrateDataApi(body: body,ApiEndPoint: "checkOfferStatus").then((value) {
                          //    if(value["offer_status"] == "LIVE" ){
                          //
                          //    } else{
                          //
                          //      showDialog(context: context,
                          //        builder: (context) {
                          //          return  StatefulBuilder(builder: (context, setState) {
                          //            return Dialog(
                          //              alignment: Alignment.center,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                          //              elevation: BorderSide.strokeAlignOutside,
                          //              child: Container(
                          //                padding: EdgeInsets.only( top: 0,bottom: 0),
                          //                width: isMobile?width*0.85:tabWidth*0.85,
                          //                decoration:  BoxDecoration(color: Color(0x1A52B46B),
                          //                    borderRadius: BorderRadius.circular(7),
                          //                    border: Border.all(color: Constants.greyDark,width: 0.5)
                          //                ),
                          //                child: ListView(
                          //                  shrinkWrap: true,
                          //                  children: [
                          //                    Padding(
                          //                      padding: const EdgeInsets.only(top: 30),
                          //                      child: SizedBox(
                          //                        width: isMobile?width*0.55:tabWidth*0.55,
                          //                        child: Center(
                          //                          child: RichText(
                          //                            textAlign: TextAlign.center,
                          //                            text:  TextSpan(
                          //                                children: [
                          //                                  TextSpan(text: 'This Offer is Closed', style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Colors.black,height: 1.5)),
                          //                               ]
                          //                            ),
                          //                          ),
                          //                        ),
                          //                      ),
                          //                    ),
                          //                    SizedBox(height: 10,),
                          //                    Row(
                          //                      mainAxisAlignment: MainAxisAlignment.center,
                          //                      children: [
                          //                        Padding(
                          //                          padding: const EdgeInsets.only(bottom: 20),
                          //                          child: ElevatedButton(
                          //                              style: ElevatedButton.styleFrom(
                          //                                  padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 2),
                          //                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor:Constants.primaryColor, elevation: 1),
                          //                              onPressed: () {
                          //                                Navigator.pop(context);
                          //                              },
                          //                              child: Text("OK",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900,color: Constants.white),)),
                          //                        ),
                          //                      ],
                          //                    ),
                          //                  ],
                          //                ),
                          //              ),
                          //            );
                          //          },);
                          //        },);
                          //    }
                          //  });
                        },
                        child:PublishLoader == true?SizedBox(height:15,width: 15,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2.5,)):    Text(  selectedTap.toString().toUpperCase().trim() == "DUPLICATE"?"PUBLISH": isModifyCounterOffer == true?"Modify": "PUBLISH",style: WhiteButtonStyle16500,
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
                            image: DecorationImage(image: NetworkImage("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg"),)
                        ):  BoxDecoration(
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
