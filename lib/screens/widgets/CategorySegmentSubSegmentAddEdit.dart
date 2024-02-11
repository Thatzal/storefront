import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loader.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/GetCategoryListModal.dart';
import 'package:socialapps/model/GetSegmentListModal.dart';
import 'package:socialapps/model/GetSubSegmentListModal.dart';
import 'package:socialapps/model/PrefChoiseCategories.dart';


Future<dynamic> CategorySubSegAddUpdate(BuildContext context,
    {From,required PrefChoiseCategoriesData PrefChoiseCategoriesDetaisl}) {
  TextEditingController searchCategoryController = TextEditingController(text: From == "New" ? "": PrefChoiseCategoriesDetaisl.category!.name.toString());
  TextEditingController searchSegmentController = TextEditingController(text: From == "New" ? "": PrefChoiseCategoriesDetaisl.segment!.name.toString());
  TextEditingController searchSubSegmentController = TextEditingController(text: From == "New" ? "": PrefChoiseCategoriesDetaisl.subsegment!.name.toString());

  var searchCategoryId = From == "New" ? "": PrefChoiseCategoriesDetaisl.category!.id.toString();
  var searchSegmentId = From == "New" ? "": PrefChoiseCategoriesDetaisl.segment!.id.toString();
  var searchSubSegmentId = From == "New" ? "": PrefChoiseCategoriesDetaisl.subsegment!.id.toString();
  bool showOther = false;
  bool isloadNewCategory = false;
  int selectedCategoryIndex = -1;
  bool showOtherSegment = false;
  bool isloadNewSegment = false;
  int selectedSegmentIndex = -1;
  bool showOtherSubSegment = false;
  bool isloadNewSubSegment = false;
  bool segmentLoader=false;
  List<CategoryData> GetCategoryList = [];
  List<CategoryData> filterGetCategoryList = [];

  List<SegmentResult> getSegmentList = [];
  List<SegmentResult> filterGetSegmentList = [];

  List<SubSegmentResult> getSubSegmentList=[];
  List<SubSegmentResult> filterGetSubSegmentList=[];

  DrawAuraAPi.getCategoryListApi().then((value) {
    GetCategoryList = value.result!;
  });
  if(From != "New"){
    DrawAuraAPi.getSegmentListApi(catId:  PrefChoiseCategoriesDetaisl.category!.id.toString()).then((value) {
        getSegmentList=value.result!;
    });
    DrawAuraAPi().getSubSegmentListApi(segId: PrefChoiseCategoriesDetaisl.segment!.id.toString()).then((value) {
        getSubSegmentList=value.result!;
    });
  }



  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isSaveLoader = false;
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints(maxWidth: ResponsiveHelper.isMobile(context)?MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth),
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
                            Text( From == "New" ?"Add Categories":"Edit Categories",style: BlackBottomHeadStyle18500,),
                            InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.close,size: 28,color: Colors.grey.shade800,))
                          ],
                        ),
                        15.height,
                        // Align(
                        //     alignment: Alignment.topLeft,
                        //     child: Text("Area of Offering", style: BlackFieldStyle,)),
                        // 7.height,
                        // Container(
                        //   height: 38,
                        //   color: Colors.white,
                        //   width: MediaQuery.of(context).size.width*0.7,
                        //   child: TextFormField(
                        //     controller: AreaOfOfferingLocation,
                        //     onTap:() async {
                        //       String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => NormalPlacePickerScreen("AIzaSyDE9xGmWMOftPvz1hHwPlTecShhHtR4goE")));
                        //       setModalState((){
                        //         AreaOfOfferingLocation.text=result.toString();
                        //       });
                        //     },
                        //     readOnly:true,
                        //     keyboardType: TextInputType.text,
                        //     decoration: InputDecoration(hintText:"Offer Location", fillColor:  Colors.white, hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 12),
                        //       focusedBorder:OutlineInputBorder(
                        //           borderSide: BorderSide(
                        //               width: 1, color: Constants.lightGreen
                        //           ),
                        //           borderRadius: BorderRadius.circular(5)
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //           borderSide: BorderSide(
                        //               width: 1, color: Constants.lightGreen
                        //           ),
                        //           borderRadius: BorderRadius.circular(5)
                        //       ),
                        //       floatingLabelBehavior: FloatingLabelBehavior.never,
                        //       contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                        //       border: const OutlineInputBorder(),
                        //     ),
                        //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                        //   ),
                        // ),
                        // 10.height,
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Category", style: BlackDescStyle,)),
                        7.height,
                        Container(
                          height: 38,
                          color: Colors.white,
                          width:isMobile?width*0.7:tabWidth*0.7,
                          child: TextFormField(
                            controller: searchCategoryController,
                            decoration: InputDecoration(
                              hintText: "Enter Category",
                              hintStyle: greyHintStyle,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Constants.lightGreen
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Constants.lightGreen
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              suffixIcon: filterGetCategoryList.isEmpty && showOther==true?
                              InkWell(
                                  onTap:(){
                                    setModalState((){
                                      isloadNewCategory= true;
                                    });
                                    var data ={"name":searchCategoryController.text.toString()};
                                    DrawAuraAPi().createCategoryApi(
                                        data: data).then((value) {
                                      if (value["status"] == 200) {
                                        setModalState((){
                                          searchCategoryId = value["result"]["id"].toString();
                                        });
                                        Fluttertoast.showToast(
                                            msg: value["message"],
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 2,
                                            backgroundColor:Constants.primaryColor1,
                                            textColor: Colors.white,
                                            fontSize: 18.0
                                        );
                                        setModalState(() {
                                          isloadNewCategory = false;
                                          showOther =false;
                                        });
                                        DrawAuraAPi.getCategoryListApi().then((value) {
                                          setModalState((){
                                            GetCategoryList.clear();
                                            GetCategoryList = value.result!;
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
                                        setModalState(() {
                                          isloadNewCategory = false;
                                          showOther =false;
                                        });
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
                               setModalState((){
                                 filterGetCategoryList = GetCategoryList.where((name) => name.name!.toLowerCase().contains(value.toLowerCase())).toList();
                                 print(filterGetCategoryList);
                                 filterGetCategoryList.isEmpty ? showOther=true:showOther=false;
                               });
                            },
                            style: BlackFieldStyle,
                          ),
                        ),
                        (filterGetCategoryList.isEmpty) ? SizedBox()
                            :SizedBox(width:isMobile?width*0.7:tabWidth*0.7,
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: ListView.builder(
                              itemCount:filterGetCategoryList.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              itemBuilder: (context, index) {
                                var data = filterGetCategoryList[index];
                                return  Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                                  child: InkWell(
                                      onTap: (){
                                        setModalState(() {
                                          searchCategoryController.text = data.name.toString() ;
                                          searchCategoryId = data.id.toString();
                                          filterGetCategoryList.clear();
                                          segmentLoader=true;
                                          selectedCategoryIndex = index;
                                        });
                                        DrawAuraAPi.getSegmentListApi(catId: data.id.toString()).then((value) {
                                          setModalState(() {
                                            getSegmentList=value.result!;
                                            segmentLoader=false;
                                          });
                                        });

                                      },
                                      child: Text("${data.name.toString()}",style: BlackFieldStyle,overflow: TextOverflow.ellipsis)),
                                );
                              },),
                          ),
                        ),
                        10.height,
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Segment", style: BlackDescStyle,)),
                        7.height,
                        Container(
                          height: 38,
                          color: Colors.white,
                          width:isMobile?width*0.7:tabWidth*0.7,

                          child: TextFormField(
                            readOnly: searchCategoryController.text.isEmpty?true:false,
                            controller: searchSegmentController,
                            decoration: InputDecoration(
                              hintText: "Enter Segment",
                              hintStyle: greyHintStyle,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Constants.lightGreen
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Constants.lightGreen
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              suffixIcon: filterGetSegmentList.isEmpty && showOtherSegment==true?
                              InkWell(
                                  onTap:(){
                                    setModalState((){
                                      isloadNewSegment= true;
                                    });
                                    var data = {
                                      "name": searchSegmentController.text,
                                      "category": searchCategoryId.toString(),
                                    };
                                    print(data);
                                    DrawAuraAPi().createSegmentApi(data: data).then((value) {
                                      if (value["status"] == 200) {
                                        setModalState((){
                                          searchSegmentId = value["result"]["id"].toString();
                                        });
                                        Fluttertoast.showToast(
                                            msg: value["message"],
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 2,
                                            backgroundColor:Constants.primaryColor1,
                                            textColor: Colors.white,
                                            fontSize: 18.0
                                        );
                                        setModalState(() {
                                          selectedSegmentIndex = -2;
                                          isloadNewSegment = false;
                                          showOtherSegment = false;
                                        });
                                        DrawAuraAPi.getSegmentListApi(catId: selectedCategoryIndex == -2?GetCategoryList.last.id.toString():GetCategoryList[selectedCategoryIndex].id.toString()).then((value) {
                                          setModalState(() {
                                            getSegmentList.clear();
                                            getSegmentList=value.result!;
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
                                        setModalState(() {
                                          isloadNewSegment = false;
                                          showOtherSegment =false;
                                        });
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
                               setModalState((){
                                 filterGetSegmentList = getSegmentList.where((name) => name.name!.toLowerCase().contains(value.toLowerCase())).toList();
                                 filterGetSegmentList.isEmpty ? showOtherSegment=true:showOtherSegment=false;
                               });
                            },
                            style:BlackFieldStyle
                          ),
                        ),
                        (filterGetSegmentList.isEmpty) ? SizedBox()
                            :SizedBox(
                          width: isMobile?width*0.7:tabWidth*0.7,
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: ListView.builder(
                              itemCount:filterGetSegmentList.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              itemBuilder: (context, index) {
                                var data = filterGetSegmentList[index];
                                return  Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                                  child: InkWell(
                                      onTap: (){
                                        setModalState(() {
                                          searchSegmentId = data.id.toString();
                                          searchSegmentController.text = data.name.toString() ;
                                          filterGetSegmentList.clear();
                                          segmentLoader=true;
                                          selectedSegmentIndex = index;
                                        });
                                        DrawAuraAPi().getSubSegmentListApi(segId: data.id.toString()).then((value) {
                                          setModalState(() {
                                            getSubSegmentList=value.result!;
                                            segmentLoader=false;
                                          });
                                        });

                                      },
                                      child: Text("${data.name.toString()}",style: BlackFieldStyle,overflow: TextOverflow.ellipsis)),
                                );
                              },),
                          ),
                        ),
                        10.height,
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Sub-Segment", style: BlackDescStyle,)),
                        7.height,
                        Container(
                          height: 38,
                          color: Colors.white,
                          width: isMobile?width*0.7:tabWidth*0.7,
                          child: TextFormField(
                            readOnly: searchSegmentController.text.isEmpty?true:false,
                            controller: searchSubSegmentController,
                            decoration: InputDecoration(
                              hintText: "Enter Sub Segment",
                              hintStyle: greyHintStyle,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,color: Constants.lightGreen
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Constants.lightGreen
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              suffixIcon: filterGetSubSegmentList.isEmpty && showOtherSubSegment==true?
                              InkWell(
                                  onTap:(){
                                    print("OtherSubSegment");
                                    setModalState((){
                                      isloadNewSubSegment= true;
                                    });
                                    var data = {
                                      "segment": searchSegmentId.toString(),
                                      "name": searchSubSegmentController.text,
                                    };

                                    DrawAuraAPi().createSubSegmentApi(data: data).then((value) {

                                      if (value["status"] == 200) {
                                        setModalState((){
                                          searchSubSegmentId = value["result"]["id"].toString();
                                        });
                                        Fluttertoast.showToast(
                                            msg: value["message"],
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 2,
                                            backgroundColor:Constants.primaryColor1,
                                            textColor: Colors.white,
                                            fontSize: 18.0
                                        );
                                        setModalState(() {
                                          isloadNewSubSegment = false;
                                          showOtherSubSegment = false;
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
                                        setModalState(() {
                                          isloadNewSubSegment = false;
                                          showOtherSubSegment =false;
                                        });
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
                              setModalState((){
                                filterGetSubSegmentList = getSubSegmentList.where((name) => name.name!.toLowerCase().contains(value.toLowerCase())).toList();
                                filterGetSubSegmentList.isEmpty ? showOtherSubSegment=true:showOtherSubSegment=false;
                              });
                            },
                            style: BlackFieldStyle,
                          ),
                        ),
                        (filterGetSubSegmentList.isEmpty) ? SizedBox()
                            :SizedBox(
                          width: isMobile?width*0.7:tabWidth*0.7,
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: ListView.builder(
                              itemCount:filterGetSubSegmentList.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              itemBuilder: (context, index) {
                                var data = filterGetSubSegmentList[index];
                                return  Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                                  child: InkWell(
                                      onTap: (){
                                        setModalState(() {
                                          searchSubSegmentId = data.id.toString();
                                          searchSubSegmentController.text = data.name.toString() ;
                                          filterGetSubSegmentList.clear();
                                        });
                                      },
                                      child: Text("${data.name.toString()}",style:BlackFieldStyle,overflow: TextOverflow.ellipsis)),
                                );
                              },),
                          ),
                        ),
                        10.height,
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
                        child: isSaveLoader == true ?ButtonLoaderWhite(): Text(
                          From == "New" ? "Save" : "Update",
                          style: WhiteButtonStyle,
                        ),
                        onPressed: () {
                          setModalState(() {
                            isSaveLoader = true;
                          });
                          Map<dynamic, String> bodyParam = From == "New"
                              ? {
                            "user": DataManager.getInstance().getuserId().toString(),
                            "category": searchCategoryId,
                            "segment" : searchSegmentId,
                            "subsegment" : searchSubSegmentId
                          }
                              : {
                            "preference_id" : PrefChoiseCategoriesDetaisl.id.toString(),
                            "category": searchCategoryId,
                            "segment" : searchSegmentId,
                            "subsegment" : searchSubSegmentId
                          };
                          DrawAuraAPi.CreateDataApi(
                              body: bodyParam,
                              ApiEndPoint: From == "New"
                                  ? "createPreference"
                                  : "updatePreference")
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
