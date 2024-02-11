
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';

ShowPickerBottomSheet(context,{required Callback GalleryOnTap, required Callback CameraOnTap}){
  showModalBottomSheet(
    constraints: BoxConstraints(maxWidth: ResponsiveHelper.isMobile(context)?MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth),
    context: context,shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
    builder: (BuildContext context) {
      return SafeArea(
        child: Wrap(
          children: <Widget>[
            Padding(
              padding:  EdgeInsets.only(top:12.0),
              child: ListTile(
                leading: const Icon(Icons.photo_library,color: primaryColor,),
                minVerticalPadding: 0,
                dense: true,
                horizontalTitleGap: 10,
                title: const Text('Gallery',style: BlackFieldStyle54,),
                onTap: GalleryOnTap,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera,color: primaryColor,),
              title: const Text('Camera',style: BlackFieldStyle54,),
              minVerticalPadding: 0,
              dense: true,
              horizontalTitleGap: 10,
              onTap:CameraOnTap,
            ),
          ],
        ),
      );
    },
  );
}