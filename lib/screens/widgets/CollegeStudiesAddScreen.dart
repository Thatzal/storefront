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
import 'package:socialapps/model/CollageListModel.dart';
import 'package:socialapps/screens/setting/NormalPlacePicker.dart';
import 'package:socialapps/screens/widgets/NewAddressPickers/NewAddressPickerList.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
Future<dynamic> CollegeStudiesAddUpdate(BuildContext context,
    {From, required CollegeListData CollegeData}) {
  TextEditingController CollegeNameController = TextEditingController(
      text: From == "New" ? "" : CollegeData.collegeName.toString());
  TextEditingController CollegeAddressController = TextEditingController(
      text: From == "New" ? "" : CollegeData.collegeAddress.toString());
  TextEditingController CollegeGegreeController = TextEditingController(
      text: From == "New" ? "" : CollegeData.degreeequivalent.toString());
  TextEditingController CollegeClassNoController = TextEditingController(
      text: From == "New" ? "" : CollegeData.classNo.toString());
  bool isSaveLoader = false;
  String CollegeDateYearController =
      From == "New" ? "" : CollegeData.yearofpassing.toString();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    constraints: BoxConstraints(maxWidth: ResponsiveHelper.isMobile(context)?MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
    ),
    builder: (BuildContext context) {
      var width = MediaQuery.of(context).size.width;
      var height = MediaQuery.of(context).size.height;
      var tabWidth = ResponsiveHelper.TabModeWidth;
      var tabHeight = ResponsiveHelper.TabModeHeight;
      var isMobile= ResponsiveHelper.isMobile(context);
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Scaffold(
                body: SafeArea(
                  child: Form(
                    key: globalKey,

                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      children: <Widget>[
                        15.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              From == "New"
                                  ? "Add College Studies"
                                  : "Edit College Studies",
                              style: BlackBottomHeadStyle18500,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 28,
                                  color: Colors.grey.shade800,
                                ))
                          ],
                        ),
                        15.height,
                        Text(
                          " Institution name",
                          style: BlackDescStyle
                        ),
                        5.height,
                        TextFormField(
                            controller: CollegeNameController,
                            style: BlackFieldStyle,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            onTap:() async {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201),isAppPlaceView: false ,isTitleSelectAsAddress: true))).then((value) {
                                setModalState((){
                                  CollegeNameController.text=value.toString();
                                });
                              });
                            },
                            decoration: inputDecoration(
                              context,
                              hint: "Institution name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Institution name";
                              }
                            }
                            // obscureText: true,
                            ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          " Address",
                          style: BlackDescStyle
                        ),
                        5.height,
                        TextFormField(
                            controller: CollegeAddressController,
                            style: BlackFieldStyle,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            onTap:() async {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201),isAppPlaceView: false,isTitleSelectAsAddress: true ))).then((value) {
                                setModalState((){
                                  CollegeAddressController.text=value.toString();
                                });
                              });

                            },
                            decoration: inputDecoration(
                              context,
                              hint: "Enter Address",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Address";
                              }
                            }
                            // obscureText: true,
                            ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          " Degree / Equivalent",
                          style: BlackDescStyle
                        ),
                        5.height,
                        TextFormField(
                            controller: CollegeGegreeController,
                            style: BlackFieldStyle,
                            keyboardType: TextInputType.text,
                            decoration: inputDecoration(
                              context,
                              hint: "Degree / Equivalent",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Degree / Equivalent";
                              }
                            }
                            // obscureText: true,
                            ),
                        10.height,
                        Text(
                          " Please enter Grade",
                          style: BlackDescStyle
                        ),
                        5.height,
                        TextFormField(
                          controller: CollegeClassNoController,

                          style: BlackFieldStyle,
                          keyboardType: TextInputType.text,
                          decoration: inputDecoration(
                            context,
                            hint: "Class",
                          ),
                          // obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Grade';
                            }
                            return null;
                          },
                        ),
                        10.height,
                        Text(
                          " Month and Year",
                          style: BlackDescStyle
                        ),
                        5.height,
                        InkWell(
                          onTap: () {
                            showMonthPicker(
                              customWidth: ResponsiveHelper.isMobile(context)?null:ResponsiveHelper.TabModeWidth*0.6,
                             // customHeight: ResponsiveHelper.isMobile(context)?null:ResponsiveHelper.TabModeWidth*0.40,
                              context: context,
                              selectedMonthBackgroundColor:
                                  Constants.primaryColor1,
                              initialDate: DateTime.now(),
                            ).then((date) {
                              if (date != null) {
                                setModalState(() {
                                  CollegeDateYearController =
                                      DateFormat("MMM-yyyy").format(date);
                                });
                              }
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height:38,
                              width: ResponsiveHelper.isMobile(context)? MediaQuery.of(context).size.width:ResponsiveHelper.TabModeWidth*0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Constants.lightGreen),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CollegeDateYearController == ""
                                      ? Text("Month and Year",
                                          style: greyHintStyle)
                                      : Text("${CollegeDateYearController}",
                                          style: BlackFieldStyle),
                                ],
                              )),
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
                      border: Border(
                          top: BorderSide(
                              color: Constants.lightGreen, width: 1.5))),
                  child: Center(
                    child: ElevatedButton(
                      child: isSaveLoader == true
                          ? ButtonLoaderWhite()
                          : Text(
                              From == "New" ? "Save" : "Update",
                              style: WhiteButtonStyle,
                            ),
                      onPressed: () {
                        if(globalKey.currentState!.validate()){
                          if(CollegeDateYearController==null||CollegeDateYearController.isEmpty){
                            Constants.showToast("Enter Month And Year");
                          }else{
                            setModalState(() {
                              isSaveLoader = true;
                            });
                            Map<dynamic, String> bodyParam = From == "New"
                                ? {
                              "user": DataManager.getInstance()
                                  .getuserId()
                                  .toString(),
                              "college_name": CollegeNameController.text,
                              "college_address":
                              CollegeAddressController.text,
                              "degreeequivalent":
                              CollegeGegreeController.text,
                              "yearofpassing": CollegeDateYearController,
                              "subject": "",
                              "Class": CollegeClassNoController.text
                            }
                                : {
                              "college_id": CollegeData.id.toString(),
                              "college_name": CollegeNameController.text,
                              "college_address":
                              CollegeAddressController.text,
                              "degreeequivalent":
                              CollegeGegreeController.text,
                              "yearofpassing": CollegeDateYearController,
                              "subject": "",
                              "Class": CollegeClassNoController.text
                            };
                            DrawAuraAPi.CreateDataApi(
                                body: bodyParam,
                                ApiEndPoint: From == "New"
                                    ? "addSubscriberCollegeStudy"
                                    : "updateSubscriberCollegeStudy")
                                .then((value) {
                              if (value["status"] == 200) {
                                setModalState(() {
                                  isSaveLoader = false;
                                });
                                Constants.showToast(value["message"]);
                                Navigator.pop(context);
                              } else {
                                setModalState(() {
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
                        backgroundColor: Constants.primaryColor1,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        fixedSize:
                            Size(ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width * 0.8:ResponsiveHelper.TabModeWidth*0.8, 40),
                      ),
                    ),
                  ),
                ),
              ));
        },
      );
    },
  );
}
