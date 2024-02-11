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
import 'package:socialapps/model/SkillSetListModel.dart';
import 'package:socialapps/screens/setting/NormalPlacePicker.dart';

import 'NewAddressPickers/NewAddressPickerList.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
Future<dynamic> SkillSetsAddUpdate(BuildContext context,{ From,required SkillSetData SkillSetsScreenData}){
  TextEditingController ProjectNameController  = TextEditingController(text: From == "New" ? "" : SkillSetsScreenData.projectName.toString() );
  TextEditingController InstitutionCompanyController  = TextEditingController(text: From == "New" ? "" : SkillSetsScreenData.companyName.toString() );
  TextEditingController ExperienceController  = TextEditingController(text: From == "New" ? "" : SkillSetsScreenData.experience.toString());
  GlobalKey<FormState> globalKey=GlobalKey<FormState>();


  bool isSaveLoader = false;
  return   showModalBottomSheet(
    backgroundColor: Colors.white,
    constraints: BoxConstraints(maxWidth: ResponsiveHelper.isMobile(context)?MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth),
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setModalState) {
        return Container(
            height: MediaQuery.of(context).size.height*0.75,
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
                          Text( From == "New" ?"Add Experience / Skillsets / Projects":"Edit Experience / Skillsets / Projects",style: BlackBottomHeadStyle18500,),
                          InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close,size: 28,color: Colors.grey.shade800,))
                        ],
                      ),
                      15.height,
                      Text(" Project Name",style: BlackDescStyle,),
                      5.height,
                      TextFormField(
                        controller: ProjectNameController,
                        style: BlackFieldStyle,
                        keyboardType: TextInputType.text,
                        decoration: inputDecoration(context,hint: "Project Name", ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Project Name';
                          }
                          // return null;
                        },
                        // obscureText: true,
                      ),
                      const SizedBox(height: 10,),
                      Text(" Institution / Company",style: BlackDescStyle,),
                      5.height,
                      TextFormField(
                        controller: InstitutionCompanyController,
                        readOnly: true,
                        onTap:() async {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong:LatLng(10.5381264, 73.8827201),isAppPlaceView: false,isTitleSelectAsAddress: true ))).then((value) {
                            setModalState((){
                              InstitutionCompanyController.text=value.toString();
                            });
                          });

                        },
                        style: BlackFieldStyle,
                        keyboardType: TextInputType.text,

                        decoration: inputDecoration(context,hint: "Institution / Company", ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Institution / Company';
                          }
                          // return null;
                        },
                        // obscureText: true,
                      ),
                      const SizedBox(height: 10,),
                      Text(" Experience / Skillset",style: BlackDescStyle,),
                      5.height,
                      TextFormField(
                        controller: ExperienceController,
                        style: BlackFieldStyle,
                        keyboardType: TextInputType.text,

                        decoration: inputDecoration(context,hint: "Experience / Skillset gained (Summary)", ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Experience / Skillset';
                          }
                          // return null;
                        },
                        // obscureText: true,
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
                          setModalState((){
                            isSaveLoader = true;
                          });
                          Map<dynamic,String> bodyParam = From == "New" ?  {
                            "user":DataManager.getInstance().getuserId().toString(),
                            "project_name":ProjectNameController.text,
                            "company_name":InstitutionCompanyController.text,
                            "experience":ExperienceController.text,

                          } : {
                            "skill_id" : SkillSetsScreenData.id.toString(),
                            "project_name":ProjectNameController.text,
                            "company_name":InstitutionCompanyController.text,
                            "experience":ExperienceController.text,
                          };
                          DrawAuraAPi.CreateDataApi(body:bodyParam,ApiEndPoint:From == "New" ? "addSubscriberSkills" : "updateSubscriberSkills" ).then((value) {
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

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.primaryColor1,elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        fixedSize: Size(ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width * 0.8:ResponsiveHelper.TabModeWidth*0.8,40),
                      ),
                    )
                ),
              ),
            )
        );
      },);
    },
  );

}