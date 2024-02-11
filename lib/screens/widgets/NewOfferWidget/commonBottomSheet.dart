import 'package:flutter/material.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
ShowBottomSheet(context,Widget BodyWidget){
  return  showModalBottomSheet<void>(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
    ),
    context: context, builder: (context) {
      return   Column(
          children: [
            10.height,

            10.height,
            BodyWidget
          ]);
  },);
}

BottomSheetDivider(){
  return  Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 4,width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade500
        ),
      )
    ],
  );
}

EditBtn(Callback onTap){
 return InkWell(
      onTap:onTap ,
      child: Text("Edit",style:editTextStyle));
}