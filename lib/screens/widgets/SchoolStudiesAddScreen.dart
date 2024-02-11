
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loader.dart';
import 'package:socialapps/constant/text_form_feild.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/SchoolListModel.dart';
import 'package:socialapps/screens/setting/NormalPlacePicker.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socialapps/screens/widgets/NewAddressPickers/NewAddressPickerList.dart';
Future<dynamic> SchoolStudiesAdd(BuildContext context,{ From,required SchoolListData SchoolData}){
  TextEditingController SchoolNameController  = TextEditingController(text: From == "New" ? "" : SchoolData.schoolName.toString() );
  TextEditingController SchoolAddressController  = TextEditingController(text: From == "New" ? "" : SchoolData.schoolAddress.toString());
  TextEditingController SchoolStandardController  = TextEditingController(text: From == "New" ? "" : SchoolData.standardForm.toString());
  bool isSaveLoader = false;
  String SchoolMonthYearValue =  From == "New" ? "" : SchoolData.yearofpassing.toString();
  String ?selectedGrade ;
  List GradeList =   ["35-40 %","40-45 %","45-50 %","50-55 %","55-60 %","60-65 %","65-70 %","70-75 %","75-80 %","80-85 %","85-90 %,90 % Above" ];
  GlobalKey<FormState> globalKey=GlobalKey<FormState>();
  return   showModalBottomSheet(
    backgroundColor: Colors.white,
    constraints: BoxConstraints(maxWidth: ResponsiveHelper.isMobile(context)?MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth),
    context: context,    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setModalState) {
        return Container(
          height: MediaQuery.of(context).size.height*0.8,
            child: Scaffold(
            body:  SafeArea(
              child: Form(
                key: globalKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  children: <Widget>[
                    15.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text( From == "New" ?"Add School Studies":"Edit School Studies",style: BlackBottomHeadStyle18500,),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close,size: 28,color: Colors.grey.shade800,))
                      ],
                    ),
                    15.height,
                    Text(" School Name",style: BlackDescStyle,),
                    5.height,
                    TextFormField(
                      controller: SchoolNameController,
                      style: BlackFieldStyle,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      onTap:() async {

                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201),isAppPlaceView: false,isTitleSelectAsAddress: true ))).then((value) {
                          setModalState((){
                            SchoolNameController.text=value.toString();
                          });
                        });

                      },
                      decoration: inputDecoration(context,hint: "School name", ),
                      validator: (value) {
                        if(value==null||value.isEmpty){
                          return "Enter School Name";
                        }
                        // return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // obscureText: true,
                    ),
                    const SizedBox(height: 10,),
                    Text(" Address",style: BlackDescStyle),
                    5.height,
                    TextFormField(
                      controller: SchoolAddressController,

                      style: BlackFieldStyle,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      onTap:() async {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201) ,isAppPlaceView: false,isTitleSelectAsAddress: true))).then((value) {
                          setModalState((){
                            SchoolAddressController.text=value.toString();
                          });
                        });

                      },
                      decoration: inputDecoration(context,hint: "Enter Address", ),
                      validator: (value) {
                        if(value==null||value.isEmpty){
                          return "Enter Address";
                        }
                        // return null;
                      },
                      // obscureText: true,
                    ),
                    const SizedBox(height: 10,),
                    Text(" Standard / Form",style: BlackDescStyle,),
                    5.height,
                    TextFormField(
                      controller: SchoolStandardController,
                      style: BlackFieldStyle,
                      keyboardType: TextInputType.text,

                      decoration: inputDecoration(context,hint: "Standard / Form", ),
                      validator: (value) {
                        if(value==null||value.isEmpty){
                          return "Standard / Form";
                        }
                        // return null;
                      },
                      // obscureText: true,
                    ),
                    10.height,
                    Text(" Grade",style:BlackDescStyle,),
                    5.height,
                    Container(
                      height: 38,
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width*0.7,
                      child:
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(

                            hint:  Center(child: Text('Choose Grade', style: Constants.hintStyle,)),
                            items: GradeList.map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0,top: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item, style: BlackFieldStyle),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            )).toList(),
                            value: selectedGrade,
                            onChanged: (value) {
                              setModalState(() {
                                selectedGrade = value.toString();
                              });
                            },
                            iconStyleData: const IconStyleData(
                              icon: Padding(
                                padding: EdgeInsets.only(left:0.0,right: 0),
                                child: Icon(Icons.keyboard_arrow_down_sharp,),
                              ),
                              iconSize: 24,
                              iconEnabledColor: Colors.grey,
                              iconDisabledColor:Colors.grey,
                            ),
                            buttonStyleData: ButtonStyleData(
                                height:  35,
                                width: MediaQuery.of(context).size.width * 0.9,
                                padding: const EdgeInsets.only(left: 10, right: 3),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Constants.lightGreen,width: 1),
                                    borderRadius: BorderRadius.circular(5),color: Colors.white),
                                elevation:  0,
                                overlayColor: MaterialStateProperty.all(Colors.white)
                            ),
                            menuItemStyleData: MenuItemStyleData(
                              height: 33,
                              selectedMenuItemBuilder: (context, child) {
                                return     Container(
                                  padding: const EdgeInsets.only(left: 0, right: 0),
                                  width: MediaQuery.of(context).size.width * 0.3,
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
                              width: ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width * 0.9:ResponsiveHelper.TabModeWidth*0.9,
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
                        // menuItemStyleData: const MenuItemStyleData(
                        //   height: 30,
                        // ),
                      ),
                    ),
                    10.height,
                    Text(" Month and Year",style:BlackFieldStyle,),
                    5.height,
                    InkWell(
                      onTap:(){
                        showMonthPicker(
                          context: context,
                          selectedMonthBackgroundColor: Constants.primaryColor1,
                          initialDate: DateTime.now(),
                        ).then((date) {
                          if (date != null) {
                            setModalState(() {
                              SchoolMonthYearValue = DateFormat("MMM-yyyy").format(date);
                            });
                          }
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 38, width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(5),border: Border.all(color: Constants.lightGreen),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SchoolMonthYearValue == ""?Text("Month and Year", style:greyHintStyle):   Text("${SchoolMonthYearValue}", style:BlackFieldStyle),
                            ],
                          )
                      ),
                    ),
                    85.height
                  ],

                ),
              ),
            ),
            bottomSheet: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                border:Border(top: BorderSide(color: Constants.lightGreen,width: 1.5))
              ),
              child: Center(
                child: ElevatedButton(
                  child:isSaveLoader == true? ButtonLoaderWhite(): Text( From == "New" ?"Save":"Update",style: WhiteButtonStyle,),
                  onPressed:(){
                    if(globalKey.currentState!.validate()){
                      if(SchoolMonthYearValue==null||SchoolMonthYearValue.isEmpty){
                        Constants.showToast("Enter Month And Year");
                      }else{
                        setModalState((){
                          isSaveLoader = true;
                        });
                        Map<dynamic,String> bodyParam =From == "New" ?  {
                          "user":DataManager.getInstance().getuserId().toString().trim(),
                          "school_name" : SchoolNameController.text,
                          "school_address" : SchoolAddressController.text,
                          "standard_form" : SchoolStandardController.text,
                          "yearofpassing": SchoolMonthYearValue,
                          "grade" :selectedGrade.toString()
                        } : {
                          "school_id" :SchoolData.id.toString(),
                          "user":DataManager.getInstance().getuserId().toString().trim(),
                          "school_name" : SchoolNameController.text,
                          "school_address" : SchoolAddressController.text,
                          "standard_form" : SchoolStandardController.text,
                          "yearofpassing": SchoolMonthYearValue,
                          "grade" :selectedGrade.toString()
                        };
                        DrawAuraAPi.CreateDataApi(body:bodyParam,ApiEndPoint:From == "New" ? "addSubscriberSchoolStudy" : "updateSubscriberSchoolStudy" ).then((value) {
                          if(value["status"] == 200 ){
                            setModalState((){
                              isSaveLoader = false;
                            });
                            Constants.showToast(value["message"]);
                            Navigator.pop(context);
                          }else{
                            setModalState((){
                              isSaveLoader = false;
                            });
                            Constants.showToast(value["message"]);
                            // Navigator.pop(context);
                          }
                        });

                      }

                    }

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.primaryColor1,elevation: 2,
                    shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(40),
                    ),
                    fixedSize: Size(ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width * 0.8:ResponsiveHelper.TabModeWidth*0.8,40),
                  ),
                ),
              ),
            ),
          )
        );
      },);
    },
  );
  
}