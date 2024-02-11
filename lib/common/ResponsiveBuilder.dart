import 'package:flutter/material.dart';



class ResponsiveHelper {
  static bool isMobile(context) {
    final size = MediaQuery.of(context).size.width;
    if (size < 650 ) {
      return true;
    } else {
      return false;
    }
  }

  static double TabModeWidth = 450;
  static double TabModeHeight = 450;

}

responsiveContainer(context,Color bgColor,Widget childWidget){
  return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: ResponsiveHelper.isMobile(context)? MediaQuery.of(context).size.width: ResponsiveHelper.TabModeWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgColor,
        ),
        child: childWidget,
      )
  );
}