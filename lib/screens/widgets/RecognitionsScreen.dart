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
import 'package:socialapps/model/CertificationListModel.dart';
import 'package:socialapps/screens/setting/NormalPlacePicker.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socialapps/screens/widgets/NewAddressPickers/NewAddressPickerList.dart';
Future<dynamic> RecognitionsAddUpdate(BuildContext context,
    {From, required CertificationDataList RecognitionsScreenData}) {
  TextEditingController RecognitionsCertificateController =
      TextEditingController(
          text: From == "New"
              ? ""
              : RecognitionsScreenData.certificate.toString());
  TextEditingController RecognitionsinstitutionsNameController =
      TextEditingController(
          text: From == "New"
              ? ""
              : RecognitionsScreenData.institutionName.toString());
  TextEditingController RecognitionsAddressController = TextEditingController(
      text: From == "New"
          ? ""
          : RecognitionsScreenData.institutionAddress.toString());
  TextEditingController RecognitionsJobRoleController = TextEditingController(
      text: From == "New" ? "" : RecognitionsScreenData.subject.toString());

  bool isSaveLoader = false;
  String RecogDateFromController =
      From == "New" ? "" : RecognitionsScreenData.fromperiod.toString();
  String RecogDateToController =
      From == "New" ? "" : RecognitionsScreenData.toperiod.toString();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    constraints: BoxConstraints(maxWidth: ResponsiveHelper.isMobile(context)?MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth),
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.80,
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
                                  ? "Add Recgn /Certifications"
                                  : "Edit Recgn /Certifications",
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
                          " Certification",
                          style: BlackDescStyle,
                        ),
                        5.height,
                        TextFormField(
                          controller: RecognitionsCertificateController,
                          style: BlackFieldStyle,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Certification';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: inputDecoration(
                            context,
                            hint: "Certification",

                          ),
                          // obscureText: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          " Institution Name",
                          style: BlackDescStyle
                        ),
                        5.height,
                        TextFormField(
                          controller: RecognitionsinstitutionsNameController,

                          style: BlackFieldStyle,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          onTap:() async {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201) ,isAppPlaceView: false,isTitleSelectAsAddress: true))).then((value) {
                              setModalState((){
                                RecognitionsinstitutionsNameController.text=value.toString();
                              });
                            });

                          },
                          decoration: inputDecoration(
                            context,
                            hint: "Institution Name",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Institution Name';
                            }
                            return null;
                          },
                          // obscureText: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          " Institution Address",
                          style:BlackDescStyle
                        ),
                        5.height,
                        TextFormField(
                          controller: RecognitionsAddressController,
                          style: BlackFieldStyle,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          onTap:() async {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201),isAppPlaceView: false,isTitleSelectAsAddress: true ))).then((value) {
                              setModalState((){
                                RecognitionsAddressController.text=value.toString();
                              });
                            });

                          },
                          decoration: inputDecoration(
                            context,
                            hint: "Institution Address",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Institution Address';
                            }
                            return null;
                          },
                          // obscureText: true,
                        ),
                        10.height,
                        Text(
                          " Subject / Job Role",
                          style:BlackDescStyle
                        ),
                        5.height,
                        TextFormField(
                          controller: RecognitionsJobRoleController,

                          style: BlackFieldStyle,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Subject / Job Role';
                            }
                            return null;
                          },
                          decoration: inputDecoration(
                            context,
                            hint: "Subject / Job Role",
                          ),
                          // obscureText: true,
                        ),
                        10.height,
                        Text(
                          " Form Date",
                          style: BlackDescStyle
                        ),
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
                                  RecogDateFromController =
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
                                  RecogDateFromController == ""
                                      ? Text("From (MMYY)", style: greyHintStyle)
                                      : Text("${RecogDateFromController}",
                                          style: BlackFieldStyle),
                                ],
                              )),
                        ),
                        10.height,
                        Text(
                          " To Date",
                          style: BlackDescStyle
                        ),
                        5.height,
                        InkWell(
                          onTap: () {
                            showMonthPicker(
                              customWidth: ResponsiveHelper.isMobile(context)?null:ResponsiveHelper.TabModeWidth*0.6,
                              context: context,
                              selectedMonthBackgroundColor:
                                  Constants.primaryColor1,
                              initialDate: DateTime.now(),
                            ).then((date) {
                              if (date != null) {
                                setModalState(() {
                                  RecogDateToController =
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
                                  RecogDateToController == ""
                                      ? Text("To (MMYY)", style: greyHintStyle)
                                      : Text("${RecogDateToController}",
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
                        if(RecogDateFromController==null||RecogDateFromController.isEmpty){
                          Constants.showToast("From Date");
                        }
                        else if(RecogDateToController==null||RecogDateToController.isEmpty){
                          Constants.showToast("To Date");
                        }
                        else{
                          setModalState(() {
                            isSaveLoader = true;
                          });
                          Map<dynamic, String> bodyParam = From == "New"
                              ? {
                            "user": DataManager.getInstance().getuserId().toString(),
                            "institution_name": RecognitionsinstitutionsNameController.text,
                            "institution_address": RecognitionsAddressController.text,
                            "certificate": RecognitionsCertificateController.text,
                            "subject": RecognitionsJobRoleController.text,
                            "Class": "",
                            "fromperiod": RecogDateFromController,
                            "toperiod": RecogDateToController
                          }
                              : {
                            "certificate_id":
                            RecognitionsScreenData.id.toString(),
                            "institution_name":
                            RecognitionsinstitutionsNameController.text,
                            "institution_address":
                            RecognitionsAddressController.text,
                            "certificate": RecognitionsCertificateController.text,
                            "subject": RecognitionsJobRoleController.text,
                            "Class": "",
                            "fromperiod": RecogDateFromController,
                            "toperiod": RecogDateToController
                          };
                          print(bodyParam);
                          DrawAuraAPi.CreateDataApi(
                              body: bodyParam,
                              ApiEndPoint: From == "New"
                                  ? "addSubscribersCertification"
                                  : "updateSubscribersCertification")
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
