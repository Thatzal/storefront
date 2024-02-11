import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker/place_picker.dart';
import 'package:place_picker/uuid.dart';
import 'package:socialapps/Apis/CommonApis.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/model/SearchPlacesModel.dart';
import 'package:socialapps/model/addressModel.dart';
import 'package:http/http.dart' as http;
import 'package:socialapps/screens/widgets/NewAddressPickers/LocationPickFromMap.dart';
import 'package:socialapps/screens/widgets/NewAddressPickers/savedAddress.dart';
import 'package:geolocator/geolocator.dart';

class NewAddressPickerList extends StatefulWidget {
  LatLng latLong ;
  bool isAppPlaceView;
  bool isTitleSelectAsAddress;
   NewAddressPickerList({super.key,required this.latLong,required this.isAppPlaceView,required this.isTitleSelectAsAddress});

  @override
  State<NewAddressPickerList> createState() => _NewAddressPickerListState();
}

class _NewAddressPickerListState extends State<NewAddressPickerList> {
  TextEditingController SearchController = TextEditingController();
  List<AddressModel> nearbyPlaces = [];

  @override
  void initState() {
    // TODO: implement initState
    if(widget.latLong == LatLng(10.5381264, 73.8827201)){
      _getCurrentLocation().then((value) {
        getNearbyPlaces(value);
      });
    }else{
      getNearbyPlaces(widget.latLong);
    }
    super.initState();
  }
  List <SearchPlacesModel> AppPlaceList = [];
  bool isGettingNearByPlace = false;
  void getNearbyPlaces(LatLng latLng) async {
    try {
      final url = Uri.parse(
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
              "key=${ApiUrls.mapKey}&location=${latLng.latitude},${latLng.longitude}"
              "&radius=150&language=en_us");
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw Error();
      }
      final responseJson = jsonDecode(response.body);
        print("responseJson");
        print(responseJson);
      if (responseJson['results'] == null) {
        throw Error();
      }
      setState(() {
        nearbyPlaces.clear();
      });
      for (Map<String, dynamic> item in responseJson['results']) {
        print("NearByApiData");
        print(item);
        print( item["geometry"]["location"]["lng"]);
        print( item["geometry"]["location"]["lat"]);
        print("item");
        final nearbyPlace = AddressModel(
          formattedAddress: item["vicinity"],
          icon: item['icon'],
          name: item['name'],
          long: item["geometry"]["location"]["lng"].toString(),
          lat: item["geometry"]["location"]["lat"].toString()
        );
        setState(() {
          nearbyPlaces.add(nearbyPlace);
        });
      }

         Future.delayed(Duration(milliseconds: 100),() {
           setState(() {
             isGettingNearByPlace = true;
           });
         },);


    } catch (e) {
      //
    }
  }
  String sessionToken = Uuid().generateV4();
  void autoCompleteSearch(String place) async {
    try {
      place = place.replaceAll(" ", "+");

      var endpoint =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
          "key=${ApiUrls.mapKey}&"
          "language=en_us&"
          "input={$place}&sessiontoken=${sessionToken}";

      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode != 200) {
        throw Error();
      }
      final responseJson = jsonDecode(response.body);
      if (responseJson['predictions'] == null) {
        throw Error();
      }
      setState(() {
        nearbyPlaces.clear();
      });
      for (Map<String, dynamic> item in responseJson['predictions']) {
        print("SerachData");
        // print(responseJson['predictions']);
        // print(item);
        // PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(item["place_id"]);
        //
        // double lat = detail.result.geometry.location.lat;
        // double lng = detail.result.geometry.location.lng;

        // print(lat);
        // print(lng);

        final nearbyPlace = AddressModel(
            formattedAddress: item["description"],
            icon: "https://cdn-icons-png.flaticon.com/128/684/684908.png",
            name: item['structured_formatting']["main_text"]
        );
        setState(() {
          nearbyPlaces.add(nearbyPlace);
        });
      }
      setState(() {
        isGettingNearByPlace = true;
      });
    } catch (e) {
      print(e);
    }
   if(widget.isAppPlaceView){
     print("CallSearchPlaceApi");
     try {
       var body = {
         "searchText":place.toString()
       };
       ThatZalApis.fromDataPost(BodyParam:body,Endpoint: ApiUrls.search_place).then((value) {
         print(value);
         print("search_place");
         if(value["status"] == "200" ){
           if(mounted){
             setState(() {
               AppPlaceList =  List.from(value["place"]).map<SearchPlacesModel>((item) => SearchPlacesModel.fromJson(item)).toList();
             });
           }
         }else{
           AppPlaceList = [];
         }
       });

     } catch (e) {
       print(e);
     }
   }


  }

  Future<LatLng> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      bool? isOk = await _showLocationDisabledAlertDialog(context);
      if (isOk ?? false) {
        return Future.error(LocationServiceDisabledException());
      } else {
        return Future.error('Location Services is not enabled');
      }
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      //return widget.defaultLocation;
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    try {
      final locationData = await Geolocator.getCurrentPosition(timeLimit: Duration(seconds: 30));
      LatLng target = LatLng(locationData.latitude, locationData.longitude);
      //moveToLocation(target);
      print('target:$target');
      return target;
    } on TimeoutException catch (e) {
      final locationData = await Geolocator.getLastKnownPosition();
      if (locationData != null) {
        return LatLng(locationData.latitude, locationData.longitude);
      } else {
        return widget.latLong;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    bool isMobile = ResponsiveHelper.isMobile(context);
    return  Scaffold(
        backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
        body: responsiveContainer(context,
        ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
        Scaffold(
          appBar: AppBar(
            titleSpacing: 5,
            title:Text("Set location",style: BlackFieldStyleBold),
            toolbarHeight: 70,
            leading: InkWell(
                onTap: (){
                  Navigator.pop(context,"");
                },
                child: Icon(Icons.arrow_back,size: 24,color: Colors.black,)),

            backgroundColor: Color(0xFFFFFFFF),
            elevation: 1,
            bottom: PreferredSize(
              preferredSize: Size(isMobile?width:tabWidth, 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                child: Material(
                  elevation: 0.1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: TextFormField(
                    controller: SearchController,
                    keyboardType: TextInputType.text,
                    onChanged: (v){
                      autoCompleteSearch(v);
                    },
                    decoration: InputDecoration(
                      hintText:"Search for area,street name...",
                      fillColor:  Color(0xFFF5F4F4),
                      hintStyle: greyHintStyle,
                      isDense: true,
                      filled: true,
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                      border: const OutlineInputBorder(),
                    ),
                    style: BlackFieldStyle,
                  ),
                ),
              ),
            )
          ),
          body: ListView(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              5.height,
              isGettingNearByPlace == false? LoadingWidgetWithoutBox():
              nearbyPlaces.isEmpty ?
              NotAvailableText("Near by places not available!")
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: nearbyPlaces.length > 6?6:nearbyPlaces.length,
                itemBuilder: (context, index) {
                  var data = nearbyPlaces[index];
                return Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Color(0xFFD9D9D9),width: 0.5)
                      )
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                  child: InkWell(
                    onTap: (){
                   //   jsonEncode({"Address": "${data.name},${data.formattedAddress}" , "Lat" : "${data.lat}" , "${data.long}" : ""}).toString();
                      Navigator.pop(context, widget.isTitleSelectAsAddress == false? "${data.name},${data.formattedAddress}" : "${data.name}");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        CircleAvatar(
                            backgroundColor: primaryColor20,
                            radius: 14,
                            child: Image.network(data.icon.toString(),width: 20,height: 15,)),
                        12.width,
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${data.name}",style: BlackColor13600Style,),
                              Text("${data.formattedAddress}",style: grey12500StyleE,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },),
              AppPlaceList.isEmpty ?
              SizedBox()
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: AppPlaceList.length,
                itemBuilder: (context, index) {
                  var data = AppPlaceList[index];
                  return Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Color(0xFFD9D9D9),width: 0.5)
                        )
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context,widget.isTitleSelectAsAddress == false? "${data.displayname},${data.username}":"${data.displayname}");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          CircleAvatar(
                              backgroundColor: primaryColor20,
                              radius: 14,
                              child:
                              data.profilePicture.toString() == "null" ?
                              Image.asset("assets/location.png",width: 20,height: 15)
                                  :
                              Image.network(data.profilePicture.toString(),width: 20,height: 15)
                          ),
                          12.width,
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${data.displayname}",style: BlackColor13600Style,),
                                Text("${data.username}",style: grey12500StyleE,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFD9D9D9),width: 0.5)
                  )
                ),
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SavedAddressScreen())).then((value) {
                      Navigator.pop(context, value == null?"": "${value.toString()}");

                    });

                    // Navigator.push(context, MaterialPageRoute(builder: (context) =>  ManageAddressScreen(from: "Home"))).then((value) {
                    //   Navigator.pop(context,"${value.toString()}");
                    // });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      CircleAvatar(
                          backgroundColor: primaryColor20,
                          radius: 14,
                          child: Icon(Icons.star,color: primaryColor,size: 18,)),
                      12.width,
                      Text("Saved places",style: BlackColor13600Style,)
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Color(0xFFD9D9D9),width: 0.5)
                    )
                ),
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                child: InkWell(
                  onTap: () async{
                     Navigator.push(context, MaterialPageRoute(builder: (context) => LocationPickFromMap(ApiUrls.mapKey),)).then((value) {
                       Navigator.pop(context, value == null?"":value);
                     });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      CircleAvatar(
                          backgroundColor: primaryColor20,
                          radius: 14,
                          child: Icon(Icons.my_location_rounded,color: primaryColor,size: 18,)),
                      12.width,
                      Text("Set location on map",style: BlackColor13600Style,)
                    ],
                  ),
                ),
              )

            ],
          ),
        )
      )
    );
  }

  Future<dynamic> _showLocationDisabledAlertDialog(BuildContext context) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
          context: context,
          builder: (BuildContext ctx) {
            return CupertinoAlertDialog(
              title: Text("Location is disabled",style: BlackTitleBoldStyle,),
              content: Text(
                  "To use location, go to your Settings App > Privacy > Location Services.",style: BlackSubHeadingStyle),
              actions: [
                CupertinoDialogAction(
                  child: Text("Cancel",style: BlackFieldStyle,),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                CupertinoDialogAction(
                  child: Text("Ok",style: BlackFieldStyle,),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            );
          });
    } else {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text("Location is disabled",style: BlackTitleBoldStyle,),
              content: Text(
                "The app needs to access your location. Please enable location service.",style: BlackSubHeadingStyle,),
              actions: [
                TextButton(
                  child: Text("Cancel",style: BlackFieldStyle),
                  onPressed: () async {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text("OK",style: BlackFieldStyle,),
                  onPressed: () async {
                    await Geolocator.openLocationSettings();
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          });
    }
  }
}

