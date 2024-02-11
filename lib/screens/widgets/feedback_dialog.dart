import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loader.dart';
import 'package:socialapps/controller/DataManager.dart';

showFeedBackDialog(context){
  return  showDialog(context: context, builder: (context) {
    var ratings = 4.0;
    TextEditingController MessageController = TextEditingController();
    bool isSaveLoader = false;
    return StatefulBuilder(builder: (context, setModalState) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal:20,vertical:20),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width*0.9 :ResponsiveHelper.TabModeWidth*0.9 ,
            child: Column(
              children: [
                const SizedBox(height: 20,),
                const Text("Share your rating", style:BlackHeadingStyle,),
                const SizedBox(height: 10,),
                RatingBar.builder(
                  itemSize: 36,
                  initialRating: 4,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color(0xFFF9C200),
                  ),
                  onRatingUpdate: (rating) {
                    setModalState(() {
                      ratings = rating;
                      print(ratings);
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: TextFormField(
                    maxLines: 4,
                    // maxLength: 200,
                    textCapitalization: TextCapitalization.sentences,
                    controller: MessageController,
                    style: Black87DescStyle,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xFF717971)),
                      ),
                      hintText: "If you have any additional feedback, please type it in here...",
                      hintStyle: greyHintStyle,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.only(top: 8.0, left: 14.0, right: 14.0, bottom: 8.0),
                      border: OutlineInputBorder(),
                      // hintText: 'Enter Query',hintStyle: hintstyle,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          fixedSize: Size(ResponsiveHelper.isMobile(context)?MediaQuery.sizeOf(context).width*0.35:ResponsiveHelper.TabModeWidth*0.35, 30),
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          primary:primaryColor,
                        ),
                        child: const Text(
                          'CANCEL',
                          style: WhiteButtonStyle,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: (){
                            setModalState((){
                              isSaveLoader = true;
                            });
                            Map<dynamic,String> bodyParam = {
                              "user":DataManager.getInstance().getuserId().toString(),
                              "message": MessageController.text,
                              "rating": ratings.toString(),
                            };
                            DrawAuraAPi.CreateDataApi(body:bodyParam,ApiEndPoint: "createSubscriberFeedback").then((value) async {
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
                              }
                            });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          fixedSize: Size(ResponsiveHelper.isMobile(context)?MediaQuery.sizeOf(context).width*0.35:ResponsiveHelper.TabModeWidth*0.35, 30),
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          primary:primaryColor,
                        ),
                        child: isSaveLoader == true ? ButtonLoaderWhite(): Text(
                          'SUBMIT',
                          style: WhiteButtonStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      );
    },);
  },);
}