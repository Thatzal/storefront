import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loader.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/constant/text_form_feild.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/controller/share_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapps/screens/Dashboard/dashboard_screen.dart';
import '../../common/style.dart';
import '../../model/GetAdressListModal.dart';
import 'current_location_picker.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';

class ManageAddressScreen extends StatefulWidget {
  String from ;
   ManageAddressScreen({Key? key,required this.from}) : super(key: key);

  @override
  State<ManageAddressScreen> createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  int borderColor = -1;
  List<GetAdressListResult> GetAdressList=[];
  bool loader =false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserLocation();
    load();
  }

  load(){
    setState(() {
      loader=true;
    });
     DrawAuraAPi().getAdressListApi().then((value) {
       GetAdressList.clear();
         for(var i = 0 ; value.result!.length > i;i++){
           GetAdressList.add(value.result![i]);
         }
       setState(() {
         loader=false;
       });
     });
    getSaveAddress();
  }
  var SaveAddress;
  var SaveAddressId;
  getSaveAddress() async {
    final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
   if(mounted){
     setState(() {
       SaveAddress = sharedpreferences.getString("SaveAddress");
       SaveAddressId = sharedpreferences.getString("SaveAddressId");
     });
   }

  }
  late LatLng currentPostion;
  late LatLng pickedPosition;
  String? pickedAdress;
  var lat;
  var long;
  String currentAddress = "Current address loading...";
  bool addLoader = false;
  void _getUserLocation() async {
    await Permission.location.request();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPostion = LatLng(position.latitude, position.longitude);
    lat = currentPostion.latitude;
    long = currentPostion.longitude;
    addLoader = false;
    var addresses = await getAddressFromLatLong(position.latitude.toString(),position.longitude.toString());
    var first = addresses;
    if(mounted){
      setState(() {
        currentAddress = first.toString();
      });
    }
  }
  final List<String> adressList = [
    'Home',
    'Work',
    'Hotel',
    'Other',
  ];

  int addressValue =0;
  String? Adress;

  TextEditingController buildingNameController = TextEditingController();
  TextEditingController LandmarkNameController = TextEditingController();
  TextEditingController updateAddressAsController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  bool isAddressSaveAsOther = false;
  bool isSaveAddressLoader = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {

        widget.from =="setting"?Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 1,),), (route) => false):Navigator.pop(context);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
        body: responsiveContainer(context, ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
            Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(

            titleSpacing: 5,
            title:Text(widget.from =="setting"?"My Address":"Select a location",style: AppBarTitle),
            toolbarHeight: 50,
            automaticallyImplyLeading: false,
            leading: InkWell(
                onTap: (){
                  widget.from =="setting"?    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 1,),), (route) => false):Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back,color: Colors.black,size: 24,)),
            iconTheme: IconThemeData(color: Color(0xFF000000)),
            backgroundColor: Color(0xFFFFFFFF),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  widget.from == "setting"? SizedBox():InkWell(
                    onTap: () async {
                      if( widget.from == "Home"){
                        LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CurrentPlacePicker("${ApiUrls.mapKey}",from: "pickAddress",SaveAddressIsEmpty:GetAdressList.isEmpty?"yes":"no",isOfferCreating: widget.from == "Home"?true:false,)));
                      }else{
                        LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CurrentPlacePicker("${ApiUrls.mapKey}",from: "pickAddress",SaveAddressIsEmpty:GetAdressList.isEmpty?"yes":"no",isOfferCreating: widget.from == "Home"?true:false,)));
                      }


                      // setState(() {
                      //   currentAddress = result!.formattedAddress.toString();
                      // });
                    },
                    child:  ListTile(
                      leading: Icon(Icons.my_location, color: primaryColor,),
                      minLeadingWidth: 5,
                      title: Text("Use Your Current Location", style: PrimaryColorHeadStyle,),
                      subtitle: Text("${currentAddress}",
                        style: greyHintStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Divider(height: 1, thickness: 1,),
                  const SizedBox(height: 5,),
                  InkWell(
                    onTap: () async {
                      Permission.location.request();
                      var permissionNotificationStatus = await Permission.location.status;
                      print(permissionNotificationStatus);
                      if(permissionNotificationStatus.isGranted){
                        if( widget.from == "Home"){
                          LocationResult? result = await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CurrentPlacePicker("${ApiUrls.mapKey}",from: "AddAddress",SaveAddressIsEmpty:GetAdressList.isEmpty?"yes":"no",isOfferCreating: widget.from == "Home"?true:false))).then((value) {
                            getSaveAddress();
                          });
                        }else{
                          LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CurrentPlacePicker("${ApiUrls.mapKey}",from: "AddAddress",SaveAddressIsEmpty:GetAdressList.isEmpty?"yes":"no",isOfferCreating: widget.from == "Home"?true:false))).then((value) {
                            getSaveAddress();
                          });
                        }
                      }else {
                        Permission.location.request().then((value) async {
                          //print("permission is NOT granted.");
                          if (value.index == 1) {
                            if( widget.from == "Home"){
                              LocationResult? result = await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CurrentPlacePicker("${ApiUrls.mapKey}",from: "AddAddress",SaveAddressIsEmpty:GetAdressList.isEmpty?"yes":"no",isOfferCreating: widget.from == "Home"?true:false))).then((value) {
                                getSaveAddress();
                              });
                            }else{
                              LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CurrentPlacePicker("${ApiUrls.mapKey}",from: "AddAddress",SaveAddressIsEmpty:GetAdressList.isEmpty?"yes":"no",isOfferCreating: widget.from == "Home"?true:false))).then((value) {
                                getSaveAddress();
                              });
                            }
                          }else{
                            Constants.showToast("Please enabled location permission from setting for add address");
                          }
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                      child: Row(
                        children: const [
                          Icon(Icons.add, color:Constants.primaryColor1,),
                          SizedBox(width: 20,),
                          Text("Add address", style: PrimaryColorHeadStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  const Divider(height: 1, thickness: 1),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Saved addresses",style: BlackFieldStyleBold,),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  loader==true?const Center(child: Padding(
                    padding: EdgeInsets.only(top: 200.0),
                    child: LoadingWidget(),
                  )):
                  GetAdressList.isEmpty ?
                  Column(

                    children: [
                      40.height,
                      InkWell(
                        onTap: () async {
                          if( widget.from == "Home"){
                            LocationResult? result = await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CurrentPlacePicker("${ApiUrls.mapKey}",from: "AddAddress",SaveAddressIsEmpty:GetAdressList.isEmpty?"yes":"no",isOfferCreating: widget.from == "Home"?true:false))).then((value) {
                              getSaveAddress();
                            });
                          }else{
                            LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CurrentPlacePicker("${ApiUrls.mapKey}",from: "AddAddress",SaveAddressIsEmpty:GetAdressList.isEmpty?"yes":"no",isOfferCreating: widget.from == "Home"?true:false))).then((value) {
                              getSaveAddress();
                            });
                          }

                        },
                        child: SizedBox(
                          height: 120,
                          child: OverflowBox(
                            minHeight: 120,
                            maxHeight: 120,
                            child: Lottie.asset('assets/add_address.json'),
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        child: Center(child: Text("Your saved addresses is not found please add your address",style: BlackFieldStyle54,textAlign: TextAlign.center,)),
                      ),
                    ],
                  )
                      :
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: GetAdressList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = GetAdressList[index];
                      return GestureDetector(
                          onTap: (){
                            setState(() {
                              SaveAddressId=data.id.toString().trim();
                              Fluttertoast.showToast(
                                  msg: "Address selected!!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Constants.primaryColor1,
                                  textColor: Colors.white,
                                  fontSize: 18.0
                              );
                            });
                            SharePre.setAddress("${data.descriptionLine1},${data.landmark}, ${data.area},${data.pincode}",);
                            SharePre.setAddressId("${data.id}");
                            SharePre.setAddressTitle("${data.name}");
                            widget.from == "setting"?null: Navigator.pop(context,"${data.descriptionLine1},${data.landmark}, ${data.area},${data.pincode}");
                            //widget.from == "setting"?null:Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>NewOfferCreateScreen(Address:"${data.descriptionLine1}, ${data.landmark} ${data.area} ${data.city},${data.state},${data.country},${data.pincode}",AddressTitle: "${data.name}",From: "New",PrefillOfferData: PrefillOfferDataModel(), ) ,));
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                    border: Border.all(color:  SaveAddressId.toString().trim()==data.id.toString().trim()   ? Constants.primaryColor1:Color(0xFFE0E0E0),width: 1.2),borderRadius: BorderRadius.circular(5)
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          3.width,
                                          Icon(
                                            data.name.toString().trim() == "home" ||data.name.toString().trim() == "Home"?Icons.home_outlined:
                                            data.name.toString().trim() == "Work" ||data.name.toString().trim() == "work"?Icons.work:
                                            data.name.toString().trim() == "Hotel" ||data.name.toString().trim() == "hotel"?Icons.hotel:
                                            Icons.new_label_rounded,color: Colors.grey,size: 25,),
                                          SizedBox(width: 5,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("${data.name}", style: BlackSubTitleStyle,),
                                              const SizedBox(height: 2,),
                                              SizedBox(
                                                  width: ResponsiveHelper.isMobile(context)? MediaQuery.of(context).size.width*0.75:ResponsiveHelper.TabModeWidth*0.75,
                                                  child: Text("${data.descriptionLine1},${data.landmark}, ${data.area},${data.pincode}", style: BlackSubHeadingStyle,)),
                                              const SizedBox(height: 5,),

                                            ],
                                          ),


                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Positioned(
                                right: 3,top:24,
                                child: InkWell(
                                  onTap:(){},
                                  child: Container(

                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey.shade200,width: 0.8)
                                    ),
                                    child: SizedBox(
                                      height: 20,width: 20,
                                      child: InkWell(onTap: () {
                                        setState(() {
                                          DrawAuraAPi().deleteAddressApi(data.id!.toString()).then((value) {
                                            print(value);
                                            print("currentAddress +++++++++++++++++++++");
                                            if(value["status"].toString() =="200"){
                                              Fluttertoast.showToast(
                                                  msg: value['message'],
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.blueGrey,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0
                                              );
                                              load();
                                              Loading().onDone();

                                            }
                                            else {
                                              Loading().onError(msg: value['message']);
                                              Loading().onDone();
                                            }
                                          }
                                          );
                                        }
                                        );
                                      },

                                        child:Icon(Icons.delete,color: Constants.primaryColor1,size: 18,),


                                      ),

                                    ),
                                  ),
                                ),


                              ),
                              SizedBox(width: 6,),
                              Positioned(
                                right: 40,top:24,
                                child: InkWell(
                                  onTap:(){},
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey.shade200,width: 0.8)
                                    ),
                                    child: SizedBox(
                                      height: 20,width: 20,
                                      child: InkWell(onTap: () {
                                        areaController.text =  data.area == null ? "": data.area.toString();
                                       // cityController.text = data.city == null ? "":data.city.toString();
                                       // stateController.text = data.state == null ? "":data.state.toString();
                                        buildingNameController.text = data.name == null ? "":data.name.toString();
                                        pinCodeController.text = data.pincode == null ? "":data.pincode.toString();
                                        LandmarkNameController.text = data.landmark == null ? "":data.landmark.toString();
                                        // countryController.text = data.country == null ? "":data.country.toString();
                                        showModalBottomSheet<void>(
                                            isScrollControlled: true,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
                                            ),
                                            context: context,
                                            builder: (BuildContext context)
                                            {

                                              return StatefulBuilder(builder: (context, setState) {
                                                var isMobile = ResponsiveHelper.isMobile(context);
                                                var width = MediaQuery.of(context).size.width;
                                                var height = MediaQuery.of(context).size.height;
                                                var tabWidth = ResponsiveHelper.TabModeWidth;
                                                var tabHeight = ResponsiveHelper.TabModeHeight;
                                                return Container(
                                                    height: MediaQuery.of(context).size.height * 0.9,

                                                    child: Form(
                                                      key: formKey,
                                                      child: Scaffold(
                                                        backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
                                                     body: responsiveContainer(
                                                          context,
                                                          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
                                                           Scaffold(
                                                            body: SafeArea(
                                                              child: Container(
                                                                width: isMobile?width:tabWidth,
                                                                child: ListView(
                                                                  padding:
                                                                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                                                  children: <Widget>[
                                                                    Padding(
                                                                      padding: const EdgeInsets.symmetric(horizontal:0,vertical: 15),
                                                                      child: Text("Update your complete address",style: BlackBottomHeadStyle18500,),
                                                                    ),
                                                                    Divider(height: 1,color: Colors.grey.shade300,thickness: 1,),
                                                                    SizedBox(height: 15,),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text("Update address as",style: greyFieldStyle,),
                                                                        Text(" *",style: greyHintStyle,)
                                                                      ],
                                                                    ),
                                                                    SizedBox(height: 15,),
                                                                    SizedBox(
                                                                      height: 30,
                                                                      child: ListView.builder(
                                                                        physics: const ScrollPhysics(),
                                                                        shrinkWrap: true,
                                                                        itemCount: adressList.length,
                                                                        scrollDirection: Axis.horizontal,
                                                                        itemBuilder: (context, index) {
                                                                          var data = adressList[index];
                                                                          return InkWell(
                                                                            onTap: (){
                                                                              setState(() {
                                                                                addressValue=index;
                                                                                Adress=data.toString();
                                                                                index==3?isAddressSaveAsOther=true:isAddressSaveAsOther=false;
                                                                                // print(addressValue);
                                                                                // print(Adress);
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                              padding:  EdgeInsets.symmetric(horizontal: 14,vertical: 7),
                                                                              margin:  EdgeInsets.symmetric(horizontal: 3),
                                                                              decoration: BoxDecoration(
                                                                                  color:addressValue==index? Constants.primaryColor20:Colors.white,
                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                  border: Border.all(color:addressValue==index?Constants.primaryColor1:Colors.grey.shade300)),
                                                                              child: Center(child: Text("${data.toString()}",style: greyHintStyle,)),
                                                                            ),
                                                                          );
                                                                        },),
                                                                    ),
                                                                    SizedBox(height: 15,),
                                                                    isAddressSaveAsOther==true?    TextFormField(

                                                                        validator: (value) {
                                                                          if(value!.isEmpty){
                                                                            return "Enter address save as";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        controller: updateAddressAsController,
                                                                        autofocus: true,
                                                                        decoration: InputDecoration(
                                                                            isDense: true,
                                                                            contentPadding:  const EdgeInsets.symmetric(horizontal: 12,vertical:14),
                                                                            focusedBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              borderSide:   BorderSide(color: Constants.primaryColor1, width: 1.0),
                                                                            ),
                                                                            enabledBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              borderSide:   BorderSide(color: Colors.grey.shade300, width: 1.0),
                                                                            ),
                                                                            filled: true,
                                                                            fillColor: Colors.white,
                                                                            hintText: "Update save as",
                                                                            hintStyle:   greyHintStyle,
                                                                            // suffixIconConstraints: BoxConstraints(maxHeight: 20),
                                                                            border: OutlineInputBorder
                                                                              (
                                                                                borderRadius: BorderRadius.circular(5,),
                                                                                borderSide:  const BorderSide(width: 1,color: Colors.grey),gapPadding: 0)
                                                                        )
                                                                    ):SizedBox(),
                                                                    isAddressSaveAsOther==true?   const SizedBox(height: 12,):SizedBox(),
                                                                    TextFormField(
                                                                      validator: (value) {
                                                                        if(value!.isEmpty){
                                                                          return "Flat / House No / Floor / Building";
                                                                        }
                                                                        return null;
                                                                      },
                                                                      controller: buildingNameController,
                                                                      decoration: commanInputDecoration(hint:"Flat / House No / Floor / Building",isOptional: false,label: " Flat / House No / Floor / Building "),
                                                                    ),
                                                                    const SizedBox(height: 15,),

                                                                    ConstrainedBox(
                                                                      constraints: BoxConstraints(
                                                                        maxHeight: 250.0,
                                                                        minWidth: MediaQuery.of(context).size.width,
                                                                      ),
                                                                      child: TextFormField(
                                                                        maxLines: null,
                                                                        validator: (value) {
                                                                          if(value!.isEmpty){
                                                                            return "Please enter area";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        controller: areaController,
                                                                        decoration: commanInputDecoration(hint:"Area / Sector / Locality",isOptional: false,label:" Area / Sector / Locality "),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(height: 15,),
                                                                    TextFormField(
                                                                      controller: LandmarkNameController,
                                                                      decoration: commanInputDecoration(hint:"Nearby landmark (Optional)",isOptional: true,label:" Nearby landmark (Optional) "),
                                                                    ),



                                                                    SizedBox(height: 80,)
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            bottomSheet: Container(
                                                              height: 80,
                                                              decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  border: Border(
                                                                      top: BorderSide(
                                                                          color: Constants.lightGreen, width: 1.5))),
                                                              child: Center(
                                                                child:              ElevatedButton(onPressed: (){
                                                                  if(formKey.currentState!.validate()){
                                                                    setState(() {
                                                                      isSaveAddressLoader=true;
                                                                    });
                                                                    var updateAddress = {
                                                                      "id":data.id.toString(),
                                                                      "user":DataManager.getInstance().userId.toString(),
                                                                      "name": isAddressSaveAsOther == true ?updateAddressAsController.text:adressList[addressValue],
                                                                      "description_line_1":buildingNameController.text.toString(),
                                                                      "landmark":LandmarkNameController.text.toString(),
                                                                      "area":areaController.text.toString(),
                                                                      "city":cityController.text.toString(),
                                                                      "state":stateController.text.toString(),
                                                                      "country":countryController.text.toString(),
                                                                      "pincode":pinCodeController.text.toString(),
                                                                      "geolocation": "",
                                                                    };
                                                                    DrawAuraAPi().updateAddressApi(updateAddress).then((value) {
                                                                      if(value["status"]=="200"){
                                                                        Fluttertoast.showToast(
                                                                            msg: value["message"].toString(),
                                                                            toastLength: Toast.LENGTH_SHORT,
                                                                            gravity: ToastGravity.BOTTOM,
                                                                            timeInSecForIosWeb: 2,
                                                                            backgroundColor: Constants.primaryColor1,
                                                                            textColor: Colors.white,
                                                                            fontSize: 18.0
                                                                        );
                                                                        Navigator.pop(context,false);
                                                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  ManageAddressScreen(from: "setting"),));
                                                                        setState(() {
                                                                          isSaveAddressLoader=false;
                                                                        });
                                                                      }else{
                                                                        Fluttertoast.showToast(
                                                                            msg: value["message"].toString(),
                                                                            toastLength: Toast.LENGTH_SHORT,
                                                                            gravity: ToastGravity.BOTTOM,
                                                                            timeInSecForIosWeb: 2,
                                                                            backgroundColor: Colors.red,
                                                                            textColor: Colors.white,
                                                                            fontSize: 18.0
                                                                        );
                                                                        setState(() {
                                                                          isSaveAddressLoader=false;
                                                                        });
                                                                      }
                                                                    });
                                                                  }

                                                                }, style: ElevatedButton.styleFrom(
                                                                    backgroundColor:Constants.primaryColor1,elevation: 0,
                                                                    fixedSize: Size(ResponsiveHelper.isMobile(context)? MediaQuery.of(context).size.width*0.9:ResponsiveHelper.TabModeWidth*0.90, 48),
                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                                                                ),
                                                                    child: isSaveAddressLoader == false?Text("Update address",style: WhiteButtonStyle18500,):ButtonLoaderWhite()),),
                                                            ),
                                                        ),
                                                         ),
                                                      ),
                                                    ));
                                              });
                                            });
                                      },

                                        child:Icon(Icons.edit,color: Constants.primaryColor1,size: 18,),


                                      ),
                                      // child: Center(
                                      //   child: PopupMenuButton<int>(
                                      //
                                      //     itemBuilder: (context) => [
                                      //       // PopupMenuItem 1
                                      //       PopupMenuItem(
                                      //         value: 1,
                                      //         // row with 2 children
                                      //         child: Row(
                                      //           children: [
                                      //             Icon(Icons.edit),
                                      //             SizedBox(
                                      //               width: 10,
                                      //             ),
                                      //             Text("Edit")
                                      //           ],
                                      //         ),
                                      //       ),
                                      //       // PopupMenuItem 2
                                      //       PopupMenuItem(
                                      //         value: 2,
                                      //         // row with two children
                                      //         child: Row(
                                      //           children: [
                                      //             InkWell(
                                      //                 child: Icon(Icons.delete),
                                      //                  onTap: (){
                                      //                   setState(() {
                                      //                     drawauraApi().deleteAddressApi(data.id!.toString()).then((value) {
                                      //                       print(value);
                                      //                       print("currentAddress +++++++++++++++++++++");
                                      //                       if(value["status"].toString() =="200"){
                                      //                         Fluttertoast.showToast(
                                      //                         msg: value['message'],
                                      //                         toastLength: Toast.LENGTH_LONG,
                                      //                         gravity: ToastGravity.BOTTOM,
                                      //                         timeInSecForIosWeb: 1,
                                      //                         backgroundColor: Colors.blueGrey,
                                      //                         textColor: Colors.white,
                                      //                         fontSize: 16.0
                                      //                         );
                                      //                         load();
                                      //                         Loading().onDone();
                                      //
                                      //                       }
                                      //                       else {
                                      //                         Loading().onError(msg: value['message']);
                                      //                         Loading().onDone();
                                      //                       }
                                      //                     }
                                      //                     );
                                      //                   });
                                      //                 }
                                      //             ),
                                      //             SizedBox(
                                      //               width: 10,
                                      //             ),
                                      //             Text("Delete"),
                                      //           ]
                                      //         ),
                                      //       ),
                                      //
                                      //     ],
                                      //     offset: Offset(0, 70),icon: Icon(Icons.more_horiz,color: Constants.primaryColor,size: 15,),
                                      //     color: Constants.white,padding: EdgeInsets.all(0),
                                      //     elevation: 2,
                                      //     // on selected we show the dialog box
                                      //     onSelected: (value) {
                                      //       // if value 1 show dialog
                                      //
                                      //     },
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                ),
                              ),
                              SaveAddressId.toString().trim()==data.id.toString().trim()  ?
                              Positioned(
                                  right:0,top:0,
                                  child:
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 3,vertical: 1),
                                    decoration: BoxDecoration(
                                        color: Constants.primaryColor1
                                        ,borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(5))
                                    ),
                                    child: Center(child: Text(index==0?"Default":"Selected",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),),),
                                  )):SizedBox()

                            ],
                          )

                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
