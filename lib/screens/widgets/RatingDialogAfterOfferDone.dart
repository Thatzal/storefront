

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loader.dart';

RatingDialog(context , Callback onTap){
  var PRODUCT = "";
  var DELIVERY = "";
 return showDialog(context: context,
   barrierDismissible: false,
   builder: (context) {
    return StatefulBuilder(builder: (context, setModalState) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15),
        backgroundColor: Colors.white,

        child: SingleChildScrollView(
          physics: ScrollPhysics(),padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          child: Column(
            children: [

               Text("Share your feedback about offer", style:BlackTitle500height,),
               SizedBox(height: 20,),
               Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Text("1. Rate the product / service like or dislike.",style: BlackSubTitleStyle,),
               ],
             ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  InkWell(
                    onTap: (){
                      setModalState((){
                        PRODUCT = "Like";
                      });
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor:PRODUCT == "Like" ?Colors.amber: Colors.black54,
                      child: Center(
                        child:PRODUCT == "Like"? Icon(Icons.thumb_up,color: Constants.primaryColor1,size: 18,):
                        Icon(Icons.thumb_up_alt_outlined,color: Colors.white,size: 18,),
                      ),
                    ),
                  ),
                  SizedBox(width: 70,),
                  InkWell(
                    onTap: (){
                      setModalState((){
                        PRODUCT = "Dislike";
                      });
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: PRODUCT == "Dislike" ?Colors.amber: Colors.black54,
                      child: Center(
                        child:PRODUCT == "Dislike"? Icon(Icons.thumb_down_alt_rounded,color: Constants.primaryColor1,size: 18,):
                        Icon(Icons.thumb_down_alt_outlined,color: Colors.white,size: 18,),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("2. Rate the delivery like or dislike.",style: BlackSubTitleStyle,),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  InkWell(
                    onTap: (){
                      setModalState((){
                        DELIVERY = "Like";
                      });
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: DELIVERY == "Like" ?Colors.amber:Colors.black54,
                      child: Center(
                        child: DELIVERY == "Like"? Icon(Icons.thumb_up,color: Constants.primaryColor1,size: 18,):
                        Icon(Icons.thumb_up_alt_outlined,color: Colors.white,size: 18,),
                      ),
                    ),
                  ),
                  SizedBox(width: 70,),
                  InkWell(
                    onTap: (){
                      setModalState((){
                        DELIVERY = "Dislike";
                      });
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: DELIVERY == "Dislike" ?Colors.amber: Colors.black54,
                      child: Center(
                        child:DELIVERY == "Dislike"? Icon(Icons.thumb_down_alt_rounded,color: Constants.primaryColor1,size: 18,):
                        Icon(Icons.thumb_down_alt_outlined,color: Colors.white,size: 18,),
                      ),
                    ),
                  ),
                ],
              ),
              25.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ElevatedButton(
                    onPressed: onTap,
                    // onPressed: (){
                    //   // setModalState((){
                    //   //   isSaveLoader = true;
                    //   // });
                    //   // Map<dynamic,String> bodyParam = {
                    //   //   "user":DataManager.getInstance().getuserId().toString(),
                    //   //   "message": MessageController.text,
                    //   //   "rating": ratings.toString(),
                    //   // };
                    //   // DrawAuraAPi.CreateDataApi(body:bodyParam,ApiEndPoint: "createSubscriberFeedback").then((value) async {
                    //   //   if(value["status"] == 200 ){
                    //   //     setState((){
                    //   //       isSaveLoader = false;
                    //   //     });
                    //   //     Constants.showToast(value["message"]);
                    //   //
                    //   //     Navigator.pop(context);
                    //   //   }else{
                    //   //     setState((){
                    //   //       isSaveLoader = false;
                    //   //     });
                    //   //     Constants.showToast(value["message"]);
                    //   //   }
                    //   // });
                    //
                    // },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 40),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      primary:primaryColor,
                    ),
                    child: Text(
                      'SUBMIT',
                      style: WhiteButtonStyle,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      );
    },);
  },).then((value) {

     Fluttertoast.showToast(
         msg: "Updated",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 2,
         backgroundColor: primaryColor,
         textColor: Colors.white,
         fontSize: 18.0
     );
     Navigator.pop(context);
 });
}