import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialapps/Apis/CommonApis.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/Auth/login_screen.dart';
import 'package:socialapps/constant/CustomMultiselect.dart';
import 'package:socialapps/constant/constant_function.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/GetCategoryListModal.dart';
import 'package:socialapps/model/GetKYCListModel.dart';
import 'package:socialapps/model/GetSegmentListModal.dart';
import 'package:socialapps/model/PrefillOfferDataModel.dart';
import 'package:socialapps/model/ServicePersonListModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapps/model/UnitListModel.dart';
import 'package:socialapps/model/filtterOfferDetailsModel.dart';
import 'package:socialapps/screens/GlobalSearch.dart';
import 'package:socialapps/screens/widgets/ImagePickeBottomSheet.dart';
import 'package:socialapps/screens/widgets/NewAddressPickers/NewAddressPickerList.dart';
import 'package:socialapps/screens/widgets/NewOfferPageWidget.dart';
import 'package:socialapps/screens/widgets/NewPeriodPicker/FromToDatePicker.dart';
import 'package:socialapps/screens/widgets/ShowDurationPicker.dart';
import 'package:socialapps/screens/widgets/SimmerLoadingBuilder.dart';
import 'package:socialapps/screens/widgets/upload_image_camera.dart';
import '../common/style.dart';
import '../constant/loading.dart';
import '../model/GetSubSegmentListModal.dart';
import 'Dashboard/dashboard_screen.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'widgets/NewOfferWidget/commonBottomSheet.dart';
import 'widgets/NewPeriodPicker/DromToTimePicker.dart';
import 'widgets/GuestLogInScreen.dart';
import 'widgets/NewFromScreenWidgets.dart';
import 'widgets/NewOfferImageListView.dart';
import 'widgets/NewPeriodPicker/ItemDatePicker.dart';
import 'widgets/NewPeriodPicker/ItemTimePicker.dart';
import 'package:get/get.dart';


class NewOfferCreateScreen extends StatefulWidget {
  String Address;
  String AddressTitle;
  String From ;
  PrefillOfferDataModel? PrefillOfferData;
  String Type;
  String OfferId;
   String SubId;
  NewOfferCreateScreen({Key? key,
    required this.Address,
    required this.AddressTitle,
    required this.From,
    required this.PrefillOfferData,
    required this.Type,
    required this.OfferId,
    required this.SubId,
  }) : super(key: key);

  @override
  State<NewOfferCreateScreen> createState() => _NewOfferCreateScreenState();
}

class _NewOfferCreateScreenState extends State<NewOfferCreateScreen> {
  bool cateLoader=false;
  bool segmentLoader=false;
  int _currentTapindex = 0;
  List<String> selectTypeList = [
    "Deliver",
    "Cancel",
    "Confirm",
    "Template",
    "Modify",
    "New"
  ];
  final List<String> priority = [
    'Normal',
    'Immediate',
    'Premium',
    'Urgent',
    'Low',
    'High'
  ];
  String ? selectedValuePriority;
  String selectedPeriodicityValue = "Today";
  var Img = "";
  File? PhotoImg;

  var searchCategoryId = "";
  var searchSegmentId = "";
  var searchSubSegmentId = "";
  var offerPeriodFromDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
  var offerPeriodToDate = "";
  var offerPeriodFromTime =  DateFormat('HH:mm').format(DateTime.now()).toString();
  var offerPeriodToTime = "";


  var offerExpiryDateTime = "${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}";


  TextEditingController searchCategoryController = TextEditingController();
  TextEditingController searchSegmentController = TextEditingController();
  TextEditingController searchSubSegmentController = TextEditingController();
  TextEditingController OfferDurationController = TextEditingController();


  TextEditingController OfferExpiryController = TextEditingController(text:DateFormat('dd-MMM-yyyy hh:mm a').format(DateTime.now()));
  TextEditingController OfferFromLocationController = TextEditingController();
  TextEditingController OfferToLocationController = TextEditingController();
  TextEditingController OfferAtLocationController = TextEditingController();



  TextEditingController OfferPeriodController = TextEditingController(text: "${DateFormat('dd-MMM-yyyy').format(DateTime.now())}");
  TextEditingController OfferPeriodTimeController = TextEditingController(text: "${ DateFormat('hh:mm a').format(DateTime.now())}");
  var maskFormatter = new MaskTextInputFormatter(
      mask: '##:##:##:##:##', filter: {"#": RegExp(r'[0-9]')});

  List<CategoryData> GetCategoryList = [];
  List<CategoryData> filterGetCategoryList = [];

  List<SegmentResult> getSegmentList = [];
  List<SegmentResult> filterGetSegmentList = [];

  List<SubSegmentResult> getSubSegmentList=[];
  List<SubSegmentResult> filterGetSubSegmentList=[];

  List<UnitListData> getUnitList = [];
  bool showOther = false;
  bool isloadNewCategory = false;
  int selectedCategoryIndex = -1;
  bool showOtherSegment = false;
  bool isloadNewSegment = false;
  int selectedSegmentIndex = -1;
  bool showOtherSubSegment = false;
  bool isloadNewSubSegment = false;
  bool isViewOfferFormLocation = true;
  bool isViewOfferToLocation = false;
  bool isViewOfferAtLocation = false;
  int Qty = 0;
  int itemCount = 1;
  SubSegmentResult? selectedSubSegmentValue;
  List<TextEditingController> serviceAreaList =[];
  List<dynamic> ItemsList = [];
  DateTime  ? OfferExpiryDateTime ;
  DateTime OfferFromDate  = DateTime.now().add(Duration(hours: 1));
  DateTime OfferFromTime = DateTime.now().add(Duration(minutes: 1));
  DateTime OfferToDate = DateTime.now().add(Duration(days: 60));
  DateTime OfferToTime =  DateTime.now().add(Duration(minutes: 2));

  bool isNewOfferNow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.From.toString() == "New"?isNewOfferNow = true:isNewOfferNow = false;
    getKYCList();
    addLoader = true;
    _getLocation();
    String EndPoint = "filterOffers";
    GetOfferForFill(EndPoint,setState,by: "All");
    loadInitDetails();
    isOwnerOfTemplateCheck();
  }
  @override
  void dispose(){
    super.dispose();
  }
  List<KYCDocData> KycDataList = [];
  getKYCList(){
    var body = {
      "user_id" : DataManager.getInstance().getuserId().toString().trim()
    };
    DrawAuraAPi.GetListData(body: body,ApiEndPoint: "getSubscriberKYCList").then((value) {
      if(mounted){
        setState(() {
          var data = GetKycListModel.fromJson(value);
          KycDataList = data.result!;
          KycDataList.isEmpty || KycDataList.length == 1 ?isPrivateOffer = true:isPrivateOffer =false;
          if(widget.From == "Fill"){
            isPrivateOffer = widget.PrefillOfferData!.privacy.toString().toUpperCase() == "PRIVATE" ? true:false;
          }
        });
      }
    });
  }
  
  TextEditingController addSearchController = TextEditingController();
  TextEditingController adressLocationController = TextEditingController();
  // TextEditingController OfferInstruction1Controller = TextEditingController(text:
  //     " ${DataManager.getInstance().getuserEmail().toString() == "" || DataManager.getInstance().getuserEmail().toString() == "null" ?"":
  //     "Email Id - ${DataManager.getInstance().getuserEmail().toString()},"}${ DataManager.getInstance().getUserSecMobile().toString() == "" || DataManager.getInstance().getUserSecMobile().toString() == "null" ?"":
  //     " Contact No. - ${DataManager.getInstance().getUserSecMobile().toString()}"}"
  // );
  TextEditingController OfferInstruction1Controller = TextEditingController(text: "${DataManager.getInstance().getuserEmail().toString()} ${DataManager.getInstance().getUserSecMobile().toString()}");
  //TextEditingController OfferInstruction2Controller = TextEditingController(text: "");
  late LatLng currentPostion;
  late LatLng pickedPosition;
  String? pickedAdress;
  var lat;
  var long;
  bool addLoader = false;
  bool isLoadAddress  =  false;
  LatLng ? LatitudeLongitude;
  _getLocation() async
  {
    if(mounted){
      setState(() {
        isLoadAddress = true;
      });
    }
    await Permission.location.request().then((value) async {
      if(value.isGranted){
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        debugPrint('location: ${position.latitude}');
        if(mounted){
          setState(() {
            LatitudeLongitude = LatLng(position.latitude, position.longitude);
          });
        }
        var addresses = await getAddressFromLatLong(position.latitude.toString(),position.longitude.toString());
        var first = addresses;
        final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
          if(mounted){
            setState(() {
              DisplayName = sharedpreferences.getString("UserDisplayName")??"";
              if(widget.Address == ""){
                saveAddressId = sharedpreferences.getString("SaveAddressId")??"0";
                saveAddressTitle = sharedpreferences.getString("SaveAddressTitle")??"Current Location";
                adressLocationController.text = sharedpreferences.getString("SaveAddress")??"${first}";
                _currentTapindex == 1 ?  OfferFromLocationController.text = adressLocationController.text :OfferToLocationController.text =  adressLocationController.text;
                isViewOfferToLocation=true;
                isLoadAddress = false;
              }else{
                saveAddressTitle =  widget.AddressTitle;
                adressLocationController.text =  widget.Address;
                isLoadAddress = false;
              }
            });
          }
      }else{
        Constants.showToast("Your location permission not allowed");
      }});
  }
  String selectedTap = "New";
  void _searchFilter(value,setModalState) {
    setState(() {
      filterGetCategoryList = GetCategoryList.where((name) => name.name!.toLowerCase().contains(value.toLowerCase())).toList();
      filterGetCategoryList.isEmpty ? showOther=true:showOther=false;
    });
    setModalState((){});
  }

  void _searchFilterSegment(value,setModalState) {
    setState(() {
      filterGetSegmentList = getSegmentList!.where((name) => name.name!.toLowerCase().contains(value.toLowerCase())).toList();
      filterGetSegmentList.isEmpty ? showOtherSegment=true:showOtherSegment=false;
    });
    setModalState((){});
  }

  void _searchFilterSubSegment(value,setModalState) {
    setState(() {
      filterGetSubSegmentList = getSubSegmentList!.where((name) => name.name!.toLowerCase().contains(value.toLowerCase())).toList();
      filterGetSubSegmentList.isEmpty ? showOtherSubSegment=true:showOtherSubSegment=false;
    });
  }

 bool isPeriodicityVisible = true;
 bool isDurationVisible = true;
 bool isPeriodVisible = true;
 bool isPeriodTimeVisible = true;
 bool isPriorityVisible = true;
 bool isServicePersonVisible = true;
 bool isExpiryVisible = true;
 List servicePersonCountList  =[TextEditingController()];

 bool isSinglePeriodSelect = true;
 DateTime  ? ExDTime;
 bool isAdvancePriceShow = false;
 bool isMaintancePriceShow =false;

 ///Item Offer

  bool isItemServicePersonVisible = true;
  bool isItemSinglePeriodSelect = true;
  DateTime  ? ItemExDTime;
  String? selectedValueItemPriority;
  String? selectedItemPeriodicityValue;
  bool OfferInstruction1Visible = true;
  bool OfferInstruction2Visible = true;
  bool PublishLoader = false;
  var saveAddressTitle;
  var saveAddressId;
  var DisplayName;
  bool isGetServicePerson = false;
  loadInitDetails(){

    if(widget.From == "Fill"){
      cateLoader=true;
      DrawAuraAPi.GetServicePersonList().then((value) {
        ServicePersonList.clear();
        ServicePersonList.add( ServicePersonListModel(
          id: 0,
          followers: 0,
          following: 0,
          displayname: "NEEDED",
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
        value.forEach((element) {
          if(element.displayname == null || element.displayname.toString() == "" ||element.displayname.toString() == "null" ){
          }else{
            ServicePersonList.add(element);
          }
        });
        Future.delayed(Duration(milliseconds: 200),() {
          setState(() {
            isGetServicePerson = true;
          });
        },);
      });
      setState(() {
        selectedItems = widget.PrefillOfferData!.offerConditions!.servicepersons.map((e) =>e).toList();
        isPrivateOffer = DataManager.getInstance().getUserIsPlaceType().toString() == "true"? widget.PrefillOfferData!.privacy.toString().toUpperCase() == "PRIVATE" ? true:false:
        KycDataList.isEmpty || KycDataList.length == 1?true:widget.PrefillOfferData!.privacy.toString().toUpperCase() == "PRIVATE" ? true:false;
      });
      DrawAuraAPi.getUnitList().then((value) {
       if(mounted){
         setState(() {
           getUnitList = value.result!;
         });
       }
      });
      DrawAuraAPi.getCategoryListApi().then((value) {
        GetCategoryList = value.result!;
        setState(() {
          cateLoader=false;
        });
      });
      DrawAuraAPi.getSegmentListApi(catId:  widget.PrefillOfferData!.category!.id.toString()).then((value) {
    if(mounted){
      setState(() {
        getSegmentList=value.result!;
      });
    }
      });
      DrawAuraAPi().getSubSegmentListApi(segId: widget.PrefillOfferData!.segment!.id.toString()).then((value) {
       if(mounted){
         setState(() {
           getSubSegmentList=value.result!;
         });
       }
      });
      for (var n = 0 ; n< widget.PrefillOfferData!.offerareas!.length ; n++){
        serviceAreaList.add(TextEditingController(text: widget.PrefillOfferData!.offerareas![n].address.toString()));
      }
      Future.delayed(Duration(milliseconds: 50),() async{
        final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
        final fromPeriodDate = widget.PrefillOfferData!.offerConditions!.fromPeriod== null ?"": widget.PrefillOfferData!.offerConditions!.fromPeriod.toString();
        final fromPeriodTime = widget.PrefillOfferData!.offerConditions!.fromPeriodTime==null?"":widget.PrefillOfferData!.offerConditions!.fromPeriodTime.toString();
        final toPeriodDate =widget.PrefillOfferData!.offerConditions!.toPeriod== null ?"": widget.PrefillOfferData!.offerConditions!.toPeriod.toString();
        final toPeriodTime = widget.PrefillOfferData!.offerConditions!.toPeriodTime == null?"": widget.PrefillOfferData!.offerConditions!.toPeriodTime.toString();

        setState(() {
          DisplayName = sharedpreferences.getString("UserDisplayName")??"";
          searchCategoryController.text = widget.PrefillOfferData!.category!.name.toString();
          searchSegmentController.text =  widget.PrefillOfferData!.segment!.name.toString();
          searchSubSegmentController.text = widget.PrefillOfferData!.subsegment!.name.toString();
          searchCategoryId = widget.PrefillOfferData!.category!.id.toString();
          searchSegmentId = widget.PrefillOfferData!.segment!.id.toString();
          searchSubSegmentId =  widget.PrefillOfferData!.subsegment!.id.toString();
          adressLocationController.text =  widget.PrefillOfferData!.addres.toString();
          selectedTap = "New";
          _currentTapindex = widget.PrefillOfferData!.buyORsell.toString() == "BUY"?0:1;
           selectedPeriodicityValue = widget.PrefillOfferData!.offerConditions!.periodicity.toString()=="null"?"": widget.PrefillOfferData!.offerConditions!.periodicity.toString().trim();
           selectedValuePriority = widget.PrefillOfferData!.offerConditions!.priority.toString() == "null"?"": widget.PrefillOfferData!.offerConditions!.priority.toString().trim();

        //  OfferDurationController.text = widget.PrefillOfferData!.offerConditions!.duration==null?"": widget.PrefillOfferData!.offerConditions!.duration.toString();
          OfferDurationController.text = "";

            if(widget.PrefillOfferData!.offerConditions!.expiry == null || widget.PrefillOfferData!.offerConditions!.expiry == ""){
              DateTime now = DateTime.now();
              var NewDate =  "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}";
              OfferExpiryController.text = NewDate;
              offerExpiryDateTime = NewDate;
            }else{
              DateTime OExpiry = DateFormat('dd/MM/yyyy HH:mm:ss').parse('${ widget.PrefillOfferData!.offerConditions!.expiry.toString().replaceAll("-","/")}:00');
              bool isOldDate = OExpiry.isBefore(DateTime.now());
              if(isOldDate){
                DateTime now = DateTime.now();
                var NewDate =  "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}";
                 OfferExpiryController.text = NewDate;
                offerExpiryDateTime = NewDate;
              }
              else{
                OfferExpiryController.text = widget.PrefillOfferData!.offerConditions!.expiry.toString();
                offerExpiryDateTime = widget.PrefillOfferData!.offerConditions!.expiry.toString();
                ExDTime =  widget.PrefillOfferData!.offerConditions!.expiry==null ? null : DateFormat('dd/MM/yyyy HH:mm:ss').parse('${ widget.PrefillOfferData!.offerConditions!.expiry.toString().replaceAll("-","/")}:00');
              }
            }

          if(selectedPeriodicityValue == ""){
            selectedPeriodicityValue = "Today";
            final  STime = DateFormat('hh:mm a').format(DateTime.now());
            OfferPeriodTimeController.text = "${STime}";
            offerPeriodFromTime="";
            offerPeriodToTime="";
            final  STime24 = DateFormat('HH:mm').format(DateTime.now());
            offerPeriodFromTime = STime24.toString();
            OfferFromTime = DateTime.now();
            OfferToTime = DateTime.now().add(Duration(minutes: 2));
          }else{
            if(selectedPeriodicityValue == "Today" || selectedPeriodicityValue == "Tomorrow"){
              final  STime = DateFormat('hh:mm a').format(DateTime.now());
              OfferPeriodTimeController.text = "${STime}";
              offerPeriodFromTime="";
              offerPeriodToTime="";
              final  STime24 = DateFormat('HH:mm').format(DateTime.now());
              offerPeriodFromTime = STime24.toString();
              OfferFromTime = DateTime.now();
              OfferToTime = DateTime.now().add(Duration(minutes: 2));
            }else{
              if( widget.PrefillOfferData!.offerConditions!.fromPeriod == null ||  widget.PrefillOfferData!.offerConditions!.fromPeriod.toString() == "" ){
                final  STime = DateFormat('dd-MMM-yyyy').format(DateTime.now());
                OfferPeriodController.text = "${STime}";
                final  SDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                offerPeriodFromTime="";
                offerPeriodFromDate="";
                offerPeriodToDate="";
                offerPeriodToTime="";
                offerPeriodFromDate = SDate.toString();
                OfferFromDate  = DateTime.now();
                final  TimeF = DateFormat('hh:mm a').format(DateTime.now());
                OfferPeriodTimeController.text = "${TimeF}";
                offerPeriodFromTime="";
                offerPeriodToTime="";
                final  STime24 = DateFormat('HH:mm').format(DateTime.now());
                offerPeriodFromTime = STime24.toString();
                OfferFromTime = DateTime.now();
                OfferToTime = DateTime.now().add(Duration(minutes: 2));
              }
              else{


                DateTime OPeriodDate = widget.PrefillOfferData!.offerConditions!.fromPeriodTime == null || widget.PrefillOfferData!.offerConditions!.fromPeriodTime.toString() == "null" || widget.PrefillOfferData!.offerConditions!.fromPeriodTime.toString() == ""?

                DateFormat('dd/MM/yyyy HH:mm:ss').parse('${  widget.PrefillOfferData!.offerConditions!.fromPeriod.toString().replaceAll("-","/")} 00:00:00'):
                DateFormat('dd/MM/yyyy HH:mm:ss').parse('${  widget.PrefillOfferData!.offerConditions!.fromPeriod.toString().replaceAll("-","/")} ${widget.PrefillOfferData!.offerConditions!.fromPeriodTime}');
                bool isOldDate = OPeriodDate.isBefore(DateTime.now());
                if(isOldDate){
                  final  STime = DateFormat('dd-MMM-yyyy').format(DateTime.now());
                  OfferPeriodController.text = "${STime}";
                  final  SDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                  offerPeriodFromTime="";
                  offerPeriodFromDate="";
                  offerPeriodToDate="";
                  offerPeriodToTime="";
                  offerPeriodFromDate = SDate.toString();
                  OfferFromDate  = DateTime.now();
                  final  TimeF = DateFormat('hh:mm a').format(DateTime.now());
                  OfferPeriodTimeController.text = "${TimeF}";
                  offerPeriodFromTime="";
                  offerPeriodToTime="";
                  final  STime24 = DateFormat('HH:mm').format(DateTime.now());
                  offerPeriodFromTime = STime24.toString();
                  OfferFromTime = DateTime.now();
                  OfferToTime = DateTime.now().add(Duration(minutes: 2));
                }else{
                  OfferPeriodTimeController.text = "${fromPeriodTime=="" && toPeriodTime==""?"": toPeriodTime != ""? fromPeriodTime +" To "+toPeriodTime : fromPeriodTime}";
                  OfferPeriodController.text = "${fromPeriodTime=="" && toPeriodDate=="" ?"": toPeriodDate !=  ""? fromPeriodDate+" To " + toPeriodDate :fromPeriodDate}";
                  offerPeriodFromDate =  widget.PrefillOfferData!.offerConditions!.fromPeriod == null ? "": widget.PrefillOfferData!.offerConditions!.fromPeriod;
                  offerPeriodToDate = widget.PrefillOfferData!.offerConditions!.toPeriod == null ? "": widget.PrefillOfferData!.offerConditions!.toPeriod;
                  offerPeriodFromTime = widget.PrefillOfferData!.offerConditions!.fromPeriodTime == null ? "": "${widget.PrefillOfferData!.offerConditions!.fromPeriodTime.toString().split(":")[0]}:${widget.PrefillOfferData!.offerConditions!.fromPeriodTime.toString().split(":")[1]}";
                  offerPeriodToTime = widget.PrefillOfferData!.offerConditions!.toPeriodTime == null ? "": "${widget.PrefillOfferData!.offerConditions!.toPeriodTime.toString().split(":")[0]}:${widget.PrefillOfferData!.offerConditions!.toPeriodTime.toString().split(":")[1]}";
                  DateTime FromDatePeriod = fromPeriodDate == ""  ? DateTime.now().add(Duration(days: 60)) :
                  fromPeriodTime == "" ?DateFormat('dd/MM/yyyy HH:mm:ss').parse('${fromPeriodDate.replaceAll("-","/")} 00:00:00.000'):
                  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${fromPeriodDate.replaceAll("-","/")} $fromPeriodTime');
                  DateTime toDatePeriod = toPeriodDate == "" ?DateTime.now().add(Duration(days: 60)) :
                  toPeriodTime == ""? DateFormat('dd/MM/yyyy HH:mm:ss').parse('${toPeriodDate.replaceAll("-","/")} 00:00:00.000'):
                  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${toPeriodDate.replaceAll("-","/")} $toPeriodTime');
                  OfferFromDate =   FromDatePeriod;
                  OfferToDate = toDatePeriod;
                  DateTime FromTimePeriod = selectedPeriodicityValue.toString().toUpperCase() == "TODAY" ? fromPeriodTime != "" ?  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().day.toString().length == 1 ?"0${DateTime.now().day}":DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} $fromPeriodTime') : DateTime.now().add(Duration(days: 1)) :
                  selectedPeriodicityValue.toString().toUpperCase() == "TOMORROW" ? fromPeriodTime != "" ?  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().add(Duration(days: 1)).day.toString().length == 1 ?"0${DateTime.now().add(Duration(days: 1)).day}":DateTime.now().add(Duration(days: 1)).day}/${DateTime.now().month}/${DateTime.now().year} $fromPeriodTime'): DateTime.now().add(Duration(days: 1)): DateTime.now().add(Duration(days: 1));
                  OfferFromTime = FromTimePeriod;
                  DateTime ToTimePeriod = selectedPeriodicityValue.toString().toUpperCase() == "TODAY" ? toPeriodTime != "" ? DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().day.toString().length == 1 ?"0${DateTime.now().day}":DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} $toPeriodTime') : DateTime.now().add(Duration(days: 1)) :
                  selectedPeriodicityValue.toString().toUpperCase() == "TOMORROW" ? toPeriodTime != "" ? DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().add(Duration(days: 1)).day.toString().length == 1 ?"0${DateTime.now().add(Duration(days: 1)).day}":DateTime.now().add(Duration(days: 1)).day}/${DateTime.now().month}/${DateTime.now().year} $toPeriodTime') : DateTime.now().add(Duration(days: 1)): DateTime.now().add(Duration(days: 1));
                  OfferToTime = ToTimePeriod;
                }

              }
            }
          }

          OfferFromLocationController.text =  widget.PrefillOfferData!.offerConditions!.fromlocation.toString();
          OfferToLocationController.text =  widget.PrefillOfferData!.offerConditions!.tolocation.toString();
          OfferAtLocationController.text =  widget.PrefillOfferData!.offerConditions!.atlocation.toString();
          isViewOfferFormLocation=true;
          isViewOfferToLocation=true;
          isViewOfferAtLocation=true;


          OfferInstruction1Controller.text = widget.PrefillOfferData!.offerBids!.isEmpty? "":  widget.PrefillOfferData!.offerBids!.first.comments.toString();
          // OfferInstruction2Controller.text = widget.PrefillOfferData!.offerBids!.length == 1 || widget.PrefillOfferData!.offerBids!.isEmpty ? "":widget.PrefillOfferData!.offerBids![1].comments.toString();
        });
        for(var i = 0 ; i<widget.PrefillOfferData!.offerItems!.length ; i++){
          List<UnitListData> TempUnitList = [];
          List selectedItemsPersonList = [];
           selectedItemsPersonList = widget.PrefillOfferData!.offerItems![i].offerItemConditions!.servicepersons!.map((e) =>e).toList();
          final imageMedia = [];
          final fileUrls = [];
          for(var j = 0 ; j< widget.PrefillOfferData!.offerItems![i].itemMedia!.length ; j++){
            imageMedia.add({
              "file":"${ widget.PrefillOfferData!.offerItems![i].itemMedia![j]["id"]}",
              "name": "${widget.PrefillOfferData!.offerItems![i].itemMedia![j]["name"]}"
            });
            fileUrls.add(
              "${widget.PrefillOfferData!.offerItems![i].itemMedia![j]["file"]}",
            );
          }
          final fromPeriodDate = widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiod== null ?"": widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiod.toString();
          final fromPeriodTime = widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiodtime==null?"":widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiodtime.toString();
          final toPeriodDate = widget.PrefillOfferData!.offerItems![i].offerItemConditions!.toperiod == null ?"": widget.PrefillOfferData!.offerItems![i].offerItemConditions!.toperiod.toString();
          final toPeriodTime = widget.PrefillOfferData!.offerItems![i].offerItemConditions!.toperiodtime == null?"":widget.PrefillOfferData!.offerItems![i].offerItemConditions!.toperiodtime.toString();
          String ExpiryDate = "";
          final ExDTimeItem ;
          if(widget.PrefillOfferData!.offerItems![i].offerItemConditions!.expiry == null || widget.PrefillOfferData!.offerItems![i].offerItemConditions!.expiry == ""){
            DateTime now = DateTime.now();
            var NewDate =  "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}";
            ExpiryDate = NewDate;
            ExDTimeItem = null;
          }else{
            DateTime OExpiry = DateFormat('dd/MM/yyyy HH:mm:ss').parse('${ widget.PrefillOfferData!.offerItems![i].offerItemConditions!.expiry.toString().toString().replaceAll("-","/")}:00.000');
            bool isOldDate = OExpiry.isBefore(DateTime.now());
            if(isOldDate){
              DateTime now = DateTime.now();
              var NewDate =  "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}";
              ExpiryDate = NewDate;
              ExDTimeItem = null;
            }else{
              ExpiryDate = widget.PrefillOfferData!.offerItems![i].offerItemConditions!.expiry.toString();
              ExDTimeItem = DateFormat('dd/MM/yyyy HH:mm:ss').parse('${ widget.PrefillOfferData!.offerItems![i].offerItemConditions!.expiry.toString().replaceAll("-","/")}:00');
            }
          }
          String periodController = "";
          String periodTimeController = "";
          String ApiFromDate = "";
          String ApiToDate = "";
          String ApiFromTIme = "";
          String ApiToTIme = "";
          DateTime ? FillFromDate ;
          DateTime ?FillFromTime ;
          DateTime ?FillToDate ;
          DateTime ?FillToTime ;

          if(widget.PrefillOfferData!.offerItems![i].offerItemConditions!.periodicity == ""){

            final  STime = DateFormat('hh:mm a').format(DateTime.now());
            periodTimeController = "${STime}";

            final  STime24 = DateFormat('HH:mm').format(DateTime.now());
            ApiFromTIme = STime24.toString();
            FillFromTime = DateTime.now();
          }else{
            if(widget.PrefillOfferData!.offerItems![i].offerItemConditions!.periodicity == "Today" || widget.PrefillOfferData!.offerItems![i].offerItemConditions!.periodicity == "Tomorrow"){
              final  STime = DateFormat('hh:mm a').format(DateTime.now());
              periodTimeController = "${STime}";

              final  STime24 = DateFormat('HH:mm').format(DateTime.now());
              ApiFromTIme = STime24.toString();
              FillFromTime = DateTime.now();
            }else{
              if(widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiod == null ||  widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiod.toString() == "" ){
                final  STime = DateFormat('dd-MMM-yyyy').format(DateTime.now());
                periodController = "${STime}";
                final  SDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

                ApiFromDate = SDate.toString();
                FillFromDate  = DateTime.now();
                final  TimeF = DateFormat('hh:mm a').format(DateTime.now());
                periodTimeController = "${TimeF}";

                final  STime24 = DateFormat('HH:mm').format(DateTime.now());
                ApiFromTIme = STime24.toString();
                FillFromTime = DateTime.now();
              }
              else{


                DateTime OPeriodDate = widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiodtime == null || widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiodtime.toString() == "null" || widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiodtime.toString() == ""?

                DateFormat('dd/MM/yyyy HH:mm:ss').parse('${  widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiod.toString().replaceAll("-","/")} 00:00:00'):
                DateFormat('dd/MM/yyyy HH:mm:ss').parse('${  widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiod.toString().replaceAll("-","/")} ${widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiodtime}');
                bool isOldDate = OPeriodDate.isBefore(DateTime.now());
                if(isOldDate){
                  final  STime = DateFormat('dd-MMM-yyyy').format(DateTime.now());
                  periodController = "${STime}";
                  final  SDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

                  ApiFromDate = SDate.toString();
                  FillFromDate  = DateTime.now();
                  final  TimeF = DateFormat('hh:mm a').format(DateTime.now());
                  periodTimeController = "${TimeF}";

                  final  STime24 = DateFormat('HH:mm').format(DateTime.now());
                  ApiFromTIme = STime24.toString();
                  FillFromTime = DateTime.now();
                }else{
                  periodTimeController = "${fromPeriodTime=="" && toPeriodTime==""?"": toPeriodTime != ""?fromPeriodTime +" To "+toPeriodTime :fromPeriodTime}";
                  periodController = "${fromPeriodTime=="" && toPeriodDate=="" ?"": toPeriodDate !=  ""?fromPeriodDate+" To " + toPeriodDate :fromPeriodDate}";
                  ApiFromDate = widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiod == null ? "": widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiod.toString();
                  ApiToDate = widget.PrefillOfferData!.offerItems![i].offerItemConditions!.toperiod == null ? "": widget.PrefillOfferData!.offerItems![i].offerItemConditions!.toperiod.toString();
                  ApiFromTIme = widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiodtime == null ? "": "${widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiodtime.toString().split(":")[0]}:${widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromperiodtime.toString().split(":")[1]}";
                  ApiToTIme = widget.PrefillOfferData!.offerItems![i].offerItemConditions!.toperiodtime == null ? "": "${widget.PrefillOfferData!.offerItems![i].offerItemConditions!.toperiodtime.toString().split(":")[0]}:${widget.PrefillOfferData!.offerItems![i].offerItemConditions!.toperiodtime.toString().split(":")[1]}";
                  DateTime FromDatePeriod = fromPeriodDate == ""  ? DateTime.now().add(Duration(days: 60)) :
                  fromPeriodTime == "" ?DateFormat('dd/MM/yyyy HH:mm:ss').parse('${fromPeriodDate.replaceAll("-","/")} 00:00:00.000'):
                  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${fromPeriodDate.replaceAll("-","/")} $fromPeriodTime');
                  DateTime toDatePeriod = toPeriodDate == "" ?DateTime.now().add(Duration(days: 60)) :
                  toPeriodTime == ""? DateFormat('dd/MM/yyyy HH:mm:ss').parse('${toPeriodDate.replaceAll("-","/")} 00:00:00.000'):
                  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${toPeriodDate.replaceAll("-","/")} $toPeriodTime');
                  FillFromDate =   FromDatePeriod;
                  FillToDate = toDatePeriod;
                  DateTime FromTimePeriod =widget.PrefillOfferData!.offerItems![i].offerItemConditions!.periodicity.toString().toUpperCase() == "TODAY" ? fromPeriodTime != "" ?  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().day.toString().length == 1 ?"0${DateTime.now().day}":DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} $fromPeriodTime') : DateTime.now().add(Duration(days: 1)) :
                  widget.PrefillOfferData!.offerItems![i].offerItemConditions!.periodicity.toString().toUpperCase() == "TOMORROW" ? fromPeriodTime != "" ?  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().add(Duration(days: 1)).day.toString().length == 1 ?"0${DateTime.now().add(Duration(days: 1)).day}":DateTime.now().add(Duration(days: 1)).day}/${DateTime.now().month}/${DateTime.now().year} $fromPeriodTime'): DateTime.now().add(Duration(days: 1)): DateTime.now().add(Duration(days: 1));
                  FillFromTime = FromTimePeriod;
                  DateTime ToTimePeriod = selectedPeriodicityValue.toString().toUpperCase() == "TODAY" ? toPeriodTime != "" ? DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().day.toString().length == 1 ?"0${DateTime.now().day}":DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} $toPeriodTime') : DateTime.now().add(Duration(days: 1)) :
                  widget.PrefillOfferData!.offerItems![i].offerItemConditions!.periodicity.toString().toUpperCase() == "TOMORROW" ? toPeriodTime != "" ? DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().add(Duration(days: 1)).day.toString().length == 1 ?"0${DateTime.now().add(Duration(days: 1)).day}":DateTime.now().add(Duration(days: 1)).day}/${DateTime.now().month}/${DateTime.now().year} $toPeriodTime') : DateTime.now().add(Duration(days: 1)): DateTime.now().add(Duration(days: 1));
                  FillToTime = ToTimePeriod;
                }

              }
            }
          }


          ItemsList.add({
            "itemId":widget.PrefillOfferData!.offerItems![i].id.toString(),
            "name":TextEditingController(text: widget.PrefillOfferData!.offerItems![i].name.toString()),
            "desc":TextEditingController(text: widget.PrefillOfferData!.offerItems![i].desc.toString()),
            "price":TextEditingController(text:  widget.PrefillOfferData!.offerItems![i].price.toString() == "null" ?"":  widget.PrefillOfferData!.offerItems![i].price.toString()),
            "unit":TextEditingController(text:  widget.PrefillOfferData!.offerItems![i].unit!.name.toString() == "null" ?"":widget.PrefillOfferData!.offerItems![i].unit!.name.toString()),
            "AdvancePrice" : TextEditingController(text :widget.PrefillOfferData!.offerItems![i].advancePrice == null ? "":  widget.PrefillOfferData!.offerItems![i].advancePrice.toString()),
            "AdvanceUnit" : TextEditingController(text :widget.PrefillOfferData!.offerItems![i].advanceUnit!.name == null ? "" :  widget.PrefillOfferData!.offerItems![i].advanceUnit!.name.toString()),
            "MaintenancePrice" : TextEditingController(text :  widget.PrefillOfferData!.offerItems![i].maintenancePrice == null ? "": widget.PrefillOfferData!.offerItems![i].maintenancePrice.toString()),
            "MaintenanceUnit" : TextEditingController(text : widget.PrefillOfferData!.offerItems![i].maintenanceUnit!.name == null ? "" : widget.PrefillOfferData!.offerItems![i].maintenanceUnit!.name.toString()),
            "filterGetUnitList" : TempUnitList,
            "showOtherUnit" : false,
            "isLoadNewUnit" : false,
            "selectedUnitIndex" : -1,
            "SelectedUnitId" : widget.PrefillOfferData!.offerItems![i].unit == null ? null : widget.PrefillOfferData!.offerItems![i].unit!.id.toString() ,
            "filterGetUnitListMain" : TempUnitList,
            "showOtherUnitMain" : false,
            "isLoadNewUnitMain" : false,
            "selectedUnitIndexMain" : -1,
            "SelectedUnitIdMain" : widget.PrefillOfferData!.offerItems![i].maintenanceUnit == null ? null :widget.PrefillOfferData!.offerItems![i].maintenanceUnit!.id.toString(),

            "filterGetUnitListAdva" : TempUnitList,
            "showOtherUnitAdva" : false,
            "isLoadNewUnitAdva" : false,
            "selectedUnitIndexAdva" : -1,
            "SelectedUnitIdAdva" :  widget.PrefillOfferData!.offerItems![i].advanceUnit == null ? null :widget.PrefillOfferData!.offerItems![i].advanceUnit!.id.toString(),
            "fillSelectedPerson" : selectedItemsPersonList,
            "type" : "old",

            "quantity": widget.PrefillOfferData!.offerItems![i].quantity,
            "currency":"INR",
            "addon":false,
            "required":false,
            "toggle_state":false,
            "media":imageMedia,
            "isLoadingFile":false,
            "fileUrl":fileUrls,

            "item_condition":{
              "itemDisableFields":[],
              "itemConditionId":widget.PrefillOfferData!.offerItems![i].offerItemConditions!.id.toString(),
              "periodicity":widget.PrefillOfferData!.offerItems![i].offerItemConditions!.periodicity.toString() == ""? "Today":widget.PrefillOfferData!.offerItems![i].offerItemConditions!.periodicity.toString(),
              "priority":widget.PrefillOfferData!.offerItems![i].offerItemConditions!.priority.toString(),
              "periodTime":TextEditingController(text:"${periodTimeController}"),
              "period":TextEditingController(text:  "${periodController}"),
              "fromperiod": ApiFromDate,
              "toperiod": ApiToDate,
              "duration": TextEditingController(text: widget.PrefillOfferData!.offerItems![i].offerItemConditions!.duration.toString()),
              "fromperiodtime":ApiFromTIme,
              "toperiodtime":ApiToTIme,
              "durationoftime":"",
              "fromlocation":TextEditingController(text: widget.PrefillOfferData!.offerItems![i].offerItemConditions!.fromlocation.toString()),
              "tolocation":TextEditingController(text: widget.PrefillOfferData!.offerItems![i].offerItemConditions!.tolocation.toString()),
              "atlocation":TextEditingController(text: widget.PrefillOfferData!.offerItems![i].offerItemConditions!.atlocation.toString()),
              "servicepersons":selectedItemsPersonList,
              "expiry": TextEditingController(text:ExpiryDate),
              "ExpiryDateTime" : ExDTimeItem,
              "FromPeriodDateFill" : FillFromDate,
              "ToPeriodDateFill" : FillToDate,
              "FromPeriodTimeFill" : FillFromTime,
              "ToPeriodTimeFIll" : FillToTime,
            },
            "isShowItem": true,
            "showItemPriceMain":true,
            "showItemQty":true,
            "showMediaData":true,
            "showItemPrice2":false,
            "showItemPrice3":false,
            "showItemCondition": false,
            "showItemPeriodicity" :true,
            "showItemPeriod" :true,
            "showItemPeriodTime" :true,
            "isItemSinglePeriodSelect" :true,
            "showItemDuration" :true,
            "showItemServicePerson1" :true,
            "showItemServicePerson2" :false,
            "showItemServicePerson3" :false,
            "showItemServicePerson4" :false,
            "showItemServicePerson5" :false,
            "showItemPriority" :true,
            "showItemExpiry" :true,
            "showItemFromLocation" :true,
            "showItemTOLocation" :false,
            "showItemAtLocation" :false,
            "showOfferBids1" :true,
            "showOfferBids2" :false,
          });
        }
        Future.delayed(Duration(seconds: 3),() {
          if(mounted){
            setState(() {
              cateLoader=false;
            });
          }
        },);
      },);
    }
    else{
      cateLoader=true;
      DrawAuraAPi.getUnitList().then((value) {
       if(mounted){
         setState(() {
           getUnitList = value.result!;
         });
       }
      });
      DrawAuraAPi.GetServicePersonList().then((value) {
        ServicePersonList.clear();
        ServicePersonList.add( ServicePersonListModel(
          id: 0,
          followers: 0,
          following: 0,
          displayname: "NEEDED",
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
        value.forEach((element) {
          if(element.displayname == null || element.displayname.toString() == "" ||element.displayname.toString() == "null" ){
          }else{
            ServicePersonList.add(element);
          }
        });
        Future.delayed(Duration(milliseconds: 200),() {
          setState(() {
            isGetServicePerson = true;
          });
        },);
       
      });
      DrawAuraAPi.getCategoryListApi().then((value) {
        GetCategoryList = value.result!;
        if(mounted){
          setState(() {
            // print(DataManager.getInstance().getOfferArea().toString());
            List serviceTemp = DataManager.getInstance().getOfferArea().toString() == "null" || DataManager.getInstance().getOfferArea() == "null" || DataManager.getInstance().getOfferArea() == "" ? []:jsonDecode("${DataManager.getInstance().getOfferArea().toString()}");
            serviceAreaList = serviceTemp.isEmpty ? [TextEditingController(text: "")]: serviceTemp.map((e) => TextEditingController(text: e["Address"])).toList();
            _currentTapindex == 1 ?  OfferFromLocationController.text = adressLocationController.text :OfferToLocationController.text =  adressLocationController.text;
            isViewOfferToLocation = true;
            cateLoader=false;
          });
        }
      });
      List<UnitListData> TempUnitList = [];
      List selectedItemsPersonList = [];
      Future.delayed(Duration( milliseconds: 500),() {
        var offerPeriodFromDate = "";
        var offerPeriodToDate = "";
        var offerPeriodFromTime = "";
        var offerPeriodToTime = "";
        DateTime OfferFromDate  = DateTime.now().add(Duration(hours: 1));
        DateTime OfferFromTime = DateTime.now().add(Duration(minutes: 1));
        DateTime OfferToDate = DateTime.now().add(Duration(days: 60));
        DateTime OfferToTime = DateTime.now().add(Duration(minutes: 2));
        if(mounted){
          setState(() {
            ItemsList.add({

              "itemId" :"",
              "name":TextEditingController(text: ""),
              "desc":TextEditingController(text: ""),
              "price":TextEditingController(text: ""),
              "unit":TextEditingController(text: ""),
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
              "type" : "new",

              "quantity":1,
              "currency":"INR",
              "addon":false,
              "required":false,
              "toggle_state":false,
              "media":[],
              "fileUrl":[],
              "isLoadingFile":false,

              "item_condition":{
                 "itemDisableFields":[],
                "itemConditionId":"",
                "periodicity":null,
                "period":TextEditingController(text: ""),
                "periodTime": TextEditingController(text: ""),
                "fromperiod":"",
                "toperiod":"",
                "fromperiodtime":"",
                "toperiodtime":"",
                "duration": TextEditingController(text: ""),
                "durationoftime":"",
                "fromlocation": TextEditingController(text : ""),
                "tolocation": TextEditingController(text:""),
                "atlocation":TextEditingController(text: ""),
                "servicepersons": selectedItemsPersonList,
                "priority":"",
                "expiry":TextEditingController(text: ""),
                "ExpiryDateTime" : ItemExDTime,
                "FromPeriodDateFill" : OfferFromDate,
                "ToPeriodDateFill" : OfferToDate,
                "FromPeriodTimeFill" : OfferFromTime,
                "ToPeriodTimeFIll" : OfferToTime,
              },
              "showItemPriceMain":true,
              "showItemQty":true,
              "isShowItem": true,
              "showItemPrice2":false,
              "showItemPrice3":false,
              "showItemCondition": false,
              "showItemPeriodicity" :true,
              "showItemPeriod" :true,
              "showItemPeriodTime" :true,
              "isItemSinglePeriodSelect" :true,
              "showItemDuration" :true,
              "showItemServicePerson1" :true,
              "showItemServicePerson2" :false,
              "showItemServicePerson3" :false,
              "showItemServicePerson4" :false,
              "showItemServicePerson5" :false,
              "showItemPriority" :true,
              "showItemExpiry" :true,
              "showItemFromLocation" :true,
              "showItemTOLocation" :true,
              "showItemAtLocation" :false,
              "showOfferBids1" :true,
              "showOfferBids2" :false,
            }
            );
          });
        }
      },);
    }
  }

   List selectedItems = [];

  List<ServicePersonListModel> ServicePersonList = [];
/// Periodicity Lists

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
  final List<String> periodicityTodayList = [
    "Today"
  ];
  final List<String> periodicityTomorrowList = [
    "Tomorrow"
  ];
  final List<String> periodicityWeeklyList = [
    "Weekly"
  ];
  final List<String> periodicityYearlyList = [
    "Yearly"
  ];
  final List<String> periodicityMonthlyList = [
    "Monthly"
  ];
  final List<String> periodicityOnceList = [
    "Once"
  ];

  List <FiltterOfferDetailsModel> filterOfferbyCatList = [];
  List <FiltterOfferDetailsModel> filterOfferbySegList = [];
  List <FiltterOfferDetailsModel> filterOfferbySubSegList = [];
  List <FiltterOfferDetailsModel> filterOfferNameMainList = [];
  List <FiltterOfferDetailsModel> filterOfferNameList = [];
  List <FiltterOfferDetailsModel> OfferListByName = [];
  bool isLoadingFilterOffer = false;
  bool isLoadingFillOffer = false;
  bool isPrivateOffer = false;
  bool isOwnerOfTemplate = false;

  isOwnerOfTemplateCheck(){

    if(widget.Type == "Template"){
      if(widget.SubId.toString().trim() == DataManager.getInstance().getuserId().toString()){
        if(mounted){
          setState(() {
            isOwnerOfTemplate = true;
          });
        }
        Future.delayed(Duration(seconds: 1),() {
          if(mounted){
            setState(() {
              selectedTap = "Modify";
              print("Update");
            });
          }
        },);
      }
    }else{
      if(mounted){
        setState(() {
          isOwnerOfTemplate = false;
        });
      }
    }
  }
  List offerDisableFields = [];
  bool isGettingSearchOffer = false;
  GetOfferForFill(EndPoint,setModalState,{required String by}){
    setState(() {
      isGettingSearchOffer = true;
    });
    DrawAuraAPi.GetFilterOfferListFromParam(EndPoint).then((value) {
      print(value.length);
      if(mounted){
        setState(() {
          isGettingSearchOffer = false;
          filterOfferbyCatList =[];
          filterOfferbySegList =[];
          filterOfferbySubSegList =[];
          filterOfferNameMainList=[];
          filterOfferNameList=[];
        });
      }

      if(by == "Cat"){

        if(value.isEmpty){
          setState(() {
            filterOfferbyCatList = [];
            isLoadingFilterOffer = false;
          });
          setModalState((){});
        }else {
          if(mounted){
            setState(() {
              filterOfferbyCatList = value;

              List TempNameList = [];
              value.forEach((element) {
                if(TempNameList.contains(element.offerItems!.first.name.toString().toUpperCase().trim())){
                }else{
                  TempNameList.add(element.offerItems!.first.name.toString().toUpperCase().trim());
                  filterOfferNameMainList.add(element);
                }
              });
              isLoadingFilterOffer = false;
            });
            setModalState((){});
          }
        }
      }else if(by == "Seg"){

        if(value.isEmpty){
          setState(() {
            filterOfferbySegList =[];
            isLoadingFilterOffer = false;
          });
          setModalState((){});
        }else {
          if(mounted){
            setState(() {
              filterOfferbySegList = value;
              List TempNameList = [];
              value.forEach((element) {
                if(TempNameList.contains(element.offerItems!.first.name.toString().toUpperCase().trim())){
                }else{
                  TempNameList.add(element.offerItems!.first.name.toString().toUpperCase().trim());
                  filterOfferNameMainList.add(element);
                }
              });
              isLoadingFilterOffer = false;
            });
            setModalState((){});
          }
        }
      }else if(by =="SubSeg"){

        if(value.isEmpty){
          setState(() {
            filterOfferbySubSegList =[];
            isLoadingFilterOffer = false;
          });       setModalState((){});
        }else {
          if(mounted){
            setState(() {
              List TempNameList = [];
              value.forEach((element) {
                if(TempNameList.contains(element.offerItems!.first.name.toString().toUpperCase().trim())){
                }else{
                  TempNameList.add(element.offerItems!.first.name.toString().toUpperCase().trim());
                  filterOfferNameMainList.add(element);
                }
              });
              filterOfferbySubSegList = value;
              isLoadingFilterOffer = false;
            });       setModalState((){});
          }
        }
      }else{
        if(mounted){
           setState(() {
           List TempNameList = [];
           value.forEach((element) {
             if(TempNameList.contains(element.offerItems!.first.name.toString().toUpperCase().trim())){
             }else{
               TempNameList.add(element.offerItems!.first.name.toString().toUpperCase().trim());
               filterOfferNameMainList.add(element);
             }
           });
            isLoadingFilterOffer = false;
          });       setModalState((){});
        }
      }
    });
  }

  GetOfferForFillByItemName(String Name,setModalState){
    setState(() {
      isGettingSearchOffer = true;
      OfferListByName = [];
    });
    setModalState((){});
    DrawAuraAPi().getSearchData(Name.toString()).then((SearchRes) {
      var res = json.decode(utf8.decode(SearchRes.bodyBytes));
      if (SearchRes.statusCode == 200) {
        print(res);
        if (res['status'] == "200"){
          res["offers"].forEach((element) {
            setState(() {
              OfferListByName.add(
                  FiltterOfferDetailsModel.fromJson(element["OfferData"])
              );
            });
            setModalState((){});
          });
          setState(() {
            isGettingSearchOffer = false;
          });
          setModalState((){});
        }
      }});
  }
  String TempDurationDate = "";
  String TempDurationTime = "";
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    bool isMobile = ResponsiveHelper.isMobile(context);
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
              title:cateLoader==true?const SizedBox(): Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(saveAddressTitle==""?"":saveAddressTitle==null? "":'${saveAddressTitle}', style: BlackTitleStyle),
                  Flexible(
                    child: Container(
                      height: 30,
                      margin: EdgeInsets.only(left:5),
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:Center(
                        child: TextFormField(
                          controller: adressLocationController.text.isEmpty?TextEditingController(text:"Select Address"): adressLocationController,
                          onTap:() async {
                            if(LatitudeLongitude == null ){
                              Constants.showToast("Please wait");
                            }else{
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong: LatitudeLongitude!,isAppPlaceView: true,isTitleSelectAsAddress: false,))).then((value) {
                                setState(() {
                                  adressLocationController.text = value;
                                  _currentTapindex == 1 ?  OfferFromLocationController.text = adressLocationController.text :OfferToLocationController.text =  adressLocationController.text;
                                  isViewOfferToLocation=true;
                                });
                              });
                            }
                          },
                          readOnly:true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(hintText:"Select Address", fillColor:  Colors.white, hintStyle: greyHintStyle,
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
                  )
                ],
              ),
            ),
            body:cateLoader==true || isGetServicePerson == false?const Center(child: LoadingWidget()):
            Stack(
              children:[
                GestureDetector(
                    onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    setState(() {
                      filterOfferNameList.clear();
                    });
                  },
                  child: Column  (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isLoadAddress ? LinearProgressIndicator(color: Constants.primaryColor1,minHeight: 2,backgroundColor: Colors.grey,):SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            InkWell(
                                onTap:(){Navigator.pop(context);},
                                child: const Icon(Icons.arrow_back,size: 24,)),
                            const SizedBox(width: 10,),

                            SizedBox(
                              height: 25,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) )),
                                      backgroundColor: Constants.primaryColor1,
                                      elevation: 1
                                  ),
                                  onPressed: () {},
                                  child:  Text(DisplayName == null ? "--": "${DisplayName}",style: WhiteHeadingStyle,)),
                            ),
                            Spacer(),
                            Column(
                              children: [
                                5.height,
                                InkWell(
                                    onTap:(){
                                      if(DataManager.getInstance().getUserIsPlaceType().toString() == "true"){
                                        setState(() {
                                          isPrivateOffer = !isPrivateOffer;
                                        });
                                      }else{
                                        if(KycDataList.isEmpty || KycDataList.length == 1){
                                          Constants.showToast("Your not added kyc document,then not eligible to create public offer.");
                                        }else {
                                          setState(() {
                                            isPrivateOffer = !isPrivateOffer;
                                          });
                                        }
                                      }

                                    },
                                    child: isPrivateOffer ? Image(image: AssetImage("assets/secured_lock.png"),width: 22,height: 22,color: primaryColor):Image(image: AssetImage("assets/world.png"),width: 20,height: 20,color: primaryColor,)),
                                3.height,
                                Text( isPrivateOffer ?"Private":"Public",style: greyHintStyle,)
                              ],
                            )
                          ],
                        ),
                      ),
                   
                      Expanded(
                          child: ListView(
                            shrinkWrap: false,
                           // physics: ScrollPhysics(),
                            children: [
                              // TODO Offering Area
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      width:isMobile?width*0.75:tabWidth*0.75,
                                      child:
                                      serviceAreaList.isEmpty || serviceAreaList[0].text.isEmpty || serviceAreaList[0].text =="" || serviceAreaList[0].text.toString() =="null"?
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [Text("Tap Edit To Enter The Area Of Offering",style:BlackSubCardTitle2)])
                                      :
                                      ListView.builder (
                                        scrollDirection: Axis.horizontal,
                                        itemCount: serviceAreaList.length,
                                        physics: const ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Center(
                                            child: Padding(
                                              padding:  EdgeInsets.only(right :10.0),
                                              child: Text(" | "+"${serviceAreaList[index].text}",style: BlackSubTitleStyle,),
                                            ),
                                          );
                                        },),
                                    ),
                                    EditBtn((){
                                          showModalBottomSheet<void>(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                                            ),
                                            backgroundColor: Constants.bottomSheetBg,
                                            context: context, builder: (context) {
                                            return  StatefulBuilder(builder: (context, setModalState) {
                                              return  Stack(
                                                children: [
                                                  ListView(
                                                    shrinkWrap: true,
                                                    physics: ScrollPhysics(),
                                                    padding: EdgeInsets.only(top:30),
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            const Text("Offering location", style: BlackTitleStyle),
                                                            10.width,
                                                            serviceAreaList.isEmpty ?  InkWell(
                                                              onTap:(){
                                                                setState((){
                                                                  serviceAreaList = [TextEditingController(text: "")];
                                                                  offerDisableFields.remove("offerArea");
                                                                });
                                                                setModalState((){});
                                                              },
                                                              child: CircleAvatar(
                                                                radius:9,
                                                                backgroundColor: Constants.primaryColor1 ,
                                                                child: Center(
                                                                    child:Icon(Icons.add,color: Colors.white,size:14,)
                                                                ),
                                                              ),
                                                            ):SizedBox()
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                                        child: ListView.builder (
                                                          scrollDirection: Axis.vertical,
                                                          itemCount: serviceAreaList.length,
                                                          physics: const ScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemBuilder: (context, index) {
                                                            return Padding(
                                                              padding: const EdgeInsets.only(top:8,bottom: 5),
                                                              child: Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap:(){
                                                                      setState((){
                                                                        serviceAreaList.removeAt(index);
                                                                        if(index == 0){
                                                                          offerDisableFields.add("offerArea");
                                                                        }
                                                                      });
                                                                      setModalState((){});
                                                                    },
                                                                    child: CircleAvatar(
                                                                      radius:10,
                                                                      backgroundColor: Color(
                                                                          0x3389F6B9) ,
                                                                      child: Center(
                                                                          child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  10.width,
                                                                  Flexible(
                                                                    child: Container(
                                                                      height: 35,
                                                                      padding: EdgeInsets.only(left:12),
                                                                      decoration: BoxDecoration(color: Colors.white,  borderRadius: BorderRadius.circular(5)),
                                                                     
                                                                      child: TextFormField(
                                                                        controller: serviceAreaList[index],
                                                                        onTap:() async {
                                                                          if(LatitudeLongitude == null ){
                                                                            Constants.showToast("Please wait");
                                                                          }else{
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong: LatitudeLongitude!,isAppPlaceView: true,isTitleSelectAsAddress: true))).then((value) {
                                                                              setState(() {
                                                                                serviceAreaList[index].text= value.toString() == "null"?"": value.toString();
                                                                              });
                                                                              setModalState((){});
                                                                            });
                                                                          }
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
                                                                  10.width,
                                                                  InkWell(
                                                                    onTap:(){
                                                                      if(serviceAreaList.length == 5 ){
                                                                        Constants.showToast("Max 5 Offering location allowed");
                                                                      }else{
                                                                        setState((){
                                                                          serviceAreaList.add(TextEditingController()) ;
                                                                        });
                                                                        setModalState((){});
                                                                      }

                                                                    },
                                                                    child: CircleAvatar(
                                                                      radius:10,
                                                                      backgroundColor: Constants.primaryColor1 ,
                                                                      child: Center(
                                                                          child:Icon(Icons.add,color: Colors.white,size:14,)
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          },),
                                                      ),
                                                    ],
                                                  ),
                                                  Positioned(
                                                      top:10,left:0,right:0,
                                                      child:BottomSheetDivider())
                                                ],
                                              );
                                            },);
                                          },);
                                        })                                    ],
                                ),
                              ),

                              const SizedBox(height:5),
                              // TODO Tab Activity
                              Container(
                                // color: Colors.black12,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color:  Color(0xFFD2D0D0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFFD2D0D0),
                                            blurRadius: 4,
                                            spreadRadius: 4,
                                            offset: Offset(0,4)
                                        )
                                      ]
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  height: 32,
                                  child:
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            setState(() {
                                              selectedTap = "Deliver";
                                            });
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
                                          onTap:(){
                                            setState(() {
                                              selectedTap = "Cancel";
                                            });
                                          },
                                          child: Container(
                                            height: 30,
                                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                            decoration: BoxDecoration(
                                              color:  selectedTap == "Cancel"? Constants.primaryColor1:Colors.transparent,
                                              borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                            ),
                                            child:  Center(child: Text('Cancel',style:  selectedTap == "Cancel"?WhiteSubTitleStyle:BlackSubTitleStyle,)),),
                                        ),
                                        InkWell(
                                          onTap:(){
                                            // setState(() {
                                            //   selectedTap = "Duplicate";
                                            // });
                                          },
                                          child: Container(
                                              height: 30,
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                              decoration: BoxDecoration(
                                                color:  selectedTap == "Duplicate"? Constants.primaryColor1:Constants.unActiveTabBg,
                                                borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                              ),
                                              child:  Center(child: Text('Duplicate',style:  selectedTap == "Duplicate"?WhiteSubTitleStyle:unActiveTabStyle,))
                                          ),
                                        ),
                                        InkWell(
                                          onTap:(){
                                            if(widget.Type != "Template"){
                                              setState(() {
                                                selectedTap = "Template";
                                              });
                                            }else if(widget.Type == "Template"){
                                              MessageShowDialogWithText(context,
                                                  Text("A TEMPLATE CAN'T BE MADE ANOTHER TEMPLATE",textAlign: TextAlign.center,style: BlackTitle500height,)
                                                  ,(){
                                                    Navigator.pop(context);
                                                  });
                                            }

                                          },
                                          child: Container(
                                            height: 30,
                                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                            decoration: BoxDecoration(
                                              color:  selectedTap == "Template"? Constants.primaryColor1:widget.Type == "Template"?Constants.unActiveTabBg:Colors.transparent,
                                              borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                            ),
                                            child:  Center(child: Text('Template',style:  selectedTap == "Template"?WhiteSubTitleStyle:widget.Type == "Template" ?unActiveTabStyle:BlackSubTitleStyle,)),),
                                        ),
                                        InkWell(
                                          onTap:(){
                                            if(isOwnerOfTemplate){
                                              setState(() {
                                                selectedTap = "Modify";
                                              });
                                            }

                                          },
                                          child: Container(
                                              height: 30,
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                              decoration: BoxDecoration(
                                                color:  selectedTap == "Modify"? Constants.primaryColor1:isOwnerOfTemplate?Colors.transparent:Constants.unActiveTabBg,
                                                borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                                              ),
                                              child:  Center(child: Text('Modify',style:  selectedTap == "Modify"?WhiteSubTitleStyle:isOwnerOfTemplate?BlackSubTitleStyle:unActiveTabStyle,))
                                          ),
                                        ),
                                        InkWell(
                                          onTap:(){
                                            setState(() {
                                              selectedTap = "New";
                                            });
                                          },
                                          child: Container(
                                              height: 30,
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                              decoration: BoxDecoration(
                                                color:  selectedTap == "New"? Constants.primaryColor1:Colors.transparent,
                                                borderRadius: const BorderRadius.only(topRight: Radius.circular(8),topLeft:Radius.circular(8) ),
                                              ),
                                              child:  Center(child: Text('New',style:  selectedTap == "New"?WhiteSubTitleStyle:BlackSubTitleStyle,))
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                              // TODO Buy Sell
                              Container(
                                  height: 75,
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration:  const BoxDecoration(color: Color(0xFFE7E6E6),
                                  ),
                                  child: Center(
                                    child: ListView.builder(
                                      itemCount: 2,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const ScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              _currentTapindex = index;
                                              OfferFromLocationController.clear();
                                              OfferToLocationController.clear();
                                              _currentTapindex == 1 ?  OfferFromLocationController.text = adressLocationController.text :OfferToLocationController.text =  adressLocationController.text;
                                              isViewOfferToLocation = true;
                                            });
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
                                                      blurRadius: 2.5,
                                                      spreadRadius: 2.5,
                                                      offset: const Offset(1, 4))
                                                ],
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: Constants.lightGreen,width: 1)
                                            ),
                                            child: Center(
                                              child: Text(index == 0 ? selectedTap == "Deliver"?"Deliver Buy": "Buy" :selectedTap == "Deliver"?"Deliver Sell": "Sell", style:_currentTapindex == index?WhiteTitleStyle:BlackFieldStyleBold,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                              ),
                              // TODO Cat - Seg - SubSeg
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    searchCategoryController.text == "" || searchSegmentController.text == "" || searchSubSegmentController.text ==""?
                                    Flexible(
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text("Tap Edit & enter CATEGORY/SEGMENT/SUBSEGMENT",style:BlackSubCardTitle2),
                                        ))
                                        :
                                    Container(

                                       height: 30,
                                      width:isMobile?width*0.75:tabWidth*0.75,
                                      child: SingleChildScrollView(
                                        physics: ScrollPhysics(),
                                        scrollDirection: Axis.horizontal ,
                                        child: Row (
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("${searchCategoryController.text}"+" | ",style: BlackSubTitleStyle,),
                                            Text("${searchSegmentController.text}" +" | ",style: BlackSubTitleStyle,),
                                            Text("${searchSubSegmentController.text}",style: BlackSubTitleStyle,),
                                          ],
                                        ),
                                      ),
                                    ),
                                    EditBtn((){
                                    Get.bottomSheet(
                                      elevation: 0,  shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                                    ),
                                      isDismissible: true,isScrollControlled: true,
                                      StatefulBuilder(builder: (context, setModalState) {
                                      return  Container(
                                        decoration: BoxDecoration(
                                          color:Colors.white,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                                        ),
                                        child: Stack(
                                          children: [
                                            ListView(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.only(top:30),
                                              children: [
                                                InkWell(
                                                  onTap:(){
                                                    setState(() {
                                                      filterGetCategoryList.clear();
                                                    });
                                                    setModalState((){});
                                                  },
                                                  child: Container(
                                                    width: isMobile ?width:tabWidth,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        // borderRadius: BorderRadius.circular(5),
                                                        border: Border.all(color: Colors.white),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              color: Color(0xfffD2D0D0),
                                                              blurRadius: 4,
                                                              spreadRadius: 4,
                                                              offset: Offset(0,4)
                                                          )
                                                        ]),
                                                    child: Column(
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                                                          child: Align(
                                                              alignment: Alignment.topLeft,
                                                              child: Text("Category", style: BlackTitleBoldStyle,)),
                                                        ),
                                                        Center(
                                                          child: Container(
                                                            height: 40,
                                                            color: Color(0x3389F6B9),
                                                            width: isMobile?width*0.7:tabWidth*0.7,
                                                            margin: EdgeInsets.only(left: 15,right:15,top: 0),
                                                            child: TextFormField(
                                                              controller: searchCategoryController,
                                                              decoration: InputDecoration(
                                                                hintText: "Enter Category",
                                                                hintStyle: greyHintStyle,
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      width: 1, color: Colors.grey,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(5)
                                                                ),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      width: 1,
                                                                      color:  Colors.grey,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(5)
                                                                ),
                                                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                suffixIcon: filterGetCategoryList.isEmpty && showOther==true?
                                                                InkWell(
                                                                    onTap:(){
                                                                      setState((){
                                                                        isloadNewCategory= true;
                                                                        searchSegmentId = "";
                                                                        searchSegmentController.text = "";
                                                                        filterGetSegmentList.clear();
                                                                        searchSubSegmentId = "";
                                                                        searchSubSegmentController.text = "";
                                                                        filterGetSubSegmentList.clear();
                                                                      });
                                                                      setModalState((){});
                                                                      var data ={"name":searchCategoryController.text.toString()};
                                                                      DrawAuraAPi().createCategoryApi(
                                                                          data: data).then((value) {
                                                                        if (value["status"] == 200) {
                                                                          setState((){
                                                                            searchCategoryId = value["result"]["id"].toString();
                                                                          });
                                                                          setModalState((){});
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
                                                                            isloadNewCategory = false;
                                                                            showOther =false;
                                                                          });
                                                                          setModalState((){});
                                                                          DrawAuraAPi.getCategoryListApi().then((value) {
                                                                            setState((){
                                                                              GetCategoryList.clear();
                                                                              GetCategoryList = value.result!;
                                                                            });
                                                                            setModalState((){});
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
                                                                            isloadNewCategory = false;
                                                                            showOther =false;
                                                                          });
                                                                          setModalState((){});
                                                                        }
                                                                      },);
                                                                    },
                                                                    child: Container(height: 30,width: 50,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(5),
                                                                            color:Constants.primaryColor1
                                                                        ),
                                                                        child:Center(child:isloadNewCategory==false?Text("Other",style: WhiteHeadingStyle,):SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)))
                                                                    )):SizedBox(),
                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                                border: const OutlineInputBorder(),
                                                                // hintText: 'Enter Query',hintStyle: hintstyle,
                                                              ),
                                                              onChanged: (String value) async {
                                                                _searchFilter(value,setModalState);
                                                              },
                                                              style: Black87HintStyle,
                                                            ),
                                                          ),
                                                        ),
                                                        (filterGetCategoryList.isEmpty) ? SizedBox()
                                                            :Container(
                                                          width: isMobile?width*0.7:tabWidth*0.7,
                                                          margin: EdgeInsets.only(left: 15,right:15,top: 0),
                                                          height:filterGetCategoryList.length > 4?isMobile?width*0.3:tabWidth*0.3:null,
                                                          child: Card(
                                                            elevation: 2,
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                            child: CupertinoScrollbar(
                                                              child: ListView.builder(
                                                                itemCount:filterGetCategoryList.length,
                                                                shrinkWrap: true,
                                                                physics: ClampingScrollPhysics(),
                                                                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                                                                itemBuilder: (context, index) {
                                                                  var data = filterGetCategoryList[index];
                                                                  return  InkWell(
                                                                      onTap: (){
                                                                        setState(() {
                                                                          searchSegmentId = "";
                                                                          searchSegmentController.text = "";
                                                                          filterGetSegmentList.clear();
                                                                          searchSubSegmentId = "";
                                                                          searchSubSegmentController.text = "";
                                                                          filterGetSubSegmentList.clear();
                                                                          searchCategoryController.text = data.name.toString() ;
                                                                          searchCategoryId = data.id.toString();
                                                                          filterGetCategoryList.clear();
                                                                          segmentLoader=true;
                                                                          selectedCategoryIndex = index;
                                                                        });
                                                                        setModalState((){});
                                                                        String EndPoint = "filterOffers?category=${searchCategoryId}";
                                                                        GetOfferForFill(EndPoint,setModalState,by:"Cat");
                                                                        DrawAuraAPi.getSegmentListApi(catId: data.id.toString()).then((value) {
                                                                          setState(() {
                                                                            getSegmentList=value.result!;
                                                                            segmentLoader=false;
                                                                          });
                                                                          setModalState((){});
                                                                        });

                                                                      },
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 6),
                                                                        child: Text("${data.name.toString()}",style: Black87HintStyle,overflow: TextOverflow.ellipsis),
                                                                      ));
                                                                },),
                                                            ),
                                                          ),
                                                        ),

                                                        filterOfferbyCatList.isEmpty || filterOfferbyCatList == []?SizedBox():
                                                        FillBuilder(context,setModalState,filterList: filterOfferbyCatList,bgColor: Constants.offerPageSecoundry,by: "Cat"),
                                                        const Padding(
                                                          padding: EdgeInsets.only(left: 15, bottom: 5),
                                                          child: Align(
                                                              alignment: Alignment.bottomLeft,
                                                              child: Text(
                                                                "Products and Services (Specific category by name)",
                                                                style: BlackSubCardTitle2,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap:(){
                                                    setState(() {
                                                      filterGetSegmentList.clear();
                                                    });
                                                    setModalState((){});
                                                  },
                                                  child: Container(
                                                    width: isMobile ?width:tabWidth,
                                                    margin: const EdgeInsets.only(bottom: 5),
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xFFE7E6E6),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                                                          child: Align(
                                                              alignment: Alignment.topLeft,
                                                              child: Text(
                                                                "Segment",
                                                                style: BlackTitleBoldStyle,
                                                              )),
                                                        ),
                                                        Center(
                                                          child: Container(
                                                            height: 40,
                                                            color: Color(0x3389F6B9),
                                                            width: isMobile?width*0.7:tabWidth*0.7,
                                                            margin: EdgeInsets.only(left: 15,right:15,top: 0),
                                                            child: TextFormField(
                                                              readOnly: searchCategoryController.text.isEmpty && searchSegmentController.text.isEmpty? true:false,
                                                              controller: searchSegmentController,
                                                              decoration: InputDecoration(
                                                                hintText: "Enter Segment",
                                                                hintStyle: greyHintStyle,
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      width: 1, color: Colors.grey,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(5)
                                                                ),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      width: 1,
                                                                      color:  Colors.grey,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(5)
                                                                ),
                                                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                suffixIcon: filterGetSegmentList.isEmpty && showOtherSegment==true?
                                                                InkWell(
                                                                    onTap:(){
                                                                      setState((){

                                                                        searchSubSegmentId = "";
                                                                        searchSubSegmentController.text = "";
                                                                        filterGetSubSegmentList.clear();
                                                                        isloadNewSegment= true;
                                                                      });
                                                                      setModalState((){});
                                                                      var data = {
                                                                        "name": searchSegmentController.text,
                                                                        "category": searchCategoryId.toString(),
                                                                      };

                                                                      DrawAuraAPi().createSegmentApi(data: data).then((value) {
                                                                        if (value["status"] == 200) {
                                                                          setState((){
                                                                            searchSegmentId = value["result"]["id"].toString();
                                                                          });setModalState((){});
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
                                                                            selectedSegmentIndex = -2;
                                                                            isloadNewSegment = false;
                                                                            showOtherSegment = false;
                                                                          });setModalState((){});
                                                                          DrawAuraAPi.getSegmentListApi(catId: selectedCategoryIndex == -2?GetCategoryList.last.id.toString():GetCategoryList[selectedCategoryIndex].id.toString()).then((value) {
                                                                            setState(() {
                                                                              getSegmentList.clear();
                                                                              getSegmentList=value.result!;
                                                                            });setModalState((){});
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
                                                                            isloadNewSegment = false;
                                                                            showOtherSegment =false;
                                                                          });
                                                                          setModalState((){});
                                                                        }
                                                                      },);
                                                                    },
                                                                    child: Container(height: 30,width: 50,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(5),
                                                                            color:Constants.primaryColor1
                                                                        ),
                                                                        child:Center(child:isloadNewSegment==false?Text("Other",style: WhiteHeadingStyle,):SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)))
                                                                    )):SizedBox(),
                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                                border: const OutlineInputBorder(),
                                                                // hintText: 'Enter Query',hintStyle: hintstyle,
                                                              ),
                                                              onChanged: (String value) async {
                                                                _searchFilterSegment(value,setModalState);
                                                              },
                                                              style: Black87HintStyle,
                                                            ),
                                                          ),
                                                        ),
                                                        (filterGetSegmentList.isEmpty) ? SizedBox()
                                                            :Container(
                                                          width: isMobile?width*0.7:tabWidth*0.7,
                                                          margin: EdgeInsets.only(left: 15,right:15,top: 0),
                                                          height:filterGetSegmentList.length > 4? isMobile?width*0.3:tabWidth*0.3:null,
                                                          child: Card(
                                                            elevation: 2,
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                            child: CupertinoScrollbar(
                                                              child: ListView.builder(
                                                                itemCount:filterGetSegmentList.length,
                                                                shrinkWrap: true,
                                                                physics: ClampingScrollPhysics(),
                                                                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                                                                itemBuilder: (context, index) {
                                                                  var data = filterGetSegmentList[index];
                                                                  return  InkWell(
                                                                      onTap: (){
                                                                        setState(() {
                                                                          searchSubSegmentId = "";
                                                                          searchSubSegmentController.text = "";
                                                                          filterGetSubSegmentList.clear();
                                                                          searchSegmentId = data.id.toString();
                                                                          searchSegmentController.text = data.name.toString() ;
                                                                          filterGetSegmentList.clear();
                                                                          segmentLoader=true;
                                                                          selectedSegmentIndex = index;
                                                                        });setModalState((){});
                                                                        String EndPoint = "filterOffers?category=${searchCategoryId}&segment=${searchSegmentId}";
                                                                        GetOfferForFill(EndPoint,setModalState,by: "Seg");
                                                                        DrawAuraAPi().getSubSegmentListApi(segId: data.id.toString()).then((value) {
                                                                          setState(() {
                                                                            getSubSegmentList=value.result!;
                                                                            segmentLoader=false;
                                                                          });
                                                                          setModalState((){});
                                                                        });

                                                                      },
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 6),
                                                                        child: Text("${data.name.toString()}",style: Black87HintStyle,overflow: TextOverflow.ellipsis),
                                                                      ));
                                                                },),
                                                            ),
                                                          ),
                                                        ),
                                                        filterOfferbySegList.isEmpty || filterOfferbySegList == [] ?SizedBox():
                                                        FillBuilder(context,setModalState,filterList: filterOfferbySegList,bgColor: Colors.white,by: "Seg"),


                                                        const Padding(
                                                          padding: EdgeInsets.only(left: 15, bottom: 5),
                                                          child: Align(
                                                              alignment: Alignment.bottomLeft,
                                                              child: Text(
                                                                "Segments under the category chosen",
                                                                style: BlackSubCardTitle2,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap:(){
                                                    setState(() {
                                                      filterGetSubSegmentList.clear();
                                                    });setModalState((){});
                                                  },
                                                  child: Container(
                                                    width: isMobile ?width:tabWidth,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(color: Colors.white),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                                                          child: Align(
                                                              alignment: Alignment.topLeft,
                                                              child: Text(
                                                                "Sub-Segment",
                                                                style: BlackTitleBoldStyle,
                                                              )),
                                                        ),
                                                        Center(
                                                          child: Container(
                                                            height: 40,
                                                            color: Color(0x3389F6B9),
                                                            width: isMobile?width*0.7:tabWidth*0.7,
                                                            margin: EdgeInsets.only(left: 15,right:15,top: 0),
                                                            child: TextFormField(
                                                              readOnly: searchSegmentController.text.isEmpty && searchSubSegmentController.text.isEmpty && searchCategoryController.text.isEmpty?true:false,
                                                              controller: searchSubSegmentController,
                                                              decoration: InputDecoration(
                                                                hintText: "Enter Sub Segment",
                                                                hintStyle: greyHintStyle,
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      width: 1, color: Colors.grey,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(5)
                                                                ),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      width: 1,
                                                                      color:  Colors.grey,
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(5)
                                                                ),
                                                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                suffixIcon: filterGetSubSegmentList.isEmpty && showOtherSubSegment==true?
                                                                InkWell(
                                                                    onTap:(){

                                                                      setState((){
                                                                        isloadNewSubSegment= true;
                                                                      });setModalState((){});
                                                                      var data = {
                                                                        "segment": searchSegmentId.toString(),
                                                                        "name": searchSubSegmentController.text,
                                                                      };

                                                                      DrawAuraAPi().createSubSegmentApi(data: data).then((value) {

                                                                        if (value["status"] == 200) {
                                                                          setState((){
                                                                            searchSubSegmentId = value["result"]["id"].toString();
                                                                          });setModalState((){});
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
                                                                            isloadNewSubSegment = false;
                                                                            showOtherSubSegment = false;
                                                                          });setModalState((){});
                                                                          // String EndPoint = "filterOffers?category=${searchCategoryId}&segment=${searchSegmentId}";

                                                                          DrawAuraAPi().getSubSegmentListApi(segId: searchSegmentId).then((value) {
                                                                            setState(() {
                                                                              getSubSegmentList=value.result!;
                                                                              segmentLoader=false;
                                                                            });setModalState((){});
                                                                          });
                                                                          // drawauraApi().getCategoryListApi().then((value) {
                                                                          //   setState((){
                                                                          //     GetCategoryList.clear();
                                                                          //     GetCategoryList = value.result!;
                                                                          //   });
                                                                          // });
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
                                                                            isloadNewSubSegment = false;
                                                                            showOtherSubSegment =false;
                                                                          });setModalState((){});
                                                                        }
                                                                      },);
                                                                    },
                                                                    child: Container(height: 30,width: 50,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(5),
                                                                            color:Constants.primaryColor1
                                                                        ),
                                                                        child:Center(child:isloadNewSubSegment==false?Text("Other",style: WhiteHeadingStyle,):SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)))
                                                                    )):SizedBox(),
                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                                border: const OutlineInputBorder(),
                                                                // hintText: 'Enter Query',hintStyle: hintstyle,
                                                              ),
                                                              onChanged: (String value) async {
                                                                _searchFilterSubSegment(value,setModalState);
                                                              },
                                                              style: Black87HintStyle,
                                                            ),
                                                          ),
                                                        ),
                                                        (filterGetSubSegmentList.isEmpty) ? SizedBox()
                                                            :Container(
                                                          width: isMobile?width*0.7:tabWidth*0.7,
                                                          margin: EdgeInsets.only(left: 15,right:15,top: 0),
                                                          height:filterGetCategoryList.length > 4? isMobile?width*0.3:tabWidth*0.3:null,
                                                          child: Card(
                                                            elevation: 2,
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                            child: CupertinoScrollbar(
                                                              child: ListView.builder(
                                                                itemCount:filterGetSubSegmentList.length,
                                                                shrinkWrap: true,
                                                                physics: ClampingScrollPhysics(),
                                                                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                                itemBuilder: (context, index) {
                                                                  var data = filterGetSubSegmentList[index];
                                                                  return  InkWell(
                                                                      onTap: (){
                                                                        setState(() {
                                                                          searchSubSegmentId = data.id.toString();
                                                                          searchSubSegmentController.text = data.name.toString() ;
                                                                          filterGetSubSegmentList.clear();
                                                                        });setModalState((){});
                                                                        String EndPoint = "filterOffers?category=${searchCategoryId}&segment=${searchSegmentId}&subsegment=${searchSubSegmentId}";
                                                                        GetOfferForFill(EndPoint,setModalState,by: "SubSeg");
                                                                      },
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 6),
                                                                        child: Text("${data.name.toString()}",style: Black87HintStyle,overflow: TextOverflow.ellipsis),
                                                                      ));
                                                                },),
                                                            ),
                                                          ),
                                                        ),
                                                        filterOfferbySubSegList.isEmpty ||  filterOfferbySubSegList == []?SizedBox():
                                                        FillBuilder(context,setModalState,filterList: filterOfferbySubSegList,bgColor: Constants.offerPageSecoundry,by: "SubSeg"),
                                                        const Padding(
                                                          padding: EdgeInsets.only(left: 15, bottom: 5),
                                                          child: Align(
                                                              alignment: Alignment.bottomLeft,
                                                              child: Text(
                                                                "Sub-Segments under the Segments chosen",
                                                                style: BlackSubCardTitle2,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                                top:10,left:0,right:0,
                                                child:BottomSheetDivider()),
                                            Positioned.fill(
                                                bottom: 0,left: 0,right: 0,top: 0,
                                                child:   segmentLoader==true || isLoadingFillOffer ==true || isGettingSearchOffer == true?
                                            Container(
                                              color: Colors.black12,

                                              width: isMobile ?width:tabWidth,
                                              child: const Center(
                                                  child:   SearchLoading()
                                              ),
                                            ) : const SizedBox())
                                          ],
                                        ),
                                      );
                                    },)
                                    );
                                    })                                    ],
                                ),
                              ),
                              // TODO Offer Conditions
                              Container(
                                color: Constants.bottomSheetBg,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      isNewOfferNow
                                  ?
                                      Flexible(
                                          child: Padding(
                                            padding:  EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text("Tap Edit To Enter Offer Conditions",style:BlackSubCardTitle2),
                                          ))
                                          :
                                      Container(
                                        width:isMobile?width*0.8:tabWidth*0.8,
                                        child: Row (
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(style: TextStyle(height: 1.5, color: Colors.black), children: [
                                                    TextSpan(text:selectedPeriodicityValue.toString() == ""||selectedPeriodicityValue.toString() == "null"?"":  "${selectedPeriodicityValue}", style: Black45DescStyle),
                                                    // TextSpan(text: " ${selectedValuePriority}", style:Black45DescStyle),
                                                    OfferPeriodController.text.isEmpty || OfferPeriodController.text.toString() == "" || selectedPeriodicityValue == "Today" || selectedPeriodicityValue == "Tomorrow" ?
                                                    TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " From ", style:BlackSubTitleItalicStyle),
                                                    OfferPeriodController.text.isEmpty || OfferPeriodController.text.toString() == "" || selectedPeriodicityValue == "Today" || selectedPeriodicityValue == "Tomorrow"?
                                                    TextSpan(text: "", style:Black45DescStyle):
                                                    TextSpan(text: "${OfferPeriodController.text}", style: Black45DescStyle),
                                                    OfferPeriodTimeController.text.isEmpty || OfferPeriodTimeController.text.toString() == ""  ?
                                                    TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " From ", style:BlackSubTitleItalicStyle),
                                                    OfferPeriodTimeController.text.isEmpty || OfferPeriodTimeController.text.toString() == "" ?
                                                    TextSpan(text: "", style:Black45DescStyle):
                                                    TextSpan(text: "${OfferPeriodTimeController.text}", style: Black45DescStyle),

                                                    OfferDurationController.text.isEmpty || OfferDurationController.text.toString() == ""  ?
                                                    TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " For ", style:BlackSubTitleItalicStyle),
                                                    OfferDurationController.text.isEmpty || OfferDurationController.text.toString() == "" ?
                                                    TextSpan(text: "", style:Black45DescStyle):
                                                    TextSpan(text: "${OfferDurationController.text}", style: Black45DescStyle),

                                                    selectedItems.isEmpty || selectedItems.contains("-1") || selectedItems.contains("0") == ""  ?
                                                    TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " By ", style:BlackSubTitleItalicStyle),
                                                    selectedItems.isEmpty || selectedItems.contains("-1") || selectedItems.contains("0") == ""  ?
                                                    TextSpan(text: "", style:Black45DescStyle):
                                                    TextSpan(text: ServicePersonList.where((e) => e.id.toString() == selectedItems.first.toString()).first.displayname.toString(), style: Black45DescStyle),

                                                    selectedValuePriority.toString() == "null" || selectedValuePriority.toString() == "" ?
                                                    TextSpan(text: "", style:Black45DescStyle):
                                                    TextSpan(text: " ${selectedValuePriority}", style: Black45DescStyle),

                                                    OfferFromLocationController.text.isEmpty || OfferFromLocationController.text.toString() == "" || OfferFromLocationController.text.toString().trim() == "null" ?
                                                    TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " From ", style:BlackSubTitleItalicStyle),
                                                    OfferFromLocationController.text.isEmpty || OfferFromLocationController.text.toString() == "" || OfferFromLocationController.text.toString().trim() == "null"?
                                                    TextSpan(text: "", style:Black45DescStyle):
                                                    TextSpan(text: "${OfferFromLocationController.text}", style: Black45DescStyle),


                                                    OfferToLocationController.text.isEmpty || OfferToLocationController.text.toString() == "" || OfferToLocationController.text.toString().trim() == "null" ?
                                                    TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " To ", style:BlackSubTitleItalicStyle),
                                                    OfferToLocationController.text.isEmpty || OfferToLocationController.text.toString() == ""|| OfferToLocationController.text.toString().trim() == "null" ?
                                                    TextSpan(text: "", style:Black45DescStyle):
                                                    TextSpan(text: "${OfferToLocationController.text}", style: Black45DescStyle),

                                                    OfferAtLocationController.text.isEmpty || OfferAtLocationController.text.toString() == ""  || OfferAtLocationController.text.toString().trim() == "null" ?
                                                    TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " At ", style:BlackSubTitleItalicStyle),
                                                    OfferAtLocationController.text.isEmpty || OfferAtLocationController.text.toString() == "" || OfferAtLocationController.text.toString().trim() == "null"?
                                                    TextSpan(text: "", style:Black45DescStyle):
                                                    TextSpan(text: "${OfferAtLocationController.text}", style: Black45DescStyle),

                                                    OfferExpiryController.text.isEmpty || OfferExpiryController.text.toString() == ""  || OfferExpiryController.text.toString().trim() == "null" ?
                                                    TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " Expiry ", style:BlackSubTitleItalicStyle),
                                                    OfferExpiryController.text.isEmpty || OfferExpiryController.text.toString() == "" || OfferExpiryController.text.toString().trim() == "null"?
                                                    TextSpan(text: "", style:Black45DescStyle):
                                                    TextSpan(text: "${OfferExpiryController.text}", style: Black45DescStyle),


                                                  ])),
                                            ),
                              
                                          ],
                                        ),
                                      ),
                                      EditBtn((){
                                        setState((){
                                          isNewOfferNow = false;
                                        });
                                        Get.bottomSheet(
                                            elevation: 0,  shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                                        ),
                                            isDismissible: true,isScrollControlled: true,
                                            StatefulBuilder(builder: (context, setModalState) {
                                              return  Container(
                                                decoration: BoxDecoration(
                                                    color:Colors.white,
                                                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                                                ),
                                                child: Stack(
                                                  children: [
                                                    ListView(
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      padding: EdgeInsets.only(top:30),
                                                      children: [
                                                        Container(
                                                          padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                                          decoration: BoxDecoration(
                                                            color: Constants.bottomSheetBg,
                                                            // borderRadius: BorderRadius.circular(5),
                                                            border: Border.all(color: Colors.white),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Align(
                                                                  alignment: Alignment.topLeft,
                                                                  child: Text("Offer’s Conditions",style: BlackTitleBoldStyle,)),
                                                              const SizedBox(height: 10,),
                                                              isPeriodicityVisible == true ?  Padding(
                                                                padding: EdgeInsets.only(top:2),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [

                                                                    const Padding(
                                                                      padding: EdgeInsets.only(left:0.0,bottom: 5),
                                                                      child: Text("Periodicity", style: BlackDescStyle500,),
                                                                    ),

                                                                    Row(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:(){
                                                                            setState((){
                                                                              selectedPeriodicityValue = "";
                                                                              isPeriodicityVisible = false;

                                                                              offerDisableFields.add("Periodicity");

                                                                            });setModalState((){});
                                                                          },
                                                                          child: CircleAvatar(
                                                                            radius:8,
                                                                            backgroundColor: Color(
                                                                                0x3389F6B9) ,
                                                                            child: Center(
                                                                                child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        10.width,
                                                                        Flexible(
                                                                          child: DropdownButtonHideUnderline(
                                                                            child: DropdownButton2(
                                                                              isExpanded: true,
                                                                              items:periodicityList.map((item) => DropdownMenuItem (
                                                                                value: item,
                                                                                child: Text(
                                                                                  item,
                                                                                  style: Black87HintStyle,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                              )).toList(),
                                                                              value: selectedPeriodicityValue==""?null:selectedPeriodicityValue,
                                                                              onChanged: (newValue) {
                                                                                setState(() {
                                                                                  selectedPeriodicityValue = newValue!;

                                                                                  OfferPeriodController.clear();
                                                                                  OfferDurationController.clear();
                                                                                  OfferPeriodTimeController.clear();
                                                                                  offerPeriodFromDate = "";
                                                                                  offerPeriodToDate = "";
                                                                                  offerPeriodFromTime = "";
                                                                                  offerPeriodToTime = "";
                                                                                  OfferFromDate  = DateTime.now().add(Duration(days: 60));
                                                                                  OfferFromTime = DateTime.now().add(Duration(minutes: 1));
                                                                                  OfferToDate = DateTime.now().add(Duration(days: 60));
                                                                                  OfferToTime = DateTime.now().add(Duration(minutes: 2));
                                                                                  for(var i = 0 ;i< ItemsList.length ; i++){
                                                                                    ItemsList[i]["item_condition"]["periodicity"] = "";
                                                                                    ItemsList[i]["item_condition"]["period"].text = "" ;
                                                                                    ItemsList[i]["item_condition"]["periodTime"].text = "" ;
                                                                                    ItemsList[i]["item_condition"]["fromperiod"] = "" ;
                                                                                    ItemsList[i]["item_condition"]["toperiod"] = "" ;
                                                                                    ItemsList[i]["item_condition"]["fromperiodtime"] = "" ;
                                                                                    ItemsList[i]["item_condition"]["toperiodtime"] = "" ;
                                                                                  }

                                                                                });setModalState((){});
                                                                                if(selectedPeriodicityValue == "Today" || selectedPeriodicityValue == "Tomorrow" ){
                                                                                  if(selectedPeriodicityValue == "Today" ){
                                                                                    final  SDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                                                                                    offerPeriodFromDate = SDate.toString();
                                                                                    print(offerPeriodFromDate);
                                                                                  } else if(selectedPeriodicityValue == "Tomorrow" ){
                                                                                    final  SDate = DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 1)));
                                                                                    offerPeriodFromDate = SDate.toString();
                                                                                    print(offerPeriodFromDate);
                                                                                  }

                                                                                  final  STime = DateFormat('hh:mm a').format(DateTime.now());
                                                                                  print(STime.toString());
                                                                                  OfferPeriodTimeController.text = "${STime}";
                                                                                  offerPeriodFromTime="";
                                                                                  offerPeriodToTime="";
                                                                                  final  STime24 = DateFormat('HH:mm').format(DateTime.now());
                                                                                  offerPeriodFromTime = STime24.toString();
                                                                                  print(STime24.toString());
                                                                                  OfferFromTime = DateTime.now();
                                                                                  print("OfferFromTime" + "$OfferFromTime");
                                                                                  OfferToTime = DateTime.now().add(Duration(minutes: 2));

                                                                                }else{
                                                                                  final  STime = DateFormat('dd-MMM-yyyy').format(DateTime.now());
                                                                                  OfferPeriodController.text = "${STime}";
                                                                                  final  SDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                                                                                  offerPeriodFromTime="";
                                                                                  offerPeriodFromDate="";
                                                                                  offerPeriodToDate="";
                                                                                  offerPeriodToTime="";
                                                                                  offerPeriodFromDate = SDate.toString();
                                                                                  OfferFromDate  = DateTime.now();
                                                                                  final  TimeF = DateFormat('hh:mm a').format(DateTime.now());
                                                                                  OfferPeriodTimeController.text = "${TimeF}";
                                                                                  offerPeriodFromTime="";
                                                                                  offerPeriodToTime="";
                                                                                  final  STime24 = DateFormat('HH:mm').format(DateTime.now());
                                                                                  offerPeriodFromTime = STime24.toString();
                                                                                  OfferFromTime = DateTime.now();
                                                                                  OfferToTime = DateTime.now().add(Duration(minutes: 2));

                                                                                }

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
                                                                                  height:35,
                                                                                  width: isMobile?width:tabWidth,
                                                                                  padding: const EdgeInsets.only(left: 22, right: 3),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white),
                                                                                  elevation:  0,
                                                                                  overlayColor: MaterialStateProperty.all(Colors.white)
                                                                              ),
                                                                              menuItemStyleData: MenuItemStyleData(
                                                                                height: 33,
                                                                                selectedMenuItemBuilder: (context, child) {
                                                                                  return     Container(
                                                                                    padding: const EdgeInsets.only(left: 0, right: 0),
                                                                                    // width: isMobile?width*0.9:tabWidth*0.9,
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
                                                                                // width: isMobile?width*0.9:tabWidth*0.9,
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

                                                                              style: Black87HintStyle,

                                                                            ),
                                                                          ),
                                                                        ),
                                                                       
                                                                      ],
                                                                    ),

                                                                  ],
                                                                ),
                                                              ):TextForNewAdd(context,text: "Periodicity",onTap: (){
                                                                setState(() {
                                                                  isPeriodicityVisible = true;
                                                                  offerDisableFields.remove("Periodicity");
                                                                });setModalState((){});
                                                              }),
                                                              // isPeriodVisible == true? Padding(
                                                              //   padding: EdgeInsets.only(right:10,top:2),
                                                              //   child: Column(
                                                              //     crossAxisAlignment: CrossAxisAlignment.start,
                                                              //     children: [
                                                              //       Stack(
                                                              //         children: [
                                                              //           Container(
                                                              //             height: 35,
                                                              //             padding:EdgeInsets.only(left:12),
                                                              //             decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                                              //               BoxShadow(
                                                              //                   blurRadius: 2.0,
                                                              //                   color: Colors.black54,
                                                              //                   offset: Offset(0.0, 0.5) ),
                                                              //             ], borderRadius: BorderRadius.circular(5)),
                                                              //             width: isMobile?width*0.55:tabWidth*0.55,
                                                              //             child: TextFormField(
                                                              //               controller: OfferPeriodController,
                                                              //               readOnly: true,
                                                              //               onTap:(){
                                                              //                 if(selectedPeriodicityValue == null || selectedPeriodicityValue == ""){
                                                              //                   Constants.showToast("Please select periodicity first");
                                                              //                 }else{
                                                              //                   if(selectedPeriodicityValue == "Today" || selectedPeriodicityValue == "Tomorrow"){
                                                              //                     OfferConditionTimePicker(
                                                              //                         startText: "From",
                                                              //                         endText: "To",
                                                              //                         doneText: "Done",
                                                              //                         cancelText: "Cancel",
                                                              //                         interval: 1,
                                                              //                         mode: OfferConditionTimePickerMode.time,
                                                              //                         minimumTime: DateTime.now(),
                                                              //                         type: selectedPeriodicityValue.toString(),
                                                              //                         maximumTime: DateTime.now().add(Duration(days: 25)),
                                                              //                         initialStartTime: OfferPeriodController.text.isEmpty?
                                                              //                         selectedPeriodicityValue.toString().trim() == "Tomorrow" ?
                                                              //                         DateFormat("yyyy-MM-dd HH:mm:ss").parse("${DateFormat("yyyy-MM-dd").parse(DateTime.now().add(Duration(days: 1)).toString())} 00:01:00"):
                                                              //                         DateTime.now().add(Duration(hours: 1)):OfferFromTime,
                                                              //                         initialEndTime: OfferPeriodController.text.isEmpty?
                                                              //                         selectedPeriodicityValue.toString().trim() == "Tomorrow" ?
                                                              //                         DateFormat("yyyy-MM-dd HH:mm:ss").parse("${DateFormat("yyyy-MM-dd").parse(DateTime.now().add(Duration(days: 1)).toString())} 00:01:00"):
                                                              //                         DateTime.now().add(Duration(hours: 1)):OfferToTime,
                                                              //                         use24hFormat: false,
                                                              //                         onConfirm: (start, end) {
                                                              //                           if(end == "NotPick"){
                                                              //                             setState((){
                                                              //                               OfferDurationController.clear();
                                                              //                               isSinglePeriodSelect =true;
                                                              //                               final  STime = DateFormat('hh:mm a').format(start);
                                                              //
                                                              //                               OfferPeriodController.text = "From ${STime}";
                                                              //                               offerPeriodFromTime="";
                                                              //                               offerPeriodFromDate="";
                                                              //                               offerPeriodToDate="";
                                                              //                               offerPeriodToTime="";
                                                              //                               final  STime24 = DateFormat('HH:mm').format(start);
                                                              //                               offerPeriodFromTime = STime24.toString();
                                                              //                               for(var i = 0 ;i< ItemsList.length ; i++){
                                                              //                                 ItemsList[i]["item_condition"]["period"].text = "From ${STime}";
                                                              //                                 ItemsList[i]["item_condition"]["fromperiodtime"]= STime24.toString();
                                                              //                                 OfferFromTime = start;
                                                              //                                 ItemsList[i]["item_condition"]["FromPeriodTimeFill"]= start;
                                                              //                               }
                                                              //                             });
                                                              //
                                                              //                           }else{
                                                              //                             setState((){
                                                              //                               isSinglePeriodSelect =false;
                                                              //                               Duration diff = DateTime.parse(end).difference(start);
                                                              //                               diff.inHours !=0?  OfferDurationController.text = "${diff.inHours.toString()} Hours": diff.inSeconds !=00?OfferDurationController.text = "${diff.inMinutes.toString()} Minutes" :OfferDurationController.text = "${diff.inSeconds.toString()} Seconds";
                                                              //                               final  FTime = DateFormat('hh:mm a').format(start);
                                                              //                               final  ToTime = DateFormat('hh:mm a').format(DateTime.parse(end));
                                                              //
                                                              //
                                                              //                               OfferPeriodController.text = "${FTime} - ${ToTime}";
                                                              //                               offerPeriodFromTime="";
                                                              //                               offerPeriodFromDate="";
                                                              //                               offerPeriodToDate="";
                                                              //                               offerPeriodToTime="";
                                                              //                               final  FTime24 = DateFormat('HH:mm').format(start);
                                                              //                               final  ToTime24 = DateFormat('HH:mm').format(DateTime.parse(end));
                                                              //                               offerPeriodFromTime = FTime24.toString();
                                                              //                               offerPeriodToTime = ToTime24.toString();
                                                              //
                                                              //                               for(var i = 0 ;i< ItemsList.length ; i++){
                                                              //                                 ItemsList[i]["item_condition"]["period"].text = "${FTime} - ${ToTime}";
                                                              //                                 ItemsList[i]["item_condition"]["fromperiodtime"]= FTime24.toString();
                                                              //                                 ItemsList[i]["item_condition"]["toperiodtime"]= ToTime24.toString();
                                                              //                                 OfferFromTime = start;
                                                              //                                 OfferToTime = DateTime.parse(end);
                                                              //                                 ItemsList[i]["item_condition"]["FromPeriodTimeFill"]= start;
                                                              //                                 ItemsList[i]["item_condition"]["ToPeriodTimeFIll"]= DateTime.parse(end);
                                                              //                               }
                                                              //                             });
                                                              //                           }
                                                              //                         }).showPicker(context);
                                                              //                   }
                                                              //                   else{
                                                              //                     DateTimeRangePicker(
                                                              //                         startText: "From",
                                                              //                         endText: "To",
                                                              //                         doneText: "Done",
                                                              //                         cancelText: "Cancel",
                                                              //                         interval: 1,
                                                              //                         mode: DateTimeRangePickerMode.dateAndTime,
                                                              //                         minimumTime: DateTime.now(),
                                                              //                         maximumTime: DateTime.now().add(Duration(days: 25)),
                                                              //                         initialStartTime: OfferPeriodController.text.isEmpty? DateTime.now().add(Duration(hours: 1)):OfferFromDate,
                                                              //                         initialEndTime:OfferPeriodController.text.isEmpty? DateTime.now().add(Duration(hours: 1)):OfferToDate ,
                                                              //                         use24hFormat: false,
                                                              //                         onConfirm: (start, end) {
                                                              //                           if(end == "NotPick"){
                                                              //                             setState((){
                                                              //                               OfferDurationController.clear();
                                                              //                               isSinglePeriodSelect =true;
                                                              //                               final  STime = DateFormat('dd-MMM-yyyy hh:mm a').format(start);
                                                              //                               OfferPeriodController.text = "From ${STime}";
                                                              //                               final  SDate = DateFormat('dd-MM-yyyy').format(start);
                                                              //                               final  STime24 = DateFormat('HH:mm').format(start);
                                                              //                               offerPeriodFromTime="";
                                                              //                               offerPeriodFromDate="";
                                                              //                               offerPeriodToDate="";
                                                              //                               offerPeriodToTime="";
                                                              //                               offerPeriodFromTime = STime24.toString();
                                                              //                               offerPeriodFromDate = SDate.toString();
                                                              //                               for(var i = 0 ;i< ItemsList.length ; i++){
                                                              //                                 ItemsList[i]["item_condition"]["period"].text = "From ${STime}";
                                                              //                                 ItemsList[i]["item_condition"]["fromperiod"]= SDate.toString();
                                                              //                                 ItemsList[i]["item_condition"]["fromperiodtime"]= STime24.toString();
                                                              //                                 ItemsList[i]["item_condition"]["FromPeriodDateFill"]= start;
                                                              //                                 OfferFromDate = start;
                                                              //                               }
                                                              //                             });
                                                              //                           }else{
                                                              //                             setState((){
                                                              //                               isSinglePeriodSelect = false;
                                                              //
                                                              //                               int totalDays = DateTime.parse(end).difference(start).inDays;
                                                              //                               int years = totalDays ~/ 365;
                                                              //                               int months = (totalDays-years*365) ~/ 30;
                                                              //                               int days = totalDays-years*365-months*30;
                                                              //                               int doneHours = years*365*24;
                                                              //                               int hours = DateTime.parse(end).difference(start).inHours  -(doneHours) -(months*30*24) - (days*24);
                                                              //                               int min = (((DateTime.parse(end).difference(start).inMinutes - (years*365*24*60)) -(months*30*24*60)) - (days*24*60) )-hours*60;
                                                              //                               String empty = "";
                                                              //
                                                              //                               OfferDurationController.text ="${years != 0 ? '${years} Years': empty} ${ months != 0 ? '${months} Months': empty } ${days != 0 ?'${days} Days': empty } ${ hours != 0 ?'${hours} Hours': empty } ${ min != 0 ?'${min} Minutes': empty}";
                                                              //                               final  FTime = DateFormat('dd-MMM-yyyy').format(start);
                                                              //                               final  ToTime = DateFormat('dd-MMM-yyyy').format(DateTime.parse(end));
                                                              //                               OfferPeriodController.text = "${FTime}-${ToTime}";
                                                              //                               final  SDate = DateFormat('dd-MM-yyyy').format(start);
                                                              //                               final  STime24 = DateFormat('HH:mm').format(start);
                                                              //                               offerPeriodFromTime = STime24.toString();
                                                              //                               offerPeriodFromDate = SDate.toString();
                                                              //                               final  EDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(end));
                                                              //                               final  ETime24 = DateFormat('HH:mm').format(DateTime.parse(end));
                                                              //                               offerPeriodToTime = ETime24.toString();
                                                              //                               offerPeriodToDate = EDate.toString();
                                                              //                               for(var i = 0 ;i< ItemsList.length ; i++){
                                                              //                                 ItemsList[i]["item_condition"]["period"].text = "${FTime}-${ToTime}";
                                                              //                                 ItemsList[i]["item_condition"]["fromperiod"]= SDate.toString();
                                                              //                                 ItemsList[i]["item_condition"]["fromperiodtime"]= STime24.toString();
                                                              //                                 ItemsList[i]["item_condition"]["toperiodtime"] = ETime24.toString();
                                                              //                                 ItemsList[i]["item_condition"]["toperiod"] = SDate.toString();
                                                              //
                                                              //                                 OfferFromDate = start;
                                                              //                                 OfferToDate = DateTime.parse(end);
                                                              //
                                                              //                                 ItemsList[i]["item_condition"]["FromPeriodDateFill"]= start;
                                                              //                                 ItemsList[i]["item_condition"]["ToPeriodDateFill"]= DateTime.parse(end);
                                                              //
                                                              //
                                                              //                               }
                                                              //                             });
                                                              //                           }
                                                              //                         }).showPicker(context);
                                                              //                   }
                                                              //                 }
                                                              //               },
                                                              //               keyboardType: TextInputType.text,
                                                              //               decoration: InputDecoration(hintText: "Period", fillColor:  Colors.white, hintStyle: greyHintStyle,
                                                              //                 focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                              //                 enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                              //                 floatingLabelBehavior: FloatingLabelBehavior.never,
                                                              //                 contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                              //                 border: const OutlineInputBorder(),
                                                              //               ),
                                                              //               style: Black87HintStyle,
                                                              //             ),
                                                              //           ),
                                                              //           Positioned(
                                                              //               bottom:1,left:2,
                                                              //               child: InkWell(
                                                              //                 onTap:(){
                                                              //                   setState((){
                                                              //                     OfferPeriodController.clear();
                                                              //                     offerPeriodFromTime="";
                                                              //                     offerPeriodFromDate="";
                                                              //                     offerPeriodToDate="";
                                                              //                     offerPeriodToTime="";
                                                              //                     isPeriodVisible = false;
                                                              //                     offerDisableFields.add("Period");
                                                              //                   });
                                                              //                 },
                                                              //                 child: CircleAvatar(
                                                              //                   radius:8,
                                                              //                   backgroundColor: Color(
                                                              //                       0x3389F6B9) ,
                                                              //                   child: Center(
                                                              //                       child:Icon(Icons.close,color: Colors.black,size:14,)
                                                              //                   ),
                                                              //                 ),
                                                              //               ))
                                                              //         ],
                                                              //       ),
                                                              //       const SizedBox(height:5),
                                                              //       const Padding(
                                                              //         padding: EdgeInsets.only(left:8.0),
                                                              //         child: Text("Period", style: BlackDescStyle,),
                                                              //       ),
                                                              //     ],
                                                              //   ),
                                                              // ):TextForNewAdd(context,text: "Period",onTap: (){
                                                              //   setState(() {
                                                              //     isPeriodVisible = true;
                                                              //     offerDisableFields.remove("Period");
                                                              //   });
                                                              // }),
                                                              selectedPeriodicityValue == "Today" || selectedPeriodicityValue == "Tomorrow"?SizedBox():
                                                              isPeriodVisible?
                                                              Padding(
                                                                padding: EdgeInsets.only(right:0,top:2),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [

                                                                    const Padding(
                                                                      padding: EdgeInsets.only(left:0.0,bottom: 5,top:5),
                                                                      child: Text("Period Date", style: BlackDescStyle500,),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:(){
                                                                            setState((){
                                                                              OfferPeriodController.clear();
                                                                              offerPeriodFromDate="";
                                                                              offerPeriodToDate="";
                                                                              isPeriodVisible = false;
                                                                              offerDisableFields.add("DatePeriod");
                                                                            });setModalState((){});
                                                                          },
                                                                          child: CircleAvatar(
                                                                            radius:8,
                                                                            backgroundColor: Color(0x3389F6B9) ,
                                                                            child: Center(
                                                                                child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        10.width,
                                                                        Flexible(
                                                                          child: Container(
                                                                            height: 35,
                                                                            padding:EdgeInsets.only(left:12),
                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                                            width: isMobile?width:tabWidth,
                                                                            child: TextFormField(
                                                                              controller: OfferPeriodController,
                                                                              readOnly: true,
                                                                              onTap:(){

                                                                                DatePickerFromTo(
                                                                                    startText: "From",
                                                                                    endText: "To",
                                                                                    doneText: "Done",
                                                                                    cancelText: "Cancel",
                                                                                    interval: 1,
                                                                                    mode: FromToDateRangePickerMode.date,
                                                                                    minimumTime: DateTime.now(),
                                                                                    maximumTime: DateTime.now().add(Duration(days: 25)),
                                                                                    initialStartTime: OfferPeriodController.text.isEmpty? DateTime.now().add(Duration(hours: 1)):OfferFromDate,
                                                                                    initialEndTime:OfferPeriodController.text.isEmpty? DateTime.now().add(Duration(hours: 1)):OfferToDate ,
                                                                                    use24hFormat: false,
                                                                                    onConfirm:  (start, end) {
                                                                                      if(end == "NotPick"){
                                                                                        isSinglePeriodSelect =true;

                                                                                        setState((){
                                                                                          OfferPeriodTimeController.clear();
                                                                                          OfferDurationController.clear();
                                                                                          final  STime = DateFormat('dd-MMM-yyyy').format(start);
                                                                                          OfferPeriodController.text = "${STime}";
                                                                                          final  SDate = DateFormat('dd-MM-yyyy').format(start);
                                                                                          offerPeriodFromTime="";
                                                                                          offerPeriodFromDate="";
                                                                                          offerPeriodToDate="";
                                                                                          offerPeriodToTime="";
                                                                                          offerPeriodFromDate = SDate.toString();
                                                                                          OfferFromDate  = start;


                                                                                          // for(var i = 0 ;i< ItemsList.length ; i++){
                                                                                          //   ItemsList[i]["item_condition"]["period"].text = "${STime}";
                                                                                          //   ItemsList[i]["item_condition"]["fromperiod"]= SDate.toString();
                                                                                          //   ItemsList[i]["item_condition"]["FromPeriodDateFill"]= start;
                                                                                          // }
                                                                                        });setModalState((){});
                                                                                      }else{
                                                                                        setState((){
                                                                                          isSinglePeriodSelect = false;

                                                                                          int totalDays = DateTime.parse(end).difference(start).inDays;
                                                                                          int years = totalDays ~/ 365;
                                                                                          int months = (totalDays-years*365) ~/ 30;
                                                                                          int days = totalDays-years*365-months*30;
                                                                                          int doneHours = years*365*24;
                                                                                          int hours = DateTime.parse(end).difference(start).inHours  -(doneHours) -(months*30*24) - (days*24);
                                                                                          int min = (((DateTime.parse(end).difference(start).inMinutes - (years*365*24*60)) -(months*30*24*60)) - (days*24*60) )-hours*60;
                                                                                          String empty = "";

                                                                                          TempDurationDate = "${years != 0 ? '${years} Year(s)': empty} ${ months != 0 ? '${months} Month(s)': empty } ${days != 0 ?'${days} Day(s)': empty }";
                                                                                          OfferDurationController.text = "${years != 0 ? '${years} Year(s)': empty} ${ months != 0 ? '${months} Month(s)': empty } ${days != 0 ?'${days} Day(s)': empty }";
                                                                                          final  FTime = DateFormat('dd-MMM-yyyy').format(start);
                                                                                          final  ToTime = DateFormat('dd-MMM-yyyy').format(DateTime.parse(end));
                                                                                          OfferPeriodController.text = "${FTime}-${ToTime}";
                                                                                          final  SDate = DateFormat('dd-MM-yyyy').format(start);

                                                                                          offerPeriodFromDate = SDate.toString();
                                                                                          final  EDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(end));
                                                                                          offerPeriodToDate = EDate.toString();
                                                                                          OfferFromDate  = start;
                                                                                          OfferToDate = DateTime.parse(end.toString());
                                                                                          print("API = > ${offerPeriodFromDate}");
                                                                                          print("API = > ${offerPeriodToDate}");
                                                                                          print("View = > ${OfferPeriodController.text}");

                                                                                          // for(var i = 0 ;i< ItemsList.length ; i++){
                                                                                          //   ItemsList[i]["item_condition"]["period"].text = "${FTime}-${ToTime}";
                                                                                          //   ItemsList[i]["item_condition"]["fromperiod"]= SDate.toString();
                                                                                          //   ItemsList[i]["item_condition"]["toperiod"] = SDate.toString();
                                                                                          //   ItemsList[i]["item_condition"]["FromPeriodDateFill"]= start;
                                                                                          //   ItemsList[i]["item_condition"]["ToPeriodDateFill"]= DateTime.parse(end);
                                                                                          // }
                                                                                        });setModalState((){});
                                                                                      }
                                                                                    }).showPicker(context);

                                                                                // FromToDatePicker(context,FirstDate: DateTime.now(),LastDate: DateTime.now().add(Duration(days: 365)));
                                                                              },
                                                                              keyboardType: TextInputType.text,
                                                                              decoration: InputDecoration(hintText: "Period Date", fillColor:  Colors.white, hintStyle: greyHintStyle,
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

                                                                      ],
                                                                    ),

                                                                  ],
                                                                ),
                                                              ):
                                                              TextForNewAdd(context,text: "Period Date",onTap: (){
                                                                setState(() {
                                                                  isPeriodVisible = true;
                                                                  offerDisableFields.remove("DatePeriod");
                                                                });setModalState((){});
                                                              }),
                                                              isPeriodTimeVisible?    Padding(
                                                                padding: EdgeInsets.only(top:2),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [

                                                                    const Padding(
                                                                      padding: EdgeInsets.only(left:0.0,bottom: 5,top:5),
                                                                      child: Text("Period Time", style: BlackDescStyle500,),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:(){
                                                                            setState((){
                                                                              OfferPeriodTimeController.clear();
                                                                              offerPeriodFromTime="";
                                                                              offerPeriodToTime="";
                                                                              isPeriodTimeVisible = false;
                                                                              offerDisableFields.add("DatePeriod");
                                                                            });setModalState((){});
                                                                          },
                                                                          child: CircleAvatar(
                                                                            radius:8,
                                                                            backgroundColor: Color(0x3389F6B9) ,
                                                                            child: Center(
                                                                                child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                            ),
                                                                          ),
                                                                        ),10.width,
                                                                        Flexible(
                                                                          child: Container(
                                                                            height: 35,
                                                                            padding:EdgeInsets.only(left:12),
                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),

                                                                            child: TextFormField(
                                                                              controller: OfferPeriodTimeController,
                                                                              readOnly: true,

                                                                              onTap:(){
                                                                                FromToTimePicker(
                                                                                    startText: "From",
                                                                                    endText: "To",
                                                                                    doneText: "Done",
                                                                                    cancelText: "Cancel",
                                                                                    interval: 1,

                                                                                    mode: FromToTimePickerMode.time,

                                                                                    type:selectedPeriodicityValue == "Today" ?"Today":"Else",
                                                                                    initialStartTime: OfferPeriodTimeController.text.isEmpty?
                                                                                    selectedPeriodicityValue.toString().trim() == "Today" ?
                                                                                    DateTime.now().add(Duration(hours: 1)):
                                                                                    DateFormat("yyyy-MM-dd HH:mm:ss").parse("${DateFormat("yyyy-MM-dd").parse(DateTime.now().toString())} 00:01:00"):
                                                                                    OfferFromTime,
                                                                                    initialEndTime: OfferPeriodTimeController.text.isEmpty?
                                                                                    selectedPeriodicityValue.toString().trim() == "Today" ?
                                                                                    DateTime.now().add(Duration(hours: 1)):
                                                                                    DateFormat("yyyy-MM-dd HH:mm:ss").parse("${DateFormat("yyyy-MM-dd").parse(DateTime.now().toString())} 00:01:00"):
                                                                                    OfferToTime,

                                                                                    use24hFormat: false,
                                                                                    onConfirm: (start, end) {
                                                                                      print(start);
                                                                                      print(end);
                                                                                      if(end == "NotPick"){

                                                                                        setState((){
                                                                                          selectedPeriodicityValue == "Today" || selectedPeriodicityValue == "Tomorrow"?
                                                                                          isSinglePeriodSelect =true :null;
                                                                                          final  STime = DateFormat('hh:mm a').format(start);
                                                                                          OfferPeriodTimeController.text = "${STime}";
                                                                                          offerPeriodFromTime="";
                                                                                          offerPeriodToTime="";
                                                                                          final  STime24 = DateFormat('HH:mm').format(start);
                                                                                          offerPeriodFromTime = STime24.toString();
                                                                                          OfferFromTime = start;


                                                                                          // for(var i = 0 ;i< ItemsList.length ; i++){
                                                                                          //   ItemsList[i]["item_condition"]["periodTime"].text = "From ${STime}";
                                                                                          //   ItemsList[i]["item_condition"]["fromperiodtime"]= STime24.toString();
                                                                                          //   ItemsList[i]["item_condition"]["FromPeriodTimeFill"]= start;
                                                                                          // }
                                                                                        });setModalState((){});
                                                                                      }else{
                                                                                        setState((){
                                                                                          selectedPeriodicityValue == "Today" || selectedPeriodicityValue == "Tomorrow"?
                                                                                          isSinglePeriodSelect =false :null;
                                                                                          if(  selectedPeriodicityValue == "Today" || selectedPeriodicityValue == "Tomorrow"){
                                                                                            OfferDurationController.clear();
                                                                                            Duration diff = DateTime.parse(end).difference(start);
                                                                                            diff.inHours !=0?  TempDurationTime = "${diff.inHours.toString()} Hours": diff.inSeconds !=00?TempDurationTime = "${diff.inMinutes.toString()} Minutes" :TempDurationTime = "${diff.inSeconds.toString()} Seconds";
                                                                                            OfferDurationController.text.isEmpty ? OfferDurationController.text = TempDurationTime : OfferDurationController.text = "${OfferDurationController.text}${TempDurationTime}";
                                                                                          }


                                                                                          final  FTime = DateFormat('hh:mm a').format(start);
                                                                                          final  ToTime = DateFormat('hh:mm a').format(DateTime.parse(end));
                                                                                          OfferPeriodTimeController.text = "${FTime} - ${ToTime}";
                                                                                          offerPeriodFromTime="";
                                                                                          offerPeriodToTime="";
                                                                                          final  FTime24 = DateFormat('HH:mm').format(start);
                                                                                          final  ToTime24 = DateFormat('HH:mm').format(DateTime.parse(end));
                                                                                          offerPeriodFromTime = FTime24.toString();
                                                                                          offerPeriodToTime = ToTime24.toString();
                                                                                          OfferFromTime = start;
                                                                                          OfferToTime = DateTime.parse(end);

                                                                                          // for(var i = 0 ;i< ItemsList.length ; i++){
                                                                                          //   ItemsList[i]["item_condition"]["periodTime"].text = "${FTime} - ${ToTime}";
                                                                                          //   ItemsList[i]["item_condition"]["fromperiodtime"]= FTime24.toString();
                                                                                          //   ItemsList[i]["item_condition"]["toperiodtime"]= ToTime24.toString();
                                                                                          //   ItemsList[i]["item_condition"]["FromPeriodTimeFill"]= start;
                                                                                          //   ItemsList[i]["item_condition"]["ToPeriodTimeFIll"]= DateTime.parse(end);
                                                                                          // }
                                                                                        });setModalState((){});
                                                                                      }
                                                                                    }).showPicker(context);


                                                                              },
                                                                              keyboardType: TextInputType.text,
                                                                              decoration: InputDecoration(hintText: "Period Time", fillColor:  Colors.white, hintStyle: greyHintStyle,
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

                                                                      ],
                                                                    ),

                                                                  ],
                                                                ),
                                                              ): TextForNewAdd(context,text: "Period Time",onTap: (){
                                                                setState(() {
                                                                  isPeriodTimeVisible = true;
                                                                  offerDisableFields.remove("TimePeriod");
                                                                });setModalState((){});
                                                              }),

                                                              isDurationVisible==true?   Padding(
                                                                padding: EdgeInsets.only(top:2),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [

                                                                    const Padding(
                                                                      padding: EdgeInsets.only(left:0.0,bottom: 5,top:5),
                                                                      child: Text("Duration(YY:MM:DD:HH:MI)", style: BlackDescStyle500,),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:(){
                                                                            setState((){
                                                                              OfferDurationController.clear();
                                                                              isDurationVisible = false;
                                                                              offerDisableFields.add("Duration");
                                                                            });setModalState((){});
                                                                          },
                                                                          child: CircleAvatar(
                                                                            radius:8,
                                                                            backgroundColor: Color(
                                                                                0x3389F6B9) ,
                                                                            child: Center(
                                                                                child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        10.width,
                                                                        Flexible(
                                                                          child: Container(
                                                                            height: 35,
                                                                            padding:EdgeInsets.only(left:12),
                                                                            decoration: BoxDecoration(color: Colors.white,  borderRadius: BorderRadius.circular(5)),

                                                                            child: TextFormField(
                                                                              inputFormatters: [maskFormatter],
                                                                              controller: OfferDurationController,
                                                                              keyboardType: TextInputType.number,

                                                                              onTap:(){
                                                                                if(isSinglePeriodSelect==true){
                                                                                  showDurationPickerNew(context,setState,setModalState,OfferDurationController);
                                                                                }else{
                                                                                }
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
                                                                        ),

                                                                      ],
                                                                    ),

                                                                  ],
                                                                ),
                                                              ):TextForNewAdd(context,text: "Duration",onTap: (){
                                                                setState(() {
                                                                  isDurationVisible = true;
                                                                  offerDisableFields.remove("Duration");
                                                                });setModalState((){});
                                                              }),
                                                              selectedTap == "Deliver"?SizedBox():  Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                                children: [

                                                                  const Padding(
                                                                    padding: EdgeInsets.only(left:0.0,bottom: 5,top:5),
                                                                    child: Text("Service/Delivery person", style: BlackDescStyle500,),
                                                                  ),
                                                                  Container(
                                                                    height:38,
                                                                    decoration:BoxDecoration(
                                                                      color:Colors.transparent,

                                                                    ),
                                                                    width:isMobile?width*0.9:tabWidth*0.9,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(0.0),
                                                                      child: CustomSearchableDropDownForUs(
                                                                        initialValue: widget.From == "Fill" ? selectedItems :[],
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

                                                                              // for(var i = 0 ;i< ItemsList.length ; i++){
                                                                              //   ItemsList[i]["item_condition"]["servicepersons"]  =jsonDecode(value).map((e) =>e["id"] ).toList();
                                                                              // }
                                                                            });setModalState((){});
                                                                          }
                                                                          else{
                                                                            //selectedItems!.clear();
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),


                                                              isPriorityVisible==true?    Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(left:0.0,bottom: 5,top:5),
                                                                    child: Text("Priority", style: BlackDescStyle500,),
                                                                  ),
                                                                  Row(
                                                                    children: [

                                                                      InkWell(
                                                                        onTap:(){
                                                                          setState((){
                                                                            selectedValuePriority = "";
                                                                            isPriorityVisible = false;
                                                                            offerDisableFields.add("Priority");
                                                                          });setModalState((){});
                                                                        },
                                                                        child: CircleAvatar(
                                                                          radius:8,
                                                                          backgroundColor: Color(0x3389F6B9) ,
                                                                          child: Center(
                                                                              child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      10.width,
                                                                      Flexible(
                                                                        child: DropdownButtonHideUnderline(
                                                                          child: DropdownButton2(
                                                                              isExpanded: true,
                                                                              items:priority.map((item) => DropdownMenuItem (
                                                                                value: item,
                                                                                child: Text(item, style:  Black87HintStyle, overflow: TextOverflow.ellipsis,),
                                                                              )).toList(),
                                                                              value: selectedValuePriority==""?null:selectedValuePriority,
                                                                              onChanged: (newValue) {
                                                                                setState(() {
                                                                                  selectedValuePriority = newValue!;
                                                                                });setModalState((){});
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

                                                                                  padding: const EdgeInsets.only(left: 20, right: 3),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white),
                                                                                  elevation:  0,
                                                                                  overlayColor: MaterialStateProperty.all(Colors.white)
                                                                              ),
                                                                              menuItemStyleData: MenuItemStyleData(
                                                                                height: 33,
                                                                                selectedMenuItemBuilder: (context, child) {
                                                                                  return     Container(
                                                                                    padding: const EdgeInsets.only(left: 0, right: 0),

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

                                                                              style: Black87HintStyle

                                                                          ),
                                                                        ),
                                                                      ),

                                                                    ],
                                                                  ),

                                                                ],
                                                              ):
                                                              TextForNewAdd(context,text: "Priority",onTap: (){
                                                                setState(() {
                                                                  isPriorityVisible = true;
                                                                  offerDisableFields.remove("Priority");
                                                                });setModalState((){});
                                                              }),
                                                              isExpiryVisible == true? Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [

                                                                  const Padding(
                                                                    padding: EdgeInsets.only(left:0.0,bottom: 5,top:5),
                                                                    child: Text("Expiry", style: BlackDescStyle500,),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:(){
                                                                          setState((){
                                                                            ExDTime=null;
                                                                            offerExpiryDateTime = "";
                                                                            OfferExpiryController.clear();
                                                                            isExpiryVisible = false;
                                                                            offerDisableFields.add("Expiry");
                                                                          });setModalState((){});
                                                                        },
                                                                        child: CircleAvatar(
                                                                          radius:8,
                                                                          backgroundColor: Color(0x3389F6B9) ,
                                                                          child: Center(
                                                                              child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      10.width,
                                                                      Flexible(
                                                                        child: Container(
                                                                          height: 35,
                                                                          padding: EdgeInsets.only(left:12),
                                                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),

                                                                          child: TextFormField(
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
                                                                                                height: ResponsiveHelper.isMobile(context)?height*0.3:tabWidth*0.45,
                                                                                                width: isMobile?null:tabWidth,
                                                                                                child:  Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                  children: [
                                                                                                    Flexible(
                                                                                                      child: Padding(
                                                                                                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                                                                                                              initialDateTime: OfferExpiryController.text.isEmpty ?DateTime.now():ExDTime,
                                                                                                              onDateTimeChanged: (DateTime newDateTime) {
                                                                                                                setState((){
                                                                                                                  ExDTime = newDateTime;

                                                                                                                });setModalState((){});
                                                                                                              },
                                                                                                              maximumDate: DateTime.now().add(const Duration(days: 720)),
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
                                                                                                            OfferExpiryDateTime = ExDTime;

                                                                                                            final  STime = DateFormat('dd-MMM-yyyy hh:mm a').format(ExDTime!);
                                                                                                            OfferExpiryController.text = STime ;
                                                                                                            final  SDateTime = DateFormat('dd-MM-yyyy HH:mm').format(ExDTime!);
                                                                                                            offerExpiryDateTime = SDateTime;
                                                                                                            // for(var i = 0 ;i< ItemsList.length ; i++){
                                                                                                            //   ItemsList[i]["item_condition"]["expiry"].text  = SDateTime;
                                                                                                            //   ItemsList[i]["item_condition"]["ExpiryDateTime"]  = ExDTime;
                                                                                                            // }
                                                                                                          });setModalState((){});
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
                                                                      ),

                                                                    ],
                                                                  ),

                                                                ],
                                                              ):TextForNewAdd(context,text: "Expiry",onTap: (){
                                                                setState(() {
                                                                  isExpiryVisible = true;
                                                                  offerDisableFields.remove("Expiry");
                                                                });setModalState((){});
                                                              }),
                                                              isViewOfferFormLocation==true?  Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [

                                                                  Padding(
                                                                    padding: EdgeInsets.only(left:0.0,bottom: 5,top:5),
                                                                    child: Text("From location", style: BlackDescStyle500,),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:(){
                                                                          setState((){
                                                                            OfferFromLocationController.clear();
                                                                            isViewOfferFormLocation = false;
                                                                            offerDisableFields.add("FromLocation");
                                                                          });setModalState((){});
                                                                        },
                                                                        child: CircleAvatar(
                                                                          radius:8,
                                                                          backgroundColor: Color(
                                                                              0x3389F6B9) ,
                                                                          child: Center(
                                                                              child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      10.width,
                                                                      Flexible(
                                                                        child: Container(
                                                                          height: 35,
                                                                          padding: EdgeInsets.only(left:12),
                                                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),

                                                                          child: TextFormField(
                                                                            controller: OfferFromLocationController,
                                                                            onTap:() async {
                                                                              if(LatitudeLongitude == null ){
                                                                                Constants.showToast("Please wait");
                                                                              }else{
                                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong: LatitudeLongitude!,isAppPlaceView: true,isTitleSelectAsAddress: true))).then((value) {
                                                                                  setState((){
                                                                                    OfferFromLocationController.text=value.toString();
                                                                                  });setModalState((){});
                                                                                  // for(var i = 0 ;i< ItemsList.length ; i++){
                                                                                  //   ItemsList[i]["item_condition"]["fromlocation"].text  = value.toString();
                                                                                  // }
                                                                                });
                                                                              }


                                                                              // if(_currentTapindex == 0){
                                                                              //
                                                                              //   String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => NormalPlacePickerScreen("AIzaSyDE9xGmWMOftPvz1hHwPlTecShhHtR4goE")));
                                                                              //   setState((){
                                                                              //     OfferFromLocationController.text=result.toString();
                                                                              //   });
                                                                              //   for(var i = 0 ;i< ItemsList.length ; i++){
                                                                              //     ItemsList[i]["item_condition"]["fromlocation"].text  = result.toString();
                                                                              //   }
                                                                              // }else{
                                                                              //   Navigator.push(context, MaterialPageRoute(builder: (context) => ManageAddressScreen(from: "Home"))).then((value) {
                                                                              //     setState((){
                                                                              //       OfferFromLocationController.text=value.toString();
                                                                              //       for(var i = 0 ;i< ItemsList.length ; i++){
                                                                              //         ItemsList[i]["item_condition"]["fromlocation"].text  = value.toString();
                                                                              //       }
                                                                              //     });
                                                                              //   });
                                                                              // }


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
                                                                      ),

                                                                      // isViewOfferToLocation==true?SizedBox():    Positioned(
                                                                      //     top:1,right:2,
                                                                      //     child: InkWell(
                                                                      //       onTap:(){
                                                                      //         setState((){
                                                                      //           isViewOfferToLocation =true ;
                                                                      //         });
                                                                      //       },
                                                                      //       child: CircleAvatar(
                                                                      //         radius:8,
                                                                      //         backgroundColor: Constants.primaryColor1 ,
                                                                      //         child: Center(
                                                                      //             child:Icon(Icons.add,color: Colors.white,size:14,)
                                                                      //         ),
                                                                      //       ),
                                                                      //     ))
                                                                    ],
                                                                  ),

                                                                ],
                                                              ):
                                                              TextForNewAdd(context,text: "FromLocation",onTap: (){
                                                                setState(() {
                                                                  isViewOfferFormLocation = true;
                                                                  offerDisableFields.remove("FromLocation");
                                                                });setModalState((){});
                                                              }),
                                                              isViewOfferToLocation==true?  Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [

                                                                  Padding(
                                                                    padding: EdgeInsets.only(left:0.0,bottom: 5,top:5),
                                                                    child: Text("To location", style: BlackDescStyle500,),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:(){
                                                                          setState((){
                                                                            OfferToLocationController.clear();
                                                                            isViewOfferToLocation = false;
                                                                            offerDisableFields.add("ToLocation");
                                                                          });setModalState((){});
                                                                        },
                                                                        child: CircleAvatar(
                                                                          radius:8,
                                                                          backgroundColor: Color(
                                                                              0x3389F6B9) ,
                                                                          child: Center(
                                                                              child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      10.width,
                                                                      Flexible(
                                                                        child: Container(
                                                                          height: 35,
                                                                          padding: EdgeInsets.only(left:12),
                                                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),

                                                                          child: TextFormField(
                                                                            controller: OfferToLocationController,
                                                                            onTap:() async {
                                                                              if(LatitudeLongitude == null ){
                                                                                Constants.showToast("Please wait");
                                                                              }else{
                                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong: LatitudeLongitude!,isAppPlaceView: true,isTitleSelectAsAddress: true))).then((value) {
                                                                                  setState((){
                                                                                    OfferToLocationController.text=value.toString();
                                                                                    // for(var i = 0 ;i< ItemsList.length ; i++){
                                                                                    //   ItemsList[i]["item_condition"]["tolocation"].text  = value.toString();
                                                                                    // }
                                                                                  });setModalState((){});
                                                                                });
                                                                              }


                                                                              // if(_currentTapindex == 0){
                                                                              //   Navigator.push(context, MaterialPageRoute(builder: (context) => ManageAddressScreen(from: "Home"))).then((value) {
                                                                              //     setState((){
                                                                              //       OfferToLocationController.text=value.toString();
                                                                              //       for(var i = 0 ;i< ItemsList.length ; i++){
                                                                              //         ItemsList[i]["item_condition"]["tolocation"].text  = value.toString();
                                                                              //       }
                                                                              //     });
                                                                              //   });
                                                                              // }else{
                                                                              //   String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => NormalPlacePickerScreen("AIzaSyDE9xGmWMOftPvz1hHwPlTecShhHtR4goE")));
                                                                              //   setState((){
                                                                              //     OfferToLocationController.text=result.toString();
                                                                              //     for(var i = 0 ;i< ItemsList.length ; i++){
                                                                              //       ItemsList[i]["item_condition"]["tolocation"].text  = result.toString();
                                                                              //     }
                                                                              //   });
                                                                              // }
                                                                              // String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => NormalPlacePickerScreen("AIzaSyDE9xGmWMOftPvz1hHwPlTecShhHtR4goE")));
                                                                              // setState((){
                                                                              //   OfferToLocationController.text=result.toString();
                                                                              //   for(var i = 0 ;i< ItemsList.length ; i++){
                                                                              //     ItemsList[i]["item_condition"]["tolocation"].text  = result.toString();
                                                                              //   }
                                                                              // });
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
                                                                      ),

                                                                      // isViewOfferAtLocation==true?SizedBox():  Positioned(
                                                                      //     top:1,right:2,
                                                                      //     child: InkWell(
                                                                      //       onTap:(){
                                                                      //         setState((){
                                                                      //           isViewOfferAtLocation = true ;
                                                                      //         });
                                                                      //       },
                                                                      //       child: CircleAvatar(
                                                                      //         radius:8,
                                                                      //         backgroundColor: Constants.primaryColor1 ,
                                                                      //         child: Center(
                                                                      //             child:Icon(Icons.add,color: Colors.white,size:14,)
                                                                      //         ),
                                                                      //       ),
                                                                      //     ))
                                                                    ],
                                                                  ),

                                                                ],
                                                              ):
                                                              TextForNewAdd(context,text: "To Location",onTap: (){
                                                                setState(() {
                                                                  isViewOfferToLocation = true;
                                                                  offerDisableFields.remove("ToLocation");
                                                                });setModalState((){});
                                                              }),
                                                              isViewOfferAtLocation==true?  Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [

                                                                  Padding(
                                                                    padding: EdgeInsets.only(left:0.0,bottom: 5,top:5),
                                                                    child: Text("At location", style: BlackDescStyle500,),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:(){
                                                                          setState((){
                                                                            OfferAtLocationController.clear();
                                                                            isViewOfferAtLocation= false;
                                                                            offerDisableFields.add("AtLocation");
                                                                          });setModalState((){});
                                                                        },
                                                                        child: CircleAvatar(
                                                                          radius:8,
                                                                          backgroundColor: Color(
                                                                              0x3389F6B9) ,
                                                                          child: Center(
                                                                              child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      10.width,
                                                                      Flexible(
                                                                        child: Container(
                                                                          height: 35,
                                                                          padding: EdgeInsets.only(left:12),
                                                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),

                                                                          child: TextFormField(
                                                                            controller:  OfferAtLocationController,
                                                                            onTap:() async {
                                                                              if(LatitudeLongitude == null ){
                                                                                Constants.showToast("Please wait");
                                                                              }else{
                                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong: LatitudeLongitude!,isAppPlaceView: true,isTitleSelectAsAddress: true))).then((value) {
                                                                                  setState((){
                                                                                    OfferAtLocationController.text=value.toString();
                                                                                    // for(var i = 0 ;i< ItemsList.length ; i++){
                                                                                    //   ItemsList[i]["item_condition"]["atlocation"].text  = value.toString();
                                                                                    // }
                                                                                  });setModalState((){});
                                                                                });
                                                                              }


                                                                              // String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => NormalPlacePickerScreen("AIzaSyDE9xGmWMOftPvz1hHwPlTecShhHtR4goE")));

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
                                                                      ),

                                                                      // Positioned(
                                                                      //     top:1,right:2,
                                                                      //     child: InkWell(
                                                                      //       onTap:(){
                                                                      //         setState((){
                                                                      //           Constants.showToast("From Location,To Location and At Location are allowed");
                                                                      //         });
                                                                      //       },
                                                                      //       child: CircleAvatar(
                                                                      //         radius:8,
                                                                      //         backgroundColor: Constants.primaryColor1 ,
                                                                      //         child: Center(
                                                                      //             child:Icon(Icons.add,color: Colors.white,size:14,)
                                                                      //         ),
                                                                      //       ),
                                                                      //     ))
                                                                    ],
                                                                  ),

                                                                ],
                                                              ):TextForNewAdd(context,text: "At Location",onTap: (){
                                                                setState(() {
                                                                  isViewOfferAtLocation = true;
                                                                  offerDisableFields.remove("AtLocation");
                                                                });setModalState((){});
                                                              }),

                                                              const SizedBox(height: 10,),


                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Positioned(
                                                        top:10,left:0,right:0,
                                                        child:BottomSheetDivider())
                                                  ],
                                                ),
                                              );
                                            },)
                                        );
                                      })                                    ],
                                  ),
                                ),
                              ),

                              // TODO Item Details
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: ItemsList.isEmpty?1:ItemsList.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var data = ItemsList[index];
                                return   Container(
                                   decoration:BoxDecoration(
                                     color:Colors.white,
                                     border:Border(bottom: BorderSide(color: Constants.bottomSheetBg,width: 1.5))
                                   ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                         data["name"].text.isEmpty || data["name"].text == ""?
                                        Row(
                                          children: [
                                            Text("Tap Edit To Enter Item Details",style:BlackSubCardTitle2),

                                          index ==0 ?SizedBox():  Padding(
                                              padding: const EdgeInsets.only(left:10.0),
                                              child: InkWell(
                                                onTap:  (){
                                                  setState((){
                                                    ItemsList.remove(data);
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:primaryColor,
                                                  child: Center(
                                                    child: Icon(Icons.remove, color: Colors.white, size: 20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                            :
                                        Container(
                                            width:isMobile?width:tabWidth,
                                            margin:EdgeInsets.only(bottom:10),
                                            child: Column(
                                              children: [
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:[
                                                      SizedBox(
                                                        width:isMobile?width*0.6:tabWidth*0.6,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children:[
                                                              Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width:isMobile?width*0.52:tabWidth*0.52,
                                                                      child: Text("${data["name"].text}",style:BlackSubTitleStyle,)),
                                                                  4.width,
                                                                  InkWell(
                                                                    onTap:  index == 0 ?(){
                                                                      setState((){

                                                                        List<UnitListData> TempUnitList = [];
                                                                        List selectedItemsPersonList = [];
                                                                        ItemsList.add({
                                                                          "itemId" :"",
                                                                          "name":TextEditingController(text: ""),
                                                                          "desc":TextEditingController(text: ""),
                                                                          "price":TextEditingController(text: ""),
                                                                          "unit":TextEditingController(text: ""),
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
                                                                          "type" : "new",

                                                                          "quantity":1,
                                                                          "currency":"INR",
                                                                          "addon":false,
                                                                          "required":false,
                                                                          "toggle_state":false,
                                                                          "media":[],
                                                                          "fileUrl":[],
                                                                          "isLoadingFile":false,
                                                                          "item_condition":{
                                                                            "itemDisableFields":[],
                                                                            "itemConditionId":"",
                                                                            "period":TextEditingController(text: ""),
                                                                            "periodTime":TextEditingController(text: ""),
                                                                            "periodicity":null,
                                                                            "fromperiod":"",
                                                                            "toperiod":"",
                                                                            "duration":TextEditingController(text: ""),
                                                                            "fromperiodtime":"",
                                                                            "toperiodtime":"",
                                                                            "durationoftime":"",
                                                                            "fromlocation" : TextEditingController(text:""),
                                                                            "tolocation" :  TextEditingController(text :""),
                                                                            "atlocation" : TextEditingController(text:""),
                                                                            "servicepersons": [],
                                                                            "priority":"",
                                                                            "expiry":TextEditingController(text: ""),
                                                                            "ExpiryDateTime" : ExDTime,
                                                                            "FromPeriodDateFill" : OfferFromDate,
                                                                            "ToPeriodDateFill" : OfferToDate,
                                                                            "FromPeriodTimeFill" : OfferFromTime,
                                                                            "ToPeriodTimeFIll" : OfferToTime,
                                                                          },
                                                                          "showMediaData":true,
                                                                          "isShowItem": true,
                                                                          "showItemPrice2":false,
                                                                          "showItemPrice3":false,
                                                                          "showItemCondition": false,
                                                                          "showItemPeriodicity" :true,
                                                                          "showItemPeriod" :true,
                                                                          "showItemPeriodTime" :true,
                                                                          "isItemSinglePeriodSelect" :true,
                                                                          "showItemDuration" :true,
                                                                          "showItemServicePerson1" :true,
                                                                          "showItemServicePerson2" :false,
                                                                          "showItemServicePerson3" :false,
                                                                          "showItemServicePerson4" :false,
                                                                          "showItemServicePerson5" :false,
                                                                          "showItemPriority" :true,
                                                                          "showItemExpiry" :true,
                                                                          "showItemFromLocation" :true,
                                                                          "showItemTOLocation" :true,
                                                                          "showItemAtLocation" :false,
                                                                          "showOfferBids1" :true,
                                                                          "showOfferBids2" :false,
                                                                        });
                                                                      });
                                                                    }:(){
                                                                      setState((){
                                                                        ItemsList.remove(data);
                                                                      });
                                                                    },
                                                                    child: CircleAvatar(
                                                                      radius: 10,
                                                                      backgroundColor:primaryColor,
                                                                      child: Center(
                                                                        child: index == 0 ? Icon(Icons.add, color: Colors.white, size: 20): Icon(Icons.remove, color: Colors.white, size: 20),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),

                                                              data["desc"].text == ""?SizedBox(): Padding(
                                                                padding: const EdgeInsets.only(top:5.0),
                                                                child: Text("${data["desc"].text}",style: Black87DescStyle,textAlign: TextAlign.start,),
                                                              ) ,

                                                              data["price"].text.isEmpty || data["price"].text == ""?SizedBox():
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                                                child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text("Rs. ${data["price"].text} ${data["unit"].text == "" || data["unit"].text.toString() == "null" ?"":data["unit"].text }",style:BlackSubTitleStyle,),
                                                                    Spacer(),
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children:[

                                                                        InkWell(
                                                                            onTap:(){
                                                                              setState(() {
                                                                                data["required"] = !data["required"];
                                                                                Constants.showToast( data["required"]  == true ?"REQUIRED Enabled":"REQUIRED Disabled");
                                                                              });
                                                                            },
                                                                            child: Text("REQUIRED", style: TextStyle(color:data["required"] ==true?primaryColor: Colors.black38, fontWeight:data["required"] ==true ?FontWeight.w600:FontWeight.w600, fontSize: 14),)),
                                                                        SizedBox(height: 10,),

                                                                        InkWell(
                                                                            onTap:(){
                                                                              setState(() {
                                                                                data["addon"] = !data["addon"];
                                                                                Constants.showToast( data["addon"]  == true ?"ADDON Enabled":"ADDON Disabled");
                                                                              });
                                                                            },
                                                                            child: Text("ADD ON", style: TextStyle(color: data["addon"] == true?primaryColor: Colors.black38, fontWeight:data["addon"] ==true ?FontWeight.w600: FontWeight.w600, fontSize: 14), )),
                                                                      ],
                                                                    ),
                                                                    5.width
                                                                  ],
                                                                ),
                                                              ),
                                                              // Padding(
                                                              //   padding: const EdgeInsets.only(top:2.0),
                                                              //   child: Row(
                                                              //     crossAxisAlignment: CrossAxisAlignment.start,
                                                              //     mainAxisAlignment: MainAxisAlignment.start,
                                                              //     children:[
                                                              //
                                                              //       InkWell(
                                                              //           onTap:(){
                                                              //             setState(() {
                                                              //               data["required"] = !data["required"];
                                                              //               Constants.showToast( data["required"]  == true ?"REQUIRED Enabled":"REQUIRED Disabled");
                                                              //             });
                                                              //           },
                                                              //           child: Text("REQUIRED", style: TextStyle(color:data["required"] ==true?primaryColor: Colors.black38, fontWeight:data["required"] ==true ?FontWeight.w600:FontWeight.w600, fontSize: 15),)),
                                                              //       SizedBox(width: 20,),
                                                              //
                                                              //       InkWell(
                                                              //           onTap:(){
                                                              //             setState(() {
                                                              //               data["addon"] = !data["addon"];
                                                              //               Constants.showToast( data["addon"]  == true ?"ADDON Enabled":"ADDON Disabled");
                                                              //             });
                                                              //           },
                                                              //           child: Text("ADD ON", style: TextStyle(color: data["addon"] == true?primaryColor: Colors.black38, fontWeight:data["addon"] ==true ?FontWeight.w600: FontWeight.w600, fontSize: 15), )),
                                                              //     ],
                                                              //   ),
                                                              // ),


                                                            ]
                                                        ),
                                                      ),
                                                      Stack(

                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              data["media"].isEmpty?
                                                              null:
                                                              ImageGalleryView(context, data["media"], data["fileUrl"],setState);
                                                              //Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryScreenNewOffer(MediaList: data["media"],UrlList: data["fileUrl"],)));
                                                            },
                                                            child: data["media"].isEmpty
                                                                ? Container(
                                                                height: isMobile?width*0.3:tabWidth*0.3,
                                                                width:isMobile?width*0.3:tabWidth*0.3,
                                                                padding: const EdgeInsets.all(0),
                                                                margin: EdgeInsets.only(bottom:10),
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                    color: Colors.white,
                                                                    borderRadius: BorderRadius.circular(5)),
                                                                child: DottedBorder(
                                                                  dashPattern: const [6, 2],
                                                                  strokeWidth: 1.5,
                                                                  color: Constants.primaryColor1,
                                                                  borderType: BorderType.RRect,
                                                                  radius: const Radius.circular(2),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(8.0),
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

                                                                      ],
                                                                    ),
                                                                  ),
                                                                ))
                                                                : Container(      margin: EdgeInsets.only(bottom:10),
                                                              height: isMobile?width*0.3:tabWidth*0.3,
                                                              width: isMobile?width*0.3:tabWidth*0.3, child:
                                                            "${data["media"][0]["name"].toString().substring( data["media"][0]["name"].toString().lastIndexOf('.'))}" == ".mp4"?Image.asset("assets/mp4placeholder.png",fit: BoxFit.cover):
                                                            Image.network(data["fileUrl"][0], fit: BoxFit.fill),
                                                            ),
                                                          ),
                                                          data["media"].isEmpty ||  data["media"].length == 1 ?SizedBox():
                                                          InkWell(
                                                            onTap:(){
                                                              ImageGalleryView(context, data["media"], data["fileUrl"],setState);
                                                              //  Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryScreenNewOffer(MediaList: data["media"],UrlList: data["fileUrl"])));
                                                            },
                                                            child: Container(
                                                                margin: EdgeInsets.only(bottom:10),
                                                                height: isMobile?width*0.3:tabWidth*0.3,
                                                                width: isMobile?width*0.3:tabWidth*0.3,
                                                                padding: const EdgeInsets.all(0),
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                    color: Colors.transparent,
                                                                    borderRadius: BorderRadius.circular(5)),
                                                                child:Center(
                                                                    child:Text("+${data["media"].length -1}",style: BlackTitle500height,)
                                                                )
                                                            ),
                                                          ),
                                                          Positioned(
                                                              left:20,right:20,bottom:0,
                                                              child:
                                                          Container(
                                                            height:30,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(3),
                                                              color: primaryColor,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                InkWell(
                                                                  onTap:(){
                                                                    setState((){
                                                                      data["quantity"]==1? Constants.showToast("Minimum QTY is 1"):  data["quantity"] --;
                                                                    });
                                                                  },
                                                                  child:Icon(Icons.remove,color:Colors.white,size:16)
                                                                ),
                                                                Text(data["quantity"]==0?"Qty":"${data["quantity"]}",style: WhiteSubTitleStyle,),
                                                                InkWell(
                                                                    onTap:(){
                                                                      setState((){
                                                                        data["quantity"] ++;
                                                                      });
                                                                    },
                                                                    child:Icon(Icons.add,color:Colors.white,size:16)
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                          ),
                                                        ],
                                                      ),

                                                    ]
                                                ),

                                                data["item_condition"]["period"].text == "" &&
                                                    data["item_condition"]["periodTime"].text == "" &&
                                                    data["item_condition"]["periodicity"] == null &&
                                                    data["item_condition"]["expiry"].text == ""&&
                                                    data["item_condition"]["priority"] == "" &&
                                                    data["item_condition"]["duration"].text == "" &&
                                                    data["item_condition"]["servicepersons"].isEmpty &&
                                                    data["item_condition"]["atlocation"].text == "" &&
                                                    data["item_condition"]["fromlocation"].text == "" &&
                                                    data["item_condition"]["tolocation"].text == ""?
                                                Padding(
                                                  padding: const EdgeInsets.only(top:0.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text("No item level conditions",style: BlackSubTitleStyle,),
                                                    ],
                                                  ),
                                                )
                                                    :
                                                Padding(
                                                  padding: const EdgeInsets.only(top:8.0),
                                                  child: Row (
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Flexible(
                                                        child: RichText(
                                                            textAlign: TextAlign.left,
                                                            text: TextSpan(style: TextStyle(height: 1.5, color: Colors.black), children: [
                                                              TextSpan(text: data["item_condition"]["periodicity"].toString() == ""|| data["item_condition"]["periodicity"].toString() == "null"?"":  "${ data["item_condition"]["periodicity"]}", style: Black45DescStyle),
                                                              // TextSpan(text: " ${selectedValuePriority}", style:Black45DescStyle),
                                                              data["item_condition"]["period"].text.isEmpty ||  data["item_condition"]["period"].text.toString() == "" ||  data["item_condition"]["periodicity"] == "Today" ||  data["item_condition"]["periodicity"] == "Tomorrow" ?
                                                              TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " From ", style:BlackSubTitleItalicStyle),
                                                              data["item_condition"]["period"].text.isEmpty ||  data["item_condition"]["period"].text.toString() == "" ||  data["item_condition"]["periodicity"] == "Today" ||  data["item_condition"]["periodicity"] == "Tomorrow"?
                                                              TextSpan(text: "", style:Black45DescStyle):
                                                              TextSpan(text: "${ data["item_condition"]["period"].text}", style: Black45DescStyle),
                                                              data["item_condition"]["periodTime"].text.isEmpty ||  data["item_condition"]["periodTime"].text.toString() == ""  ?
                                                              TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " From ", style:BlackSubTitleItalicStyle),
                                                              data["item_condition"]["periodTime"].text.isEmpty ||  data["item_condition"]["periodTime"].text.toString() == "" ?
                                                              TextSpan(text: "", style:Black45DescStyle):
                                                              TextSpan(text: "${ data["item_condition"]["periodTime"].text}", style: Black45DescStyle),

                                                              data["item_condition"]["duration"].text.isEmpty || data["item_condition"]["duration"].text.toString() == ""  ?
                                                              TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " For ", style:BlackSubTitleItalicStyle),
                                                              data["item_condition"]["duration"].text.isEmpty || data["item_condition"]["duration"].text.toString() == "" ?
                                                              TextSpan(text: "", style:Black45DescStyle):
                                                              TextSpan(text: "${data["item_condition"]["duration"].text}", style: Black45DescStyle),

                                                              data["item_condition"]["servicepersons"].isEmpty || data["item_condition"]["servicepersons"].contains("-1") || data["item_condition"]["servicepersons"].contains("0") == ""  ?
                                                              TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " By ", style:BlackSubTitleItalicStyle),
                                                              data["item_condition"]["servicepersons"].isEmpty || data["item_condition"]["servicepersons"].contains("-1") || data["item_condition"]["servicepersons"].contains("0") == ""  ?
                                                              TextSpan(text: "", style:Black45DescStyle):
                                                              TextSpan(text: ServicePersonList.where((e) => e.id.toString() == data["item_condition"]["servicepersons"].first.toString()).first.displayname.toString(), style: Black45DescStyle),

                                                              data["item_condition"]["priority"].toString() == "null" || data["item_condition"]["priority"].toString() == "" ?
                                                              TextSpan(text: "", style:Black45DescStyle):
                                                              TextSpan(text: " ${data["item_condition"]["priority"]}", style: Black45DescStyle),

                                                              data["item_condition"]["fromlocation"].text.isEmpty ||  data["item_condition"]["fromlocation"].text.toString() == "" ||  data["item_condition"]["fromlocation"].text.toString().trim() == "null" ?
                                                              TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " From ", style:BlackSubTitleItalicStyle),
                                                              data["item_condition"]["fromlocation"].text.isEmpty ||  data["item_condition"]["fromlocation"].text.toString() == "" ||  data["item_condition"]["fromlocation"].text.toString().trim() == "null"?
                                                              TextSpan(text: "", style:Black45DescStyle):
                                                              TextSpan(text: "${ data["item_condition"]["fromlocation"].text}", style: Black45DescStyle),


                                                              data["item_condition"]["tolocation"].text.isEmpty || data["item_condition"]["tolocation"].text.toString() == "" || data["item_condition"]["tolocation"].text.toString().trim() == "null" ?
                                                              TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " To ", style:BlackSubTitleItalicStyle),
                                                              data["item_condition"]["tolocation"].text.isEmpty || data["item_condition"]["tolocation"].text.toString() == ""|| data["item_condition"]["tolocation"].text.toString().trim() == "null" ?
                                                              TextSpan(text: "", style:Black45DescStyle):
                                                              TextSpan(text: "${data["item_condition"]["tolocation"].text}", style: Black45DescStyle),

                                                              data["item_condition"]["atlocation"].text.isEmpty ||   data["item_condition"]["atlocation"].text.toString() == ""  ||   data["item_condition"]["atlocation"].text.toString().trim() == "null" ?
                                                              TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " At ", style:BlackSubTitleItalicStyle),
                                                              data["item_condition"]["atlocation"].text.isEmpty ||   data["item_condition"]["atlocation"].text.toString() == "" ||   data["item_condition"]["atlocation"].text.toString().trim() == "null"?
                                                              TextSpan(text: "", style:Black45DescStyle):
                                                              TextSpan(text: "${  data["item_condition"]["atlocation"].text}", style: Black45DescStyle),

                                                              data["item_condition"]["expiry"].text.isEmpty ||   data["item_condition"]["expiry"].text.toString() == ""  ||   data["item_condition"]["expiry"].text.toString().trim() == "null" ?
                                                              TextSpan(text: "", style:Black45DescStyle): TextSpan(text: " Expiry ", style:BlackSubTitleItalicStyle),
                                                              data["item_condition"]["expiry"].text.isEmpty ||   data["item_condition"]["expiry"].text.toString() == "" ||   data["item_condition"]["expiry"].text.toString().trim() == "null"?
                                                              TextSpan(text: "", style:Black45DescStyle):
                                                              TextSpan(text: "${ data["item_condition"]["expiry"].text}", style: Black45DescStyle),


                                                            ])),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children:[
                                              EditBtn((){
                                                Get.bottomSheet(
                                                    elevation: 0,  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                                                ),
                                                    isDismissible: true,isScrollControlled: true,
                                                    StatefulBuilder(builder: (context, setModalState) {
                                                      return  Container(
                                                         constraints: BoxConstraints(
                                                           maxHeight:height*0.85,
                                                         ),
                                                        decoration: BoxDecoration(
                                                            color:Constants.bottomSheetBg,
                                                            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Stack(
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      color:Constants.bottomSheetBg,
                                                                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                                                                  ),
                                                                  child: SingleChildScrollView(
                                                                    physics: ScrollPhysics(),
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        30.height,
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            const SizedBox(width: 5,),
                                                                            Column(
                                                                              children: [
                                                                                Container(
                                                                                  height: data["name"].text.length < 15 ?35:null,
                                                                                  decoration: BoxDecoration(
                                                                                      color: Constants.white,
                                                                                      borderRadius: BorderRadius.circular(5)),
                                                                                  width: isMobile?width*0.4:tabWidth*0.4,
                                                                                  margin: EdgeInsets.only(left: 5,right:10,top: 10),
                                                                                  child: ConstrainedBox(
                                                                                    constraints: BoxConstraints(
                                                                                        maxHeight: 150.0
                                                                                    ),
                                                                                    child: TextFormField(
                                                                                      controller: data["name"],
                                                                                      maxLines: null,
                                                                                      onChanged:(value){
                                                                                        onSearchTextChanged(value);

                                                                                        setModalState((){});
                                                                                      },
                                                                                      decoration: InputDecoration(
                                                                                        hintText: "Enter Item Name",
                                                                                        fillColor:  Colors.white,
                                                                                        hintStyle:Constants.hintStyle,
                                                                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                                                        enabledBorder: OutlineInputBorder(borderSide:  BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                                                        border: const OutlineInputBorder(),
                                                                                        // hintText: 'Enter Query',hintStyle: hintstyle,
                                                                                      ),
                                                                                      style: BlackSubTitleStyle,),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  height: data["desc"].text.length < 15 ?35:null,
                                                                                  decoration: BoxDecoration(color: Colors.white,
                                                                                      borderRadius: BorderRadius.circular(5)),
                                                                                  width: isMobile?width*0.4:tabWidth*0.4,
                                                                                  margin: EdgeInsets.only(left: 0,right:5,top: 10),
                                                                                  child: ConstrainedBox(
                                                                                    constraints: BoxConstraints(
                                                                                        maxHeight: 150.0
                                                                                    ),
                                                                                    child: TextFormField(
                                                                                      controller: data["desc"],
                                                                                      maxLines: null,
                                                                                      onChanged: (v){
                                                                                        setModalState((){});
                                                                                      },
                                                                                      decoration: InputDecoration(
                                                                                        hintText: "Enter Description",
                                                                                        fillColor:  Colors.white,
                                                                                        hintStyle:Constants.hintStyle,
                                                                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                                                        enabledBorder: OutlineInputBorder(borderSide:  BorderSide(width: 1.0, color: Constants.greyFieldColor) , borderRadius: BorderRadius.circular(5)),
                                                                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                                                        border: const OutlineInputBorder(),
                                                                                        // hintText: 'Enter Query',hintStyle: hintstyle,
                                                                                      ),
                                                                                      style:Black87HintStyle,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const Spacer(),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children:[
                                                                                SizedBox(height: 10,),
                                                                                InkWell(
                                                                                    onTap:(){
                                                                                      setState(() {
                                                                                        data["required"] = !data["required"];
                                                                                        Constants.showToast( data["required"]  == true ?"REQUIRED Enabled":"REQUIRED Disabled");
                                                                                      });setModalState((){});
                                                                                    },
                                                                                    child: Text("REQUIRED", style: TextStyle(color:data["required"] ==true?primaryColor: Colors.black38, fontWeight:data["required"] ==true ?FontWeight.w700:FontWeight.w500, fontSize: 14),)),

                                                                                SizedBox(height: 20,),
                                                                                InkWell(
                                                                                    onTap:(){
                                                                                      setState(() {
                                                                                        data["addon"] = !data["addon"];
                                                                                        Constants.showToast( data["addon"]  == true ?"ADDON Enabled":"ADDON Disabled");
                                                                                      });setModalState((){});
                                                                                    },
                                                                                    child: Text("ADD ON", style: TextStyle(color: data["addon"] == true?primaryColor: Colors.black38, fontWeight:data["addon"] ==true ?FontWeight.w700: FontWeight.w500, fontSize: 14), )),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(width: 10,),
                                                                            data["showMediaData"] == false ?
                                                                            DottedBorder(
                                                                              dashPattern: const [6, 2],
                                                                              strokeWidth: 1.5,
                                                                              color: Constants.primaryColor1,
                                                                              borderType: BorderType.RRect,
                                                                              radius: const Radius.circular(2),
                                                                              padding: EdgeInsets.symmetric(horizontal: 7),
                                                                              child: Column(
                                                                                children: [
                                                                                  10.height,
                                                                                  Text("Add back \nImage",style: BlackDescStyle,textAlign: TextAlign.center,),
                                                                                  5.height,
                                                                                  InkWell(
                                                                                    onTap:(){
                                                                                      setState(() {
                                                                                        data["showMediaData"] = true;
                                                                                        ItemsList[index]["item_condition"]["itemDisableFields"].remove("UploadMeta");
                                                                                        data["media"] = [];
                                                                                        data["fileUrl"] = [];
                                                                                      });setModalState((){});
                                                                                    },
                                                                                    child: CircleAvatar(
                                                                                      radius:8,
                                                                                      backgroundColor: primaryColor ,
                                                                                      child: Center(
                                                                                          child:Icon(Icons.add,color: Colors.white,size:14,)
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  10.height,
                                                                                ],
                                                                              ),
                                                                            ):
                                                                            Column(

                                                                              children: [
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
                                                                                                      },);setModalState((){});
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
                                                                                                            });setModalState((){});
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
                                                                                                          },);setModalState((){});
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
                                                                                                                });setModalState((){});
                                                                                                              }
                                                                                                            }
                                                                                                          });
                                                                                                        });
                                                                                                      }else{
                                                                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nothing is selected')));
                                                                                                      }
                                                                                                    });
                                                                                                  }
                                                                                              ):
                                                                                              ImageGalleryViewWithModal(context,setModalState, data["media"], data["fileUrl"],setState);
                                                                                              //Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryScreenNewOffer(MediaList: data["media"],UrlList: data["fileUrl"],)));
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
                                                                                                        : SizedBox(),
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
                                                                                              ImageGalleryViewWithModal(context,setModalState, data["media"], data["fileUrl"],setState);

                                                                                              //  Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryScreenNewOffer(MediaList: data["media"],UrlList: data["fileUrl"])));
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
                                                                                                    child:Text("+${data["media"].length -1}",style: BlackTitle500height,)
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
                                                                                              Constants.showToast("Max 4 files are allowed");
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
                                                                                                      },);setModalState((){});
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
                                                                                                            });setModalState((){});
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
                                                                                                          },);setModalState((){});
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
                                                                                                                });setModalState((){});
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
                                                                                //     "UPLOAD MEDIA",
                                                                                //     style: BlackHintStyle,
                                                                                //       textAlign: TextAlign.center,
                                                                                //   ),
                                                                                // ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    InkWell(
                                                                                      onTap:() async{

                                                                                        setState(() {
                                                                                          data["showMediaData"] = false;
                                                                                          ItemsList[index]["item_condition"]["itemDisableFields"].add("UploadMeta");
                                                                                        });setModalState((){});

                                                                                        final byteData = await rootBundle.load('assets/image_placeholder.jpg');
                                                                                        final file = File('${(await getTemporaryDirectory()).path}/image_placeholder.jpg');
                                                                                        await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

                                                                                        ThatZalApis.UploadFile(file: file.path).then((value)  {
                                                                                          if(value != null){
                                                                                            if(value["status"] == true){
                                                                                              setState(() {
                                                                                                data["isLoadingFile"] = false;
                                                                                                data["media"] = [{
                                                                                                  "file": "${value["result"]["id"]}",
                                                                                                  "name" : "${value["result"]["name"]}"
                                                                                                }];
                                                                                              });setModalState((){});
                                                                                            }
                                                                                          }
                                                                                        });

                                                                                      },
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.only(top:3.0,left:5),
                                                                                        child: CircleAvatar(
                                                                                          radius:8,
                                                                                          backgroundColor: Color(0x3389F6B9) ,
                                                                                          child: Center(
                                                                                              child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )

                                                                              ],
                                                                            ),
                                                                            const SizedBox(width: 15,),
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: 5,),
                                                                        data["showItemPriceMain"] ==false? Row(
                                                                          children: [
                                                                            15.width,
                                                                            Text("Add back price",style: BlackDescStyle,),
                                                                            5.width,
                                                                            InkWell(
                                                                              onTap:(){
                                                                                setState(() {
                                                                                  data["showItemPriceMain"] = true;
                                                                                  ItemsList[index]["item_condition"]["itemDisableFields"].remove("PriceUnit");
                                                                                });setModalState((){});
                                                                              },
                                                                              child: CircleAvatar(
                                                                                radius:8,
                                                                                backgroundColor: primaryColor ,
                                                                                child: Center(
                                                                                    child:Icon(Icons.add,color: Colors.white,size:14,)
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ):
                                                                        Stack(
                                                                          children: [
                                                                            InkWell(
                                                                              onTap:(){
                                                                                print("ClearUNitLisPAi");
                                                                                setState((){
                                                                                  data["filterGetUnitList"].clear();
                                                                                });setModalState((){});
                                                                              },
                                                                              child: Container(

                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    const SizedBox(width: 5,),
                                                                                    Container(
                                                                                      height: 35,
                                                                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                                                      width:isMobile?width*0.39:tabWidth*0.39,
                                                                                      margin: EdgeInsets.only(left: 5,top: 10),
                                                                                      child: TextFormField(
                                                                                        controller: data["price"],
                                                                                        keyboardType: TextInputType.number,
                                                                                        decoration: InputDecoration(hintText: "Enter Price", fillColor:  Colors.white,hintStyle: Constants.hintStyle,
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
                                                                                          decoration: BoxDecoration(color: Colors.white,
                                                                                              borderRadius: BorderRadius.circular(5)),
                                                                                          width: isMobile?width*0.39:tabWidth*0.39,
                                                                                          margin: EdgeInsets.only(left: 1,right:0,top: 10),
                                                                                          child: TextFormField(
                                                                                            controller: data["unit"],
                                                                                            keyboardType: TextInputType.text,
                                                                                            decoration: InputDecoration(hintText: "Enter Unit", fillColor:  Colors.white,hintStyle: Constants.hintStyle,
                                                                                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                                                              enabledBorder: OutlineInputBorder(borderSide:  BorderSide(width: 1.0, color: Constants.greyFieldColor), borderRadius: BorderRadius.circular(5)),
                                                                                              floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                                              contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                                                              border: const OutlineInputBorder(),

                                                                                              // hintText: 'Enter Query',hintStyle: hintstyle,
                                                                                            ),
                                                                                            onChanged: (String value) async {
                                                                                              setState(() {
                                                                                                if(value.isEmpty || value == ""){
                                                                                                  data["SelectedUnitId"]="";
                                                                                                }
                                                                                                data["filterGetUnitList"] = getUnitList.where((name) => name.name!.toLowerCase().contains(value.toLowerCase())).toList();
                                                                                                data["filterGetUnitList"].isEmpty ?  data["showOtherUnit"]=true:data["showOtherUnit"]=false;
                                                                                              });setModalState((){});
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
                                                                                                          setModalState((){});

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
                                                                                          });setModalState((){});
                                                                                          var dataParam ={"name": data["unit"].text.toString()};
                                                                                          DrawAuraAPi().createUnitApi(
                                                                                              data: dataParam).then((value) {
                                                                                            if (value["status"] == 200) {
                                                                                              setState((){
                                                                                                data["SelectedUnitId"] = value["result"]["id"].toString();
                                                                                              });setModalState((){});
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
                                                                                              });setModalState((){});
                                                                                              DrawAuraAPi.getUnitList().then((value) {
                                                                                                setState((){
                                                                                                  getUnitList.clear();
                                                                                                  getUnitList = value.result!;
                                                                                                });setModalState((){});
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
                                                                                                data["isLoadNewUnit"] = false;
                                                                                                data["showOtherUnit"] =false;
                                                                                              });setModalState((){});
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
                                                                              ),
                                                                            ),
                                                                            Positioned(
                                                                              top: 2,
                                                                              left: isMobile?width*0.82:tabWidth*0.80,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(top:3.0,left:0),
                                                                                child: InkWell(
                                                                                  onTap:(){
                                                                                    setState(() {

                                                                                      data["showItemPriceMain"] = false;
                                                                                      data["price"].text = "";
                                                                                      data["unit"].text = "";
                                                                                      ItemsList[index]["item_condition"]["itemDisableFields"].add("PriceUnit");
                                                                                    });setModalState((){});
                                                                                  },
                                                                                  child: CircleAvatar(
                                                                                    radius:8,
                                                                                    backgroundColor: Color(
                                                                                        0x3389F6B9) ,
                                                                                    child: Center(
                                                                                        child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Positioned(
                                                                              top: 2,
                                                                              left: isMobile?width*0.40:tabWidth*0.39,
                                                                              child: InkWell(
                                                                                onTap:(){
                                                                                  setState(() {
                                                                                    //isMaintancePriceShow == false ?isMaintancePriceShow=true:isAdvancePriceShow =true;
                                                                                    data["showItemPrice2"] == false ? data["showItemPrice2"] =true : data["showItemPrice3"] = true;
                                                                                  });setModalState((){});
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
                                                                                  decoration: BoxDecoration(color: Colors.white,  borderRadius: BorderRadius.circular(5)),
                                                                                  width:isMobile?width*0.39:tabWidth*0.39,
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
                                                                                          });setModalState((){});
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
                                                                                                      });setModalState((){});
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
                                                                                      });setModalState((){});
                                                                                      var dataParam ={"name": data["MaintenanceUnit"].text.toString()};
                                                                                      DrawAuraAPi().createUnitApi(
                                                                                          data: dataParam).then((value) {
                                                                                        if (value["status"] == 200) {
                                                                                          setState((){
                                                                                            data["SelectedUnitIdMain"] = value["result"]["id"].toString();
                                                                                          });setModalState((){});
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
                                                                                          });setModalState((){});
                                                                                          DrawAuraAPi.getUnitList().then((value) {
                                                                                            setState((){
                                                                                              getUnitList.clear();
                                                                                              getUnitList = value.result!;
                                                                                            });setModalState((){});
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
                                                                                          });setModalState((){});
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
                                                                                    isMaintancePriceShow = false;
                                                                                    data["showItemPrice2"] = false;
                                                                                  });setModalState((){});
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
                                                                                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
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
                                                                                          });setModalState((){});
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
                                                                                                      });setModalState((){});
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
                                                                                      });setModalState((){});
                                                                                      var dataParam ={"name": data["AdvanceUnit"].text.toString()};
                                                                                      DrawAuraAPi().createUnitApi(
                                                                                          data: dataParam).then((value) {
                                                                                        if (value["status"] == 200) {
                                                                                          setState((){
                                                                                            data["SelectedUnitIdAdva"] = value["result"]["id"].toString();
                                                                                          });setModalState((){});
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
                                                                                          });setModalState((){});
                                                                                          DrawAuraAPi.getUnitList().then((value) {
                                                                                            setState((){
                                                                                              getUnitList.clear();
                                                                                              getUnitList = value.result!;
                                                                                            });setModalState((){});
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
                                                                                            data["isLoadNewUnitAdva"] = false;
                                                                                            data["showOtherUnitAdva"] =false;
                                                                                          });setModalState((){});
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
                                                                                    data["showItemPrice3"] = false;
                                                                                  });setModalState((){});
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
                                                                        10.height,
                                                                        data["showItemQty"] ==false?
                                                                        Row(
                                                                          children: [
                                                                            20.width,
                                                                            Text("Add back Qty",style: BlackDescStyle,),
                                                                            5.width,
                                                                            InkWell(
                                                                              onTap:(){
                                                                                setState(() {
                                                                                  data["showItemQty"] = true;
                                                                                  ItemsList[index]["item_condition"]["itemDisableFields"].add("Qty");
                                                                                });setModalState((){});
                                                                              },
                                                                              child: CircleAvatar(
                                                                                radius:8,
                                                                                backgroundColor: primaryColor ,
                                                                                child: Center(
                                                                                    child:Icon(Icons.add,color: Colors.white,size:14,)
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                            : Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            15.width,
                                                                            InkWell(
                                                                              onTap:  (){
                                                                                setState((){
                                                                                  data["quantity"]==1? Constants.showToast("Minimum QTY is 1"):  data["quantity"] --;
                                                                                });setModalState((){});
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
                                                                                });setModalState((){});
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
                                                                            InkWell(
                                                                              onTap:(){
                                                                                setState(() {
                                                                                  data["showItemQty"] =false;
                                                                                  data["quantity"] = "0";
                                                                                  ItemsList[index]["item_condition"]["itemDisableFields"].add("Qty");
                                                                                });setModalState((){});
                                                                              },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(top:3.0,left:5),
                                                                                child: CircleAvatar(
                                                                                  radius:8,
                                                                                  backgroundColor: Color(
                                                                                      0x3389F6B9) ,
                                                                                  child: Center(
                                                                                      child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(height: 15,),
                                                                        Padding(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                          child: Row(
                                                                            children:  [
                                                                              const Text(" Add Offer’s conditions for this item", style: BlackSubTitleItalicStyle,),
                                                                              const SizedBox(width: 5,),
                                                                              InkWell(
                                                                                onTap:(){
                                                                                  setState(() {
                                                                                    data["showItemCondition"] = !  data["showItemCondition"];
                                                                                  });setModalState((){});
                                                                                },
                                                                                child:  CircleAvatar(
                                                                                  radius: 10,
                                                                                  backgroundColor: primaryColor,
                                                                                  child: Center(
                                                                                    child: data["showItemCondition"] == false? Icon(Icons.add, color: Colors.white, size: 20): Icon(Icons.remove, color: Colors.white, size: 20),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                
                                                                        data["showItemCondition"]==true? Padding(
                                                                          padding: EdgeInsets.only(right:10,left:10),
                                                                          child: Column(


                                                                            children: [

                                                                              data["showItemPeriodicity"]==true?  Padding(
                                                                                padding: EdgeInsets.only(top:3),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [

                                                                                    const Padding(
                                                                                      padding: EdgeInsets.only(left:0.0,bottom: 5),
                                                                                      child: Text("Periodicity", style: BlackDescStyle500,),
                                                                                    ),

                                                                                    Row(
                                                                                      children: [
                                                                                        InkWell(
                                                                                          onTap:(){
                                                                                            setState((){
                                                                                              data["item_condition"]["periodicity"]=="";
                                                                                              data["showItemPeriodicity"] = false;
                                                                                              ItemsList[index]["item_condition"]["itemDisableFields"].add("Periodicity");
                                                                                            });setModalState((){});
                                                                                          },
                                                                                          child: CircleAvatar(
                                                                                            radius:8,
                                                                                            backgroundColor: Color(
                                                                                                0x3389F6B9) ,
                                                                                            child: Center(
                                                                                                child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        10.width,
                                                                                        Flexible(
                                                                                          child: DropdownButtonHideUnderline(
                                                                                            child: DropdownButton2(
                                                                                              isExpanded: true,
                                                                                              items:
                                                                                              selectedPeriodicityValue == "Daily" ?
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
                                                                                              selectedPeriodicityValue == "Today"?
                                                                                              periodicityTodayList.map((item) => DropdownMenuItem (
                                                                                                value: item,
                                                                                                child: Text(
                                                                                                  item,
                                                                                                  style:  BlackSubHeadingStyle,
                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                ),
                                                                                              )).toList():
                                                                                              selectedPeriodicityValue == "Tomorrow"?
                                                                                              periodicityTomorrowList.map((item) => DropdownMenuItem (
                                                                                                value: item,
                                                                                                child: Text(
                                                                                                  item,
                                                                                                  style:  BlackSubHeadingStyle,
                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                ),
                                                                                              )).toList():
                                                                                              selectedPeriodicityValue == "Weekly"?
                                                                                              periodicityWeeklyList.map((item) => DropdownMenuItem (
                                                                                                value: item,
                                                                                                child: Text(
                                                                                                  item,
                                                                                                  style:  BlackSubHeadingStyle,
                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                ),
                                                                                              )).toList():
                                                                                              selectedPeriodicityValue == "Yearly"?
                                                                                              periodicityYearlyList.map((item) => DropdownMenuItem (
                                                                                                value: item,
                                                                                                child: Text(
                                                                                                  item,
                                                                                                  style:  BlackSubHeadingStyle,
                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                ),
                                                                                              )).toList():
                                                                                              selectedPeriodicityValue == "Monthly"?
                                                                                              periodicityMonthlyList.map((item) => DropdownMenuItem (
                                                                                                value: item,
                                                                                                child: Text(
                                                                                                  item,
                                                                                                  style:  BlackSubHeadingStyle,
                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                ),
                                                                                              )).toList():
                                                                                              selectedPeriodicityValue == "Once"?
                                                                                              periodicityOnceList.map((item) => DropdownMenuItem (
                                                                                                value: item,
                                                                                                child: Text(
                                                                                                  item,
                                                                                                  style:  BlackSubHeadingStyle,
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
                                                                                              // selectedPeriodicityValue == "Today" ||
                                                                                              //     selectedPeriodicityValue == "Tomorrow" ||
                                                                                              //     selectedPeriodicityValue == "Once" ||
                                                                                              //     selectedPeriodicityValue == "Monthly" ||
                                                                                              //     selectedPeriodicityValue == "Yearly" ||
                                                                                              //     selectedPeriodicityValue == "Weekly" ?
                                                                                              // null:
                                                                                                  (newValue) {
                                                                                                setState(() {
                                                                                                  data["item_condition"]["periodicity"] = newValue!;
                                                                                                });setModalState((){});
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
                                                                                                  height:35,
                                                                                                  width: isMobile?width:tabWidth,
                                                                                                  padding: const EdgeInsets.only(left: 22, right: 3),
                                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white),
                                                                                                  elevation:  0,
                                                                                                  overlayColor: MaterialStateProperty.all(Colors.white)
                                                                                              ),
                                                                                              menuItemStyleData: MenuItemStyleData(
                                                                                                height: 33,
                                                                                                selectedMenuItemBuilder: (context, child) {
                                                                                                  return     Container(
                                                                                                    padding: const EdgeInsets.only(left: 0, right: 0),
                                                                                                    // width: isMobile?width*0.9:tabWidth*0.9,
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
                                                                                                // width: isMobile?width*0.9:tabWidth*0.9,
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

                                                                                              style: Black87HintStyle,

                                                                                            ),
                                                                                          ),
                                                                                        ),

                                                                                      ],
                                                                                    ),

                                                                                  ],
                                                                                ),
                                                                              ): TextForNewAdd(context,text: "Periodicity",onTap: (){
                                                                                setState(() {
                                                                                  data["showItemPeriodicity"] = true;
                                                                                  ItemsList[index]["item_condition"]["itemDisableFields"].remove("Periodicity");
                                                                                });setModalState((){});
                                                                              }),

                                                                              data["item_condition"]["periodicity"] == "Today" ||
                                                                                  data["item_condition"]["periodicity"] == "Tomorrow" ||
                                                                                  data["item_condition"]["periodicity"] == "Sunday" ||
                                                                                  data["item_condition"]["periodicity"] == "Monday" ||
                                                                                  data["item_condition"]["periodicity"] == "Tuesday" ||
                                                                                  data["item_condition"]["periodicity"] == "Wednesday" ||
                                                                                  data["item_condition"]["periodicity"] == "Thursday" ||
                                                                                  data["item_condition"]["periodicity"] == "Friday" ||
                                                                                  data["item_condition"]["periodicity"] == "Saturday"? SizedBox():
                                                                              data["showItemPeriod"] == true?    Padding(
                                                                                padding: EdgeInsets.only(top:2),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top:5.0,bottom:3),
                                                                                      child: Text("Period Date", style: BlackDescStyle500,),
                                                                                    ),

                                                                                    Row(
                                                                                      children: [
                                                                                        InkWell(
                                                                                          onTap:(){
                                                                                            setState((){
                                                                                              data["item_condition"]["period"].clear();
                                                                                              data["item_condition"]["fromperiod"]="";
                                                                                              data["item_condition"]["toperiod"]="";
                                                                                              data["showItemPeriod"] = false;
                                                                                              ItemsList[index]["item_condition"]["itemDisableFields"].add("DatePeriod");
                                                                                            });setModalState((){});
                                                                                          },
                                                                                          child: CircleAvatar(
                                                                                            radius:8,
                                                                                            backgroundColor: Color(0x3389F6B9) ,
                                                                                            child: Center(
                                                                                                child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                                            ),
                                                                                          ),
                                                                                        ),10.width,
                                                                                        Flexible(
                                                                                          child: Container(
                                                                                            height: 35,
                                                                                            padding:EdgeInsets.only(left:12),
                                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                                                            width: isMobile?width:tabWidth,
                                                                                            child: TextFormField(
                                                                                              controller:  data["item_condition"]["period"],
                                                                                              readOnly: true,
                                                                                              onTap:(){
                                                                                                print("Call");
                                                                                                ItemDatePicker(
                                                                                                    startText: "From",
                                                                                                    endText: "To",
                                                                                                    doneText: "Done",
                                                                                                    cancelText: "Cancel",
                                                                                                    interval: 1,
                                                                                                    mode: ItemDatePickerMode.date,
                                                                                                    minimumTime: DateTime.now(),
                                                                                                    maximumFromTime: OfferFromDate,
                                                                                                    maximumToTime: OfferToDate,
                                                                                                    initialStartTime:data["item_condition"]["period"].text.isEmpty? DateTime.now().add(Duration(hours: 1)):data["item_condition"]["FromPeriodDateFill"],
                                                                                                    initialEndTime:data["item_condition"]["period"].text.isEmpty? DateTime.now().add(Duration(hours: 1)):data["item_condition"]["ToPeriodDateFill"] ,
                                                                                                    use24hFormat: false,
                                                                                                    onConfirm:  (start, end) {
                                                                                                      if(end == "NotPick"){



                                                                                                        setState((){
                                                                                                          data["isItemSinglePeriodSelect"] =true;
                                                                                                          data["item_condition"]["periodTime"].clear();
                                                                                                          data["item_condition"]["duration"].clear();

                                                                                                          final  STime = DateFormat('dd-MMM-yyyy hh:mm a').format(start);
                                                                                                          data["item_condition"]["period"].text = "${STime}";
                                                                                                          data["item_condition"]["fromperiod"]="";
                                                                                                          data["item_condition"]["toperiod"]="";

                                                                                                          final  SDate = DateFormat('dd-MM-yyyy').format(start);
                                                                                                          final  STime24 = DateFormat('HH:mm').format(start);
                                                                                                          data["item_condition"]["fromperiod"] = SDate.toString();
                                                                                                          data["item_condition"]["FromPeriodDateFill"]= start;

                                                                                                        });setModalState((){});
                                                                                                      }else{
                                                                                                        setState((){
                                                                                                          data["isItemSinglePeriodSelect"] =false;
                                                                                                          data["item_condition"]["periodTime"].clear();
                                                                                                          data["item_condition"]["duration"].clear();
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
                                                                                                          data["item_condition"]["duration"].text ="${years != 0 ? '${years} Year(s)': empty} ${ months != 0 ? '${months} Month(s)': empty } ${days != 0 ?'${days} Day(s)': empty } ${ hours != 0 ?'${hours} Hour(s)': empty } ${ min != 0 ?'${min} Minute(s)': empty}";
                                                                                                          final  FTime = DateFormat('dd-MMM-yyyy').format(start);
                                                                                                          final  ToTime = DateFormat('dd-MMM-yyyy').format(DateTime.parse(end));
                                                                                                          data["item_condition"]["period"].text = "${FTime}-${ToTime}";
                                                                                                          final  SDate = DateFormat('dd-MM-yyyy').format(start);
                                                                                                          data["item_condition"]["fromperiod"] = SDate.toString();
                                                                                                          final  EDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(end));
                                                                                                          data["item_condition"]["toperiod"] = EDate.toString();
                                                                                                          data["item_condition"]["FromPeriodDateFill"]= start;
                                                                                                          data["item_condition"]["ToPeriodDateFill"]= DateTime.parse(end);

                                                                                                        });setModalState((){});
                                                                                                      }
                                                                                                    }).showPicker(context);

                                                                                                // FromToDatePicker(context,FirstDate: DateTime.now(),LastDate: DateTime.now().add(Duration(days: 365)));
                                                                                              },
                                                                                              keyboardType: TextInputType.text,
                                                                                              decoration: InputDecoration(hintText: "Period Date", fillColor:  Colors.white, hintStyle: greyHintStyle,
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

                                                                                      ],
                                                                                    ),

                                                                                  ],
                                                                                ),
                                                                              ):
                                                                              TextForNewAdd(context,text: "Period Date",onTap: (){
                                                                                setState(() {
                                                                                  data["showItemPeriod"] = true;
                                                                                  ItemsList[index]["item_condition"]["itemDisableFields"].remove("DatePeriod");
                                                                                });setModalState((){});
                                                                              }),




                                                                              data["showItemPeriodTime"] == true?    Padding(
                                                                                padding: EdgeInsets.only(top:2),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top:5.0,bottom:3),
                                                                                      child: Text("Period Time", style: BlackDescStyle500,),
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        InkWell(
                                                                                          onTap:(){
                                                                                            setState((){
                                                                                              data["item_condition"]["periodTime"].clear();
                                                                                              data["item_condition"]["fromperiodtime"]="";
                                                                                              data["item_condition"]["toperiodtime"]="";
                                                                                              data["showItemPeriodTime"]  = false;
                                                                                              ItemsList[index]["item_condition"]["itemDisableFields"].add("TimePeriod");
                                                                                            });setModalState((){});
                                                                                          },
                                                                                          child: CircleAvatar(
                                                                                            radius:8,
                                                                                            backgroundColor: Color(0x3389F6B9) ,
                                                                                            child: Center(
                                                                                                child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        10.width,
                                                                                        Flexible(
                                                                                          child: Container(
                                                                                            height: 35,
                                                                                            padding:EdgeInsets.only(left:12),
                                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                                                            child: TextFormField(
                                                                                              controller:  data["item_condition"]["periodTime"],
                                                                                              readOnly: true,

                                                                                              onTap:(){
                                                                                                print("Call");
                                                                                                ItemTimePicker(
                                                                                                    startText: "From",
                                                                                                    endText: "To",
                                                                                                    doneText: "Done",
                                                                                                    cancelText: "Cancel",
                                                                                                    interval: 1,

                                                                                                    mode: ItemTimePickerMode.time,
                                                                                                    type:data["item_condition"]["periodicity"] == "Today" ?"Today":"Else",
                                                                                                    initialStartTime:  data["item_condition"]["periodTime"].text.isEmpty?
                                                                                                    data["item_condition"]["periodicity"] == "Today" ?
                                                                                                    DateTime.now().add(Duration(hours: 1)):
                                                                                                    DateFormat("yyyy-MM-dd HH:mm:ss").parse("${DateFormat("yyyy-MM-dd").parse(DateTime.now().toString())} 00:01:00"):
                                                                                                    data["item_condition"]["FromPeriodTimeFill"],
                                                                                                    initialEndTime:  data["item_condition"]["periodTime"].text.isEmpty?
                                                                                                    data["item_condition"]["periodicity"] == "Today" ?
                                                                                                    DateTime.now().add(Duration(hours: 1)):
                                                                                                    DateFormat("yyyy-MM-dd HH:mm:ss").parse("${DateFormat("yyyy-MM-dd").parse(DateTime.now().toString())} 00:01:00"): data["item_condition"]["ToPeriodTimeFill"],

                                                                                                    use24hFormat: false,
                                                                                                    onConfirm: (start, end) {
                                                                                                      print(start);
                                                                                                      print(end);
                                                                                                      if(end == "NotPick"){

                                                                                                        setState((){
                                                                                                          data["item_condition"]["periodicity"] == "Today" ||
                                                                                                              data["item_condition"]["periodicity"] == "Tomorrow" ||
                                                                                                              data["item_condition"]["periodicity"] == "Sunday" ||
                                                                                                              data["item_condition"]["periodicity"] == "Monday" ||
                                                                                                              data["item_condition"]["periodicity"] == "Tuesday" ||
                                                                                                              data["item_condition"]["periodicity"] == "Wednesday" ||
                                                                                                              data["item_condition"]["periodicity"] == "Thursday" ||
                                                                                                              data["item_condition"]["periodicity"] == "Friday" ||
                                                                                                              data["item_condition"]["periodicity"] == "Saturday"?
                                                                                                          data["isItemSinglePeriodSelect"] = true :null;
                                                                                                          final  STime = DateFormat('hh:mm a').format(start);
                                                                                                          data["item_condition"]["periodTime"].text = "${STime}";
                                                                                                          data["item_condition"]["fromperiodtime"]="";
                                                                                                          data["item_condition"]["toperiodtime"]="";
                                                                                                          final  STime24 = DateFormat('HH:mm').format(start);
                                                                                                          data["item_condition"]["fromperiodtime"] = STime24.toString();
                                                                                                          data["item_condition"]["FromPeriodTimeFill"]= start;

                                                                                                        });setModalState((){});
                                                                                                      }else{
                                                                                                        setState((){
                                                                                                          data["item_condition"]["periodicity"] == "Today" ||
                                                                                                              data["item_condition"]["periodicity"] == "Tomorrow" ||
                                                                                                              data["item_condition"]["periodicity"] == "Sunday" ||
                                                                                                              data["item_condition"]["periodicity"] == "Monday" ||
                                                                                                              data["item_condition"]["periodicity"] == "Tuesday" ||
                                                                                                              data["item_condition"]["periodicity"] == "Wednesday" ||
                                                                                                              data["item_condition"]["periodicity"] == "Thursday" ||
                                                                                                              data["item_condition"]["periodicity"] == "Friday" ||
                                                                                                              data["item_condition"]["periodicity"] == "Saturday"?
                                                                                                          data["isItemSinglePeriodSelect"] = false :null;

                                                                                                          Duration diff = DateTime.parse(end).difference(start);
                                                                                                          String TempDuration = "";
                                                                                                          diff.inHours !=0?TempDuration = "${diff.inHours.toString()} Hours": diff.inSeconds !=00?  TempDuration = "${diff.inMinutes.toString()} Minutes" :   TempDuration = "${diff.inSeconds.toString()} Seconds";
                                                                                                          data["item_condition"]["duration"].text.isEmpty ?  data["item_condition"]["duration"].text = TempDuration :  data["item_condition"]["duration"].text = "${ data["item_condition"]["duration"].text}${TempDuration}";

                                                                                                          final  FTime = DateFormat('hh:mm a').format(start);
                                                                                                          final  ToTime = DateFormat('hh:mm a').format(DateTime.parse(end));
                                                                                                          data["item_condition"]["periodTime"].text = "${FTime} - ${ToTime}";
                                                                                                          data["item_condition"]["fromperiodtime"]="";
                                                                                                          data["item_condition"]["toperiodtime"]="";
                                                                                                          final  FTime24 = DateFormat('HH:mm').format(start);
                                                                                                          final  ToTime24 = DateFormat('HH:mm').format(DateTime.parse(end));
                                                                                                          data["item_condition"]["fromperiodtime"] = FTime24.toString();
                                                                                                          data["item_condition"]["toperiodtime"] = ToTime24.toString();
                                                                                                          data["item_condition"]["FromPeriodTimeFill"]= start;
                                                                                                          data["item_condition"]["ToPeriodTimeFIll"]= DateTime.parse(end);

                                                                                                        });setModalState((){});
                                                                                                      }
                                                                                                    }).showPicker(context);

                                                                                                // FromToDatePicker(context,FirstDate: DateTime.now(),LastDate: DateTime.now().add(Duration(days: 365)));
                                                                                              },
                                                                                              keyboardType: TextInputType.text,
                                                                                              decoration: InputDecoration(hintText: "Period Time", fillColor:  Colors.white, hintStyle: greyHintStyle,
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
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ): TextForNewAdd(context,text: "Period Time",onTap: (){
                                                                                setState(() {
                                                                                  data["showItemPeriodTime"]  = true;
                                                                                  ItemsList[index]["item_condition"]["itemDisableFields"].remove("TimePeriod");
                                                                                });setModalState((){});
                                                                              }),




                                                                              data["showItemDuration"]==true?   Padding(
                                                                                padding: EdgeInsets.only(top:2),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top:5.0,bottom:3),
                                                                                      child: Text("Duration(YY:MM:DD:HH:MI)", style: BlackDescStyle500,),
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        InkWell(
                                                                                          onTap:(){
                                                                                            setState((){
                                                                                              data["item_condition"]["duration"].clear();
                                                                                              data["showItemDuration"] = false;
                                                                                              ItemsList[index]["item_condition"]["itemDisableFields"].add("Duration");
                                                                                            });setModalState((){});
                                                                                          },
                                                                                          child: CircleAvatar(
                                                                                            radius:8,
                                                                                            backgroundColor: Color(
                                                                                                0x3389F6B9) ,
                                                                                            child: Center(
                                                                                                child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        10.width,
                                                                                        Flexible(
                                                                                          child: Container(
                                                                                            height: 35,
                                                                                            padding:EdgeInsets.only(left:12),
                                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),

                                                                                            child: TextFormField(
                                                                                              inputFormatters: [maskFormatter],
                                                                                              controller:  data["item_condition"]["duration"],
                                                                                              keyboardType: TextInputType.number,
                                                                                              onTap:(){
                                                                                                if(isItemSinglePeriodSelect==true){
                                                                                                  showDurationPickerNew(context,setState,setModalState,data["item_condition"]["duration"]);
                                                                                                }else{

                                                                                                }
                                                                                              },
                                                                                              //readOnly: isSinglePeriodSelect==true?false:true,
                                                                                              readOnly: true,
                                                                                              // onFieldSubmitted: (value){

                                                                                              //   String empty = "";
                                                                                              //   int years =  value!.length < 2 ?int.parse(value) :int.parse(value.split(":").first);
                                                                                              //   int months =  value.length > 3 ?int.parse(value.split(":")[1]):0;
                                                                                              //   int days =  value.length > 5 ?int.parse(value.split(":")[2]):0;
                                                                                              //   int hours =  value.length > 7 ?int.parse(value.split(":")[3]):0;
                                                                                              //   int min =  value.length > 9 ?int.parse(value.split(":")[4]):0;
                                                                                              //   setState(() {
                                                                                              //     data["item_condition"]["duration"].text ="${years != 0 ? '${years} Years': empty} ${ months != 0 ? '${months} Months': empty } ${days != 0 ?'${days} Days': empty } ${ hours != 0 ?'${hours} Hours': empty } ${ min != 0 ?'${min} Minutes': empty}";
                                                                                              //   });
                                                                                              //   ( data["item_condition"]["duration"].text);
                                                                                              // },
                                                                                              // readOnly: isItemSinglePeriodSelect==true?false:true,
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
                                                                                        ),

                                                                                      ],
                                                                                    ),

                                                                                  ],
                                                                                ),
                                                                              ):
                                                                              TextForNewAdd(context,text: "Duration",onTap: (){
                                                                                setState(() {
                                                                                  data["showItemDuration"] = true;
                                                                                  ItemsList[index]["item_condition"]["itemDisableFields"].remove("Duration");
                                                                                });setModalState((){});
                                                                              }),

                                                                              selectedTap == "Deliver"?SizedBox():  Padding(
                                                                                padding: EdgeInsets.only(top:2),
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top:5.0,bottom:3),
                                                                                      child: Text("Service/Delivery person", style: BlackDescStyle500,),
                                                                                    ),
                                                                                    Container(
                                                                                      height:40,
                                                                                      decoration:BoxDecoration(
                                                                                        color:Colors.transparent,

                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(0.0),
                                                                                        child: CustomSearchableDropDownForUs(
                                                                                          initialValue: widget.From == "Fill" && data["type"] == "old" ? data["fillSelectedPerson"]: data["item_condition"]["servicepersons"],

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
                                                                                            return item.displayname;
                                                                                          }).toList() ??
                                                                                              [],
                                                                                          onChanged: (value){
                                                                                            if(value!=null)
                                                                                            {
                                                                                              setState(() {
                                                                                                data["item_condition"]["servicepersons"] =   jsonDecode(value).map((e) =>e["id"] ).toList();
                                                                                                data["fillSelectedPerson"] =  jsonDecode(value).map((e) =>e["id"] ).toList();
                                                                                              });setModalState((){});
                                                                                            }
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ),

                                                                                  ],
                                                                                ),
                                                                              ),

                                                                              data["showItemPriority"]==true?    Padding(
                                                                                padding: const EdgeInsets.only(top: 2.0),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsets.only(left:0.0,top:3,bottom:4),
                                                                                      child: Text("Priority", style: BlackDescStyle500,),
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        InkWell(
                                                                                          onTap:(){
                                                                                            setState((){
                                                                                              data["item_condition"]["priority"] = "";
                                                                                              data["showItemPriority"] = false;
                                                                                              ItemsList[index]["item_condition"]["itemDisableFields"].add("Priority");
                                                                                            });setModalState((){});
                                                                                          },
                                                                                          child: CircleAvatar(
                                                                                            radius:8,
                                                                                            backgroundColor: Color(0x3389F6B9) ,
                                                                                            child: Center(
                                                                                                child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        10.width,
                                                                                        Flexible(
                                                                                          child: DropdownButtonHideUnderline(
                                                                                            child: DropdownButton2(
                                                                                                isExpanded: true,
                                                                                                items:priority.map((item) => DropdownMenuItem (
                                                                                                  value: item,
                                                                                                  child: Text(
                                                                                                    item,
                                                                                                    style:BlackSubHeadingStyle,
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                  ),
                                                                                                )).toList(),
                                                                                                value:  data["item_condition"]["priority"] ==""?null: data["item_condition"]["priority"].toString().trim(),
                                                                                                onChanged: (newValue) {
                                                                                                  setState(() {
                                                                                                    data["item_condition"]["priority"] = newValue!;
                                                                                                  });setModalState((){});
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

                                                                                                    padding: const EdgeInsets.only(left: 20, right: 3),
                                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white),
                                                                                                    elevation:  0,
                                                                                                    overlayColor: MaterialStateProperty.all(Colors.white)
                                                                                                ),
                                                                                                menuItemStyleData: MenuItemStyleData(
                                                                                                  height: 33,
                                                                                                  selectedMenuItemBuilder: (context, child) {
                                                                                                    return     Container(
                                                                                                      padding: const EdgeInsets.only(left: 0, right: 0),

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
                                                                                                  offset: const Offset(0, -5),
                                                                                                ),

                                                                                                style: BlackFieldStyle
                                                                                            ),
                                                                                          ),
                                                                                        ),

                                                                                      ],
                                                                                    ),

                                                                                  ],
                                                                                ),
                                                                              ):
                                                                              TextForNewAdd(context,text: "Priority",onTap: (){
                                                                                setState(() {
                                                                                  data["showItemPriority"] = true;
                                                                                  ItemsList[index]["item_condition"]["itemDisableFields"].remove("Priority");
                                                                                });setModalState((){});
                                                                              }),

                                                                              data["showItemExpiry"] == true? Padding(
                                                                                padding: EdgeInsets.only(top:2),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top:5.0,bottom:3),
                                                                                      child: Text("Expiry", style: BlackDescStyle500,),
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        InkWell(
                                                                                          onTap:(){
                                                                                            setState((){
                                                                                              data["item_condition"]["expiry"].clear();
                                                                                              ItemExDTime = null;
                                                                                              data["showItemExpiry"]  = false;
                                                                                              ItemsList[index]["item_condition"]["itemDisableFields"].add("Expiry");
                                                                                            });
                                                                                            setModalState((){});
                                                                                          },
                                                                                          child: CircleAvatar(
                                                                                            radius:8,
                                                                                            backgroundColor: Color(0x3389F6B9) ,
                                                                                            child: Center(
                                                                                                child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        10.width,
                                                                                        Flexible(
                                                                                          child: Container(
                                                                                            height: 35,
                                                                                            padding: EdgeInsets.only(left:12),
                                                                                            decoration: BoxDecoration(color: Colors.white,  borderRadius: BorderRadius.circular(5)),
                                                                                            child: TextFormField(
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
                                                                                                                  height: isMobile?height*0.3:tabHeight*0.4,
                                                                                                                  width: isMobile?null:tabWidth,
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
                                                                                                                                initialDateTime: data["item_condition"]["expiry"].text.isEmpty ?DateTime.now():data["item_condition"]["ExpiryDateTime"],
                                                                                                                                onDateTimeChanged: (DateTime newDateTime) {
                                                                                                                                  setState((){
                                                                                                                                    data["item_condition"]["ExpiryDateTime"] = newDateTime;
                                                                                                                                    ItemExDTime = newDateTime;
                                                                                                                                  });setModalState((){});
                                                                                                                                },
                                                                                                                                maximumDate:OfferExpiryDateTime,
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
                                                                                                                              data["item_condition"]["expiry"].text = STime ;
                                                                                                                            });setModalState((){});
                                                                                                                            Navigator.pop(context);
                                                                                                                          },
                                                                                                                          child: const Padding(
                                                                                                                            padding: EdgeInsets.all(12.0),
                                                                                                                            child: Center(
                                                                                                                              child: Text('Save',
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
                                                                                        ),

                                                                                      ],
                                                                                    ),

                                                                                  ],
                                                                                ),
                                                                              ):   TextForNewAdd(context,text: "Expiry",onTap: (){
                                                                                setState(() {
                                                                                  data["showItemExpiry"]  = true;
                                                                                  ItemsList[index]["item_condition"]["itemDisableFields"].remove("Expiry");
                                                                                });setModalState((){});
                                                                              }),

                                                                              data["showItemFromLocation"]==true?  Padding(
                                                                                padding: EdgeInsets.only(top:2),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [                                                                                     Padding(
                                                                                      padding: const EdgeInsets.only(top:5.0,bottom:3),
                                                                                      child: Text("From location", style: BlackDescStyle500,),
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        InkWell(
                                                                                          onTap:(){
                                                                                            setState((){
                                                                                              data["item_condition"]["fromlocation"].clear();
                                                                                              data["showItemFromLocation"] = false;
                                                                                              ItemsList[index]["item_condition"]["itemDisableFields"].add("FromLocation");
                                                                                            });setModalState((){});
                                                                                          },
                                                                                          child: CircleAvatar(
                                                                                            radius:8,
                                                                                            backgroundColor: Color(
                                                                                                0x3389F6B9) ,
                                                                                            child: Center(
                                                                                                child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        10.width,
                                                                                        Flexible(
                                                                                          child: Container(
                                                                                            height: 35,
                                                                                            padding: EdgeInsets.only(left:12),
                                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),

                                                                                            child: TextFormField(
                                                                                              controller:  data["item_condition"]["fromlocation"],
                                                                                              onTap:() async {
                                                                                                if(LatitudeLongitude == null ){
                                                                                                  Constants.showToast("Please wait");
                                                                                                }else{
                                                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong: LatitudeLongitude!,isAppPlaceView: true ,isTitleSelectAsAddress: true))).then((value) {
                                                                                                    setState((){
                                                                                                      data["item_condition"]["fromlocation"].text= value == null ? "": value.toString();
                                                                                                    });setModalState((){});
                                                                                                  });
                                                                                                }

                                                                                                // String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => NormalPlacePickerScreen("AIzaSyDE9xGmWMOftPvz1hHwPlTecShhHtR4goE")));
                                                                                                // setState((){
                                                                                                //   data["item_condition"]["fromlocation"].text= result == null ? "": result.toString();
                                                                                                // });

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
                                                                                        ),

                                                                                        // data["showItemTOLocation"]==true?SizedBox():    Positioned(
                                                                                        //     top:1,right:2,
                                                                                        //     child: InkWell(
                                                                                        //       onTap:(){
                                                                                        //         setState((){
                                                                                        //           data["showItemTOLocation"]==true?null:data["showItemTOLocation"] =true ;
                                                                                        //         });
                                                                                        //       },
                                                                                        //       child: CircleAvatar(
                                                                                        //         radius:8,
                                                                                        //         backgroundColor: Constants.primaryColor1 ,
                                                                                        //         child: Center(
                                                                                        //             child:Icon(Icons.add,color: Colors.white,size:14,)
                                                                                        //         ),
                                                                                        //       ),
                                                                                        //     ))
                                                                                      ],
                                                                                    ),

                                                                                  ],
                                                                                ),
                                                                              ): TextForNewAdd(context,text: "From Location",onTap: (){
                                                                                setState(() {
                                                                                  data["showItemFromLocation"]  = true;
                                                                                  ItemsList[index]["item_condition"]["itemDisableFields"].remove("FromLocation");
                                                                                });setModalState((){});
                                                                              }),
                                                                              data["showItemTOLocation"]==true?  Padding(
                                                                                padding: EdgeInsets.only(top:2),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top:5.0,bottom:3),
                                                                                      child: Text("To location", style: BlackDescStyle500,),
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        InkWell(
                                                                                          onTap:(){
                                                                                            setState((){
                                                                                              data["item_condition"]["tolocation"].clear();
                                                                                              data["showItemTOLocation"] = false;
                                                                                              ItemsList[index]["item_condition"]["itemDisableFields"].add("ToLocation");
                                                                                            });setModalState((){});
                                                                                          },
                                                                                          child: CircleAvatar(
                                                                                            radius:8,
                                                                                            backgroundColor: Color(
                                                                                                0x3389F6B9) ,
                                                                                            child: Center(
                                                                                                child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        10.width,
                                                                                        Flexible(
                                                                                          child: Container(
                                                                                            height: 35,
                                                                                            padding: EdgeInsets.only(left:12),
                                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),

                                                                                            child: TextFormField(
                                                                                              controller:  data["item_condition"]["tolocation"],
                                                                                              onTap:() async {
                                                                                                if(LatitudeLongitude == null ){
                                                                                                  Constants.showToast("Please wait");
                                                                                                }else{
                                                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong: LatitudeLongitude!,isAppPlaceView: true,isTitleSelectAsAddress: true))).then((value) {
                                                                                                    setState((){
                                                                                                      data["item_condition"]["tolocation"].text=value.toString();
                                                                                                    });setModalState((){});
                                                                                                  });
                                                                                                }


                                                                                                // String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => NormalPlacePickerScreen("AIzaSyDE9xGmWMOftPvz1hHwPlTecShhHtR4goE")));
                                                                                                // setState((){
                                                                                                //   data["item_condition"]["tolocation"].text=result.toString();
                                                                                                // });
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
                                                                                        ),

                                                                                        // data["showItemAtLocation"]==true?SizedBox():  Positioned(
                                                                                        //     top:1,right:2,
                                                                                        //     child: InkWell(
                                                                                        //       onTap:(){
                                                                                        //         setState((){
                                                                                        //           data["showItemAtLocation"] = true ;
                                                                                        //         });
                                                                                        //       },
                                                                                        //       child: CircleAvatar(
                                                                                        //         radius:8,
                                                                                        //         backgroundColor: Constants.primaryColor1 ,
                                                                                        //         child: Center(
                                                                                        //             child:Icon(Icons.add,color: Colors.white,size:14,)
                                                                                        //         ),
                                                                                        //       ),
                                                                                        //     ))
                                                                                      ],
                                                                                    ),

                                                                                  ],
                                                                                ),
                                                                              ): TextForNewAdd(context,text: "To Location",onTap: (){
                                                                                setState(() {
                                                                                  data["showItemTOLocation"]  = true;
                                                                                  ItemsList[index]["item_condition"]["itemDisableFields"].remove("ToLocation");
                                                                                });setModalState((){});
                                                                              }),
                                                                              data["showItemAtLocation"]==true?  Padding(
                                                                                padding: EdgeInsets.only(top:2),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top:5.0,bottom:3),
                                                                                      child: Text("At location", style: BlackDescStyle500,),
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        InkWell(
                                                                                          onTap:(){
                                                                                            setState((){
                                                                                              data["item_condition"]["atlocation"].clear();
                                                                                              data["showItemAtLocation"] = false;
                                                                                              ItemsList[index]["item_condition"]["itemDisableFields"].add("AtLocation");
                                                                                            });setModalState((){});
                                                                                          },
                                                                                          child: CircleAvatar(
                                                                                            radius:8,
                                                                                            backgroundColor: Color(
                                                                                                0x3389F6B9) ,
                                                                                            child: Center(
                                                                                                child:Icon(Icons.close,color: Colors.black,size:14,)
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        10.width,
                                                                                        Flexible(
                                                                                          child: Container(
                                                                                            height: 35,
                                                                                            padding: EdgeInsets.only(left:12),
                                                                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),

                                                                                            child: TextFormField(
                                                                                              controller:  data["item_condition"]["atlocation"],
                                                                                              onTap:() async {
                                                                                                if(LatitudeLongitude == null ){
                                                                                                  Constants.showToast("Please wait");
                                                                                                }else{
                                                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong: LatitudeLongitude!,isAppPlaceView: true,isTitleSelectAsAddress: true))).then((value) {
                                                                                                    setState((){
                                                                                                      data["item_condition"]["atlocation"].text=value.toString();
                                                                                                    });setModalState((){});
                                                                                                  });
                                                                                                }

                                                                                                //   String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => NormalPlacePickerScreen("AIzaSyDE9xGmWMOftPvz1hHwPlTecShhHtR4goE")));
                                                                                                //   setState((){
                                                                                                //     data["item_condition"]["atlocation"].text=result.toString();
                                                                                                //   });
                                                                                                //
                                                                                                //   //  Navigator.push(context, MaterialPageRoute(builder: (context) => placepick(title: "Place picker"),));
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
                                                                                        ),
                                                                                      ],
                                                                                    ),

                                                                                  ],
                                                                                ),
                                                                              ): TextForNewAdd(context,text: "At Location",onTap: (){
                                                                                setState(() {
                                                                                  data["showItemAtLocation"]  = true;
                                                                                  ItemsList[index]["item_condition"]["itemDisableFields"].remove("AtLocation");
                                                                                });setModalState((){});
                                                                              }),

                                                                            ],
                                                                          ),
                                                                        ):SizedBox(),
                                                                        10.height,
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                filterOfferNameList.isEmpty?SizedBox():
                                                                Positioned(
                                                                    top:70,left:8,
                                                                    child: SizedBox(
                                                                      width: isMobile?width*0.5:tabWidth*0.5,
                                                                      height:
                                                                      filterOfferNameList.length  == 1 ?35 :
                                                                      filterOfferNameList.length == 2 ?60:
                                                                      filterOfferNameList.length == 3 ?90:
                                                                      filterOfferNameList.length == 4 ?120:
                                                                      filterOfferNameList.length == 5 ?150:
                                                                      180,
                                                                      child: Card(
                                                                        elevation: 1.4,
                                                                        color: Colors.white,
                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),side: BorderSide(color: primaryColor20,width: 1)),
                                                                        child:
                                                                        CupertinoScrollbar(
                                                                          child: ListView.builder(
                                                                            itemCount: filterOfferNameList.length,
                                                                            shrinkWrap: true,
                                                                            physics: ClampingScrollPhysics(),
                                                                            padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                                                                            itemBuilder: (context, index) {
                                                                              print(filterOfferNameList.length);
                                                                              var Name = filterOfferNameList[index];
                                                                              return InkWell(
                                                                                onTap: (){
                                                                                  setState(() {
                                                                                    GetOfferForFillByItemName("${Name.offerItems!.first.name}",setModalState);
                                                                                    data["name"].text = "${Name.offerItems!.first.name}";

                                                                                    //  filterOfferNameList.clear();
                                                                                    filterOfferNameList = [];
                                                                                  });setModalState((){});
                                                                                },
                                                                                child: Padding(
                                                                                  padding:  EdgeInsets.symmetric(horizontal: 5.0,vertical: 4),
                                                                                  child:Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children:  [
                                                                                      0.width,
                                                                                      Flexible(
                                                                                        child: Text.rich(
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          TextSpan(
                                                                                            children: highlightOccurrences("${Name.offerItems!.first.name}", data["name"].text ),
                                                                                            style: BlackFieldStyle,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      // Flexible(child: Text("${searchText}", style: BlackFieldStyle,overflow: TextOverflow.ellipsis)),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },),
                                                                        ),
                                                                      ),
                                                                    )
                                                                ),
                                                                OfferListByName.isEmpty ||  OfferListByName == []?SizedBox():
                                                                Positioned(
                                                                  top:70,left:0,
                                                                  child:      SizedBox(
                                                                      width: isMobile?width:tabWidth,
                                                                      height:
                                                                      OfferListByName.length  == 1 ?35 +50:
                                                                      OfferListByName.length == 2 ?60+50:
                                                                      OfferListByName.length == 3 ?90+50:
                                                                      OfferListByName.length == 4 ?125+50:
                                                                      OfferListByName.length == 5 ?155+50:185+50,
                                                                      child: FillBuilder(context,setModalState,filterList: OfferListByName,bgColor: Constants.offerPageSecoundry,by: "Item")),
                                                                ),
                                                              ],
                                                            ),
                                                            Positioned(
                                                                top:10,left:0,right:0,
                                                                child:BottomSheetDivider()),
                                                            Positioned.fill(
                                                                bottom: 0,left: 0,right: 0,top: 0,
                                                                child:   segmentLoader==true || isLoadingFillOffer ==true || isGettingSearchOffer == true?
                                                                Container(
                                                                  color: Colors.black12,

                                                                  width: isMobile ?width:tabWidth,
                                                                  child: const Center(
                                                                      child:   SearchLoading()
                                                                  ),
                                                                ) : const SizedBox())
                                                          ],
                                                        ),
                                                      );
                                                    },)
                                                );
                                              })
                                            ]
                                        )  ],
                                    ),
                                  ),
                                );
                              },),
                              // TODO Offer Bids
                              Container(
                                  padding:  EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                                color:Constants.bottomSheetBg,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OfferInstruction1Controller.text == "" ||  OfferInstruction1Controller.text == "," || OfferInstruction1Controller.text == " " || OfferInstruction1Controller.text.toString() == "null"?
                                    Padding(
                                      padding:  EdgeInsets.only(top: 8.0),
                                      child: Text("Tap Edit To Enter Addition Instruction",style:BlackSubCardTitle2),
                                    )
                                        :
                                     ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        5.height,
                                        Row (
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Flexible(child: Text("${OfferInstruction1Controller.text}",style: BlackSubTitleStyle,)),
                                          ],
                                        ),

                                      ],
                                    ),
                                     Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                       EditBtn((){
                                         Get.bottomSheet(
                                             backgroundColor:  Constants.bottomSheetBg,
                                             elevation: 0,  shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                                         ),
                                             isDismissible: true,isScrollControlled: true,
                                             StatefulBuilder(builder: (context, setModalState) {
                                               return  ListView(
                                                 shrinkWrap: true,
                                                 physics: NeverScrollableScrollPhysics(),
                                                 children: [
                                                   10.height,
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      BottomSheetDivider()
                                                    ],
                                                  ),
                                                   10.height,
                                                   const Padding(
                                                     padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                                                     child: Align(
                                                         alignment: Alignment.topLeft,
                                                         child: Text(
                                                           "Offer Instruction & bids",
                                                           style: BlackFieldStyleBold,
                                                         )),
                                                   ),
                                                   Padding(
                                                   padding: const EdgeInsets.only(right: 15.0,top:3,bottom: 10,left: 15),
                                                   child: Container(
                                                     height: 37,
                                                     padding: EdgeInsets.only(left:12),
                                                     decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
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
                                                       onChanged: (v){

                                                         setModalState((){});
                                                       },
                                                       style: Black87HintStyle,
                                                     ),
                                                   ),
                                                 ),

                                                   // Padding(
                                                   //   padding: const EdgeInsets.only(right: 15.0,top:8,bottom: 5,left: 15),
                                                   //   child: Container(
                                                   //     height: 37,
                                                   //     padding: EdgeInsets.only(left:12),
                                                   //     decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
                                                   //     child: TextFormField(
                                                   //       controller: OfferInstruction2Controller,
                                                   //       keyboardType: TextInputType.text,
                                                   //       onChanged: (v){
                                                   //         setModalState((){});
                                                   //       },
                                                   //       decoration: InputDecoration(hintText:"Enter Offer Instruction Remarks", fillColor:  Colors.white, hintStyle: greyHintStyle,
                                                   //         focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                   //         enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                                                   //         floatingLabelBehavior: FloatingLabelBehavior.never,
                                                   //         contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                   //         border: const OutlineInputBorder(),
                                                   //
                                                   //         // hintText: 'Enter Query',hintStyle: hintstyle,
                                                   //       ),
                                                   //       style: Black87HintStyle,
                                                   //     ),
                                                   //   ),
                                                   // )
                                                 ],
                                               );
                                             },)
                                         );
                                       })
                                     ],
                                   ),
                                     5.height,
                                  ],
                                ),
                              ),
                              20.height

                            ],
                          )
                      ),
                    ],
                  ),
                ),
                segmentLoader==true || isLoadingFillOffer ==true || isGettingSearchOffer == true?
                Container(
                  color: Colors.black12,
                  height: MediaQuery.of(context).size.height,
                  width: isMobile ?width:tabWidth,
                  child: const Center(
                    child:   SearchLoading()
                  ),
                ) : const SizedBox()
              ],
            ),

            bottomNavigationBar:  segmentLoader==true || isLoadingFillOffer ==true || isGettingSearchOffer == true?SizedBox(): Container (
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black38, spreadRadius: 2.5, blurRadius: 2.5),],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: isMobile?width*0.2:tabWidth*0.2,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            backgroundColor:
                            searchCategoryId == "" || searchSegmentId=="" || searchSubSegmentId=="" ||

                                ItemsList[0]["name"].text.toString()==""||ItemsList[0]["name"].text.toString()=="null"||ItemsList[0]["name"].text.isEmpty ||
                                ItemsList[0]["media"].isEmpty ||
                                OfferInstruction1Controller.text.isEmpty?nullBtnColor:
                            Constants.primaryColor1,
                            elevation: 1),
                        onPressed:
                        DataManager.getInstance().getuserId().toString() == "1"?
                        (){GuestLoginDialog(context);}:
                        selectedTap.toString().toUpperCase().trim() == "CANCEL"?
                            (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewOfferCreateScreen(Address: "",AddressTitle: "",From: "New",PrefillOfferData: PrefillOfferDataModel(),Type: "",OfferId: "",SubId: "")));


                          Constants.showToastAtBottom("Offer canceled");
                        }:
                        searchCategoryId == "" || searchSegmentId=="" || searchSubSegmentId=="" ||
                            ItemsList[0]["name"].text.toString()==""||ItemsList[0]["name"].text.toString()=="null"||ItemsList[0]["name"].text.isEmpty ||
                            ItemsList[0]["media"].isEmpty ||
                            OfferInstruction1Controller.text.isEmpty
                        ?(){
                          if(searchCategoryId == "" || searchSegmentId=="" || searchSubSegmentId==""){
                            Constants.showToastAtBottom("${Url.CatSegSubSegEnterMessage}");
                          }else if( ItemsList[0]["name"].text.toString()==""||ItemsList[0]["name"].text.toString()=="null"||ItemsList[0]["name"].text.isEmpty ||
                              ItemsList[0]["media"].isEmpty ){
                            Constants.showToastAtBottom("${Url.itemNameEnterMessage}");
                          }else if ( OfferInstruction1Controller.text.isEmpty){
                            Constants.showToastAtBottom("${Url.BidsMessage}");
                          }

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
                          }
                          Future.delayed(Duration(seconds: 1),() {
                            // if(adressLocationController.text == "" || adressLocationController.text.isEmpty){
                            //   setState(() {
                            //     PublishLoader = false;
                            //   });
                            //   Constants.MessageShowDialog(context, RichText(
                            //     textAlign: TextAlign.center,
                            //     text:  TextSpan(
                            //         children: [
                            //           TextSpan(text: 'Please select your ', style: BlackTitle700height),
                            //           TextSpan(text: " \naddress", style: BlackTitles400height),
                            //         ]
                            //     ),
                            //   ),(){
                            //     Navigator.pop(context);
                            //   });
                            //
                            // }
                            // else
                              if(ErrorMessage != "NoError"){
                              setState(() {
                                PublishLoader = false;
                              });
                              Constants.MessageShowDialog(context, RichText(
                                textAlign: TextAlign.center,
                                text:  TextSpan(
                                    children: [
                                      TextSpan(text: '$ErrorMessage', style: BlackTitle700height),
                                      TextSpan(text: " \nto publish", style: BlackTitles400height),
                                    ]
                                ),
                              ),(){
                                Navigator.pop(context);
                              });

                            }
                            // else if(ItemsList[0]["media"].isEmpty)
                            // {
                            //   setState(() {
                            //     PublishLoader = false;
                            //   });
                            //   Constants.MessageShowDialog(context, RichText(
                            //     textAlign: TextAlign.center,
                            //     text:  TextSpan(
                            //         children: [
                            //           TextSpan(text: 'It seems that the media file has ', style: BlackTitle700height),
                            //           TextSpan(text: " \nnot been uploaded", style: BlackTitles400height),
                            //         ]
                            //     ),
                            //   ),(){
                            //     Navigator.pop(context);
                            //   });
                            // }
                            // else if( OfferInstruction1Controller.text.isEmpty && OfferInstruction2Controller.text.isEmpty){
                            //   setState(() {
                            //     PublishLoader = false;
                            //   });
                            //   Constants.MessageShowDialog(context, RichText(
                            //     textAlign: TextAlign.center,
                            //     text:  TextSpan(
                            //         children: [
                            //           TextSpan(text: 'Please enter offer bids ', style: BlackTitle700height),
                            //           TextSpan(text: " \nor instructions", style: BlackTitles400height),
                            //         ]
                            //     ),
                            //   ),(){
                            //     Navigator.pop(context);
                            //   });
                            // }
                            else{
                              setState((){
                                PublishLoader =true;
                              });
                              List offerAreas = [];
                              for (var i in serviceAreaList){
                                setState(() {
                                  offerAreas.add({"Address": i.text.toString(),"latitude": "" ,"longitude": ""});
                                  // offerAreas.add({"Address": i.text.toString(),"latitude": "" ,"longitude": ""});
                                });
                              }
                              String TextModeration = "${searchCategoryController.text} ${searchSegmentController.text} ${searchSubSegmentController.text} ${OfferInstruction1Controller.text}";

                              if(selectedTap == "Modify"){
                                /// *Modify Offer Template*
                                    print("Modify Template");
                                List bids = [];

                                OfferInstruction1Controller.text != ""?bids.add({"id":"${widget.PrefillOfferData!.offerBids![0].id}","comment": "${OfferInstruction1Controller.text}"}):null;
                                //OfferInstruction2Controller.text != "" ?bids.add({"id":"${widget.PrefillOfferData!.offerBids![1].id}","comment": "${OfferInstruction2Controller.text}"}):null;
                                final List<dynamic> ItemsFinalList = [];
                                for(var i=0; i<ItemsList.length ;i++){
                                  TextModeration = "${TextModeration} ${ItemsList[i]["name"].text.toString()} ${ItemsList[i]["desc"].text.toString()}";
                                  ItemsFinalList.add(
                                      {
                                        "id":"${ItemsList[i]["itemId"].toString()}",
                                        "name":ItemsList[i]["name"].text.toString()==""?null:"${ItemsList[i]["name"].text.toString()}",
                                        "desc":ItemsList[i]["desc"].text.toString()==""?null:"${ItemsList[i]["desc"].text.toString()}",
                                        "price":ItemsList[i]["price"].text==""?null:"${ItemsList[i]["price"].text}",
                                        "unit": ItemsList[i]["SelectedUnitId"].toString()=="" || ItemsList[i]["unit"].text.isEmpty  || ItemsList[i]["unit"].text == ""?null:"${ItemsList[i]["SelectedUnitId"].toString()}",
                                        "advance_price" : ItemsList[i]["AdvancePrice"].text==""?null:"${ItemsList[i]["AdvancePrice"].text}",
                                        "maintenance_price" : ItemsList[i]["MaintenancePrice"].text==""?null:"${ItemsList[i]["MaintenancePrice"].text}",
                                        "advance_unit" : ItemsList[i]["SelectedUnitIdAdva"].toString()=="" ||  ItemsList[i]["AdvanceUnit"].text.isEmpty  || ItemsList[i]["AdvanceUnit"].text == ""?null:"${ ItemsList[i]["SelectedUnitIdAdva"]}",
                                        "maintenance_unit" : ItemsList[i]["SelectedUnitIdMain"].toString()=="" ||  ItemsList[i]["MaintenanceUnit"].text.isEmpty  || ItemsList[i]["MaintenanceUnit"].text == "" ?null:"${ItemsList[i]["SelectedUnitIdMain"]}",
                                        "quantity":"${ItemsList[i]["quantity"].toString()}",
                                        "currency":"INR",
                                        "addon":"${ItemsList[i]["addon"].toString()}",
                                        "required":"${ItemsList[i]["required"].toString()}",
                                        "toggle_state":"false",
                                        "media": ItemsList[i]["media"],
                                        "item_condition":{
                                          "id":"${ItemsList[i]["item_condition"]["itemConditionId"].toString()}",
                                          "periodicity":"${ItemsList[i]["item_condition"]["periodicity"].toString()}",
                                          "fromperiod":ItemsList[i]["item_condition"]["fromperiod"].toString() == ""?null:ItemsList[i]["item_condition"]["fromperiod"].toString(),
                                          "toperiod":ItemsList[i]["item_condition"]["toperiod"].toString() == ""?null:ItemsList[i]["item_condition"]["toperiod"].toString(),
                                          "duration": ItemsList[i]["item_condition"]["duration"].text.toString() == ""?null :isItemSinglePeriodSelect==false?ItemsList[i]["item_condition"]["duration"].text.toString():ItemsList[i]["item_condition"]["duration"].text.toString()==3?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00:00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==6?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==9?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==12?ItemsList[i]["item_condition"]["duration"].text.toString()+"00":ItemsList[i]["item_condition"]["duration"].text.toString(),
                                          "fromperiodtime":ItemsList[i]["item_condition"]["fromperiodtime"].toString()==""?null:ItemsList[i]["item_condition"]["fromperiodtime"].toString(),
                                          "toperiodtime":ItemsList[i]["item_condition"]["toperiodtime"].toString() == ""?null:ItemsList[i]["item_condition"]["toperiodtime"].toString(),
                                          "durationoftime":null,
                                          "fromlocation":ItemsList[i]["item_condition"]["fromlocation"].text.toString()==""?null:"${ItemsList[i]["item_condition"]["fromlocation"].text.toString()}",
                                          "tolocation":ItemsList[i]["item_condition"]["tolocation"].text.toString()==""?null:"${ItemsList[i]["item_condition"]["tolocation"].text.toString()}",
                                          "atlocation":ItemsList[i]["item_condition"]["atlocation"].text.toString()==""?null:"${ItemsList[i]["item_condition"]["atlocation"].text.toString()}",
                                          "servicepersons": ItemsList[i]["item_condition"]["servicepersons"].where((e)=> e.toString() == "-1" || e.toString() == "0").length >= 1 ? [] : ItemsList[i]["item_condition"]["servicepersons"],
                                          "priority":ItemsList[i]["item_condition"]["priority"].toString()==""?null:"${ItemsList[i]["item_condition"]["priority"].toString().toUpperCase()}",
                                          "expiry":ItemsList[i]["item_condition"]["expiry"].text.toString()==""?null:ItemsList[i]["item_condition"]["expiry"].text.toString()
                                        }});
                                }
                                Map<String, dynamic> UpdateOfferParam = {
                                  "id":widget.PrefillOfferData!.offerId.toString(),
                                  "subscribers":"${DataManager.getInstance().userId.toString()}",
                                  "category": "${searchCategoryId.toString()}",
                                  "segment": "${searchSegmentId.toString()}",
                                  "subsegment": "${searchSubSegmentId.toString()}",
                                  "addres":adressLocationController.text.toString(),
                                  "offerareas":jsonEncode(offerAreas).toString(),
                                  "privacy": DataManager.getInstance().getUserIsPlaceType().toString() == "true" ? isPrivateOffer?"PRIVATE":"PUBLIC":  KycDataList.isEmpty || KycDataList.length == 1 ? "PRIVATE": isPrivateOffer?"PRIVATE":"PUBLIC",
                                  "offertemplate" : DataManager.getInstance().getUserIsPlaceType().toString() == "true" ?
                                   selectedTap.toUpperCase().toString().toUpperCase() == "TEMPLATE"?true: false: KycDataList.isEmpty || KycDataList.length == 1? true:selectedTap.toUpperCase().toString().toUpperCase() == "TEMPLATE"?true: false,
                                  "tabactivity": DataManager.getInstance().getUserIsPlaceType().toString() == "true" ?  selectedTap.toUpperCase().toString().toUpperCase():KycDataList.isEmpty || KycDataList.length == 1? "TEMPLATE": selectedTap.toUpperCase().toString().toUpperCase(),
                                  "buyORsell": selectedTap.toString().toUpperCase().trim() == "DELIVER"?_currentTapindex==0?"DELIVER_BUY":"DELIVER_SELL":_currentTapindex==0?"BUY":"SELL",
                                  "offerexecutestart": null,
                                  "offerexecuteend": null,
                                  "offer_condition":{
                                    "id": widget.PrefillOfferData!.offerConditions!.id.toString(),
                                    "periodicity":selectedPeriodicityValue,
                                    "fromperiod": offerPeriodFromDate==""?null:"${offerPeriodFromDate}",
                                    "toperiod": offerPeriodToDate==""?null:"${offerPeriodToDate}",
                                    "fromperiodtime":offerPeriodFromTime==""?null:offerPeriodFromTime,
                                    "toperiodtime":offerPeriodToTime==""?null:offerPeriodToTime,
                                    "duration":OfferDurationController.text == ""?null :isSinglePeriodSelect==false?OfferDurationController.text.toString():OfferDurationController.text.length==3?OfferDurationController.text+"00:00:00:00":OfferDurationController.text.length==6?OfferDurationController.text+"00:00:00":OfferDurationController.text.length==9?OfferDurationController.text+"00:00":OfferDurationController.text.length==12?OfferDurationController.text+"00":OfferDurationController.text,
                                    "durationoftime":"",
                                    "fromlocation":OfferFromLocationController.text.isEmpty?null:OfferFromLocationController.text,
                                    "tolocation":OfferToLocationController.text.isEmpty?null:OfferToLocationController.text,
                                    "atlocation":OfferAtLocationController.text.isEmpty?null:OfferAtLocationController.text,
                                    "servicepersons":  selectedItems.where((e)=> e.toString() == "-1" || e.toString() == "0" ).length >= 1  ? [] : selectedItems,
                                    "priority":selectedValuePriority==null?null:selectedValuePriority!.toUpperCase().toString(),
                                    "expiry":offerExpiryDateTime==""?null:offerExpiryDateTime.toString(),
                                  },
                                  "bids":bids,
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

                                  DrawAuraAPi().UpdateOfferDetails(UpdateOfferParam).then((response){

                                    if (response.statusCode == 200) {
                                      var data = json.decode(response.body);
                                      if(data["status"] == 200){

                                        Constants.showToastAtBottom("Template Updated");

                                        DataManager.getInstance().getUserIsPlaceType().toString() == "false" && KycDataList.isEmpty || KycDataList.length == 1
                                            ?
                                        MessageShowDialogWithText(context,
                                            Text("Please add atleast two KYC documents in your profile to publish",textAlign: TextAlign.center,style: BlackTitle500height,)
                                            ,(){
                                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 4),), (route) => false);
                                            }
                                          ):  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 4),), (route) => false);
                                      }else{
                                        Constants.showToastAtBottom(data["message"]);
                                      }
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (context) {
                                      //     return  StatefulBuilder(builder: (context, setState) {
                                      //       return Dialog(
                                      //         alignment: Alignment.center,
                                      //         elevation: BorderSide.strokeAlignOutside,
                                      //         child: Container(
                                      //           height:MediaQuery.of(context).size.height*0.3,
                                      //           width: isMobile?width*0.8:tabWidth*0.8,
                                      //           decoration:  BoxDecoration(color: Color(0x1A52B46B)),
                                      //           child: Column(
                                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //             children: [
                                      //               Padding(
                                      //                 padding: const EdgeInsets.only(top: 40),
                                      //                 child: SizedBox(
                                      //                   width: isMobile?width*0.5:tabWidth*0.5,
                                      //                   child: Center(
                                      //                     child: RichText(
                                      //                         textAlign: TextAlign.center,
                                      //                         text: TextSpan(
                                      //                             children: [
                                      //                               TextSpan(text: 'Your Offer template', style: BlackTitle500height),
                                      //                               TextSpan(text: ' is Update.', style:BlackTitle500height),
                                      //                             ]
                                      //                         )
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               Padding(
                                      //                 padding: const EdgeInsets.only(bottom: 20),
                                      //                 child: ElevatedButton(
                                      //                     style: ElevatedButton.styleFrom(
                                      //                         padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 2),
                                      //                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor:Constants.primaryColor1, elevation: 1),
                                      //                     onPressed: () {
                                      //                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 4),), (route) => false);
                                      //                     },
                                      //                     child: Text("ok",style: WhiteButtonStyle,)),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       );
                                      //     },);
                                      //   },).then((value) {
                                      //
                                      // });
                                    }else if(response.statusCode == 500){
                                      Navigator.pop(context);
                                    }
                                    else{
                                      Navigator.pop(context);
                                    }
                                  }).then((value) {
                                    setState((){
                                      PublishLoader =false;
                                    });
                                  });
                                },);
                              }
                              else{
                                /// New Offer Creator
                                List bids = [];

                                OfferInstruction1Controller.text != ""?bids.add({"comment": "${OfferInstruction1Controller.text}"}):null;
                                // OfferInstruction2Controller.text != ""?bids.add({"comment": "${OfferInstruction2Controller.text}"}):null;

                                final List<dynamic> ItemsFinalList = [];
                                for(var i=0; i<ItemsList.length ;i++){
                                  TextModeration = "${TextModeration} ${ItemsList[i]["name"].text.toString()} ${ItemsList[i]["desc"].text.toString()}";
                                  ItemsFinalList.add(
                                      {
                                        "name":ItemsList[i]["name"].text.toString()==""?null:"${ItemsList[i]["name"].text.toString()}",
                                        "desc":ItemsList[i]["desc"].text.toString()==""?null:"${ItemsList[i]["desc"].text.toString()}",
                                        "price": ItemsList[i]["price"].text==""?null:"${ItemsList[i]["price"].text}",
                                        "unit": ItemsList[i]["SelectedUnitId"].toString()=="" || ItemsList[i]["unit"].text.isEmpty  || ItemsList[i]["unit"].text == ""?null:"${ItemsList[i]["SelectedUnitId"].toString()}",
                                        "advance_price" : ItemsList[i]["AdvancePrice"].text==""?null:"${ItemsList[i]["AdvancePrice"].text}",
                                        "maintenance_price" : ItemsList[i]["MaintenancePrice"].text==""?null:"${ItemsList[i]["MaintenancePrice"].text}",
                                        "advance_unit" : ItemsList[i]["SelectedUnitIdAdva"].toString()=="" ||  ItemsList[i]["AdvanceUnit"].text.isEmpty  || ItemsList[i]["AdvanceUnit"].text == ""?null:"${ ItemsList[i]["SelectedUnitIdAdva"]}",
                                        "maintenance_unit" : ItemsList[i]["SelectedUnitIdMain"].toString()=="" ||  ItemsList[i]["MaintenanceUnit"].text.isEmpty  || ItemsList[i]["MaintenanceUnit"].text == "" ?null:"${ItemsList[i]["SelectedUnitIdMain"]}",
                                        "quantity":"${ItemsList[i]["quantity"].toString()}",
                                        "currency":"INR",
                                        "addon":"${ItemsList[i]["addon"].toString()}",
                                        "required":"${ItemsList[i]["required"].toString()}",
                                        "toggle_state":"false",
                                        "media": ItemsList[i]["media"],
                                        "item_condition":{
                                          "periodicity":"${ItemsList[i]["item_condition"]["periodicity"].toString()}",
                                          "fromperiod":ItemsList[i]["item_condition"]["fromperiod"].toString() == ""?null:ItemsList[i]["item_condition"]["fromperiod"].toString(),
                                          "toperiod":ItemsList[i]["item_condition"]["toperiod"].toString() == ""?null:ItemsList[i]["item_condition"]["toperiod"].toString(),
                                          "duration": ItemsList[i]["item_condition"]["duration"].text.toString() == ""?null :isItemSinglePeriodSelect==false?ItemsList[i]["item_condition"]["duration"].text.toString():ItemsList[i]["item_condition"]["duration"].text.toString()==3?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00:00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==6?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==9?ItemsList[i]["item_condition"]["duration"].text.toString()+"00:00":ItemsList[i]["item_condition"]["duration"].text.toString()==12?ItemsList[i]["item_condition"]["duration"].text.toString()+"00":ItemsList[i]["item_condition"]["duration"].text.toString(),
                                          "fromperiodtime":ItemsList[i]["item_condition"]["fromperiodtime"].toString()==""?null:ItemsList[i]["item_condition"]["fromperiodtime"].toString(),
                                          "toperiodtime":ItemsList[i]["item_condition"]["toperiodtime"].toString() == ""?null:ItemsList[i]["item_condition"]["toperiodtime"].toString(),
                                          "durationoftime":null,
                                          "fromlocation":ItemsList[i]["item_condition"]["fromlocation"].text.toString()==""?null:"${ItemsList[i]["item_condition"]["fromlocation"].text.toString()}",
                                          "tolocation":ItemsList[i]["item_condition"]["tolocation"].text.toString()==""?null:"${ItemsList[i]["item_condition"]["tolocation"].text.toString()}",
                                          "atlocation":ItemsList[i]["item_condition"]["atlocation"].text.toString()==""?null:"${ItemsList[i]["item_condition"]["atlocation"].text.toString()}",
                                          "servicepersons": ItemsList[i]["item_condition"]["servicepersons"].where((e)=> e.toString() == "-1" || e.toString() == "0").length >= 1 ? [] : ItemsList[i]["item_condition"]["servicepersons"],
                                          "priority":ItemsList[i]["item_condition"]["priority"].toString()==""?null:"${ItemsList[i]["item_condition"]["priority"].toString().toUpperCase()}",
                                          "expiry":ItemsList[i]["item_condition"]["expiry"].text.toString()==""?null:ItemsList[i]["item_condition"]["expiry"].text.toString(),
                                          "disable_fields" : jsonEncode(ItemsList[i]["item_condition"]["itemDisableFields"]).toString()
                                        }});
                                }
                                Map<String, dynamic> CreateOfferParam = {
                                  "subscribers":"${DataManager.getInstance().userId.toString()}",
                                  "category": "${searchCategoryId.toString()}",
                                  "segment": "${searchSegmentId.toString()}",
                                  "subsegment": "${searchSubSegmentId.toString()}",
                                  "addres":adressLocationController.text.toString(),
                                  "offerareas":jsonEncode(offerAreas).toString(),
                                  "privacy":DataManager.getInstance().getUserIsPlaceType().toString() == "true" ? isPrivateOffer?"PRIVATE":"PUBLIC": KycDataList.isEmpty || KycDataList.length == 1 ? "PRIVATE": isPrivateOffer?"PRIVATE":"PUBLIC",
                                  "offertemplate" : selectedTap.toUpperCase().toString().toUpperCase() == "TEMPLATE"?true: false,
                                  "tabactivity": DataManager.getInstance().getUserIsPlaceType().toString() == "true" ?selectedTap.toUpperCase().toString().toUpperCase() :KycDataList.isEmpty || KycDataList.length == 1? "TEMPLATE": selectedTap.toUpperCase().toString().toUpperCase(),
                                  "buyORsell": selectedTap.toString().toUpperCase().trim() == "DELIVER"?_currentTapindex==0?"DELIVER_BUY":"DELIVER_SELL":_currentTapindex==0?"BUY":"SELL",
                                  "offerexecutestart": null,
                                  "offerexecuteend": null,
                                  "periodicity":selectedPeriodicityValue,
                                  "fromperiod": offerPeriodFromDate==""?null:"${offerPeriodFromDate}",
                                  "toperiod": offerPeriodToDate==""?null:"${offerPeriodToDate}",
                                  "fromperiodtime":offerPeriodFromTime==""?null:offerPeriodFromTime,
                                  "toperiodtime":offerPeriodToTime==""?null:offerPeriodToTime,
                                  "duration":OfferDurationController.text == ""?null :isSinglePeriodSelect==false?OfferDurationController.text.toString():OfferDurationController.text.length==3?OfferDurationController.text+"00:00:00:00":OfferDurationController.text.length==6?OfferDurationController.text+"00:00:00":OfferDurationController.text.length==9?OfferDurationController.text+"00:00":OfferDurationController.text.length==12?OfferDurationController.text+"00":OfferDurationController.text,
                                  "durationoftime":null,
                                  "fromlocation":OfferFromLocationController.text.isEmpty?null:OfferFromLocationController.text,
                                  "tolocation":OfferToLocationController.text.isEmpty?null:OfferToLocationController.text,
                                  "atlocation":OfferAtLocationController.text.isEmpty?null:OfferAtLocationController.text,
                                  "servicepersons": selectedItems.where((e)=> e.toString() == "-1" || e.toString() == "0" ).length >= 1  ? [] : selectedItems,
                                  "servicepersons_need":  selectedItems.where((e)=> e.toString() == "0" ).length == 1  ?"true" :
                                    selectedItems.where((e)=> e.toString() == "-1" ).length == 1 ?"false":
                                    selectedItems.isEmpty ? "false":"true",
                                  "priority":selectedValuePriority==null?null:selectedValuePriority!.toUpperCase().toString(),
                                  "expiry":offerExpiryDateTime==""?null:offerExpiryDateTime.toString(),
                                  "bids":bids,
                                  "items":ItemsFinalList,
                                  "disable_fields" : jsonEncode(offerDisableFields).toString(),
                                };
                                log(CreateOfferParam.toString());

                                print("CreateOfferParamNew");
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
                                         log(CreateOfferParam.toString());
                                         print("Create offer Param");
                                  DrawAuraAPi().createOffer(CreateOfferParam).then((response){
                                    if (response.statusCode == 200) {
                                      var data = json.decode(response.body);


                                      if(data["status"] == 200){
                                        if(widget.Type != ""){
                                          if(widget.Type == "Template"){
                                            if(widget.SubId.toString().trim() != DataManager.getInstance().getuserId().toString().trim()){
                                              var body = {
                                                "from_user" : DataManager.getInstance().getuserId().toString(),
                                                "to_user" : "${widget.SubId}",
                                                "offer_id" :  widget.OfferId,
                                                "counter_id" : "null",
                                                "type" : "Template",
                                                "message" : "used your template for their offer",
                                              };
                                              DrawAuraAPi.CreateDataApi(ApiEndPoint: "sendPushNotification",body: body);
                                            }
                                            var body = {
                                              "user_id":DataManager.getInstance().getuserId().toString(),
                                              "offer_id":"${widget.OfferId.toString()}"
                                            };
                                            DrawAuraAPi.CreateDataApi(ApiEndPoint: "updateOfferCopyCount",body: body).then((UpadteCOunt) {});
                                          }else{
                                            if(widget.SubId.toString().trim() != DataManager.getInstance().getuserId().toString().trim()){
                                              var body = {
                                                "from_user" : DataManager.getInstance().getuserId().toString(),
                                                "to_user" : "${widget.SubId}",
                                                "offer_id" :  widget.OfferId,
                                                "counter_id" : "null",
                                                "type" : "Duplicate",
                                                "message" : "duplicated yours for their offer",
                                              };
                                              DrawAuraAPi.CreateDataApi(ApiEndPoint: "sendPushNotification",body: body);
                                            }
                                            var body = {
                                              "user_id":DataManager.getInstance().getuserId().toString(),
                                              "offer_id":"${widget.OfferId.toString()}"
                                            };
                                            DrawAuraAPi.CreateDataApi(ApiEndPoint: "updateOfferCopyCount",body: body).then((UpadteCOunt) {});
                                          }
                                        }

                                        selectedTap.toUpperCase().toString().toUpperCase() == "TEMPLATE" ?
                                        Constants.showToastAtBottom("Template Created"):  Constants.showToastAtBottom("Offer Created");

                                        DataManager.getInstance().getUserIsPlaceType().toString() == "true" ?  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 4),), (route) => false):  KycDataList.isEmpty || KycDataList.length == 1
                                            ?
                                        MessageShowDialogWithText(context,
                                            Text("Please add atleast two KYC documents to publish",textAlign: TextAlign.center,style: BlackTitle500height,)
                                            ,(){
                                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 4),), (route) => false);
                                            }): Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 4),), (route) => false);

                                     //   Navigator.pop(context,false);
                                        // showDialog(
                                        //   context: context,
                                        //   builder: (context) {
                                        //     return  StatefulBuilder(builder: (context, setState) {
                                        //       return Dialog(
                                        //         alignment: Alignment.center,
                                        //         elevation: BorderSide.strokeAlignOutside,
                                        //         child: Container(
                                        //           height:MediaQuery.of(context).size.height*0.25,
                                        //           width: isMobile?width*0.8:tabWidth*0.8,
                                        //           decoration:  BoxDecoration(color: Color(
                                        //               0x1A52B46B)),
                                        //           child: Column(
                                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //             children: [
                                        //
                                        //               Padding(
                                        //                 padding: const EdgeInsets.only(top: 40),
                                        //                 child: SizedBox(
                                        //                   width: isMobile?width*0.5:tabWidth*0.5,
                                        //                   child: Center(
                                        //                     child: RichText(
                                        //                       textAlign: TextAlign.center,
                                        //                       text:  TextSpan(
                                        //                           children: [
                                        //                             TextSpan(text: 'Your ${    selectedTap.toString().toUpperCase() == "TEMPLATE" ? "Template": selectedTap.toString().toUpperCase().trim() == "DELIVER"?_currentTapindex==0?"DELIVER BUY":"DELIVER SELL":_currentTapindex == 0 ?"Buy":"Sell"} Offers', style: BlackTitle500height),
                                        //                             TextSpan(text: ' Is Published.', style:BlackTitle500height),
                                        //                           ]
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //               Padding(
                                        //                 padding: const EdgeInsets.only(bottom: 20),
                                        //                 child: ElevatedButton(
                                        //                     style: ElevatedButton.styleFrom(
                                        //                         padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 2),
                                        //                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor:Constants.primaryColor1, elevation: 1),
                                        //                     onPressed: () {
                                        //                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 4),), (route) => false);
                                        //                     },
                                        //                     child: Text("ok",style: WhiteButtonStyle,)),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       );
                                        //     },);
                                        //   },).then((value) {
                                        //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 4),), (route) => false);
                                        // });
                                      }
                                      else if(data["status"] == 400){
                                        setState(() {
                                          PublishLoader = false;
                                        });
                                        MessageShowDialogWithText(context,
                                            Text("${data["message"]}",textAlign: TextAlign.center,style: BlackTitle500height,)
                                            ,(){
                                               Navigator.pop(context);
                                            });
                                        }
                                      else if(data["status"] == "401"){
                                        log(data["status"]);
                                        setState(() {
                                          PublishLoader = false;
                                        });
                                        var ques = data["message"];
                                        List keys = ques.keys.toList();
                                        List value = ques.values.first.toList();
                                        MessageShowDialogWithText(context,
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                itemCount: keys.length,
                                                itemBuilder: (context, index) {
                                                  var ke = keys[index];
                                                  var vv = value[index];
                                                  return Text("${ke} : ${vv}",textAlign: TextAlign.center,style: BlackBottomHeadStyle18500,);
                                                },
                                               )
                                            ,(){
                                              Navigator.pop(context);
                                            });
                                      }else{
                                        setState(() {
                                          PublishLoader = false;
                                        });
                                        Constants.showToast("${data["message"]}");
                                      }

                                    }else if(response.statusCode == 500){

                                      Navigator.pop(context);
                                    }
                                    else{

                                      Navigator.pop(context);
                                    }
                                  }).then((value) {
                                    setState((){
                                      PublishLoader =false;
                                    });
                                  });
                                },);
                              }
                            }
                          },);
                        },
                        child:PublishLoader == true?SizedBox(height:15,width: 15,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2.5,)):    Text("PUBLISH",style: WhiteButtonStyle16500,)),
                    Container(
                      height: 45,
                      width: 45,
                      margin: const EdgeInsets.only(bottom: 5,right: 20),
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Constants.greyDark
                      ),
                      child: Center(child: Container(
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
  // TODO Other Methods
  void preFillOffer(context,{required FiltterOfferDetailsModel data}){
    if(data.offerConditions == null){
      Constants.showToast("Offer Conditions not found");
    }else{
      if(mounted){
        setState((){
          isLoadingFillOffer = true;
        });
      }
      ItemsList.clear();

      Future.delayed(Duration(milliseconds: 50),() async{
        final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
        final fromPeriodDate = data.offerConditions!.fromperiod== null ?"":data.offerConditions!.fromperiod.toString();
        final fromPeriodTime = data.offerConditions!.fromperiodtime==null?"":data.offerConditions!.fromperiodtime.toString();
        final toPeriodDate = data.offerConditions!.toperiod == null ?"": data.offerConditions!.toperiod.toString();
        final toPeriodTime = data.offerConditions!.toperiodtime == null?"": data.offerConditions!.toperiodtime.toString();

        setState(() {
          isNewOfferNow = false;
          isLoadingFillOffer = true;
          DisplayName = sharedpreferences.getString("UserDisplayName")??"";
          searchCategoryController.text = data.category!.name.toString();
          searchSegmentController.text =  data.segment!.name.toString();
          searchSubSegmentController.text = data.subsegment!.name.toString();
          searchCategoryId = data.category!.id.toString();
          searchSegmentId = data.segment!.id.toString();
          searchSubSegmentId =  data.subsegment!.id.toString();
          OfferInstruction1Controller.text = "";
          // OfferInstruction2Controller.text = "";
          //adressLocationController.text =  data.addres.toString();
          selectedTap = "New";
          _currentTapindex = data.buyORsell.toString() == "BUY"?0:1;
          selectedPeriodicityValue = data.offerConditions!.periodicity.toString()=="null"?"": data.offerConditions!.periodicity.toString().trim();
          selectedValuePriority = data.offerConditions!.priority.toString() == "null"?"": data.offerConditions!.priority.toString().trim();
       //   OfferDurationController.text = data.offerConditions!.duration==null?"": data.offerConditions!.duration.toString();
          OfferDurationController.text = "";
          isSinglePeriodSelect = true;
          OfferFromLocationController.text =  data.offerConditions!.fromlocation.toString();
          OfferToLocationController.text =  data.offerConditions!.tolocation.toString();
          OfferAtLocationController.text =  data.offerConditions!.atlocation.toString();
          isViewOfferFormLocation=true;
          isViewOfferToLocation=true;
          isViewOfferAtLocation=true;

          if( data.offerConditions!.expiry ==null || data.offerConditions!.expiry.toString() == "null" ||  data.offerConditions!.expiry == ""){
            DateTime now = DateTime.now();
            var NewDate =  "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}";
            OfferExpiryController.text = NewDate;
            offerExpiryDateTime = NewDate;
          }else{
            DateTime OExpiry = DateFormat('dd/MM/yyyy HH:mm:ss').parse('${  data.offerConditions!.expiry.toString().replaceAll("-","/")}:00');
            bool isOldDate = OExpiry.isBefore(DateTime.now());
            if(isOldDate){
              DateTime now = DateTime.now();
              var NewDate =  "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}";
              OfferExpiryController.text = NewDate;
              offerExpiryDateTime = NewDate;
            }else{
              OfferExpiryController.text =  data.offerConditions!.expiry.toString();
              offerExpiryDateTime = data.offerConditions!.expiry.toString();
            }
          }
          if(selectedPeriodicityValue == ""){
            selectedPeriodicityValue = "Today";
            final  STime = DateFormat('hh:mm a').format(DateTime.now());
            OfferPeriodTimeController.text = "${STime}";
            offerPeriodFromTime="";
            offerPeriodToTime="";
            final  STime24 = DateFormat('HH:mm').format(DateTime.now());
            offerPeriodFromTime = STime24.toString();
            OfferFromTime = DateTime.now();

            OfferToTime = DateTime.now().add(Duration(minutes: 2));
          }else{
            if(selectedPeriodicityValue == "Today" || selectedPeriodicityValue == "Tomorrow"){
              final  STime = DateFormat('hh:mm a').format(DateTime.now());
              OfferPeriodTimeController.text = "${STime}";
              offerPeriodFromTime="";
              offerPeriodToTime="";
              final  STime24 = DateFormat('HH:mm').format(DateTime.now());
              offerPeriodFromTime = STime24.toString();
              OfferFromTime = DateTime.now();
              OfferToTime = DateTime.now().add(Duration(minutes: 2));
            }else{
              if( data.offerConditions!.fromperiod == null || data.offerConditions!.fromperiod.toString() == "" ){
                final  STime = DateFormat('dd-MMM-yyyy').format(DateTime.now());
                OfferPeriodController.text = "${STime}";
                final  SDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                offerPeriodFromTime="";
                offerPeriodFromDate="";
                offerPeriodToDate="";
                offerPeriodToTime="";
                offerPeriodFromDate = SDate.toString();
                OfferFromDate  = DateTime.now();
                final  TimeF = DateFormat('hh:mm a').format(DateTime.now());
                OfferPeriodTimeController.text = "${TimeF}";
                offerPeriodFromTime="";
                offerPeriodToTime="";
                final  STime24 = DateFormat('HH:mm').format(DateTime.now());
                offerPeriodFromTime = STime24.toString();
                OfferFromTime = DateTime.now();
                OfferToTime = DateTime.now().add(Duration(minutes: 2));
              }
              else{
                DateTime OPeriodDate = data.offerConditions!.fromperiodtime == null || data.offerConditions!.fromperiodtime.toString() == "null" || data.offerConditions!.fromperiodtime.toString() == ""?
                DateFormat('dd/MM/yyyy HH:mm:ss').parse('${  data.offerConditions!.fromperiod.toString().replaceAll("-","/")} 00:00:00'):
                DateFormat('dd/MM/yyyy HH:mm:ss').parse('${  data.offerConditions!.fromperiod.toString().replaceAll("-","/")} ${data.offerConditions!.fromperiodtime}');
                bool isOldDate = OPeriodDate.isBefore(DateTime.now());
                if(isOldDate){
                  final  STime = DateFormat('dd-MMM-yyyy').format(DateTime.now());
                  OfferPeriodController.text = "${STime}";
                  final  SDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
                  offerPeriodFromTime="";
                  offerPeriodFromDate="";
                  offerPeriodToDate="";
                  offerPeriodToTime="";
                  offerPeriodFromDate = SDate.toString();
                  OfferFromDate  = DateTime.now();
                  final  TimeF = DateFormat('hh:mm a').format(DateTime.now());
                  OfferPeriodTimeController.text = "${TimeF}";
                  offerPeriodFromTime="";
                  offerPeriodToTime="";
                  final  STime24 = DateFormat('HH:mm').format(DateTime.now());
                  offerPeriodFromTime = STime24.toString();
                  OfferFromTime = DateTime.now();
                  OfferToTime = DateTime.now().add(Duration(minutes: 2));
                }else{
                  OfferPeriodTimeController.text = "${fromPeriodTime=="" && toPeriodTime==""?"": toPeriodTime != ""? fromPeriodTime +" To "+toPeriodTime :  fromPeriodTime}";
                  OfferPeriodController.text = "${fromPeriodTime=="" && toPeriodDate=="" ?"": toPeriodDate !=  ""? fromPeriodDate+" To " + toPeriodDate : fromPeriodDate}";
                  offerPeriodFromDate =  data.offerConditions!.fromperiod == null ? "": data.offerConditions!.fromperiod;
                  offerPeriodToDate = data.offerConditions!.toperiod == null ? "": data.offerConditions!.toperiod;
                  offerPeriodFromTime = data.offerConditions!.fromperiodtime == null ? "": "${data.offerConditions!.fromperiodtime.toString().split(":")[0]}:${data.offerConditions!.fromperiodtime.toString().split(":")[1]}";
                  offerPeriodToTime = data.offerConditions!.toperiodtime == null ? "": "${data.offerConditions!.toperiodtime.toString().split(":")[0]}:${data.offerConditions!.toperiodtime.toString().split(":")[1]}";
                  DateTime FromDatePeriod = fromPeriodDate == ""  ? DateTime.now().add(Duration(days: 60)) :
                  fromPeriodTime == "" ?DateFormat('dd/MM/yyyy HH:mm:ss').parse('${fromPeriodDate.replaceAll("-","/")} 00:00:00.000'):
                  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${fromPeriodDate.replaceAll("-","/")} $fromPeriodTime');
                  DateTime toDatePeriod = toPeriodDate == "" ?DateTime.now().add(Duration(days: 60)) :
                  toPeriodTime == ""? DateFormat('dd/MM/yyyy HH:mm:ss').parse('${toPeriodDate.replaceAll("-","/")} 00:00:00.000'):
                  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${toPeriodDate.replaceAll("-","/")} $toPeriodTime');
                  OfferFromDate =   FromDatePeriod;
                  OfferToDate = toDatePeriod;
                  DateTime FromTimePeriod = selectedPeriodicityValue.toString().toUpperCase() == "TODAY" ? fromPeriodTime != "" ?  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().day.toString().length == 1 ?"0${DateTime.now().day}":DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} $fromPeriodTime') : DateTime.now().add(Duration(days: 1)) :
                  selectedPeriodicityValue.toString().toUpperCase() == "TOMORROW" ? fromPeriodTime != "" ?  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().add(Duration(days: 1)).day.toString().length == 1 ?"0${DateTime.now().add(Duration(days: 1)).day}":DateTime.now().add(Duration(days: 1)).day}/${DateTime.now().month}/${DateTime.now().year} $fromPeriodTime'): DateTime.now().add(Duration(days: 1)): DateTime.now().add(Duration(days: 1));
                  OfferFromTime = FromTimePeriod;
                  DateTime ToTimePeriod = selectedPeriodicityValue.toString().toUpperCase() == "TODAY" ? toPeriodTime != "" ? DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().day.toString().length == 1 ?"0${DateTime.now().day}":DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} $toPeriodTime') : DateTime.now().add(Duration(days: 1)) :
                  selectedPeriodicityValue.toString().toUpperCase() == "TOMORROW" ? toPeriodTime != "" ? DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().add(Duration(days: 1)).day.toString().length == 1 ?"0${DateTime.now().add(Duration(days: 1)).day}":DateTime.now().add(Duration(days: 1)).day}/${DateTime.now().month}/${DateTime.now().year} $toPeriodTime') : DateTime.now().add(Duration(days: 1)): DateTime.now().add(Duration(days: 1));
                  OfferToTime = ToTimePeriod;
                }

              }
            }
          }


        });
        for(var i = 0 ; i<data.offerItems!.length ; i++){
          List<UnitListData> TempUnitList = [];
          List selectedItemsPersonList = [];
          selectedItemsPersonList = data.offerItems![i].offerItemConditions!.servicepersons!.isEmpty || data.offerItems![i].offerItemConditions!.servicepersons == null? []: data.offerItems![i].offerItemConditions!.servicepersons!.map((e) =>e).toList();
          final fromPeriodDate = data.offerItems![i].offerItemConditions!.fromperiod== null ?"":data.offerItems![i].offerItemConditions!.fromperiod.toString();
          final fromPeriodTime = data.offerItems![i].offerItemConditions!.fromperiodtime==null?"":data.offerItems![i].offerItemConditions!.fromperiodtime.toString();
          final toPeriodDate = data.offerItems![i].offerItemConditions!.toperiod == null ?"": data.offerItems![i].offerItemConditions!.toperiod.toString();
          final toPeriodTime = data.offerItems![i].offerItemConditions!.toperiodtime== null?"": data.offerItems![i].offerItemConditions!.toperiodtime.toString();



          final imageMedia = [];
          final fileUrls = [];
          for(var j = 0 ; j< data.offerItems![i].itemMedia!.length ; j++){
            imageMedia.add({
              "file":"${data.offerItems![i].itemMedia![j].id}",
              "name": "${data.offerItems![i].itemMedia![j].name}"
            });
            fileUrls.add(
                "${data.offerItems![i].itemMedia![j].file}"
            );
          }
          // String ExDateForFill = "";
          // if(  data.offerItems![i].offerItemConditions!.expiry ==null ||  data.offerItems![i].offerItemConditions!.expiry.toString() == "null" ||  data.offerItems![i].offerItemConditions!.expiry == ""){
          //   ExDateForFill = "";
          // }else{
          //   DateTime OExpiry = DateFormat('dd/MM/yyyy HH:mm:ss').parse('${  data.offerItems![i].offerItemConditions!.expiry.toString().replaceAll("-","/")}:00');
          //   bool isOldDate = OExpiry.isBefore(DateTime.now());
          //   if(isOldDate){
          //     DateTime now = DateTime.now();
          //     var NewDate =  "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}";
          //     ExDateForFill = NewDate;
          //   }else{
          //     ExDateForFill =  data.offerItems![i].offerItemConditions!.expiry.toString();
          //   }
          // }



          String ExpiryDate = "";
          final ExDTimeItem ;
          if(data.offerItems![i].offerItemConditions!.expiry == null || data.offerItems![i].offerItemConditions!.expiry == ""){
            DateTime now = DateTime.now();
            var NewDate =  "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}";
            ExpiryDate = NewDate;
            ExDTimeItem = null;
          }else{
            DateTime OExpiry = DateFormat('dd/MM/yyyy HH:mm:ss').parse('${ data.offerItems![i].offerItemConditions!.expiry.toString().toString().replaceAll("-","/")}:00.000');
            bool isOldDate = OExpiry.isBefore(DateTime.now());
            if(isOldDate){
              DateTime now = DateTime.now();
              var NewDate =  "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}";
              ExpiryDate = NewDate;
              ExDTimeItem = null;
            }else{
              ExpiryDate = data.offerItems![i].offerItemConditions!.expiry.toString();
              ExDTimeItem = DateFormat('dd/MM/yyyy HH:mm:ss').parse('${ data.offerItems![i].offerItemConditions!.expiry.toString().replaceAll("-","/")}:00');
            }
          }
          String periodController = "";
          String periodTimeController = "";
          String ApiFromDate = "";
          String ApiToDate = "";
          String ApiFromTIme = "";
          String ApiToTIme = "";
          DateTime ? FillFromDate ;
          DateTime ?FillFromTime ;
          DateTime ?FillToDate ;
          DateTime ?FillToTime ;

          if(data.offerItems![i].offerItemConditions!.periodicity == ""){

            final  STime = DateFormat('hh:mm a').format(DateTime.now());
            periodTimeController = "${STime}";

            final  STime24 = DateFormat('HH:mm').format(DateTime.now());
            ApiFromTIme = STime24.toString();
            FillFromTime = DateTime.now();
          }else{
            if(data.offerItems![i].offerItemConditions!.periodicity == "Today" || data.offerItems![i].offerItemConditions!.periodicity == "Tomorrow"){
              final  STime = DateFormat('hh:mm a').format(DateTime.now());
              periodTimeController = "${STime}";

              final  STime24 = DateFormat('HH:mm').format(DateTime.now());
              ApiFromTIme = STime24.toString();
              FillFromTime = DateTime.now();
            }else{
              if(data.offerItems![i].offerItemConditions!.fromperiod == null ||  data.offerItems![i].offerItemConditions!.fromperiod.toString() == "" ){
                final  STime = DateFormat('dd-MMM-yyyy').format(DateTime.now());
                periodController = "${STime}";
                final  SDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

                ApiFromDate = SDate.toString();
                FillFromDate  = DateTime.now();
                final  TimeF = DateFormat('hh:mm a').format(DateTime.now());
                periodTimeController = "${TimeF}";

                final  STime24 = DateFormat('HH:mm').format(DateTime.now());
                ApiFromTIme = STime24.toString();
                FillFromTime = DateTime.now();
              }
              else{


                DateTime OPeriodDate = data.offerItems![i].offerItemConditions!.fromperiodtime == null ||data.offerItems![i].offerItemConditions!.fromperiodtime.toString() == "null" || data.offerItems![i].offerItemConditions!.fromperiodtime.toString() == ""?

                DateFormat('dd/MM/yyyy HH:mm:ss').parse('${ data.offerItems![i].offerItemConditions!.fromperiod.toString().replaceAll("-","/")} 00:00:00'):
                DateFormat('dd/MM/yyyy HH:mm:ss').parse('${  data.offerItems![i].offerItemConditions!.fromperiod.toString().replaceAll("-","/")} ${data.offerItems![i].offerItemConditions!.fromperiodtime}');
                bool isOldDate = OPeriodDate.isBefore(DateTime.now());
                if(isOldDate){
                  final  STime = DateFormat('dd-MMM-yyyy').format(DateTime.now());
                  periodController = "${STime}";
                  final  SDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

                  ApiFromDate = SDate.toString();
                  FillFromDate  = DateTime.now();
                  final  TimeF = DateFormat('hh:mm a').format(DateTime.now());
                  periodTimeController = "${TimeF}";

                  final  STime24 = DateFormat('HH:mm').format(DateTime.now());
                  ApiFromTIme = STime24.toString();
                  FillFromTime = DateTime.now();
                }else{
                  periodTimeController = "${fromPeriodTime=="" && toPeriodTime==""?"": toPeriodTime != ""?fromPeriodTime +" To "+toPeriodTime :fromPeriodTime}";
                  periodController = "${fromPeriodTime=="" && toPeriodDate=="" ?"": toPeriodDate !=  ""?fromPeriodDate+" To " + toPeriodDate :fromPeriodDate}";
                  ApiFromDate = data.offerItems![i].offerItemConditions!.fromperiod == null ? "": data.offerItems![i].offerItemConditions!.fromperiod.toString();
                  ApiToDate = data.offerItems![i].offerItemConditions!.toperiod == null ? "": data.offerItems![i].offerItemConditions!.toperiod.toString();
                  ApiFromTIme = data.offerItems![i].offerItemConditions!.fromperiodtime == null ? "": "${data.offerItems![i].offerItemConditions!.fromperiodtime.toString().split(":")[0]}:${data.offerItems![i].offerItemConditions!.fromperiodtime.toString().split(":")[1]}";
                  ApiToTIme = data.offerItems![i].offerItemConditions!.toperiodtime == null ? "": "${data.offerItems![i].offerItemConditions!.toperiodtime.toString().split(":")[0]}:${data.offerItems![i].offerItemConditions!.toperiodtime.toString().split(":")[1]}";
                  DateTime FromDatePeriod = fromPeriodDate == ""  ? DateTime.now().add(Duration(days: 60)) :
                  fromPeriodTime == "" ?DateFormat('dd/MM/yyyy HH:mm:ss').parse('${fromPeriodDate.replaceAll("-","/")} 00:00:00.000'):
                  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${fromPeriodDate.replaceAll("-","/")} $fromPeriodTime');
                  DateTime toDatePeriod = toPeriodDate == "" ?DateTime.now().add(Duration(days: 60)) :
                  toPeriodTime == ""? DateFormat('dd/MM/yyyy HH:mm:ss').parse('${toPeriodDate.replaceAll("-","/")} 00:00:00.000'):
                  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${toPeriodDate.replaceAll("-","/")} $toPeriodTime');
                  FillFromDate =   FromDatePeriod;
                  FillToDate = toDatePeriod;
                  DateTime FromTimePeriod = data.offerItems![i].offerItemConditions!.periodicity.toString().toUpperCase() == "TODAY" ? fromPeriodTime != "" ?  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().day.toString().length == 1 ?"0${DateTime.now().day}":DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} $fromPeriodTime') : DateTime.now().add(Duration(days: 1)) :
                  data.offerItems![i].offerItemConditions!.periodicity.toString().toUpperCase() == "TOMORROW" ? fromPeriodTime != "" ?  DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().add(Duration(days: 1)).day.toString().length == 1 ?"0${DateTime.now().add(Duration(days: 1)).day}":DateTime.now().add(Duration(days: 1)).day}/${DateTime.now().month}/${DateTime.now().year} $fromPeriodTime'): DateTime.now().add(Duration(days: 1)): DateTime.now().add(Duration(days: 1));
                  FillFromTime = FromTimePeriod;
                  DateTime ToTimePeriod = selectedPeriodicityValue.toString().toUpperCase() == "TODAY" ? toPeriodTime != "" ? DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().day.toString().length == 1 ?"0${DateTime.now().day}":DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} $toPeriodTime') : DateTime.now().add(Duration(days: 1)) :
                  data.offerItems![i].offerItemConditions!.periodicity.toString().toUpperCase() == "TOMORROW" ? toPeriodTime != "" ? DateFormat('dd/MM/yyyy HH:mm:ss').parse('${DateTime.now().add(Duration(days: 1)).day.toString().length == 1 ?"0${DateTime.now().add(Duration(days: 1)).day}":DateTime.now().add(Duration(days: 1)).day}/${DateTime.now().month}/${DateTime.now().year} $toPeriodTime') : DateTime.now().add(Duration(days: 1)): DateTime.now().add(Duration(days: 1));
                  FillToTime = ToTimePeriod;
                }

              }
            }
          }
          ItemsList.add({
            "itemId" :"",
            "itemDisableFields":[],
            "name":TextEditingController(text: data.offerItems![i].name.toString()),
            "desc":TextEditingController(text: data.offerItems![i].desc.toString()),
            "price":TextEditingController(text: data.offerItems![i].price.toString() == "null"? "": data.offerItems![i].price.toString()),
            "unit":TextEditingController(text:  data.offerItems![i].unit!.name.toString() == "null"?"": data.offerItems![i].unit!.name.toString()),
            "AdvancePrice" : TextEditingController(text :data.offerItems![i].advancePrice == null ? "":  data.offerItems![i].advancePrice.toString()),
            "AdvanceUnit" : TextEditingController(text :data.offerItems![i].advanceUnit!.name == null ? "" :  data.offerItems![i].advanceUnit!.name.toString()),
            "MaintenancePrice" : TextEditingController(text :  data.offerItems![i].maintenancePrice == null ? "": data.offerItems![i].maintenancePrice.toString()),
            "MaintenanceUnit" : TextEditingController(text : data.offerItems![i].maintenanceUnit!.name == null ? "" : data.offerItems![i].maintenanceUnit!.name.toString()),
            "filterGetUnitList" : TempUnitList,
            "showOtherUnit" : false,
            "isLoadNewUnit" : false,
            "selectedUnitIndex" : -1,
            "SelectedUnitId" : data.offerItems![i].unit == null ? null : data.offerItems![i].unit!.id.toString() ,
            "filterGetUnitListMain" : TempUnitList,
            "showOtherUnitMain" : false,
            "isLoadNewUnitMain" : false,
            "selectedUnitIndexMain" : -1,
            "SelectedUnitIdMain" : data.offerItems![i].maintenanceUnit == null ? null :data.offerItems![i].maintenanceUnit!.id.toString(),

            "filterGetUnitListAdva" : TempUnitList,
            "showOtherUnitAdva" : false,
            "isLoadNewUnitAdva" : false,
            "selectedUnitIndexAdva" : -1,
            "SelectedUnitIdAdva" :  data.offerItems![i].advanceUnit == null ? null :data.offerItems![i].advanceUnit!.id.toString(),
            "fillSelectedPerson" : selectedItemsPersonList,
            "type" : "old",
            "quantity": data.offerItems![i].quantity,
            "currency":"INR",
            "addon":false,
            "required":false,
            "toggle_state":false,
            "media":imageMedia,
            "isLoadingFile":false,
            "fileUrl":fileUrls,

            "item_condition":{
              "itemDisableFields":[],
              "item_condition":"",
              "periodicity":data.offerItems![i].offerItemConditions!.periodicity.toString() == "null"? "": data.offerItems![i].offerItemConditions!.periodicity.toString(),
              "priority":data.offerItems![i].offerItemConditions!.priority.toString()  == "null" ? "": data.offerItems![i].offerItemConditions!.priority.toString(),
              "periodTime":TextEditingController(text:"${periodTimeController}"),
              "period":TextEditingController(text:  "${periodController}"),

              "fromperiod": ApiFromDate,
              "toperiod": ApiToDate,
              "duration": TextEditingController(text: data.offerItems![i].offerItemConditions!.duration.toString() == "" ||  data.offerItems![i].offerItemConditions!.duration.toString() == "null" ?"": data.offerItems![i].offerItemConditions!.duration.toString()),
              "fromperiodtime":ApiFromTIme,
              "toperiodtime":ApiToTIme, "durationoftime":"",
              "fromlocation":TextEditingController(text: data.offerItems![i].offerItemConditions!.fromlocation.toString() == "null" ?"": data.offerItems![i].offerItemConditions!.fromlocation.toString()),
              "tolocation":TextEditingController(text: data.offerItems![i].offerItemConditions!.tolocation.toString() == "null" ?"": data.offerItems![i].offerItemConditions!.tolocation.toString()),
              "atlocation":TextEditingController(text: data.offerItems![i].offerItemConditions!.atlocation.toString() == "null" ?"": data.offerItems![i].offerItemConditions!.atlocation.toString()),
              "servicepersons":selectedItemsPersonList,
              "expiry": TextEditingController(text:ExpiryDate),
              "ExpiryDateTime" : ExDTimeItem,
              "FromPeriodDateFill" : FillFromDate,
              "ToPeriodDateFill" : FillToDate,
              "FromPeriodTimeFill" : FillFromTime,
              "ToPeriodTimeFIll" : FillToTime,
            },
            "isShowItem": true,
            "showItemPriceMain":true,
            "showItemQty":true,
            "showMediaData":true,
            "showItemPrice2":false,
            "showItemPrice3":false,
            "showItemCondition": false,
            "showItemPeriodicity" :true,
            "showItemPeriod" :true,
            "showItemPeriodTime" :true,
            "isItemSinglePeriodSelect" :true,
            "showItemDuration" :true,
            "showItemServicePerson1" :true,
            "showItemServicePerson2" :false,
            "showItemServicePerson3" :false,
            "showItemServicePerson4" :false,
            "showItemServicePerson5" :false,
            "showItemPriority" :true,
            "showItemExpiry" :true,
            "showItemFromLocation" :true,
            "showItemTOLocation" :false,
            "showItemAtLocation" :false,
            "showOfferBids1" :true,
            "showOfferBids2" :false,
          });
        }
        Future.delayed(Duration(seconds: 2),() {
          if(mounted){
            setState(() {
              isLoadingFillOffer=false;
            });
          }
        },);
      },);
    }
  }

  onSearchTextChanged(String text) async {

    setState(() {
      filterOfferNameList = filterOfferNameMainList.where((name) => name.offerItems!.first.name!.toLowerCase().contains(text.toLowerCase())).toList();
    });

  }

  Widget FillBuilder(context,setModalState,{required List<FiltterOfferDetailsModel> filterList,required Color bgColor,required String by}){
    print("");
    return Card(
      elevation:2,
      margin:EdgeInsets.symmetric(horizontal: 25,vertical:5),
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical:7.0,horizontal: 10),
                child: Text("Click to prefill the related offer details",style:BlackColor13600Style),
              ),
              Spacer(),
              InkWell(
                  onTap:(){
                    setState((){

                       if(by == "Cat"){
                         filterOfferbyCatList = [];

                       }else if(by == "Seg"){

                         filterOfferbySegList = [];
                       }else if(by == "SubSeg"){

                         filterOfferbySubSegList = [];
                       }else if(by == "Item"){
                         OfferListByName = [];
                       }


                    });
                    setModalState((){});
                  },
                  child:Icon(Icons.close,color:Colors.black,size:20)
              ),
              10.width
            ],
          ),
          Divider(
              height:2,
              color:Colors.black87,thickness:0.8
          ),
          SizedBox(
            height: filterList.length > 6 ?MediaQuery.of(context).size.height*0.25 :null,
            child: ListView.builder(
              itemCount:filterList.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 7),
              itemBuilder: (context, index) {
                var data = filterList[index];
                return NewOfferFillList(searchText: "${data.slug}",EndText:  data.offertemplate == true ? " TEMPLATE" :
                data.offerstatus.toString().trim().toUpperCase() == "CLOSED"?
                " CLOSED": " OPEN",onTap:
                    () {
                  preFillOffer(context,data: data);
                  setState((){

                    if(by == "Cat"){
                      filterOfferbyCatList = [];
                      Navigator.pop(context); 
                    }else if(by == "Seg"){
                      filterOfferbySegList = [];
                      Navigator.pop(context);
                    }else if(by == "SubSeg"){
                      filterOfferbySubSegList = [];
                      Navigator.pop(context);
                    }else if(by == "Item"){
                      OfferListByName = [];
                      Navigator.pop(context);
                    }
                  });
                  

                },
                );
              },),
          ),
        ],
      ),
    );
  }
}


