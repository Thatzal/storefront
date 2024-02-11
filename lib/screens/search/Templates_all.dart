import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:socialapps/Apis/api.dart';

import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/OfferDataModel.dart';
import 'package:socialapps/screens/widgets/ImageGalleryByUrl.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/screens/widgets/commonCards.dart';


class AllTemplatesScreens extends StatefulWidget {
  const AllTemplatesScreens({super.key});

  @override
  State<AllTemplatesScreens> createState() => _AllTemplatesScreensState();
}

class _AllTemplatesScreensState extends State<AllTemplatesScreens> {

  List<OfferDataModelResult> TemplateList = [];
  bool loader = true;
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  getData(){
    DrawAuraAPi.getTemplateList(limit: "0".toString()).then((templateRes) {
      print(templateRes);
      if(templateRes.isNotEmpty) {
        Future.delayed(Duration.zero, () {
          if (mounted) {
            setState(() {
              TemplateList = templateRes;
              loader = false;
            });
          }
        },);
      }else{
        if (mounted) {
          setState(() {
            loader = false;
          });
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var height = MediaQuery.of(context).size.height;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    var isMobile = ResponsiveHelper.isMobile(context);
    return Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading:InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back,color: Colors.black,)),
                title: const Text("Offer Templates",style:AppBarTitle,),
                elevation: 0,
              ),
              body: loader == true ? Center(
                child: LoadingWidget(),
              ) : TemplateList.isEmpty?
              Center(
                child:NotAvailableText("Not found!")
              ) :    RefreshIndicator(
                onRefresh: () async{
                  await   getData();
                  return Future.value();
                },
                child: GridView.builder(
                    shrinkWrap: true,

                    itemCount: TemplateList.length,
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:  isMobile ? 2 / 2.4 : 2 / 1.8,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    scrollDirection: Axis.vertical,
                    physics:  AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = TemplateList[index];
                      bool  isCounterSellBuy = false ;
                      for(var i = 0 ; i<data.offerData!.counterdUser!.length; i++){
                        if(data.offerData!.counterdUser![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                          isCounterSellBuy = true;
                          break ;
                        }else{
                          isCounterSellBuy = false;
                        }
                      }
                      return FutureBuilder(future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                        builder: (BuildContextcontext, AsyncSnapshot<String>snapshot) {
                          return TemplateCardGridView(context,data,snapshot,isCounterSellBuy,TemplateList,index);
                        },
                      );
                    })
              ),
          )),
    );
  }
}
Future<String?> networkImageToBase64(String imageUrl) async {
  http.Response response = await http.get(Uri.parse(imageUrl));
  final bytes = response?.bodyBytes;
  return (bytes != null ? base64Encode(bytes) : null);
}