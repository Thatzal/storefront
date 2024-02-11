import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:socialapps/common/style.dart';
CommonAppBar(String Title,Callback onTap){
  return AppBar(
    elevation: 1,backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    leading: InkWell(onTap:onTap,child: Icon(Icons.arrow_back,color: Colors.black,size: 24,)),
    titleSpacing: 0,
    title: Text(Title,style: AppBarTitle),

  );
}