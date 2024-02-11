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
import 'package:socialapps/model/workExperiencesListModel.dart';
import 'package:socialapps/screens/setting/NormalPlacePicker.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socialapps/screens/widgets/NewAddressPickers/NewAddressPickerList.dart';
Future<dynamic> WorkExperienceAddUpdate(BuildContext context,
    {From, required WorkExperiencesListData WorkExperienceData}) {
  TextEditingController WorkExperienceNameController = TextEditingController(
      text: From == "New" ? "" : WorkExperienceData.firmName.toString());
  TextEditingController WorkExperienceAddressController = TextEditingController(
      text: From == "New" ? "" : WorkExperienceData.firmAddress.toString());
  TextEditingController WorkExperieceDesignationController =
      TextEditingController(
          text: From == "New" ? "" : WorkExperienceData.designation.toString());
  TextEditingController WorkExperienceJobRoleController = TextEditingController(
      text: From == "New" ? "" : WorkExperienceData.jobRole.toString());

  bool isSaveLoader = false;
  String WorkExperienceDateFromController =
      From == "New" ? "" : WorkExperienceData.fromperiod.toString();
  String WorkExperienceDateToController =
      From == "New" ? "" : WorkExperienceData.toperiod.toString();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  print(From);
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
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Scaffold(
                body: SafeArea(
                  child: Form(
                    key: globalKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  ? "Add Work Experiences"
                                  : "Edit Work Experiences",
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
                        Text(" Company Name", style: BlackFieldStyle,),
                        5.height,
                        TextFormField(
                            controller: WorkExperienceNameController,
                            style: BlackFieldStyle,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            onTap:() async {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201) ,isAppPlaceView: false,isTitleSelectAsAddress: true))).then((value) {
                                setModalState((){
                                  WorkExperienceNameController.text=value.toString();
                                });
                              });

                            },
                            decoration: inputDecoration(
                              context,
                              hint: "Company Name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Company Name";
                              }
                            }
                            // obscureText: true,
                            ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(" Company Address", style: BlackFieldStyle,),
                        5.height,
                        TextFormField(
                          controller: WorkExperienceAddressController,

                          style: BlackFieldStyle,
                          keyboardType: TextInputType.text,
                            readOnly: true,
                            onTap:() async {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201),isAppPlaceView: false ,isTitleSelectAsAddress: true))).then((value) {
                                setModalState((){
                                  WorkExperienceAddressController.text=value.toString();
                                });
                              });

                            },
                          decoration: inputDecoration(
                            context,
                            hint: "Company Address",
                          ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Company Address";
                              }
                            }
                          // obscureText: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(" Designation / Position", style:BlackFieldStyle,),
                        5.height,
                        TextFormField(
                          controller: WorkExperieceDesignationController,
                          style: BlackFieldStyle,
                          keyboardType: TextInputType.text,

                          decoration: inputDecoration(
                            context,
                            hint: "Designation / Position",
                          ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Designation / Position";
                              }
                            }
                          // obscureText: true,
                        ),
                        10.height,
                        Text(" Job Role", style: BlackFieldStyle,),
                        5.height,
                        TextFormField(
                          controller: WorkExperienceJobRoleController,

                          style: BlackFieldStyle,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Job Role';
                            }
                            return null;
                          },
                          decoration: inputDecoration(
                            context,
                            hint: "Job Role",
                          ),
                          // obscureText: true,
                        ),
                        10.height,
                        Text(" From Date",style: BlackFieldStyle,),
                        5.height,
                        InkWell(
                          onTap: () {
                            showMonthPicker(
                              context: context,
                              customWidth: ResponsiveHelper.isMobile(context)?null:ResponsiveHelper.TabModeWidth*0.6,
                              selectedMonthBackgroundColor:
                                  Constants.primaryColor1,
                              initialDate: DateTime.now(),
                            ).then((date) {
                              if (date != null) {
                                setModalState(() {
                                  WorkExperienceDateFromController =
                                      DateFormat("MMM-yyyy").format(date);
                                });
                              }
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 38,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Constants.lightGreen),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  WorkExperienceDateFromController == ""
                                      ? Text("From (MMYY)", style: greyHintStyle)
                                      : Text(
                                          "${WorkExperienceDateFromController}",
                                          style: BlackFieldStyle),
                                ],
                              )),
                        ),
                        10.height,
                        Text(" To Date",style: BlackFieldStyle,),
                        5.height,
                        InkWell(
                          onTap: () {
                            showMonthPicker(
                              context: context,
                              customWidth: ResponsiveHelper.isMobile(context)?null:ResponsiveHelper.TabModeWidth*0.6,
                              selectedMonthBackgroundColor:
                                  Constants.primaryColor1,
                              initialDate: DateTime.now(),
                            ).then((date) {
                              if (date != null) {
                                setModalState(() {
                                  WorkExperienceDateToController =
                                      DateFormat("MMM-yyyy").format(date);
                                });
                              }
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 38,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Constants.lightGreen),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  WorkExperienceDateToController == ""
                                      ? Text("To (MMYY)", style: greyHintStyle)
                                      : Text(
                                          "${WorkExperienceDateToController}",
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

                          if(WorkExperienceDateFromController==null||WorkExperienceDateFromController.isEmpty){
                             Constants.showToast("Enter From Date");
                          }else if(WorkExperienceDateToController==null||WorkExperienceDateToController.isEmpty){
                                  Constants.showToast("Enter TO Date");
                             } else{
                          setModalState(() {
                            isSaveLoader = true;
                          });
                          Map<dynamic, String> bodyParam = From == "New"
                              ? {
                            "user": DataManager.getInstance()
                                .getuserId()
                                .toString(),
                            "firm_name": WorkExperienceNameController.text,
                            "firm_address":
                            WorkExperienceAddressController.text,
                            "designation":
                            WorkExperieceDesignationController.text,
                            "job_role": WorkExperienceJobRoleController.text,
                            "skillset": "",
                            "fromperiod": WorkExperienceDateFromController,
                            "toperiod": WorkExperienceDateToController
                          }
                              : {
                            "work_id": WorkExperienceData.id.toString(),
                            "firm_name": WorkExperienceNameController.text,
                            "firm_address":
                            WorkExperienceAddressController.text,
                            "designation":
                            WorkExperieceDesignationController.text,
                            "job_role": WorkExperienceJobRoleController.text,
                            "skillset": "",
                            "fromperiod": WorkExperienceDateFromController,
                            "toperiod": WorkExperienceDateToController
                          };
                          DrawAuraAPi.CreateDataApi(
                              body: bodyParam,
                              ApiEndPoint: From == "New"
                                  ? "addSubscribersWork"
                                  : "updateSubscribersWork")
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
                  )),
                ),
              ));
        },
      );
    },
  );
}
