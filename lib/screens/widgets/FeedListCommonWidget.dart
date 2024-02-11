import 'package:flutter/material.dart';
import 'package:socialapps/model/OfferDataModel.dart';

GetFeedCardImage(context,OfferDataModelResult ? data) async{
  List  TempImageList = [
    "${data!.offerData!.offerItems!.first.itemMedia!.first.file.toString()}"
  ];
    if(data.offerData!.offerItems!.length == 1){
      if(data.offerData!.offerItems!.first.itemMedia!.length == 1){
        TempImageList.add("https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image@2x.png");
      }else{
        if(data.offerData!.offerItems!.first.itemMedia!.length == 2 ){
          TempImageList.add(data.offerData!.offerItems!.first.itemMedia![1].file.toString());
        }else{
          TempImageList.add("https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image@2x.png");
        }
      }
    }else if(data.offerData!.offerItems!.length == 2){
      if(data.offerData!.offerItems!.first.itemMedia!.length == 2 ){
        TempImageList.add(data.offerData!.offerItems!.first.itemMedia![1].file.toString());
      }else if(data.offerData!.offerItems![1].itemMedia!.isNotEmpty ){
        TempImageList.add(data.offerData!.offerItems![1].itemMedia![1].file.toString());
      }else{
        TempImageList.add("https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image@2x.png");
      }
    }else if(data.offerData!.offerItems!.length == 3){
      if(data.offerData!.offerItems!.first.itemMedia!.length == 2 ){
        TempImageList.add(data.offerData!.offerItems!.first.itemMedia![1].file.toString());
      }else if(data.offerData!.offerItems![1].itemMedia!.isNotEmpty ){
        TempImageList.add(data.offerData!.offerItems![1].itemMedia![1].file.toString());
      }else if(data.offerData!.offerItems![2].itemMedia!.isNotEmpty ){
        TempImageList.add(data.offerData!.offerItems![2].itemMedia![1].file.toString());
      }else{
        TempImageList.add("https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image@2x.png");
      }
    }else{
      TempImageList.add("https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image@2x.png");
    }

}