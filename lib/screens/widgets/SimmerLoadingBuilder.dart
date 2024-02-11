
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/ResponsiveBuilder.dart';

ShimmerLoadingBuilder(context){

  return SizedBox(
    height: 280,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        var isMobile = ResponsiveHelper.isMobile(context);
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;
        var tabWidth = ResponsiveHelper.TabModeWidth;
        var tabHeight = ResponsiveHelper.TabModeHeight;
        return Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child:  Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Color(0xFFEDF6F2),
            period:  Duration(seconds: 1),
            enabled: true,
            child: Container(
              // height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black12)),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: isMobile ?width*0.48:tabWidth*0.48,
                        height: MediaQuery.of(context).size.height*0.15,
                        decoration: BoxDecoration(
                          color:Colors.white,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                            decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                                ),
                            child: Center(child: Text("   ", style: WhiteHeadingStyle, textAlign: TextAlign.center,)),
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration:
                            const BoxDecoration(color: Colors.black45),
                            child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.remove_red_eye, color: Colors.white,size:18),
                                    Text("   Views", style: WhiteSubTitleStyle, textAlign: TextAlign.center,),
                                  ],
                                )),
                          )),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: isMobile ?width*0.48:tabWidth*0.48,

                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                       Container(
                         color:Colors.white,
                         height: 15,
                         margin: EdgeInsets.only(bottom: 3),
                         width: isMobile ?width*0.48:tabWidth*0.48,
                       ),
                        Container(
                          color:Colors.white,
                          height: 15,
                          margin: EdgeInsets.only(bottom: 3),
                          width: isMobile ?width*0.48:tabWidth*0.48,
                        ),
                        Container(
                          color:Colors.white,
                          height: 15,
                          margin: EdgeInsets.only(bottom: 3),
                          width: isMobile ?width*0.48:tabWidth*0.48,
                        ),
                        const SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18,),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Icon(Icons.favorite,color: Constants.primaryColor1,size: 20,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text("__",style: darkgreyFieldStyle,),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Icon(Icons.mode_comment,color: Constants.primaryColor1,size: 20,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text("__",style: darkgreyFieldStyle,),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text("__",style: darkgreyFieldStyle,),
                            ),
                            Image.asset("assets/time.png",height: 15,color: Constants.primaryColor1,),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text("  "
                                ,style: BlackDescStyle,
                              ),
                            )
                          ],
                        ),
                     Text("        ",style: BlackSubTitleStyle),
                        const SizedBox(height: 5,),
                        Text("                               ", style: greyHintStyle,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

ShimmerTemplateLoadingBuilder(context){

  return SizedBox(
    height:MediaQuery.of(context).size.height*0.25,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        var isMobile = ResponsiveHelper.isMobile(context);
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;
        var tabWidth = ResponsiveHelper.TabModeWidth;
        var tabHeight = ResponsiveHelper.TabModeHeight;
        return Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child:  Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Color(0xFFEDF6F2),
            period:  Duration(seconds: 1),
            enabled: true,
            child: Container(
              // height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black12)),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: isMobile ?width*0.48:tabWidth*0.48,
                        height: MediaQuery.of(context).size.height*0.15,
                        decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                            decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                            ),
                            child: Center(child: Text("   ", style: WhiteHeadingStyle, textAlign: TextAlign.center,)),
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration:
                            const BoxDecoration(color: Colors.black45),
                            child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.remove_red_eye, color: Colors.white,size:18),
                                    Text("   Views", style: WhiteSubTitleStyle, textAlign: TextAlign.center,),
                                  ],
                                )),
                          )),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: isMobile ?width*0.48:tabWidth*0.48,
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Container(
                          color:Colors.white,
                          height: 15,
                          margin: EdgeInsets.only(bottom: 3),
                          width: isMobile ?width*0.48:tabWidth*0.48,
                        ),

                        const SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18,),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Icon(Icons.favorite,color: Constants.primaryColor1,size: 20,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text("__",style: darkgreyFieldStyle,),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Icon(Icons.mode_comment,color: Constants.primaryColor1,size: 20,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text("__",style: darkgreyFieldStyle,),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text("__",style: darkgreyFieldStyle,),
                            ),
                            Image.asset("assets/time.png",height: 15,color: Constants.primaryColor1,),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text("  "
                                ,style: BlackDescStyle,
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}


ShimmerPersonLoadingBuilder(context){

  return SizedBox(
    height: MediaQuery.of(context).size.height*0.21,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        var isMobile = ResponsiveHelper.isMobile(context);
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;
        var tabWidth = ResponsiveHelper.TabModeWidth;
        var tabHeight = ResponsiveHelper.TabModeHeight;
        return Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child:  Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Color(0xFFEDF6F2),
            period:  Duration(seconds: 1),
            enabled: true,
            child: Container(
              // height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black12)),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width:isMobile ?width*0.45:tabWidth*0.45,
                        height: MediaQuery.of(context).size.height*0.2,
                        decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                        ),
                      ),

                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            width:isMobile ?width*0.45:tabWidth*0.45,
                            decoration:
                            const BoxDecoration(color: Colors.black45),
                            child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(" ", style: WhiteSubTitleStyle, textAlign: TextAlign.center,),
                                  ],
                                )),
                          )),

                    ],
                  ),

                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

ShimmerCardLoadingBuilder(context){

  return SizedBox(
    height: 35,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        var isMobile = ResponsiveHelper.isMobile(context);
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;
        var tabWidth = ResponsiveHelper.TabModeWidth;
        var tabHeight = ResponsiveHelper.TabModeHeight;
        return Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child:  Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Color(0xFFEDF6F2),
            period:  Duration(seconds: 1),
            enabled: true,
            child: Container(
               height: 30,
              width:isMobile ?width*0.32:tabWidth*0.32,
              decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black12)),

            ),
          ),
        );
      },
    ),
  );
}

ShimmerProleImageLoadingBuilder(){

  return  Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Color(0xFFEDF6F2),
    period:  Duration(seconds: 1),
    enabled: true,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade500,width: 2),
          color: Colors.grey.shade300),
    ),
  );
}

ShimmerProleBackImageLoadingBuilder(context){
  var isMobile = ResponsiveHelper.isMobile(context);
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var tabWidth = ResponsiveHelper.TabModeWidth;
  var tabHeight = ResponsiveHelper.TabModeHeight;
  return  Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Color(0xFFEDF6F2),
    period:  Duration(seconds: 1),
    enabled: true,
    child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: isMobile ?width:tabWidth,
        height: MediaQuery.of(context).size.height*0.18,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade500,width: 2),borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade300)
    ),
  );
}

ShimmerLoadingGridViewBuilder(context){

  return GridView.builder(
    shrinkWrap: true,
    itemCount: 2,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 2 / 3.7,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
    ),
    scrollDirection: Axis.vertical,
    physics: const ScrollPhysics(),
    itemBuilder: (context, index) {
      var isMobile = ResponsiveHelper.isMobile(context);
      var width = MediaQuery.of(context).size.width;
      var height = MediaQuery.of(context).size.height;
      var tabWidth = ResponsiveHelper.TabModeWidth;
      var tabHeight = ResponsiveHelper.TabModeHeight;
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child:  Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Color(0xFFEDF6F2),
          period:  Duration(seconds: 1),
          enabled: true,
          child: Container(
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black12)),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: isMobile ?width*0.48:tabWidth*0.48,
                      height: MediaQuery.of(context).size.height*0.15,
                      decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                          ),
                          child: Center(child: Text("   ", style: WhiteHeadingStyle, textAlign: TextAlign.center,)),
                        )),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 30,
                          width: 100,
                          decoration:
                          const BoxDecoration(color: Colors.black45),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.remove_red_eye, color: Colors.white,size:18),
                                  Text("   Views", style: WhiteSubTitleStyle, textAlign: TextAlign.center,),
                                ],
                              )),
                        )),

                  ],
                ),
                const SizedBox(height: 10,),
                Container(
                  width: isMobile ?width*0.48:tabWidth*0.48,

                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        color:Colors.white,
                        height: 15,
                        margin: EdgeInsets.only(bottom: 3),
                        width: isMobile ?width*0.48:tabWidth*0.48,
                      ),
                      Container(
                        color:Colors.white,
                        height: 15,
                        margin: EdgeInsets.only(bottom: 3),
                        width: isMobile ?width*0.48:tabWidth*0.48,
                      ),
                      Container(
                        color:Colors.white,
                        height: 15,
                        margin: EdgeInsets.only(bottom: 3),
                        width: isMobile ?width*0.48:tabWidth*0.48,
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18,),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Icon(Icons.favorite,color: Constants.primaryColor1,size: 20,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text("__",style: darkgreyFieldStyle,),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Icon(Icons.mode_comment,color: Constants.primaryColor1,size: 20,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text("__",style: darkgreyFieldStyle,),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text("__",style: darkgreyFieldStyle,),
                          ),
                          Image.asset("assets/time.png",height: 15,color: Constants.primaryColor1,),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text("  "
                              ,style: BlackDescStyle,
                            ),
                          )
                        ],
                      ),
                      Text("        ",style: BlackSubTitleStyle),
                      const SizedBox(height: 5,),
                      Text("                               ", style: greyHintStyle,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

ShimmerTemplateGridViewBuilder(context){

  return GridView.builder(
    shrinkWrap: true,
    itemCount: 2,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 2 / 3.7,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
    ),
    scrollDirection: Axis.vertical,
    physics: const ScrollPhysics(),
    itemBuilder: (context, index) {
      var isMobile = ResponsiveHelper.isMobile(context);
      var width = MediaQuery.of(context).size.width;
      var height = MediaQuery.of(context).size.height;
      var tabWidth = ResponsiveHelper.TabModeWidth;
      var tabHeight = ResponsiveHelper.TabModeHeight;
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child:  Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Color(0xFFEDF6F2),
          period:  Duration(seconds: 1),
          enabled: true,
          child: Container(
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black12)),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: isMobile ?width*0.48:tabWidth*0.48,
                      height: MediaQuery.of(context).size.height*0.15,
                      decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                          ),
                          child: Center(child: Text("   ", style: WhiteHeadingStyle, textAlign: TextAlign.center,)),
                        )),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 30,
                          width: 100,
                          decoration:
                          const BoxDecoration(color: Colors.black45),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.remove_red_eye, color: Colors.white,size:18),
                                  Text("   Views", style: WhiteSubTitleStyle, textAlign: TextAlign.center,),
                                ],
                              )),
                        )),

                  ],
                ),
                const SizedBox(height: 10,),
                Container(
                  width: isMobile ?width*0.48:tabWidth*0.48,

                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        color:Colors.white,
                        height: 15,
                        margin: EdgeInsets.only(bottom: 3),
                        width: isMobile ?width*0.48:tabWidth*0.48,
                      ),
                      Container(
                        color:Colors.white,
                        height: 15,
                        margin: EdgeInsets.only(bottom: 3),
                        width: isMobile ?width*0.48:tabWidth*0.48,
                      ),
                      Container(
                        color:Colors.white,
                        height: 15,
                        margin: EdgeInsets.only(bottom: 3),
                        width: isMobile ?width*0.48:tabWidth*0.48,
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18,),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Icon(Icons.favorite,color: Constants.primaryColor1,size: 20,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text("__",style: darkgreyFieldStyle,),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Icon(Icons.mode_comment,color: Constants.primaryColor1,size: 20,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text("__",style: darkgreyFieldStyle,),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text("__",style: darkgreyFieldStyle,),
                          ),
                          Image.asset("assets/time.png",height: 15,color: Constants.primaryColor1,),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text("  "
                              ,style: BlackDescStyle,
                            ),
                          )
                        ],
                      ),
                      Text("        ",style: BlackSubTitleStyle),
                      const SizedBox(height: 5,),
                      Text("                               ", style: greyHintStyle,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

MessageShowDialogWithText(context, Widget messageWidget , Callback onTap){
  showDialog(context: context,
    builder: (context) {
      var isMobile = ResponsiveHelper.isMobile(context);
      var width = MediaQuery.of(context).size.width;
      var height = MediaQuery.of(context).size.height;
      var tabWidth = ResponsiveHelper.TabModeWidth;
      var tabHeight = ResponsiveHelper.TabModeHeight;
      return Dialog(
        alignment: Alignment.center,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        elevation: BorderSide.strokeAlignOutside,
        insetPadding: EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          padding: EdgeInsets.only( top: 0,bottom: 0),
          width: isMobile?width*0.85:tabWidth*0.85,
          decoration:  BoxDecoration(color: Color(0x1A52B46B),
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Constants.greyDark,width: 0.5)
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30,left: 10,right: 10),
                child: SizedBox(
                  width: isMobile?width*0.55:tabWidth*0.55,
                  child: Center(
                    child:messageWidget,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor:Constants.primaryColor1, elevation: 1),
                        onPressed: onTap,
                        child: Text("OK",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900,color: Constants.white),)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },);
}

ShimmerFeedList(context){

  return ListView.builder(
    shrinkWrap: true,
    itemCount: 2,
    scrollDirection: Axis.vertical,
    physics: const ScrollPhysics(),
    itemBuilder: (context, index) {
      var isMobile = ResponsiveHelper.isMobile(context);
      var width = MediaQuery.of(context).size.width;
      var height = MediaQuery.of(context).size.height;
      var tabWidth = ResponsiveHelper.TabModeWidth;
      var tabHeight = ResponsiveHelper.TabModeHeight;
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Color(0xFFEDF6F2),
        period:  Duration(seconds: 1),
        enabled: true,
        child:  Container(
          margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          height: MediaQuery.of(context).size.height*0.4,
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurStyle: BlurStyle.outer,
                  blurRadius: 2
              )
            ],

            border: Border.all(color: Colors.grey,width: 0.2,

            ), ),
          width: isMobile ?width:tabWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Column(
                children: [
                  Stack(
                      children:[
                        Container(
                          width: isMobile ?width*0.4:tabWidth*0.4,
                          height:  MediaQuery.of(context).size.height * 0.20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                            image: DecorationImage(image: AssetImage("assets/image_placeholder.jpg"),fit: BoxFit.fill)
                          ),
                        ),

                      ]
                  ),
                  Stack(
                      children:[
                        Container(

                          width:  isMobile ?width*0.4:tabWidth*0.4,
                          height:  MediaQuery.of(context).size.height * 0.199,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/image_placeholder.jpg"),fit: BoxFit.fill),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
                          ),
                        )
                      ]
                  ),
                ],
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5,),
                      Container(
                        padding: const EdgeInsets.all(5),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            Text( "............",style:BlackSubTitleStyle,),
                          ],
                        ),
                      ),
                      SizedBox(height: 2,),
                      Text("posted this __ago",style: BlackSubTitleItalicStyle,),
                      const SizedBox(height: 5,),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height*0.2,
                        width:  isMobile ?width*0.5:tabWidth*0.5,
                        decoration: const BoxDecoration(
                          color:Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color:  Color(0xFFCECCCC),
                            ),
                            BoxShadow(
                              color: Colors.white70,
                              spreadRadius: -5.0,
                              blurRadius: 20.0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            RichText(text:   TextSpan(
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black
                                ),
                                children: [
                                  TextSpan(text: "                                          ",style: BlackFieldTitleStyle),
                                  TextSpan(text: "                                            ",style: BlackHintStyle,),
                                ]
                            )),
                            5.height,
                            Text("",style: BlackHintStyle,),
                            const SizedBox(height: 5,),
                            Container(
                                width:  isMobile ?width*0.5:tabWidth*0.5,
                                padding: const EdgeInsets.only(right: 3,left: 3,top:3,bottom: 3),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        blurStyle: BlurStyle.solid,
                                        color: Colors.grey.shade300
                                    )
                                  ],
                                  borderRadius: BorderRadius.all(Radius.circular(3)),
                                  color: Color(0xFFFFFFFFF),
                                ),
                                child:RichText(text: TextSpan(text: 'Status : ',style:PrimaryColor12400Style,
                                    children:[
                                      TextSpan(text: '       ',style: BlackHintStyle),
                                      const TextSpan(text: 'Response :',style: PrimaryColor12400Style),
                                      TextSpan(text: '        ',style: BlackHintStyle),
                                      const TextSpan(text: '\nExpiry :',style: PrimaryColor12400Style),
                                      TextSpan(text:"    ",style: BlackHintStyle)
                                    ]),

                                )
                            ),

                          ],
                        ),
                      ),
                      5.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          5.width,
                          Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18),
                          Spacer(),
                          Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Icon(Icons.favorite_border_outlined,color:Constants.greyDark,size: 20),
                              ),

                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text("_",style: greyFieldStyle,),
                          ),
                        InkWell(

                              child: Image.asset("assets/comment.png",height: 18,)),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text("_",style: greyFieldStyle,),
                          ),
                          Spacer(),
                          Image.asset("assets/note.png",height: 15,color:Colors.grey),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text("_",style: greyFieldStyle,),
                          ),
                          Spacer(),
                          Image.asset("assets/time.png",height: 15,color: Constants.primaryColor1,),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text("_",style: greyFieldStyle,),
                          ),
                          5.width,
                        ],
                      ),
                     Text("No Rating"),
                      // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()?SizedBox():   isCounterSellBuy == false?

                      // :SizedBox(),
                      // isCounterSellBuy == true ?
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical:3.0),
                      //   child: Text.rich(TextSpan(
                      //       text:"${data.offerCounters!.first.counter![0].tabactivity}  by  ",
                      //       style:greyDescItalicStyle,
                      //       children: <InlineSpan>[
                      //         TextSpan(
                      //           text: data.offerCounters!.first.counter![0].fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"You": "${data.offerCounters!.first.counter![0].fromCounter!.username.toString()}",
                      //           style:GreySubTitleStyle,
                      //         ),
                      //         // TextSpan(
                      //         //   text:data.offerCounters!.first.counter!.length <= 2?"": " -->${data.offerCounters!.first.counter!.length-2} More",
                      //         //   style:TextStyle(fontSize: 14,fontFamily: "Open Sans Hebrew",fontWeight: FontWeight.w900,fontStyle: FontStyle.italic,color: Colors.grey),
                      //         // ),
                      //       ]
                      //   )),
                      // ) :
                      // SizedBox(),
                      // isCounterSellBuy == true ?
                      // data.offerCounters!.first.counter!.length <= 1 ?SizedBox():    Text.rich(TextSpan(
                      //     text:"${data.offerCounters!.first.counter![1].tabactivity}  by  ",
                      //     style:greyDescItalicStyle,
                      //     children: <InlineSpan>[
                      //       TextSpan(
                      //         text: data.offerCounters!.first.counter![1].fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"You": "${data.offerCounters!.first.counter![1].fromCounter!.username.toString()}",
                      //         style:GreySubTitleStyle,
                      //       ),
                      //       TextSpan(
                      //         text:data.offerCounters!.first.counter!.length <= 2?"": " -->${data.offerCounters!.first.counter!.length-2} More",
                      //         style:GreySubTitleStyle,
                      //       ),
                      //     ]
                      // ))
                      //     : SizedBox(),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

MessageShowDialogWithTextForBlock(context, Widget messageWidget , Callback onTap){
  showDialog(context: context,
    barrierDismissible: false,
    builder: (context) {
      var width = MediaQuery.of(context).size.width;
      var height = MediaQuery.of(context).size.height;
      var tabWidth = ResponsiveHelper.TabModeWidth;
      var tabHeight = ResponsiveHelper.TabModeHeight;
      var isMobile = ResponsiveHelper.isMobile(context);
      return Dialog(
        alignment: Alignment.center,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        elevation: BorderSide.strokeAlignOutside,
        insetPadding: EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          padding: EdgeInsets.only( top: 0,bottom: 0),
          width:isMobile?width*0.85:tabWidth*0.85,
          decoration:  BoxDecoration(color: Color(0x1A52B46B),
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Constants.greyDark,width: 0.5)
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30,left: 10,right: 10),
                child: SizedBox(
                  width: isMobile?width*0.55:tabWidth*0.55,
                  child: Center(
                    child:messageWidget,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor:Constants.primaryColor1, elevation: 1),
                        onPressed: onTap,
                        child: Text("OK",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900,color: Constants.white),)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },);
}

ShimmerLoadingListViewBuilder(context){

  return ListView.builder(
    itemCount: 2,
    padding: const EdgeInsets.symmetric(vertical: 10),
    itemBuilder: (context, index) {
      var isMobile = ResponsiveHelper.isMobile(context);
      var width = MediaQuery.of(context).size.width;
      var height = MediaQuery.of(context).size.height;
      var tabWidth = ResponsiveHelper.TabModeWidth;
      var tabHeight = ResponsiveHelper.TabModeHeight;

      return     Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Color(0xFFEDF6F2),
        period:  Duration(seconds: 1),
        enabled: true,
        child: Container(
          decoration: BoxDecoration(
            borderRadius:  BorderRadius.circular(8),
              border: Border.all(color: Colors.white,width: 1)
          ),
          width: isMobile? width:tabWidth,
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          height: isMobile == false?tabHeight*0.40: height*0.20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: isMobile == false?tabHeight*0.40: height*0.20,
                width: isMobile? width*0.42:tabWidth*0.42,
                decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                    image: DecorationImage(image: AssetImage("assets/loading.gif"),fit: BoxFit.fill)
                ), ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      maxLines: 3,
                      text:   TextSpan(
                          style:BlackHintStyle,
                          children: [
                            TextSpan(text: "......",style: BlackCardTitle),
                            TextSpan(text: "........................................",style:BlackSubCardTitle,),
                          ]
                      )),
                  const SizedBox(height: 3,),

                  // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()?SizedBox():   isCounterSellBuy == false?
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:0.0),
                    child: Row(
                      children: [
                        Flexible(child: Text( "............", style: greyHintStyle,textAlign: TextAlign.start,overflow: TextOverflow.ellipsis)),
                        SizedBox(width: 4,),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 16,),
                      ),
                      Spacer(),
                      InkWell(

                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Icon(Icons.favorite_border_outlined,color:Constants.greyDark,size: 18),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0,top: 5),
                        child: Text("..",style: greyFieldStyle,),
                      ),
                      //   data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():  Spacer(),
                      // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                      // InkWell(
                      //     onTap:(){
                      //       var body = {
                      //         "offer_id": data.offerData!.id.toString(),
                      //         "user_id" : DataManager.getInstance().getuserId().toString()
                      //       };
                      //       DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                      //       bool isCommentsLoading = true;
                      //       List<CommentsDataList> CommentsList = [];
                      //       DrawAuraAPi().getOfferCommentsList(offer_id: data.offerData!.id.toString()).then((value) {
                      //         CommentsList = value;
                      //         isCommentsLoading = false;
                      //       });
                      //       showModalBottomSheet(
                      //         isScrollControlled: true,
                      //         shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)) ),
                      //         context: context, builder: (context) {
                      //         return  StatefulBuilder(builder: (context, modalState) {
                      //           isCommentsLoading == true?  Future.delayed(Duration(milliseconds: 500),() {
                      //             modalState((){});
                      //
                      //           },):null;
                      //           return Container(
                      //               height: MediaQuery.of(context).size.height*0.8,
                      //               width:isMobile?width:tabWidth,
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                      //                 color:Color(0x33DCF0DD),
                      //               ),
                      //               child: Scaffold(
                      //                 backgroundColor: Colors.transparent,
                      //                 body: Column(
                      //                   mainAxisAlignment: MainAxisAlignment.start,
                      //                   crossAxisAlignment: CrossAxisAlignment.center,
                      //                   children: [
                      //                     Container(
                      //                         height: 3.5,
                      //                         margin: EdgeInsets.only(top: 13),
                      //                         width: 38,
                      //                         decoration: BoxDecoration(
                      //                           borderRadius: BorderRadius.circular(5),
                      //                           color: Colors.black54,
                      //                         )),
                      //                     20.height,
                      //                     Text("Comments",style:BlackSubTitleStyle,),
                      //                     10.height,
                      //                     Divider(color: Colors.black,height: 2.5,thickness: 1.2),
                      //                     2.height,
                      //                     // isCommentsLoading?
                      //                     // Padding(
                      //                     //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                      //                     //   child: LoadingWidget(),
                      //                     // )
                      //                     //     :
                      //                     //
                      //                     // CommentsList.isEmpty?
                      //                     // Padding(
                      //                     //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                      //                     //   child: Image(image: AssetImage("assets/NoData.png"),fit: BoxFit.fill,width: 85,height: 85,),
                      //                     // )
                      //                     //     : Expanded(
                      //                     //   child: ListView.builder(
                      //                     //     controller: scrollCommentsController,
                      //                     //     itemCount: CommentsList.length,
                      //                     //     padding: EdgeInsets.only(bottom: 100),
                      //                     //     itemBuilder: (context, i) {
                      //                     //       var CommentsData = CommentsList[i];
                      //                     //       final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${CommentsData.createdAt.toString()}');
                      //                     //       final currentTime = DateTime.now();
                      //                     //       final diff_dy = currentTime.difference(startTime).inDays;
                      //                     //       final diff_mi = currentTime.difference(startTime).inMinutes;
                      //                     //       final diff_s = currentTime.difference(startTime).inSeconds;
                      //                     //       final diff_hr = currentTime.difference(startTime).inHours;
                      //                     //       return Row(
                      //                     //         mainAxisAlignment: MainAxisAlignment.start,
                      //                     //         crossAxisAlignment: CrossAxisAlignment.start,
                      //                     //         children: [
                      //                     //           Container(
                      //                     //             margin: EdgeInsets.only(left: 15,right: 0,top: 5),
                      //                     //             height: 40,
                      //                     //             width: 40,
                      //                     //             decoration: BoxDecoration(
                      //                     //                 shape: BoxShape.circle,
                      //                     //                 image:
                      //                     //                 CommentsData.user!.profilePicture == null ||
                      //                     //                     CommentsData.user!.profilePicture.toString() == "null" ||
                      //                     //                     CommentsData.user!.profilePicture.toString()  == "" ?
                      //                     //                 DecorationImage(image:   AssetImage("assets/home.png"),fit: BoxFit.fill):
                      //                     //                 DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${CommentsData.user!.profilePicture}"),fit: BoxFit.fill)
                      //                     //             ),
                      //                     //           ),
                      //                     //           Flexible(
                      //                     //             child: Container(
                      //                     //               padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                      //                     //               margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      //                     //               decoration: BoxDecoration(
                      //                     //                 borderRadius: BorderRadius.circular(7),
                      //                     //                 color: Constants.white,
                      //                     //               ),
                      //                     //               child: Column(
                      //                     //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                     //                 mainAxisAlignment: MainAxisAlignment.start,
                      //                     //                 children: [
                      //                     //                   Row(
                      //                     //                     children: [
                      //                     //                       Text("${CommentsData.user!.username}",style: BlackSubTitleStyle,),
                      //                     //                       10.width,
                      //                     //                       Text(diff_s <= 60 ?"$diff_s""s":diff_mi <= 60 ?"$diff_mi"'m':diff_hr <= 24 ?"$diff_hr"'h':"$diff_dy"'d',style: greyDescItalicStyle,)
                      //                     //                     ],
                      //                     //                   ),
                      //                     //
                      //                     //                   Padding(
                      //                     //                     padding: const EdgeInsets.only(top: 2.0),
                      //                     //                     child: Text('''${CommentsData.comment}''',style: Black87DescStyle,),
                      //                     //                   ),
                      //                     //                 ],
                      //                     //               ),
                      //                     //             ),
                      //                     //           ),
                      //                     //         ],
                      //                     //       );
                      //                     //     },),
                      //                     // ),
                      //                   ],
                      //                 ),
                      //                 bottomSheet:Container(
                      //
                      //                   decoration: BoxDecoration(
                      //                       color: Color(0x33DCF0DD),
                      //
                      //                       border: Border(top: BorderSide(color: Constants.greyLight,width: 1.5))
                      //                   ),
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                     crossAxisAlignment: CrossAxisAlignment.center,
                      //                     children: [
                      //
                      //                       10.width,
                      //                       Container(
                      //                         height: 35,
                      //                         width: 35,
                      //                         margin: const EdgeInsets.only(bottom: 5),
                      //                         padding: EdgeInsets.zero,
                      //                         decoration: BoxDecoration(
                      //                             borderRadius: BorderRadius.circular(5),
                      //                             color: Constants.greyDark
                      //                         ),
                      //                         child: Center(child: Container(
                      //                           height: 35,width: 35,
                      //                           decoration: DataManager.getInstance().getuserImage() == "null" ||  DataManager.getInstance().getuserImage() == null ||DataManager.getInstance().getuserImage()=="" ? BoxDecoration(
                      //                             // border: Border.all(color: Constants.white,width: 4),
                      //                               shape: BoxShape.circle,
                      //                               image: DecorationImage(image: AssetImage("assets/home.png"),)
                      //                           ):  BoxDecoration(
                      //                               border: Border.all(color: Constants.white,width: 2),
                      //                               shape: BoxShape.circle,
                      //                               image: DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${DataManager.getInstance().getuserImage()}"),fit: BoxFit.fill)
                      //                           ),
                      //                         )),
                      //                       ),
                      //
                      //                       Flexible(
                      //                         child: TextFormField(
                      //                           controller: messageController,
                      //                           keyboardType: TextInputType.text,
                      //                           // maxLines: ,
                      //                           onChanged: (value){
                      //                             setState(() {
                      //
                      //                             });
                      //                             modalState((){});
                      //                           },
                      //                           autofocus: false,
                      //                           focusNode: focusNode,
                      //                           // style: black14500,
                      //                           cursorColor: Colors.black,textAlignVertical: TextAlignVertical.center,
                      //                           decoration: InputDecoration(
                      //                             contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                      //                             border: const OutlineInputBorder(borderSide: BorderSide.none),
                      //                             hintText: "Write your comments",
                      //                             hintStyle: greySubTitleItalicStyle,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       messageController.text.isEmpty?SizedBox():InkWell(
                      //                         onTap: (){
                      //                           // messageController.clear();
                      //                           DrawAuraAPi.CreateOfferComments(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString(),Comments: messageController.text).then((value) {
                      //                             if(value["status"] == "200"){
                      //                               var CommentRes =  CommentsDataList(
                      //                                 id: value["result"]["id"],
                      //                                 user:CommentsUser(
                      //                                     id: value["result"]["user"]["id"],
                      //                                     displayname:  value["result"]["user"]["displayname"],
                      //                                     profilePicture:  value["result"]["user"]["profile_picture"],
                      //                                     username:  value["result"]["user"]["username"]
                      //                                 ),
                      //                                 offer: value["result"]["offer"],
                      //                                 comment: value["result"]["comment"],
                      //                                 createdAt: value["result"]["created_at"],
                      //                                 updatedAt: value["result"]["updated_at"],
                      //                               );
                      //                               modalState((){
                      //                                 CommentsList.add(CommentRes);
                      //                                 messageController.clear();
                      //                                 scrollToBottom();
                      //                               });
                      //                             }
                      //                           });
                      //                         },
                      //                         child: Container(
                      //                           margin: EdgeInsets.only(right: 10),
                      //                           height: 40,
                      //                           width: 40,
                      //                           decoration: BoxDecoration(
                      //                               shape: BoxShape.circle,
                      //                               border: Border.all(color: Constants.greyLight,width: 1),
                      //                               color:Constants.primaryColor
                      //                           ),
                      //                           child: Center(child:Icon(Icons.send,color: Colors.white,size: 24,)),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 // Column(
                      //                 //   crossAxisAlignment: CrossAxisAlignment.center,
                      //                 //   mainAxisSize: MainAxisSize.max,
                      //                 //   mainAxisAlignment: MainAxisAlignment.end,
                      //                 //   children: [
                      //                 //     Container(
                      //                 //       height: 50,
                      //                 //       decoration: BoxDecoration(
                      //                 //         color: Color(
                      //                 //             0x1ABCDFF8),
                      //                 //         border: Border(top: BorderSide(color: Constants.greyLight))
                      //                 //       ),
                      //                 //       child: Row(
                      //                 //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                 //         children: [
                      //                 //
                      //                 //           const SizedBox(width: 7,),
                      //                 //           isemojiShowing == false?
                      //                 //           InkWell(
                      //                 //               onTap: (){
                      //                 //                 // controller.focusNode.value.unfocus();
                      //                 //                 // controller.focusNode.value.canRequestFocus=false;
                      //                 //                 // Future.delayed(Duration(milliseconds: 100),() {
                      //                 //                 //   controller.emojiShowing.value = !controller.emojiShowing.value;
                      //                 //                 //   // controller.focusNode.value.requestFocus();
                      //                 //                 //   // controller.filepick.value = false;
                      //                 //                 //   // controller.showStickers.value = false;
                      //                 //                 //   // controller.showAttachmentButtons.value = false;
                      //                 //                 // },);
                      //                 //                 //
                      //                 //                 // controller.filepick.value = false;
                      //                 //                 // // if ( controller.emojiShowing.value != false) {
                      //                 //                 // //   FocusScope.of(context).unfocus();
                      //                 //                 // // }
                      //                 //               },
                      //                 //               child: const Icon(Icons.tag_faces_outlined,size: 24,color: Colors.amber,)):
                      //                 //           InkWell(
                      //                 //             onTap: () {
                      //                 //               // controller.focusNode.value.requestFocus();
                      //                 //               // controller.emojiShowing.value = false;
                      //                 //               // controller.filepick.value = false;
                      //                 //               // controller.showStickers.value = false;
                      //                 //               // controller.showAttachmentButtons.value = false;
                      //                 //
                      //                 //             },
                      //                 //             child: const Padding(
                      //                 //               padding: EdgeInsets.symmetric(horizontal: 8.0),
                      //                 //               child: Icon(
                      //                 //                 Icons.keyboard,
                      //                 //                 color: Colors.black45,size: 22,
                      //                 //               ),
                      //                 //             ),
                      //                 //           ),
                      //                 //           Flexible(
                      //                 //             child: TextFormField(
                      //                 //               controller: messageController,
                      //                 //               onChanged: (value){
                      //                 //
                      //                 //               },
                      //                 //               autofocus: false,
                      //                 //               focusNode: focusNode,
                      //                 //               // style: black14500,
                      //                 //               cursorColor: Colors.black,
                      //                 //               onTap: (){
                      //                 //                 isemojiShowing = false;
                      //                 //               },
                      //                 //               decoration: InputDecoration(
                      //                 //                 border: const OutlineInputBorder(borderSide: BorderSide.none),
                      //                 //                 hintText: "Write your comments",
                      //                 //                 hintStyle: grey14400,
                      //                 //               ),
                      //                 //             ),
                      //                 //           ),
                      //                 //
                      //                 //         ],
                      //                 //       ),
                      //                 //     ),
                      //                 //     Offstage(
                      //                 //       offstage: isemojiShowing,
                      //                 //       child: SizedBox(
                      //                 //         height: 240,
                      //                 //         child: emg.EmojiPicker(
                      //                 //
                      //                 //           onEmojiSelected: (emg.Category ?category, emg.Emoji emoji) {
                      //                 //             onEmojiSelected(emoji);
                      //                 //             messageChecker = emoji.toString();
                      //                 //           },
                      //                 //           onBackspacePressed: onBackspacePressed,
                      //                 //           config: emg.Config(
                      //                 //             columns: 9,
                      //                 //             // Issue: https://github.com/flutter/flutter/issues/28894
                      //                 //             emojiSizeMax: 24 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
                      //                 //             verticalSpacing: 0,
                      //                 //             horizontalSpacing: 0,
                      //                 //             gridPadding: EdgeInsets.zero,
                      //                 //             initCategory: emg.Category.RECENT,
                      //                 //             bgColor: const Color(0xFFF2F2F2),
                      //                 //             indicatorColor: Constants.primaryColor,
                      //                 //             iconColor: Colors.grey,
                      //                 //             iconColorSelected:  Constants.primaryColor,
                      //                 //             backspaceColor:  Constants.primaryColor,
                      //                 //             skinToneDialogBgColor: Colors.white,
                      //                 //             skinToneIndicatorColor: Colors.grey,
                      //                 //             enableSkinTones: true,
                      //                 //             // showRecentsTab: true,
                      //                 //             recentsLimit: 28,
                      //                 //             replaceEmojiOnLimitExceed: false,
                      //                 //             noRecents: const Text(
                      //                 //               'No Recent',
                      //                 //               style: TextStyle(fontSize: 20, color: Colors.black26),
                      //                 //               textAlign: TextAlign.center,
                      //                 //             ),
                      //                 //             loadingIndicator: const SizedBox.shrink(),
                      //                 //             tabIndicatorAnimDuration: kTabScrollDuration,
                      //                 //             categoryIcons: const emg.CategoryIcons(),
                      //                 //             buttonMode: emg.ButtonMode.MATERIAL,
                      //                 //             checkPlatformCompatibility: true,
                      //                 //           ),
                      //                 //         ),
                      //                 //       ),
                      //                 //     ),
                      //                 //   ],
                      //                 // ),
                      //               )
                      //           );
                      //         },);
                      //
                      //       },).then((value) {
                      //
                      //       });
                      //     },
                      //     child: Image.asset("assets/comment.png",height: 18,)),
                      // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 3.0),
                      //   child: Text("${data.offerData!.comments.toString().split(".").first}",style: greyFieldStyle,),
                      // ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset("assets/note.png",height: 15,color:Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0,top: 5,right: 20),
                        child: Text("..",style: greyFieldStyle,),
                      ),
                    ],
                  ),

                ],
                  ),
                ),
              ),
       ]
          ))
      );
      // return FutureBuilder(
      //   future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.media),
      //   builder: (BuildContext context,
      //       AsyncSnapshot<String> snapshot) {
      //     return Container(
      //       height: isMobile?height * 0.23:tabHeight*0.40,
      //       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
      //           border: Border.all(color: Colors.grey)),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           InkWell(
      //             onTap: () async {
      //               tapOnOffer(context,data,
      //                   data.offerData!.buyORsell == "COUNTER SELL" ||  data.offerData!.buyORsell == "COUNTER BUY" ?true:false,
      //                   isConfirmingUser);
      //
      //               // if (data.offerData!.offerstatus.toString().trim().toUpperCase() == "CLOSED") {
      //               //   if (isConfirmingUser == false) {
      //               //     final fromPeriodDate = data.offerData!.offerConditions!.fromperiod == null ? "" : data.offerData!.offerConditions!.fromperiod.toString();
      //               //     final fromPeriodTime = data.offerData!.offerConditions!.fromperiodtime == null ? "" : data.offerData!.offerConditions!.fromperiodtime.toString();
      //               //     final toPeriodDate = data.offerData!.offerConditions!.toperiod == null ? "" : data.offerData!.offerConditions!.toperiod.toString();
      //               //     final toPeriodTime = data.offerData!.offerConditions!.toperiodtime == null ? "" : data.offerData!.offerConditions!.toperiodtime.toString();
      //               //     List serviceTemp = jsonDecode("${data.offerData!.offerareas!.toString()}");
      //               //     List<ServiceAreaModel>serviceAreaList = serviceTemp.map((e) => ServiceAreaModel.fromJson(e)).toList();
      //               //     List<PrefillOfferBids>FillBids = [];
      //               //     List<PrefillOfferItems>FillItmsList = [];
      //               //     for (var j = 0; j < data.offerData!.offerItems!.length; j++) {final imgBase64Str = [];
      //               //     for (var k = 0; k < data.offerData!.offerItems![j].itemMedia!.length; k++) {
      //               //       imgBase64Str.add({
      //               //         "file": "${await networkImageToBase64('${Url.IMAGE_URL}${data.offerData!.offerItems![j].itemMedia![k].media}')}",
      //               //         "name": "temp${data.offerData!.offerItems![j].itemMedia![k].media.toString().substring(data.offerData!.offerItems![j].itemMedia![k].media.toString().lastIndexOf('.'))}"
      //               //       });
      //               //     }
      //               //     final fromPeriodDate = data.offerData!.offerItems![j].offerItemConditions!.fromperiod == null ? "" : data.offerData!.offerItems![j].offerItemConditions!.fromperiod.toString();
      //               //     final fromPeriodTime = data.offerData!.offerItems![j].offerItemConditions!.fromperiodtime == null ? "" : data.offerData!.offerItems![j].offerItemConditions!.fromperiodtime.toString();
      //               //     final toPeriodDate = data.offerData!.offerItems![j].offerItemConditions!.toperiod == null ? "" : data.offerData!.offerItems![j].offerItemConditions!.toperiod.toString();
      //               //     final toPeriodTime = data.offerData!.offerItems![j].offerItemConditions!.toperiodtime == null ? "" : data.offerData!.offerItems![j].offerItemConditions!.toperiodtime.toString();
      //               //
      //               //     FillItmsList.add(
      //               //         PrefillOfferItems(
      //               //             name: "${data
      //               //                 .offerData!
      //               //                 .offerItems![j]
      //               //                 .name
      //               //                 .toString()}",
      //               //             addon: data
      //               //                 .offerData!
      //               //                 .offerItems![j]
      //               //                 .addon,
      //               //             desc: "${data
      //               //                 .offerData!
      //               //                 .offerItems![j]
      //               //                 .desc
      //               //                 .toString()}",
      //               //             itemMedia: imgBase64Str,
      //               //             offerItemConditions: PrefillOfferItemConditions(
      //               //               priority: data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .priority ==
      //               //                   null
      //               //                   ? ""
      //               //                   : data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .priority
      //               //                   .toString(),
      //               //               periodicity: data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .periodicity ==
      //               //                   null
      //               //                   ? ""
      //               //                   : data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .periodicity
      //               //                   .toString(),
      //               //               duration: data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .duration ==
      //               //                   null
      //               //                   ? ""
      //               //                   : data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .duration
      //               //                   .toString(),
      //               //               fromlocation: data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .fromlocation ==
      //               //                   null
      //               //                   ? ""
      //               //                   : data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .fromlocation
      //               //                   .toString(),
      //               //               tolocation: data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .tolocation ==
      //               //                   null
      //               //                   ? ""
      //               //                   : data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .tolocation
      //               //                   .toString(),
      //               //               atlocation: data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .atlocation ==
      //               //                   null
      //               //                   ? ""
      //               //                   : data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .atlocation
      //               //                   .toString(),
      //               //               expiry: data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .expiry ==
      //               //                   null
      //               //                   ? ""
      //               //                   : data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .expiry
      //               //                   .toString(),
      //               //               servicepersons: data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .offerItemConditions!
      //               //                   .servicepersons,
      //               //               timePeriod: "${fromPeriodTime ==
      //               //                   "" &&
      //               //                   fromPeriodDate ==
      //               //                       "" &&
      //               //                   toPeriodDate ==
      //               //                       "" &&
      //               //                   toPeriodTime ==
      //               //                       ""
      //               //                   ? ""
      //               //                   : toPeriodDate !=
      //               //                   "" &&
      //               //                   toPeriodTime !=
      //               //                       ""
      //               //                   ? "From " +
      //               //                   fromPeriodDate +
      //               //                   " " +
      //               //                   fromPeriodTime +
      //               //                   " To " +
      //               //                   toPeriodDate +
      //               //                   " " +
      //               //                   toPeriodTime
      //               //                   : "From " +
      //               //                   fromPeriodDate +
      //               //                   " " +
      //               //                   fromPeriodTime}",
      //               //             ),
      //               //             price: data
      //               //                 .offerData!
      //               //                 .offerItems![j]
      //               //                 .price,
      //               //             unit: PrefillUnit(
      //               //                 id: data
      //               //                     .offerData!
      //               //                     .offerItems![j]
      //               //                     .unit!.id,
      //               //                 name: data
      //               //                     .offerData!
      //               //                     .offerItems![j]
      //               //                     .unit!
      //               //                     .name),
      //               //             quantity: data
      //               //                 .offerData!
      //               //                 .offerItems![j]
      //               //                 .quantity,
      //               //             required: data
      //               //                 .offerData!
      //               //                 .offerItems![j]
      //               //                 .required,
      //               //             toggleState: data
      //               //                 .offerData!
      //               //                 .offerItems![j]
      //               //                 .toggleState,
      //               //             advancePrice: data
      //               //                 .offerData!
      //               //                 .offerItems![j]
      //               //                 .advancePrice,
      //               //             maintenancePrice: data
      //               //                 .offerData!
      //               //                 .offerItems![j]
      //               //                 .maintenancePrice,
      //               //             advanceUnit: FillAdvanceUnit(
      //               //                 id: data
      //               //                     .offerData!
      //               //                     .offerItems![j]
      //               //                     .advanceUnit!
      //               //                     .id,
      //               //                 name: data
      //               //                     .offerData!
      //               //                     .offerItems![j]
      //               //                     .advanceUnit!
      //               //                     .name),
      //               //             maintenanceUnit: FillMaintenanceUnit(
      //               //                 id: data
      //               //                     .offerData!
      //               //                     .offerItems![j]
      //               //                     .maintenanceUnit!
      //               //                     .id,
      //               //                 name: data
      //               //                     .offerData!
      //               //                     .offerItems![j]
      //               //                     .maintenanceUnit!
      //               //                     .name)));
      //               //     }
      //               //     var preFillDetails =
      //               //     PrefillOfferDataModel(
      //               //       addres: data
      //               //           .offerData!
      //               //           .addres
      //               //           .toString(),
      //               //       buyORsell: data
      //               //           .offerData!
      //               //           .buyORsell
      //               //           .toString(),
      //               //       category:
      //               //       FillCategory(
      //               //         id: data.offerData!
      //               //             .category!.id,
      //               //         name:
      //               //         data.offerData!
      //               //             .category!.name,
      //               //       ),
      //               //       segment:
      //               //       FillSegment(
      //               //         name:
      //               //         data.offerData!.segment!
      //               //             .name,
      //               //         id: data.offerData!
      //               //             .segment!.id,
      //               //         category:
      //               //         data.offerData!.segment!
      //               //             .category,
      //               //       ),
      //               //       subsegment:
      //               //       FillSubsegment(
      //               //         id: data.offerData!
      //               //             .subsegment!.id,
      //               //         name:
      //               //         data.offerData!
      //               //             .subsegment!.name,
      //               //         segment:
      //               //         data.offerData!
      //               //             .subsegment!
      //               //             .segment,
      //               //       ),
      //               //       offerConditions:
      //               //       PrefillOfferConditions(
      //               //         fromPeriod:
      //               //         data.offerData!
      //               //             .offerConditions!
      //               //             .fromperiod,
      //               //         toPeriod:
      //               //         data.offerData!
      //               //             .offerConditions!
      //               //             .toperiod,
      //               //         fromPeriodTime:
      //               //         data.offerData!
      //               //             .offerConditions!
      //               //             .fromperiodtime,
      //               //         toPeriodTime:
      //               //         data.offerData!
      //               //             .offerConditions!
      //               //             .toperiodtime,
      //               //         priority:
      //               //         data.offerData!
      //               //             .offerConditions!
      //               //             .priority.toString()
      //               //             .trim(),
      //               //         periodicity:
      //               //         data.offerData!
      //               //             .offerConditions!
      //               //             .periodicity
      //               //             .toString().trim(),
      //               //         duration:
      //               //         data.offerData!
      //               //             .offerConditions!
      //               //             .duration,
      //               //         fromlocation:
      //               //         data.offerData!
      //               //             .offerConditions!
      //               //             .fromlocation,
      //               //         tolocation:
      //               //         data.offerData!
      //               //             .offerConditions!
      //               //             .tolocation,
      //               //         atlocation:
      //               //         data.offerData!
      //               //             .offerConditions!
      //               //             .atlocation,
      //               //         expiry:
      //               //         data.offerData!
      //               //             .offerConditions!
      //               //             .expiry,
      //               //         servicepersons:
      //               //         data.offerData!
      //               //             .offerConditions!
      //               //             .servicepersons,
      //               //         timePeriod: fromPeriodTime ==
      //               //             "" &&
      //               //             fromPeriodDate ==
      //               //                 "" &&
      //               //             toPeriodDate ==
      //               //                 "" &&
      //               //             toPeriodTime == ""
      //               //             ? ""
      //               //             : toPeriodDate !=
      //               //             "" &&
      //               //             toPeriodTime != ""
      //               //             ? "From " +
      //               //             fromPeriodDate +
      //               //             " " +
      //               //             fromPeriodTime +
      //               //             " To " +
      //               //             toPeriodDate + " " +
      //               //             toPeriodTime
      //               //             : "From " +
      //               //             fromPeriodDate +
      //               //             " " +
      //               //             fromPeriodTime,
      //               //       ),
      //               //       tabactivity:
      //               //       "New",
      //               //       offerareas:
      //               //       serviceAreaList,
      //               //       offerBids:
      //               //       FillBids,
      //               //       offerItems:
      //               //       FillItmsList,
      //               //     );
      //               //     Navigator.push(
      //               //         context,
      //               //         MaterialPageRoute(
      //               //           builder: (context) =>
      //               //               NewOfferCreateScreen(
      //               //                   Address: "",
      //               //                   AddressTitle: "",
      //               //                   From: "Fill",
      //               //                   PrefillOfferData: preFillDetails,
      //               //                   Type: "Template",
      //               //                   OfferId: data
      //               //                       .offerData!
      //               //                       .id
      //               //                       .toString(),
      //               //                   SubId: data
      //               //                       .offerData!
      //               //                       .subscribers!
      //               //                       .id
      //               //                       .toString()),
      //               //         ));
      //               //   } else {
      //               //     if (data.offerData!.buyORsell == "COUNTER SELL" || data.offerData!.buyORsell == "COUNTER BUY") {
      //               //       if (data.offerData!.abusedUser!.contains(num.parse(DataManager.getInstance().getuserId().toString()))) {
      //               //         Constants.showToast("${Url.abusedReportMessage.toString()}");
      //               //       } else {
      //               //         Get.to(() => lastCounterScreen(OferId: data.offerData!.id.toString(), to_Couter_Id: data.offerData!.subscribers!.id.toString()))!.then((value) {
      //               //           DrawAuraAPi.getSubscriberOfferApi(SubcriberId: DataManager.getInstance().getuserId().toString()).then((
      //               //               SubscriberOfferRes) {
      //               //             if (SubscriberOfferRes["status"] == "200") {
      //               //               SubscriberOfferDetailsWithoutModel =
      //               //               SubscriberOfferRes["result"];
      //               //               SubscriberOfferDetails = OfferDataModel.fromJson(SubscriberOfferRes);
      //               //               getMyOffersList = SubscriberOfferDetails!.result!;
      //               //             }
      //               //             DrawAuraAPi.getSubscriberCounterOfferApi(SubcriberId: DataManager.getInstance().getuserId().toString()).then((SubscriberCounterOfferRes) {
      //               //               if (SubscriberCounterOfferRes["status"] == "200") {
      //               //                 SubscriberCouterOfferDetails = OfferDataModel.fromJson(SubscriberCounterOfferRes);
      //               //                 getMyCounterOffersList = SubscriberCouterOfferDetails!.result!;
      //               //                 getMyOffersList.addAll(getMyCounterOffersList);
      //               //                 //  getMyOffersList.sort((a, b)=> DateTime.parse(a.offerData!.createdAt.toString()).compareTo(DateTime.parse(b.offerData!.createdAt.toString())));
      //               //               }
      //               //             });
      //               //           });
      //               //         });
      //               //       }
      //               //     } else {
      //               //       if (data.offerCounters!.isNotEmpty) {Get.to(() =>
      //               //           HomeDetailScreen(offerId: data.offerData!.id.toString()))!.then((value) {
      //               //         DrawAuraAPi.getSubscriberOfferApi(SubcriberId: DataManager.getInstance().getuserId().toString()).then((
      //               //             SubscriberOfferRes) {
      //               //           if (SubscriberOfferRes["status"] ==
      //               //               "200") {
      //               //             SubscriberOfferDetailsWithoutModel =
      //               //             SubscriberOfferRes["result"];
      //               //             SubscriberOfferDetails =
      //               //                 OfferDataModel
      //               //                     .fromJson(
      //               //                     SubscriberOfferRes);
      //               //             getMyOffersList =
      //               //             SubscriberOfferDetails!
      //               //                 .result!;
      //               //           }
      //               //           DrawAuraAPi
      //               //               .getSubscriberCounterOfferApi(
      //               //               SubcriberId: DataManager
      //               //                   .getInstance()
      //               //                   .getuserId()
      //               //                   .toString())
      //               //               .then((
      //               //               SubscriberCounterOfferRes) {
      //               //             if (SubscriberCounterOfferRes["status"] ==
      //               //                 "200") {
      //               //               SubscriberCouterOfferDetails =
      //               //                   OfferDataModel
      //               //                       .fromJson(
      //               //                       SubscriberCounterOfferRes);
      //               //               getMyCounterOffersList =
      //               //               SubscriberCouterOfferDetails!
      //               //                   .result!;
      //               //               getMyOffersList
      //               //                   .addAll(
      //               //                   getMyCounterOffersList);
      //               //               //  getMyOffersList.sort((a, b)=> DateTime.parse(a.offerData!.createdAt.toString()).compareTo(DateTime.parse(b.offerData!.createdAt.toString())));
      //               //             }
      //               //           });
      //               //         });
      //               //       });
      //               //       } else {
      //               //         final fromPeriodDate = data
      //               //             .offerData!
      //               //             .offerConditions!
      //               //             .fromperiod == null
      //               //             ? ""
      //               //             : data.offerData!
      //               //             .offerConditions!
      //               //             .fromperiod
      //               //             .toString();
      //               //         final fromPeriodTime = data
      //               //             .offerData!
      //               //             .offerConditions!
      //               //             .fromperiodtime ==
      //               //             null
      //               //             ? ""
      //               //             : data.offerData!
      //               //             .offerConditions!
      //               //             .fromperiodtime
      //               //             .toString();
      //               //         final toPeriodDate = data
      //               //             .offerData!
      //               //             .offerConditions!
      //               //             .toperiod == null
      //               //             ? ""
      //               //             : data.offerData!
      //               //             .offerConditions!
      //               //             .toperiod
      //               //             .toString();
      //               //         final toPeriodTime = data
      //               //             .offerData!
      //               //             .offerConditions!
      //               //             .toperiodtime ==
      //               //             null
      //               //             ? ""
      //               //             : data.offerData!
      //               //             .offerConditions!
      //               //             .toperiodtime
      //               //             .toString();
      //               //         List
      //               //         serviceTemp =
      //               //         jsonDecode(
      //               //             "${data.offerData!
      //               //                 .offerareas!
      //               //                 .toString()}");
      //               //         List<ServiceAreaModel>
      //               //         serviceAreaList =
      //               //         serviceTemp.map((e) =>
      //               //             ServiceAreaModel
      //               //                 .fromJson(e))
      //               //             .toList();
      //               //         List<PrefillOfferBids>
      //               //         FillBids =
      //               //         [];
      //               //         List<PrefillOfferItems>
      //               //         FillItmsList =
      //               //         [];
      //               //         for (var j = 0;
      //               //         j < data.offerData!
      //               //             .offerItems!.length;
      //               //         j++) {
      //               //           final imgBase64Str = [
      //               //           ];
      //               //
      //               //           for (var k = 0; k <
      //               //               data.offerData!
      //               //                   .offerItems![j]
      //               //                   .itemMedia!
      //               //                   .length; k++) {
      //               //             imgBase64Str.add({
      //               //               "file": "${await networkImageToBase64(
      //               //                   '${Url
      //               //                       .IMAGE_URL}${data
      //               //                       .offerData!
      //               //                       .offerItems![j]
      //               //                       .itemMedia![k]
      //               //                       .media}')}",
      //               //               "name": "temp${data
      //               //                   .offerData!
      //               //                   .offerItems![j]
      //               //                   .itemMedia![k]
      //               //                   .media
      //               //                   .toString()
      //               //                   .substring(
      //               //                   data
      //               //                       .offerData!
      //               //                       .offerItems![j]
      //               //                       .itemMedia![k]
      //               //                       .media
      //               //                       .toString()
      //               //                       .lastIndexOf(
      //               //                       '.'))}"
      //               //             });
      //               //           }
      //               //
      //               //           //    final imgBase64Str = data.offerData!.offerItems![j].itemMedia!.isEmpty?"": "${await networkImageToBase64('${Url.IMAGE_URL}${data.offerData!.offerItems![j].itemMedia![0].media}')}";
      //               //           final fromPeriodDate = data
      //               //               .offerData!
      //               //               .offerItems![j]
      //               //               .offerItemConditions!
      //               //               .fromperiod ==
      //               //               null ? "" : data
      //               //               .offerData!
      //               //               .offerItems![j]
      //               //               .offerItemConditions!
      //               //               .fromperiod
      //               //               .toString();
      //               //           final fromPeriodTime = data
      //               //               .offerData!
      //               //               .offerItems![j]
      //               //               .offerItemConditions!
      //               //               .fromperiodtime ==
      //               //               null ? "" : data
      //               //               .offerData!
      //               //               .offerItems![j]
      //               //               .offerItemConditions!
      //               //               .fromperiodtime
      //               //               .toString();
      //               //           final toPeriodDate = data
      //               //               .offerData!
      //               //               .offerItems![j]
      //               //               .offerItemConditions!
      //               //               .toperiod == null
      //               //               ? ""
      //               //               : data.offerData!
      //               //               .offerItems![j]
      //               //               .offerItemConditions!
      //               //               .toperiod
      //               //               .toString();
      //               //           final toPeriodTime = data
      //               //               .offerData!
      //               //               .offerItems![j]
      //               //               .offerItemConditions!
      //               //               .toperiodtime ==
      //               //               null ? "" : data
      //               //               .offerData!
      //               //               .offerItems![j]
      //               //               .offerItemConditions!
      //               //               .toperiodtime
      //               //               .toString();
      //               //
      //               //           FillItmsList.add(
      //               //               PrefillOfferItems(
      //               //                   name: "${data
      //               //                       .offerData!
      //               //                       .offerItems![j]
      //               //                       .name
      //               //                       .toString()}",
      //               //                   addon: data
      //               //                       .offerData!
      //               //                       .offerItems![j]
      //               //                       .addon,
      //               //                   desc: "${data
      //               //                       .offerData!
      //               //                       .offerItems![j]
      //               //                       .desc
      //               //                       .toString()}",
      //               //                   itemMedia: imgBase64Str,
      //               //                   offerItemConditions: PrefillOfferItemConditions(
      //               //                     priority: data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .priority ==
      //               //                         null
      //               //                         ? ""
      //               //                         : data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .priority
      //               //                         .toString(),
      //               //                     periodicity: data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .periodicity ==
      //               //                         null
      //               //                         ? ""
      //               //                         : data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .periodicity
      //               //                         .toString(),
      //               //                     duration: data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .duration ==
      //               //                         null
      //               //                         ? ""
      //               //                         : data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .duration
      //               //                         .toString(),
      //               //                     fromlocation: data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .fromlocation ==
      //               //                         null
      //               //                         ? ""
      //               //                         : data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .fromlocation
      //               //                         .toString(),
      //               //                     tolocation: data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .tolocation ==
      //               //                         null
      //               //                         ? ""
      //               //                         : data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .tolocation
      //               //                         .toString(),
      //               //                     atlocation: data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .atlocation ==
      //               //                         null
      //               //                         ? ""
      //               //                         : data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .atlocation
      //               //                         .toString(),
      //               //                     expiry: data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .expiry ==
      //               //                         null
      //               //                         ? ""
      //               //                         : data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .expiry
      //               //                         .toString(),
      //               //                     servicepersons: data
      //               //                         .offerData!
      //               //                         .offerItems![j]
      //               //                         .offerItemConditions!
      //               //                         .servicepersons,
      //               //                     timePeriod: "${fromPeriodTime ==
      //               //                         "" &&
      //               //                         fromPeriodDate ==
      //               //                             "" &&
      //               //                         toPeriodDate ==
      //               //                             "" &&
      //               //                         toPeriodTime ==
      //               //                             ""
      //               //                         ? ""
      //               //                         : toPeriodDate !=
      //               //                         "" &&
      //               //                         toPeriodTime !=
      //               //                             ""
      //               //                         ? "From " +
      //               //                         fromPeriodDate +
      //               //                         " " +
      //               //                         fromPeriodTime +
      //               //                         " To " +
      //               //                         toPeriodDate +
      //               //                         " " +
      //               //                         toPeriodTime
      //               //                         : "From " +
      //               //                         fromPeriodDate +
      //               //                         " " +
      //               //                         fromPeriodTime}",
      //               //                   ),
      //               //                   price: data
      //               //                       .offerData!
      //               //                       .offerItems![j]
      //               //                       .price,
      //               //                   unit: PrefillUnit(
      //               //                       id: data
      //               //                           .offerData!
      //               //                           .offerItems![j]
      //               //                           .unit!
      //               //                           .id,
      //               //                       name: data
      //               //                           .offerData!
      //               //                           .offerItems![j]
      //               //                           .unit!
      //               //                           .name),
      //               //                   quantity: data
      //               //                       .offerData!
      //               //                       .offerItems![j]
      //               //                       .quantity,
      //               //                   required: data
      //               //                       .offerData!
      //               //                       .offerItems![j]
      //               //                       .required,
      //               //                   toggleState: data
      //               //                       .offerData!
      //               //                       .offerItems![j]
      //               //                       .toggleState,
      //               //                   advancePrice: data
      //               //                       .offerData!
      //               //                       .offerItems![j]
      //               //                       .advancePrice,
      //               //                   maintenancePrice: data
      //               //                       .offerData!
      //               //                       .offerItems![j]
      //               //                       .maintenancePrice,
      //               //                   advanceUnit: FillAdvanceUnit(
      //               //                       id: data
      //               //                           .offerData!
      //               //                           .offerItems![j]
      //               //                           .advanceUnit!
      //               //                           .id,
      //               //                       name: data
      //               //                           .offerData!
      //               //                           .offerItems![j]
      //               //                           .advanceUnit!
      //               //                           .name),
      //               //                   maintenanceUnit: FillMaintenanceUnit(
      //               //                       id: data
      //               //                           .offerData!
      //               //                           .offerItems![j]
      //               //                           .maintenanceUnit!
      //               //                           .id,
      //               //                       name: data
      //               //                           .offerData!
      //               //                           .offerItems![j]
      //               //                           .maintenanceUnit!
      //               //                           .name)));
      //               //         }
      //               //         var preFillDetails =
      //               //         PrefillOfferDataModel(
      //               //           addres: data
      //               //               .offerData!.addres
      //               //               .toString(),
      //               //           buyORsell: data
      //               //               .offerData!
      //               //               .buyORsell
      //               //               .toString(),
      //               //           category: FillCategory(
      //               //             id: data.offerData!
      //               //                 .category!.id,
      //               //             name: data
      //               //                 .offerData!
      //               //                 .category!.name,
      //               //           ),
      //               //           segment: FillSegment(
      //               //             name: data
      //               //                 .offerData!
      //               //                 .segment!.name,
      //               //             id: data.offerData!
      //               //                 .segment!.id,
      //               //             category: data
      //               //                 .offerData!
      //               //                 .segment!
      //               //                 .category,
      //               //           ),
      //               //           subsegment: FillSubsegment(
      //               //             id: data.offerData!
      //               //                 .subsegment!.id,
      //               //             name: data
      //               //                 .offerData!
      //               //                 .subsegment!
      //               //                 .name,
      //               //             segment: data
      //               //                 .offerData!
      //               //                 .subsegment!
      //               //                 .segment,
      //               //           ),
      //               //           offerConditions: PrefillOfferConditions(
      //               //             fromPeriod: data
      //               //                 .offerData!
      //               //                 .offerConditions!
      //               //                 .fromperiod,
      //               //             toPeriod: data
      //               //                 .offerData!
      //               //                 .offerConditions!
      //               //                 .toperiod,
      //               //             fromPeriodTime: data
      //               //                 .offerData!
      //               //                 .offerConditions!
      //               //                 .fromperiodtime,
      //               //             toPeriodTime: data
      //               //                 .offerData!
      //               //                 .offerConditions!
      //               //                 .toperiodtime,
      //               //             priority: data
      //               //                 .offerData!
      //               //                 .offerConditions!
      //               //                 .priority
      //               //                 .toString()
      //               //                 .trim(),
      //               //             periodicity: data
      //               //                 .offerData!
      //               //                 .offerConditions!
      //               //                 .periodicity
      //               //                 .toString()
      //               //                 .trim(),
      //               //             duration: data
      //               //                 .offerData!
      //               //                 .offerConditions!
      //               //                 .duration,
      //               //             fromlocation: data
      //               //                 .offerData!
      //               //                 .offerConditions!
      //               //                 .fromlocation,
      //               //             tolocation: data
      //               //                 .offerData!
      //               //                 .offerConditions!
      //               //                 .tolocation,
      //               //             atlocation: data
      //               //                 .offerData!
      //               //                 .offerConditions!
      //               //                 .atlocation,
      //               //             expiry: data
      //               //                 .offerData!
      //               //                 .offerConditions!
      //               //                 .expiry,
      //               //             servicepersons: data
      //               //                 .offerData!
      //               //                 .offerConditions!
      //               //                 .servicepersons,
      //               //             timePeriod: fromPeriodTime ==
      //               //                 "" &&
      //               //                 fromPeriodDate ==
      //               //                     "" &&
      //               //                 toPeriodDate ==
      //               //                     "" &&
      //               //                 toPeriodTime ==
      //               //                     ""
      //               //                 ? ""
      //               //                 : toPeriodDate !=
      //               //                 "" &&
      //               //                 toPeriodTime !=
      //               //                     ""
      //               //                 ? "From " +
      //               //                 fromPeriodDate +
      //               //                 " " +
      //               //                 fromPeriodTime +
      //               //                 " To " +
      //               //                 toPeriodDate +
      //               //                 " " +
      //               //                 toPeriodTime
      //               //                 : "From " +
      //               //                 fromPeriodDate +
      //               //                 " " +
      //               //                 fromPeriodTime,
      //               //           ),
      //               //           tabactivity: "New",
      //               //           offerareas: serviceAreaList,
      //               //           offerBids: FillBids,
      //               //           offerItems: FillItmsList,
      //               //         );
      //               //         Navigator.push(
      //               //             context,
      //               //             MaterialPageRoute(
      //               //               builder: (
      //               //                   context) =>
      //               //                   NewOfferCreateScreen(
      //               //                       Address: "",
      //               //                       AddressTitle: "",
      //               //                       From: "Fill",
      //               //                       PrefillOfferData: preFillDetails,
      //               //                       Type: "Template",
      //               //                       OfferId: data
      //               //                           .offerData!
      //               //                           .id
      //               //                           .toString(),
      //               //                       SubId: data
      //               //                           .offerData!
      //               //                           .subscribers!
      //               //                           .id
      //               //                           .toString()),
      //               //             ));
      //               //       }
      //               //     }
      //               //   }
      //               // } else {
      //               //   if (data.offerData!
      //               //       .buyORsell ==
      //               //       "COUNTER SELL" ||
      //               //       data.offerData!
      //               //           .buyORsell ==
      //               //           "COUNTER BUY") {
      //               //     if (data
      //               //         .offerData!
      //               //         .abusedUser!
      //               //         .contains(num.parse(
      //               //         DataManager
      //               //             .getInstance()
      //               //             .getuserId()
      //               //             .toString()))) {
      //               //       Constants.showToast(
      //               //           "${Url
      //               //               .abusedReportMessage
      //               //               .toString()}");
      //               //     } else {
      //               //       Get.to(() =>
      //               //           lastCounterScreen(
      //               //               OferId: data
      //               //                   .offerData!.id
      //               //                   .toString(),
      //               //               to_Couter_Id: data
      //               //                   .offerData!
      //               //                   .subscribers!
      //               //                   .id
      //               //                   .toString()))!
      //               //           .then((value) {
      //               //         DrawAuraAPi
      //               //             .getSubscriberOfferApi(
      //               //             SubcriberId: DataManager
      //               //                 .getInstance()
      //               //                 .getuserId()
      //               //                 .toString())
      //               //             .then((
      //               //             SubscriberOfferRes) {
      //               //           if (SubscriberOfferRes["status"] ==
      //               //               "200") {
      //               //             SubscriberOfferDetailsWithoutModel =
      //               //             SubscriberOfferRes["result"];
      //               //             SubscriberOfferDetails =
      //               //                 OfferDataModel
      //               //                     .fromJson(
      //               //                     SubscriberOfferRes);
      //               //             getMyOffersList =
      //               //             SubscriberOfferDetails!
      //               //                 .result!;
      //               //           }
      //               //           DrawAuraAPi
      //               //               .getSubscriberCounterOfferApi(
      //               //               SubcriberId: DataManager
      //               //                   .getInstance()
      //               //                   .getuserId()
      //               //                   .toString())
      //               //               .then((
      //               //               SubscriberCounterOfferRes) {
      //               //             if (SubscriberCounterOfferRes["status"] ==
      //               //                 "200") {
      //               //               SubscriberCouterOfferDetails =
      //               //                   OfferDataModel
      //               //                       .fromJson(
      //               //                       SubscriberCounterOfferRes);
      //               //               getMyCounterOffersList =
      //               //               SubscriberCouterOfferDetails!
      //               //                   .result!;
      //               //               getMyOffersList
      //               //                   .addAll(
      //               //                   getMyCounterOffersList);
      //               //               //  getMyOffersList.sort((a, b)=> DateTime.parse(a.offerData!.createdAt.toString()).compareTo(DateTime.parse(b.offerData!.createdAt.toString())));
      //               //             }
      //               //           });
      //               //         });
      //               //       });
      //               //     }
      //               //   } else {
      //               //     if (data
      //               //         .offerCounters!
      //               //         .isNotEmpty) {
      //               //       Get.to(() =>
      //               //           HomeDetailScreen(
      //               //               offerId: data
      //               //                   .offerData!.id
      //               //                   .toString()))!
      //               //           .then((value) {
      //               //         DrawAuraAPi
      //               //             .getSubscriberOfferApi(
      //               //             SubcriberId: DataManager
      //               //                 .getInstance()
      //               //                 .getuserId()
      //               //                 .toString())
      //               //             .then((
      //               //             SubscriberOfferRes) {
      //               //           if (SubscriberOfferRes["status"] ==
      //               //               "200") {
      //               //             SubscriberOfferDetailsWithoutModel =
      //               //             SubscriberOfferRes["result"];
      //               //             SubscriberOfferDetails =
      //               //                 OfferDataModel
      //               //                     .fromJson(
      //               //                     SubscriberOfferRes);
      //               //             getMyOffersList =
      //               //             SubscriberOfferDetails!
      //               //                 .result!;
      //               //           }
      //               //           DrawAuraAPi
      //               //               .getSubscriberCounterOfferApi(
      //               //               SubcriberId: DataManager
      //               //                   .getInstance()
      //               //                   .getuserId()
      //               //                   .toString())
      //               //               .then((
      //               //               SubscriberCounterOfferRes) {
      //               //             if (SubscriberCounterOfferRes["status"] ==
      //               //                 "200") {
      //               //               SubscriberCouterOfferDetails =
      //               //                   OfferDataModel
      //               //                       .fromJson(
      //               //                       SubscriberCounterOfferRes);
      //               //               getMyCounterOffersList =
      //               //               SubscriberCouterOfferDetails!
      //               //                   .result!;
      //               //               getMyOffersList
      //               //                   .addAll(
      //               //                   getMyCounterOffersList);
      //               //               //  getMyOffersList.sort((a, b)=> DateTime.parse(a.offerData!.createdAt.toString()).compareTo(DateTime.parse(b.offerData!.createdAt.toString())));
      //               //             }
      //               //           });
      //               //         });
      //               //       });
      //               //     } else {
      //               //       print(
      //               //           "Navigate to Update OfferDetails");
      //               //       Get.to(() =>
      //               //           UpdateOfferScreen(
      //               //             OfferData: data,
      //               //           ))!
      //               //           .then((value) {
      //               //         DrawAuraAPi
      //               //             .getSubscriberOfferApi(
      //               //             SubcriberId: DataManager
      //               //                 .getInstance()
      //               //                 .getuserId()
      //               //                 .toString())
      //               //             .then((
      //               //             SubscriberOfferRes) {
      //               //           if (SubscriberOfferRes["status"] ==
      //               //               "200") {
      //               //             SubscriberOfferDetailsWithoutModel =
      //               //             SubscriberOfferRes["result"];
      //               //             SubscriberOfferDetails =
      //               //                 OfferDataModel
      //               //                     .fromJson(
      //               //                     SubscriberOfferRes);
      //               //             getMyOffersList =
      //               //             SubscriberOfferDetails!
      //               //                 .result!;
      //               //           }
      //               //           DrawAuraAPi
      //               //               .getSubscriberCounterOfferApi(
      //               //               SubcriberId: DataManager
      //               //                   .getInstance()
      //               //                   .getuserId()
      //               //                   .toString())
      //               //               .then((
      //               //               SubscriberCounterOfferRes) {
      //               //             if (SubscriberCounterOfferRes["status"] ==
      //               //                 "200") {
      //               //               SubscriberCouterOfferDetails =
      //               //                   OfferDataModel
      //               //                       .fromJson(
      //               //                       SubscriberCounterOfferRes);
      //               //               getMyCounterOffersList =
      //               //               SubscriberCouterOfferDetails!
      //               //                   .result!;
      //               //               getMyOffersList
      //               //                   .addAll(
      //               //                   getMyCounterOffersList);
      //               //               //  getMyOffersList.sort((a, b)=> DateTime.parse(a.offerData!.createdAt.toString()).compareTo(DateTime.parse(b.offerData!.createdAt.toString())));
      //               //             }
      //               //           });
      //               //         });
      //               //       });
      //               //     }
      //               //   }
      //               // }
      //             },
      //             child: Stack(
      //               children: [
      //                 Container(
      //                   width: isMobile?width * 0.45:tabWidth*0.45,
      //                   decoration: BoxDecoration(borderRadius: const BorderRadius.only(
      //                       topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
      //                       image: data.offerData!.offerItems![0].itemMedia!.isEmpty ? const DecorationImage(
      //                           image: AssetImage("assets/image1.png"),
      //                           fit: BoxFit.cover) : "${data.offerData!.offerItems!.first.itemMedia!.first.media.toString().substring(data.offerData!.offerItems!.first.itemMedia!.first.media.toString().lastIndexOf('.'))}" ==".mp4"
      //                           ? snapshot.connectionState == ConnectionState.waiting ? DecorationImage(
      //                           image: AssetImage("assets/loading.gif"),
      //                           fit: BoxFit.fill) : DecorationImage(image: FileImage(File("${snapshot.data}")), fit: BoxFit.fill)
      //                           : DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${data.offerData!.offerItems![0].itemMedia![0].media}"), fit: BoxFit.fill)),
      //                 ),
      //                 Positioned(
      //                     top: 0,
      //                     left: 0,
      //                     child: data.offerData!.buyORsell == "SELL" || data.offerData!.buyORsell == "BUY" ?
      //                     Container(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      //                       decoration: BoxDecoration(
      //                           borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
      //                           color: data.offerData!.buyORsell == "SELL" ? Colors.red : Constants.primaryColor),
      //                       child: Center(
      //                           child: Text("${data.offerData!.buyORsell.toString()}",
      //                             style: WhiteHeadingStyle,
      //                             textAlign: TextAlign.center,
      //                           )),
      //                     )
      //                         : data.offerData!.buyORsell == "DELIVER_BUY" || data.offerData!.buyORsell == "DELIVER_SELL"
      //                         ? Container(
      //                       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      //                       decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
      //                           color: data.offerData!.buyORsell == "DELIVER_SELL" ? Colors.red : Constants.primaryColor),
      //                       child: Center(
      //                           child: Text("${data.offerData!.buyORsell.toString()}",
      //                             style: WhiteHeadingStyle,
      //                             textAlign: TextAlign.center,
      //                           )),
      //                     )
      //                         : Container(
      //                       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      //                       decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
      //                           color: data.offerData!.buyORsell == "COUNTER SELL" ? Constants.primaryColor : Colors.red),
      //                       child: Center(
      //                           child: Text("${data.offerData!.buyORsell == "COUNTER SELL" ? "COUNTER BUY" : "COUNTER SELL"}",
      //                             style: WhiteHeadingStyle,
      //                             textAlign: TextAlign.center,
      //                           )),
      //                     )),
      //                 Positioned(bottom:
      //                 0,
      //                     right:
      //                     0,
      //                     child:
      //                     Container(
      //                       height:
      //                       30,
      //                       width:
      //                       100,
      //                       decoration:
      //                       const BoxDecoration(
      //                           color: Colors
      //                               .black45,
      //                           borderRadius: BorderRadius
      //                               .only(
      //                               bottomRight: Radius
      //                                   .circular(
      //                                   8))),
      //                       child: Center(
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment
      //                                 .center,
      //                             children: [
      //                               const Icon(Icons
      //                                   .remove_red_eye,
      //                                   color: Colors
      //                                       .white,
      //                                   size: 18),
      //                               Text(
      //                                 " ${data
      //                                     .offerData!
      //                                     .offerviewcount!
      //                                     .length
      //                                     .toString()} Views",
      //                                 style: WhiteSubTitleStyle,
      //                                 textAlign: TextAlign
      //                                     .center,
      //                               ),
      //                             ],
      //                           )),
      //                     )),
      //                 data.offerData!.offerstatus
      //                     .toString()
      //                     .trim()
      //                     .toUpperCase() ==
      //                     "CLOSED"
      //                     ? Container(
      //                   width:  isMobile?width * 0.45:tabWidth*0.45,
      //                   decoration: BoxDecoration(
      //                     borderRadius: const BorderRadius
      //                         .only(topLeft: Radius
      //                         .circular(10),
      //                         topRight: Radius
      //                             .circular(10)),
      //                     color: Constants
      //                         .closeOfferCard,
      //                   ),
      //                 )
      //                     : SizedBox(),
      //               ],
      //             ),
      //           ),
      //           Flexible(
      //             child: Stack(
      //               children: [
      //                 Container(
      //                   padding: const EdgeInsets
      //                       .all(
      //                       5),
      //                   child:
      //                   Column(
      //                     mainAxisAlignment:
      //                     MainAxisAlignment.start,
      //                     crossAxisAlignment:
      //                     CrossAxisAlignment.start,
      //                     children: [
      //                       SizedBox(
      //                         width:  isMobile?width * 0.45:tabWidth*0.45,
      //                         child: Text.rich(
      //                           TextSpan(
      //                               text: '${data
      //                                   .offerData!
      //                                   .category!
      //                                   .name
      //                                   .toString()} ',
      //                               style: BlackCardTitle,
      //                               children: <
      //                                   InlineSpan>[
      //                                 TextSpan(
      //                                   text: '${data
      //                                       .offerData!
      //                                       .segment!
      //                                       .name
      //                                       .toString()} ${data
      //                                       .offerData!
      //                                       .subsegment!
      //                                       .name
      //                                       .toString()}, ${data
      //                                       .offerData!
      //                                       .subscribers!
      //                                       .displayname
      //                                       .toString()} ${data
      //                                       .offerData!
      //                                       .offerItems!
      //                                       .first
      //                                       .name
      //                                       .toString()} ${data
      //                                       .offerData!
      //                                       .offerItems!
      //                                       .first
      //                                       .price
      //                                       .toString()} per ${data
      //                                       .offerData!
      //                                       .offerItems!
      //                                       .first
      //                                       .unit!
      //                                       .name
      //                                       .toString()}',
      //                                   style: BlackSubCardTitle,
      //                                 )
      //                               ]),
      //                         ),
      //                       ),
      //                       const SizedBox(
      //                         height: 5,
      //                       ),
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment
      //                             .start,
      //                         crossAxisAlignment: CrossAxisAlignment
      //                             .start,
      //                         children: [
      //                           data.offerData!
      //                               .like == 0
      //                               ? data
      //                               .offerData!
      //                               .subscribers!.id
      //                               .toString()
      //                               .trim() ==
      //                               DataManager
      //                                   .getInstance()
      //                                   .getuserId()
      //                                   .toString()
      //                                   .trim()
      //                               ? Icon(
      //                             Icons
      //                                 .thumb_up_alt_rounded,
      //                             color: Constants
      //                                 .primaryColor,
      //                             size: 18,
      //                           )
      //                               : data
      //                               .offerData!
      //                               .offerviewcount!
      //                               .contains(
      //                               num.parse(
      //                                   DataManager
      //                                       .getInstance()
      //                                       .getuserId()
      //                                       .toString()))
      //                               ? Builder(
      //                             builder: (ctx) {
      //                               return ReactionButton<
      //                                   String>(
      //                                 onReactionChanged: (
      //                                     String? value) {
      //                                   if (value ==
      //                                       "like") {
      //                                     DrawAuraAPi
      //                                         .likeUnlikeOffer(
      //                                         offer_id: data
      //                                             .offerData!
      //                                             .id
      //                                             .toString(),
      //                                         user_id: DataManager
      //                                             .getInstance()
      //                                             .getuserId()
      //                                             .toString())
      //                                         .then((
      //                                         value) {
      //                                       print(
      //                                           value);
      //                                       Constants
      //                                           .showToast(
      //                                           "${value["message"]}");
      //                                       setState(() {
      //                                         print(
      //                                             value["message"]
      //                                                 .toString()
      //                                                 .trim() ==
      //                                                 "Offer Liked");
      //                                         if (value["message"]
      //                                             .toString()
      //                                             .trim() ==
      //                                             "Offer Liked") {
      //                                           var data2 = OfferDataModelResult(
      //                                               offerCounters: data
      //                                                   .offerCounters,
      //                                               offerData: MainOfferDetails(
      //                                                   favourite: data
      //                                                       .offerData!
      //                                                       .favourite,
      //                                                   addres: data
      //                                                       .offerData!
      //                                                       .addres,
      //                                                   buyORsell: data
      //                                                       .offerData!
      //                                                       .buyORsell,
      //                                                   category: data
      //                                                       .offerData!
      //                                                       .category,
      //                                                   segment: data
      //                                                       .offerData!
      //                                                       .segment,
      //                                                   subsegment: data
      //                                                       .offerData!
      //                                                       .subsegment,
      //                                                   computedRating: data
      //                                                       .offerData!
      //                                                       .computedRating,
      //                                                   counterdUser: data
      //                                                       .offerData!
      //                                                       .counterdUser,
      //                                                   createdAt: data
      //                                                       .offerData!
      //                                                       .createdAt,
      //                                                   id: data
      //                                                       .offerData!
      //                                                       .id,
      //                                                   modified: data
      //                                                       .offerData!
      //                                                       .modified,
      //                                                   offerareas: data
      //                                                       .offerData!
      //                                                       .offerareas,
      //                                                   offerBids: data
      //                                                       .offerData!
      //                                                       .offerBids,
      //                                                   offerConditions: data
      //                                                       .offerData!
      //                                                       .offerConditions,
      //                                                   offerconfirmed: data
      //                                                       .offerData!
      //                                                       .offerconfirmed,
      //                                                   offercopycount: data
      //                                                       .offerData!
      //                                                       .offercopycount,
      //                                                   offerevent: data
      //                                                       .offerData!
      //                                                       .offerevent,
      //                                                   offerexecuteend: data
      //                                                       .offerData!
      //                                                       .offerexecuteend,
      //                                                   offerexecutestart: data
      //                                                       .offerData!
      //                                                       .offerexecutestart,
      //                                                   offerfavoritecount: data
      //                                                       .offerData!
      //                                                       .offerfavoritecount,
      //                                                   offerItems: data
      //                                                       .offerData!
      //                                                       .offerItems,
      //                                                   offerincepted: data
      //                                                       .offerData!
      //                                                       .offerincepted,
      //                                                   offerinform: data
      //                                                       .offerData!
      //                                                       .offerinform,
      //                                                   offerresponses: data
      //                                                       .offerData!
      //                                                       .offerresponses,
      //                                                   offerservicepercentage: data
      //                                                       .offerData!
      //                                                       .offerservicepercentage,
      //                                                   offersignedoff: data
      //                                                       .offerData!
      //                                                       .offersignedoff,
      //                                                   offerstatus: data
      //                                                       .offerData!
      //                                                       .offerstatus,
      //                                                   offertemplate: data
      //                                                       .offerData!
      //                                                       .offertemplate,
      //                                                   offerviewcount: data
      //                                                       .offerData!
      //                                                       .offerviewcount,
      //                                                   privacy: data
      //                                                       .offerData!
      //                                                       .privacy,
      //                                                   subscribers: data
      //                                                       .offerData!
      //                                                       .subscribers,
      //                                                   tabactivity: data
      //                                                       .offerData!
      //                                                       .tabactivity,
      //                                                   userRating: data
      //                                                       .offerData!
      //                                                       .userRating,
      //                                                   like: 1,
      //                                                   offerLike: data
      //                                                       .offerData!
      //                                                       .offerLike! +
      //                                                       1,
      //                                                   offerDisLike: data
      //                                                       .offerData!
      //                                                       .offerDisLike,
      //                                                   comments: data
      //                                                       .offerData!
      //                                                       .comments,
      //                                                   ConfirmingSubscriber: data
      //                                                       .offerData!
      //                                                       .ConfirmingSubscriber!));
      //                                           getMyOffersList[index] =
      //                                               data2;
      //                                         }
      //                                       });
      //                                     });
      //                                   } else {
      //                                     DrawAuraAPi
      //                                         .disLikeOffer(
      //                                         offer_id: data
      //                                             .offerData!
      //                                             .id
      //                                             .toString(),
      //                                         user_id: DataManager
      //                                             .getInstance()
      //                                             .getuserId()
      //                                             .toString())
      //                                         .then((
      //                                         value) {
      //                                       print(
      //                                           value);
      //                                       Constants
      //                                           .showToast(
      //                                           "${value["message"]}");
      //                                       setState(() {
      //                                         print(
      //                                             value["message"]
      //                                                 .toString()
      //                                                 .trim() ==
      //                                                 "Offer Liked");
      //                                         if (value["message"]
      //                                             .toString()
      //                                             .trim() ==
      //                                             "Offer Disliked") {
      //                                           var data2 = OfferDataModelResult(
      //                                               offerCounters: data
      //                                                   .offerCounters,
      //                                               offerData: MainOfferDetails(
      //                                                   favourite: data
      //                                                       .offerData!
      //                                                       .favourite,
      //                                                   addres: data
      //                                                       .offerData!
      //                                                       .addres,
      //                                                   buyORsell: data
      //                                                       .offerData!
      //                                                       .buyORsell,
      //                                                   category: data
      //                                                       .offerData!
      //                                                       .category,
      //                                                   segment: data
      //                                                       .offerData!
      //                                                       .segment,
      //                                                   subsegment: data
      //                                                       .offerData!
      //                                                       .subsegment,
      //                                                   computedRating: data
      //                                                       .offerData!
      //                                                       .computedRating,
      //                                                   counterdUser: data
      //                                                       .offerData!
      //                                                       .counterdUser,
      //                                                   createdAt: data
      //                                                       .offerData!
      //                                                       .createdAt,
      //                                                   id: data
      //                                                       .offerData!
      //                                                       .id,
      //                                                   modified: data
      //                                                       .offerData!
      //                                                       .modified,
      //                                                   offerareas: data
      //                                                       .offerData!
      //                                                       .offerareas,
      //                                                   offerBids: data
      //                                                       .offerData!
      //                                                       .offerBids,
      //                                                   offerConditions: data
      //                                                       .offerData!
      //                                                       .offerConditions,
      //                                                   offerconfirmed: data
      //                                                       .offerData!
      //                                                       .offerconfirmed,
      //                                                   offercopycount: data
      //                                                       .offerData!
      //                                                       .offercopycount,
      //                                                   offerevent: data
      //                                                       .offerData!
      //                                                       .offerevent,
      //                                                   offerexecuteend: data
      //                                                       .offerData!
      //                                                       .offerexecuteend,
      //                                                   offerexecutestart: data
      //                                                       .offerData!
      //                                                       .offerexecutestart,
      //                                                   offerfavoritecount: data
      //                                                       .offerData!
      //                                                       .offerfavoritecount,
      //                                                   offerItems: data
      //                                                       .offerData!
      //                                                       .offerItems,
      //                                                   offerincepted: data
      //                                                       .offerData!
      //                                                       .offerincepted,
      //                                                   offerinform: data
      //                                                       .offerData!
      //                                                       .offerinform,
      //                                                   offerresponses: data
      //                                                       .offerData!
      //                                                       .offerresponses,
      //                                                   offerservicepercentage: data
      //                                                       .offerData!
      //                                                       .offerservicepercentage,
      //                                                   offersignedoff: data
      //                                                       .offerData!
      //                                                       .offersignedoff,
      //                                                   offerstatus: data
      //                                                       .offerData!
      //                                                       .offerstatus,
      //                                                   offertemplate: data
      //                                                       .offerData!
      //                                                       .offertemplate,
      //                                                   offerviewcount: data
      //                                                       .offerData!
      //                                                       .offerviewcount,
      //                                                   privacy: data
      //                                                       .offerData!
      //                                                       .privacy,
      //                                                   subscribers: data
      //                                                       .offerData!
      //                                                       .subscribers,
      //                                                   tabactivity: data
      //                                                       .offerData!
      //                                                       .tabactivity,
      //                                                   userRating: data
      //                                                       .offerData!
      //                                                       .userRating,
      //                                                   like: 2,
      //                                                   offerLike: data
      //                                                       .offerData!
      //                                                       .offerLike,
      //                                                   offerDisLike: data
      //                                                       .offerData!
      //                                                       .offerDisLike! +
      //                                                       1,
      //                                                   comments: data
      //                                                       .offerData!
      //                                                       .comments,
      //                                                   ConfirmingSubscriber: data
      //                                                       .offerData!
      //                                                       .ConfirmingSubscriber!));
      //                                           getMyOffersList[index] =
      //                                               data2;
      //                                         }
      //                                         // ? TrendingOfferList[index].offerData!.like = true:data.offerData!.like = false;
      //                                       });
      //                                     });
      //                                   }
      //                                 },
      //                                 reactions: flagsReactions,
      //                                 initialReaction: data
      //                                     .offerData!
      //                                     .like == 0
      //                                     ? Reaction<
      //                                     String>(
      //                                   value: null,
      //                                   icon: Icon(
      //                                     Icons
      //                                         .thumb_up_outlined,
      //                                     color: Colors
      //                                         .black87,
      //                                     size: 18,
      //                                   ),
      //                                 )
      //                                     : Reaction<
      //                                     String>(
      //                                   value: 'like',
      //                                   icon: Icon(
      //                                     Icons
      //                                         .thumb_up_alt_rounded,
      //                                     color: Constants
      //                                         .primaryColor,
      //                                     size: 18,
      //                                   ),
      //                                 ),
      //                                 boxColor: Colors
      //                                     .amber
      //                                     .shade300,
      //                                 boxRadius: 10,
      //                                 boxElevation: 0,
      //                                 boxDuration: const Duration(
      //                                     milliseconds: 200),
      //                                 itemScaleDuration: const Duration(
      //                                     milliseconds: 100),
      //                               );
      //                             },
      //                           )
      //                               : Icon(
      //                             Icons
      //                                 .thumb_up_outlined,
      //                             color: Colors
      //                                 .black87,
      //                             size: 18,
      //                           )
      //                               : Icon(Icons
      //                               .thumb_up_alt_rounded,
      //                               color: Constants
      //                                   .primaryColor,
      //                               size: 18),
      //                           Spacer(),
      //                           InkWell(
      //                               onTap: () {
      //                                 DrawAuraAPi
      //                                     .AddRemoveFavorite(
      //                                     offer_id: data
      //                                         .offerData!
      //                                         .id
      //                                         .toString(),
      //                                     user_id: DataManager
      //                                         .getInstance()
      //                                         .getuserId()
      //                                         .toString())
      //                                     .then((
      //                                     value) {
      //                                   setState(() {
      //                                     print(
      //                                         value["message"]
      //                                             .toString()
      //                                             .trim() ==
      //                                             "offer removed from favourite");
      //                                     if (value["message"]
      //                                         .toString()
      //                                         .trim() ==
      //                                         "offer removed from favourite") {
      //                                       Constants
      //                                           .showToast(
      //                                           "${Url
      //                                               .UnMarkFav}");
      //                                       var data2 = OfferDataModelResult(
      //                                           offerCounters: data
      //                                               .offerCounters,
      //                                           offerData: MainOfferDetails(
      //                                               addres: data
      //                                                   .offerData!
      //                                                   .addres,
      //                                               buyORsell: data
      //                                                   .offerData!
      //                                                   .buyORsell,
      //                                               category: data
      //                                                   .offerData!
      //                                                   .category,
      //                                               segment: data
      //                                                   .offerData!
      //                                                   .segment,
      //                                               subsegment: data
      //                                                   .offerData!
      //                                                   .subsegment,
      //                                               computedRating: data
      //                                                   .offerData!
      //                                                   .computedRating,
      //                                               counterdUser: data
      //                                                   .offerData!
      //                                                   .counterdUser,
      //                                               createdAt: data
      //                                                   .offerData!
      //                                                   .createdAt,
      //                                               id: data
      //                                                   .offerData!
      //                                                   .id,
      //                                               modified: data
      //                                                   .offerData!
      //                                                   .modified,
      //                                               offerareas: data
      //                                                   .offerData!
      //                                                   .offerareas,
      //                                               offerBids: data
      //                                                   .offerData!
      //                                                   .offerBids,
      //                                               offerConditions: data
      //                                                   .offerData!
      //                                                   .offerConditions,
      //                                               offerconfirmed: data
      //                                                   .offerData!
      //                                                   .offerconfirmed,
      //                                               offercopycount: data
      //                                                   .offerData!
      //                                                   .offercopycount,
      //                                               offerevent: data
      //                                                   .offerData!
      //                                                   .offerevent,
      //                                               offerexecuteend: data
      //                                                   .offerData!
      //                                                   .offerexecuteend,
      //                                               offerexecutestart: data
      //                                                   .offerData!
      //                                                   .offerexecutestart,
      //                                               offerItems: data
      //                                                   .offerData!
      //                                                   .offerItems,
      //                                               offerincepted: data
      //                                                   .offerData!
      //                                                   .offerincepted,
      //                                               offerinform: data
      //                                                   .offerData!
      //                                                   .offerinform,
      //                                               offerresponses: data
      //                                                   .offerData!
      //                                                   .offerresponses,
      //                                               offerservicepercentage: data
      //                                                   .offerData!
      //                                                   .offerservicepercentage,
      //                                               offersignedoff: data
      //                                                   .offerData!
      //                                                   .offersignedoff,
      //                                               offerstatus: data
      //                                                   .offerData!
      //                                                   .offerstatus,
      //                                               offertemplate: data
      //                                                   .offerData!
      //                                                   .offertemplate,
      //                                               offerviewcount: data
      //                                                   .offerData!
      //                                                   .offerviewcount,
      //                                               privacy: data
      //                                                   .offerData!
      //                                                   .privacy,
      //                                               subscribers: data
      //                                                   .offerData!
      //                                                   .subscribers,
      //                                               tabactivity: data
      //                                                   .offerData!
      //                                                   .tabactivity,
      //                                               userRating: data
      //                                                   .offerData!
      //                                                   .userRating,
      //                                               favourite: false,
      //                                               offerfavoritecount: data
      //                                                   .offerData!
      //                                                   .offerfavoritecount! -
      //                                                   1,
      //                                               like: data
      //                                                   .offerData!
      //                                                   .like,
      //                                               offerLike: data
      //                                                   .offerData!
      //                                                   .offerLike,
      //                                               offerDisLike: data
      //                                                   .offerData!
      //                                                   .offerDisLike,
      //                                               comments: data
      //                                                   .offerData!
      //                                                   .comments,
      //                                               ConfirmingSubscriber: data
      //                                                   .offerData!
      //                                                   .ConfirmingSubscriber!));
      //                                       getMyOffersList[index] =
      //                                           data2;
      //                                     } else {
      //                                       Constants
      //                                           .showToast(
      //                                           "${Url
      //                                               .markFav}");
      //                                       var data2 = OfferDataModelResult(
      //                                           offerCounters: data
      //                                               .offerCounters,
      //                                           offerData: MainOfferDetails(
      //                                               addres: data
      //                                                   .offerData!
      //                                                   .addres,
      //                                               buyORsell: data
      //                                                   .offerData!
      //                                                   .buyORsell,
      //                                               category: data
      //                                                   .offerData!
      //                                                   .category,
      //                                               segment: data
      //                                                   .offerData!
      //                                                   .segment,
      //                                               subsegment: data
      //                                                   .offerData!
      //                                                   .subsegment,
      //                                               computedRating: data
      //                                                   .offerData!
      //                                                   .computedRating,
      //                                               counterdUser: data
      //                                                   .offerData!
      //                                                   .counterdUser,
      //                                               createdAt: data
      //                                                   .offerData!
      //                                                   .createdAt,
      //                                               id: data
      //                                                   .offerData!
      //                                                   .id,
      //                                               modified: data
      //                                                   .offerData!
      //                                                   .modified,
      //                                               offerareas: data
      //                                                   .offerData!
      //                                                   .offerareas,
      //                                               offerBids: data
      //                                                   .offerData!
      //                                                   .offerBids,
      //                                               offerConditions: data
      //                                                   .offerData!
      //                                                   .offerConditions,
      //                                               offerconfirmed: data
      //                                                   .offerData!
      //                                                   .offerconfirmed,
      //                                               offercopycount: data
      //                                                   .offerData!
      //                                                   .offercopycount,
      //                                               offerevent: data
      //                                                   .offerData!
      //                                                   .offerevent,
      //                                               offerexecuteend: data
      //                                                   .offerData!
      //                                                   .offerexecuteend,
      //                                               offerexecutestart: data
      //                                                   .offerData!
      //                                                   .offerexecutestart,
      //                                               offerItems: data
      //                                                   .offerData!
      //                                                   .offerItems,
      //                                               offerincepted: data
      //                                                   .offerData!
      //                                                   .offerincepted,
      //                                               offerinform: data
      //                                                   .offerData!
      //                                                   .offerinform,
      //                                               offerresponses: data
      //                                                   .offerData!
      //                                                   .offerresponses,
      //                                               offerservicepercentage: data
      //                                                   .offerData!
      //                                                   .offerservicepercentage,
      //                                               offersignedoff: data
      //                                                   .offerData!
      //                                                   .offersignedoff,
      //                                               offerstatus: data
      //                                                   .offerData!
      //                                                   .offerstatus,
      //                                               offertemplate: data
      //                                                   .offerData!
      //                                                   .offertemplate,
      //                                               offerviewcount: data
      //                                                   .offerData!
      //                                                   .offerviewcount,
      //                                               privacy: data
      //                                                   .offerData!
      //                                                   .privacy,
      //                                               subscribers: data
      //                                                   .offerData!
      //                                                   .subscribers,
      //                                               tabactivity: data
      //                                                   .offerData!
      //                                                   .tabactivity,
      //                                               userRating: data
      //                                                   .offerData!
      //                                                   .userRating,
      //                                               favourite: true,
      //                                               offerfavoritecount: data
      //                                                   .offerData!
      //                                                   .offerfavoritecount! +
      //                                                   1,
      //                                               like: data
      //                                                   .offerData!
      //                                                   .like,
      //                                               offerLike: data
      //                                                   .offerData!
      //                                                   .offerLike,
      //                                               offerDisLike: data
      //                                                   .offerData!
      //                                                   .offerDisLike,
      //                                               comments: data
      //                                                   .offerData!
      //                                                   .comments,
      //                                               ConfirmingSubscriber: data
      //                                                   .offerData!
      //                                                   .ConfirmingSubscriber!));
      //                                       getMyOffersList[index] =
      //                                           data2;
      //                                     }
      //                                   });
      //                                   DrawAuraAPi
      //                                       .getSubscriberOfferApi(
      //                                       SubcriberId: DataManager
      //                                           .getInstance()
      //                                           .getuserId()
      //                                           .toString())
      //                                       .then((
      //                                       SubscriberOfferRes) {
      //                                     if (SubscriberOfferRes["status"] ==
      //                                         "200") {
      //                                       setState(() {
      //                                         SubscriberOfferDetailsWithoutModel =
      //                                         SubscriberOfferRes["result"];
      //                                         SubscriberOfferDetails =
      //                                             OfferDataModel
      //                                                 .fromJson(
      //                                                 SubscriberOfferRes);
      //                                         getMyOffersList =
      //                                         SubscriberOfferDetails!
      //                                             .result!;
      //                                       });
      //                                     }
      //                                     DrawAuraAPi
      //                                         .getSubscriberCounterOfferApi(
      //                                         SubcriberId: DataManager
      //                                             .getInstance()
      //                                             .getuserId()
      //                                             .toString())
      //                                         .then((
      //                                         SubscriberCounterOfferRes) {
      //                                       if (SubscriberCounterOfferRes["status"] ==
      //                                           "200") {
      //                                         setState(() {
      //                                           SubscriberCouterOfferDetails =
      //                                               OfferDataModel
      //                                                   .fromJson(
      //                                                   SubscriberCounterOfferRes);
      //                                           getMyCounterOffersList =
      //                                           SubscriberCouterOfferDetails!
      //                                               .result!;
      //                                           getMyOffersList
      //                                               .addAll(
      //                                               getMyCounterOffersList);
      //                                         });
      //                                         //  getMyOffersList.sort((a, b)=> DateTime.parse(a.offerData!.createdAt.toString()).compareTo(DateTime.parse(b.offerData!.createdAt.toString())));
      //                                       }
      //                                     });
      //                                   });
      //                                 });
      //                               },
      //                               child: data
      //                                   .offerData!
      //                                   .favourite ==
      //                                   true
      //                                   ? Padding(
      //                                 padding: const EdgeInsets
      //                                     .only(
      //                                     bottom: 5.0),
      //                                 child: Icon(
      //                                   Icons
      //                                       .favorite,
      //                                   color: Constants
      //                                       .primaryColor,
      //                                   size: 20,
      //                                 ),
      //                               )
      //                                   : Padding(
      //                                 padding: const EdgeInsets
      //                                     .only(
      //                                     bottom: 5.0),
      //                                 child: Icon(
      //                                     Icons
      //                                         .favorite_border_outlined,
      //                                     color: Constants
      //                                         .greyDark,
      //                                     size: 20),
      //                               )),
      //                           Padding(
      //                             padding: const EdgeInsets
      //                                 .only(
      //                                 left: 3.0),
      //                             child: Text(
      //                               "${data
      //                                   .offerData!
      //                                   .offerfavoritecount
      //                                   .toString()}",
      //                               style: darkgreyFieldStyle,
      //                             ),
      //                           ),
      //                           Spacer(),
      //                           InkWell(
      //                               onTap: () {
      //                                 bool isCommentsLoading = true;
      //                                 List<
      //                                     CommentsDataList> CommentsList = [
      //                                 ];
      //                                 DrawAuraAPi()
      //                                     .getOfferCommentsList(
      //                                     offer_id: data
      //                                         .offerData!
      //                                         .id
      //                                         .toString())
      //                                     .then((
      //                                     value) {
      //                                   CommentsList =
      //                                       value;
      //                                   isCommentsLoading =
      //                                   false;
      //                                 });
      //                                 showModalBottomSheet(
      //                                   isScrollControlled: true,
      //                                   shape: RoundedRectangleBorder(
      //                                       borderRadius: BorderRadius
      //                                           .only(
      //                                           topLeft: Radius
      //                                               .circular(
      //                                               12),
      //                                           topRight: Radius
      //                                               .circular(
      //                                               12))),
      //                                   context: context,
      //                                   builder: (
      //                                       context) {
      //                                     return StatefulBuilder(
      //                                       builder: (
      //                                           context,
      //                                           modalState) {
      //                                         isCommentsLoading ==
      //                                             true
      //                                             ? Future
      //                                             .delayed(
      //                                           Duration(
      //                                               milliseconds: 500),
      //                                               () {
      //                                             modalState(() {});
      //                                             print(
      //                                                 isCommentsLoading);
      //                                           },
      //                                         )
      //                                             : null;
      //                                         return Container(
      //                                             height: MediaQuery
      //                                                 .of(
      //                                                 context)
      //                                                 .size
      //                                                 .height *
      //                                                 0.8,
      //                                             width:isMobile?width:tabWidth,
      //                                             decoration: BoxDecoration(
      //                                               borderRadius: BorderRadius
      //                                                   .only(
      //                                                   topLeft: Radius
      //                                                       .circular(
      //                                                       12),
      //                                                   topRight: Radius
      //                                                       .circular(
      //                                                       12)),
      //                                               color: Color(
      //                                                   0x33DCF0DD),
      //                                             ),
      //                                             child: Scaffold(
      //                                               backgroundColor: Colors
      //                                                   .transparent,
      //                                               body: Column(
      //                                                 mainAxisAlignment: MainAxisAlignment
      //                                                     .start,
      //                                                 crossAxisAlignment: CrossAxisAlignment
      //                                                     .center,
      //                                                 children: [
      //                                                   Container(
      //                                                       height: 3.5,
      //                                                       margin: EdgeInsets
      //                                                           .only(
      //                                                           top: 13),
      //                                                       width: 38,
      //                                                       decoration: BoxDecoration(
      //                                                         borderRadius: BorderRadius
      //                                                             .circular(
      //                                                             5),
      //                                                         color: Colors
      //                                                             .black54,
      //                                                       )),
      //                                                   20
      //                                                       .height,
      //                                                   Text(
      //                                                     "Comments",
      //                                                     style: BlackDescStyleBold,
      //                                                   ),
      //                                                   10
      //                                                       .height,
      //                                                   Divider(
      //                                                       color: Colors
      //                                                           .black,
      //                                                       height: 2.5,
      //                                                       thickness: 1.2),
      //                                                   2
      //                                                       .height,
      //                                                   isCommentsLoading
      //                                                       ? Padding(
      //                                                     padding: EdgeInsets
      //                                                         .only(
      //                                                         top: MediaQuery
      //                                                             .of(
      //                                                             context)
      //                                                             .size
      //                                                             .height *
      //                                                             0.25),
      //                                                     child: LoadingWidget(),
      //                                                   )
      //                                                       : CommentsList
      //                                                       .isEmpty
      //                                                       ? Padding(
      //                                                     padding: EdgeInsets
      //                                                         .only(
      //                                                         top: MediaQuery
      //                                                             .of(
      //                                                             context)
      //                                                             .size
      //                                                             .height *
      //                                                             0.3),
      //                                                     child: Image(
      //                                                       image: AssetImage(
      //                                                           "assets/NoData.png"),
      //                                                       fit: BoxFit
      //                                                           .fill,
      //                                                       width: 85,
      //                                                       height: 85,
      //                                                     ),
      //                                                   )
      //                                                       : Expanded(
      //                                                     child: ListView
      //                                                         .builder(
      //                                                       controller: scrollCommentsController,
      //                                                       itemCount: CommentsList
      //                                                           .length,
      //                                                       padding: EdgeInsets
      //                                                           .only(
      //                                                           bottom: 100),
      //                                                       itemBuilder: (
      //                                                           context,
      //                                                           i) {
      //                                                         var CommentsData = CommentsList[i];
      //                                                         final startTime = DateFormat(
      //                                                             'dd-MM-yyyy HH:mm')
      //                                                             .parse(
      //                                                             '${CommentsData
      //                                                                 .createdAt
      //                                                                 .toString()}');
      //                                                         final currentTime = DateTime
      //                                                             .now();
      //                                                         final diff_dy = currentTime
      //                                                             .difference(
      //                                                             startTime)
      //                                                             .inDays;
      //                                                         final diff_mi = currentTime
      //                                                             .difference(
      //                                                             startTime)
      //                                                             .inMinutes;
      //                                                         final diff_s = currentTime
      //                                                             .difference(
      //                                                             startTime)
      //                                                             .inSeconds;
      //                                                         final diff_hr = currentTime
      //                                                             .difference(
      //                                                             startTime)
      //                                                             .inHours;
      //                                                         return Row(
      //                                                           mainAxisAlignment: MainAxisAlignment
      //                                                               .start,
      //                                                           crossAxisAlignment: CrossAxisAlignment
      //                                                               .start,
      //                                                           children: [
      //                                                             Container(
      //                                                               margin: EdgeInsets
      //                                                                   .only(
      //                                                                   left: 15,
      //                                                                   right: 0,
      //                                                                   top: 5),
      //                                                               height: 40,
      //                                                               width: 40,
      //                                                               decoration: BoxDecoration(
      //                                                                   shape: BoxShape
      //                                                                       .circle,
      //                                                                   image: CommentsData
      //                                                                       .user!
      //                                                                       .profilePicture ==
      //                                                                       null ||
      //                                                                       CommentsData
      //                                                                           .user!
      //                                                                           .profilePicture
      //                                                                           .toString() ==
      //                                                                           "null" ||
      //                                                                       CommentsData
      //                                                                           .user!
      //                                                                           .profilePicture
      //                                                                           .toString() ==
      //                                                                           ""
      //                                                                       ? DecorationImage(
      //                                                                       image: AssetImage(
      //                                                                           "assets/home.png"),
      //                                                                       fit: BoxFit
      //                                                                           .fill)
      //                                                                       : DecorationImage(
      //                                                                       image: NetworkImage(
      //                                                                           "${Url
      //                                                                               .IMAGE_URL}${CommentsData
      //                                                                               .user!
      //                                                                               .profilePicture}"),
      //                                                                       fit: BoxFit
      //                                                                           .fill)),
      //                                                             ),
      //                                                             Flexible(
      //                                                               child: Container(
      //                                                                 padding: EdgeInsets
      //                                                                     .symmetric(
      //                                                                     vertical: 10,
      //                                                                     horizontal: 5),
      //                                                                 margin: EdgeInsets
      //                                                                     .symmetric(
      //                                                                     vertical: 5,
      //                                                                     horizontal: 10),
      //                                                                 decoration: BoxDecoration(
      //                                                                   borderRadius: BorderRadius
      //                                                                       .circular(
      //                                                                       7),
      //                                                                   color: Constants
      //                                                                       .white,
      //                                                                 ),
      //                                                                 child: Column(
      //                                                                   crossAxisAlignment: CrossAxisAlignment
      //                                                                       .start,
      //                                                                   mainAxisAlignment: MainAxisAlignment
      //                                                                       .start,
      //                                                                   children: [
      //                                                                     Row(
      //                                                                       children: [
      //                                                                         Text(
      //                                                                           "${CommentsData
      //                                                                               .user!
      //                                                                               .username}",
      //                                                                           style: BlackDescStyle500,
      //                                                                         ),
      //                                                                         10
      //                                                                             .width,
      //                                                                         Text(
      //                                                                           diff_s <=
      //                                                                               60
      //                                                                               ? "$diff_s" "s"
      //                                                                               : diff_mi <=
      //                                                                               60
      //                                                                               ? "$diff_mi" 'm'
      //                                                                               : diff_hr <=
      //                                                                               24
      //                                                                               ? "$diff_hr" 'h'
      //                                                                               : "$diff_dy" 'd',
      //                                                                           style: Black45DescStyle,
      //                                                                         )
      //                                                                       ],
      //                                                                     ),
      //                                                                     Padding(
      //                                                                       padding: const EdgeInsets
      //                                                                           .only(
      //                                                                           top: 2.0),
      //                                                                       child: Text(
      //                                                                         '''${CommentsData
      //                                                                             .comment}''',
      //                                                                         style: Black87DescStyle,
      //                                                                       ),
      //                                                                     ),
      //                                                                   ],
      //                                                                 ),
      //                                                               ),
      //                                                             ),
      //                                                           ],
      //                                                         );
      //                                                       },
      //                                                     ),
      //                                                   ),
      //                                                 ],
      //                                               ),
      //                                               bottomSheet: Container(
      //                                                 decoration: BoxDecoration(
      //                                                     color: Color(
      //                                                         0x33DCF0DD),
      //                                                     border: Border(
      //                                                         top: BorderSide(
      //                                                             color: Constants
      //                                                                 .greyLight,
      //                                                             width: 1.5))),
      //                                                 child: Row(
      //                                                   mainAxisAlignment: MainAxisAlignment
      //                                                       .spaceBetween,
      //                                                   crossAxisAlignment: CrossAxisAlignment
      //                                                       .center,
      //                                                   children: [
      //                                                     10.width,
      //                                                     Container(
      //                                                       height: 35,
      //                                                       width: 35,
      //                                                       margin: const EdgeInsets
      //                                                           .only(
      //                                                           bottom: 5),
      //                                                       padding: EdgeInsets
      //                                                           .zero,
      //                                                       decoration: BoxDecoration(
      //                                                           borderRadius: BorderRadius
      //                                                               .circular(
      //                                                               5),
      //                                                           color: Constants
      //                                                               .greyDark),
      //                                                       child: Center(
      //                                                           child: Container(
      //                                                             height: 35,
      //                                                             width: 35,
      //                                                             decoration: DataManager
      //                                                                 .getInstance()
      //                                                                 .getuserImage() ==
      //                                                                 "null" ||
      //                                                                 DataManager.getInstance().getuserImage() == null ||
      //                                                                 DataManager
      //                                                                     .getInstance()
      //                                                                     .getuserImage() ==
      //                                                                     ""
      //                                                                 ? BoxDecoration(
      //                                                               // border: Border.all(color: Constants.white,width: 4),
      //                                                                 shape: BoxShape
      //                                                                     .circle,
      //                                                                 image: DecorationImage(
      //                                                                   image: AssetImage(
      //                                                                       "assets/home.png"),
      //                                                                 ))
      //                                                                 : BoxDecoration(
      //                                                                 border: Border
      //                                                                     .all(
      //                                                                     color: Constants
      //                                                                         .white,
      //                                                                     width: 2),
      //                                                                 shape: BoxShape
      //                                                                     .circle,
      //                                                                 image: DecorationImage(
      //                                                                     image: NetworkImage(
      //                                                                         "${Url
      //                                                                             .IMAGE_URL}${DataManager
      //                                                                             .getInstance()
      //                                                                             .getuserImage()}"),
      //                                                                     fit: BoxFit
      //                                                                         .fill)),
      //                                                           )),
      //                                                     ),
      //                                                     Flexible(
      //                                                       child: TextFormField(
      //                                                         controller: messageController,
      //                                                         keyboardType: TextInputType
      //                                                             .text,
      //                                                         // maxLines: ,
      //                                                         onChanged: (
      //                                                             value) {
      //                                                           setState(() {});
      //                                                           modalState(() {});
      //                                                         },
      //                                                         autofocus: false,
      //                                                         focusNode: focusNode,
      //                                                         // style: black14500,
      //                                                         cursorColor: Colors
      //                                                             .black,
      //                                                         textAlignVertical: TextAlignVertical
      //                                                             .center,
      //                                                         decoration: InputDecoration(
      //                                                           contentPadding: EdgeInsets
      //                                                               .symmetric(
      //                                                               horizontal: 10,
      //                                                               vertical: 7),
      //                                                           border: const OutlineInputBorder(
      //                                                               borderSide: BorderSide
      //                                                                   .none),
      //                                                           hintText: "Write your comments",
      //                                                           hintStyle: greySubTitleItalicStyle,
      //                                                         ),
      //                                                       ),
      //                                                     ),
      //                                                     messageController
      //                                                         .text
      //                                                         .isEmpty
      //                                                         ? SizedBox()
      //                                                         : InkWell(
      //                                                       onTap: () {
      //                                                         // messageController.clear();
      //                                                         DrawAuraAPi
      //                                                             .CreateOfferComments(
      //                                                             offer_id: data
      //                                                                 .offerData!
      //                                                                 .id
      //                                                                 .toString(),
      //                                                             user_id: DataManager
      //                                                                 .getInstance()
      //                                                                 .getuserId()
      //                                                                 .toString(),
      //                                                             Comments: messageController
      //                                                                 .text)
      //                                                             .then((
      //                                                             value) {
      //                                                           if (value["status"] ==
      //                                                               "200") {
      //                                                             var CommentRes = CommentsDataList(
      //                                                               id: value["result"]["id"],
      //                                                               user: CommentsUser(
      //                                                                   id: value["result"]["user"]["id"],
      //                                                                   displayname: value["result"]["user"]["displayname"],
      //                                                                   profilePicture: value["result"]["user"]["profile_picture"],
      //                                                                   username: value["result"]["user"]["username"]),
      //                                                               offer: value["result"]["offer"],
      //                                                               comment: value["result"]["comment"],
      //                                                               createdAt: value["result"]["created_at"],
      //                                                               updatedAt: value["result"]["updated_at"],
      //                                                             );
      //                                                             modalState(() {
      //                                                               CommentsList
      //                                                                   .add(
      //                                                                   CommentRes);
      //                                                               messageController
      //                                                                   .clear();
      //                                                               scrollToBottom();
      //                                                             });
      //                                                           }
      //                                                         });
      //                                                       },
      //                                                       child: Container(
      //                                                         margin: EdgeInsets
      //                                                             .only(
      //                                                             right: 10),
      //                                                         height: 40,
      //                                                         width: 40,
      //                                                         decoration: BoxDecoration(
      //                                                             shape: BoxShape
      //                                                                 .circle,
      //                                                             border: Border
      //                                                                 .all(
      //                                                                 color: Constants
      //                                                                     .greyLight,
      //                                                                 width: 1),
      //                                                             color: Constants
      //                                                                 .primaryColor),
      //                                                         child: Center(
      //                                                             child: Icon(
      //                                                               Icons
      //                                                                   .send,
      //                                                               color: Colors
      //                                                                   .white,
      //                                                               size: 24,
      //                                                             )),
      //                                                       ),
      //                                                     ),
      //                                                   ],
      //                                                 ),
      //                                               ),
      //                                             ));
      //                                       },
      //                                     );
      //                                   },
      //                                 ).then((
      //                                     value) {
      //                                   DrawAuraAPi
      //                                       .getSubscriberOfferApi(
      //                                       SubcriberId: DataManager
      //                                           .getInstance()
      //                                           .getuserId()
      //                                           .toString())
      //                                       .then((
      //                                       SubscriberOfferRes) {
      //                                     if (SubscriberOfferRes["status"] ==
      //                                         "200") {
      //                                       setState(() {
      //                                         SubscriberOfferDetailsWithoutModel =
      //                                         SubscriberOfferRes["result"];
      //                                         SubscriberOfferDetails =
      //                                             OfferDataModel
      //                                                 .fromJson(
      //                                                 SubscriberOfferRes);
      //                                         getMyOffersList =
      //                                         SubscriberOfferDetails!
      //                                             .result!;
      //                                       });
      //                                     }
      //                                     DrawAuraAPi
      //                                         .getSubscriberCounterOfferApi(
      //                                         SubcriberId: DataManager
      //                                             .getInstance()
      //                                             .getuserId()
      //                                             .toString())
      //                                         .then((
      //                                         SubscriberCounterOfferRes) {
      //                                       if (SubscriberCounterOfferRes["status"] ==
      //                                           "200") {
      //                                         setState(() {
      //                                           SubscriberCouterOfferDetails =
      //                                               OfferDataModel
      //                                                   .fromJson(
      //                                                   SubscriberCounterOfferRes);
      //                                           getMyCounterOffersList =
      //                                           SubscriberCouterOfferDetails!
      //                                               .result!;
      //                                           getMyOffersList
      //                                               .addAll(
      //                                               getMyCounterOffersList);
      //                                         });
      //                                         //  getMyOffersList.sort((a, b)=> DateTime.parse(a.offerData!.createdAt.toString()).compareTo(DateTime.parse(b.offerData!.createdAt.toString())));
      //                                       }
      //                                     });
      //                                   });
      //                                 });
      //                               },
      //                               child: Image
      //                                   .asset(
      //                                 "assets/comment.png",
      //                                 height: 18,
      //                               )),
      //                           Padding(
      //                             padding: const EdgeInsets
      //                                 .only(
      //                                 left: 3.0),
      //                             child: Text(
      //                               "${data
      //                                   .offerData!
      //                                   .comments
      //                                   .toString()
      //                                   .split(".")
      //                                   .first}",
      //                               style: darkgreyFieldStyle,
      //                             ),
      //                           ),
      //                           Spacer(),
      //                           Image.asset(
      //                               "assets/note.png",
      //                               height: 15,
      //                               color: Colors
      //                                   .grey),
      //                           Padding(
      //                             padding: const EdgeInsets
      //                                 .only(
      //                                 left: 3.0),
      //                             child: Text(
      //                               "${data
      //                                   .offerData!
      //                                   .offercopycount
      //                                   .toString()}",
      //                               style: greyFieldStyle,
      //                             ),
      //                           ),
      //                           Spacer(),
      //                           Image.asset(
      //                             "assets/time.png",
      //                             height: 15,
      //                             color: Constants
      //                                 .primaryColor,
      //                           ),
      //                           Padding(
      //                             padding: const EdgeInsets
      //                                 .only(
      //                                 left: 3.0),
      //                             child: Text(
      //                               diff_s <= 60
      //                                   ? "$diff_s" "s"
      //                                   : diff_mi <=
      //                                   60
      //                                   ? "$diff_mi" "m"
      //                                   : diff_hr <=
      //                                   24
      //                                   ? "$diff_hr" "h"
      //                                   : diff_dy <=
      //                                   30
      //                                   ? "$diff_dy" "d"
      //                                   : months <=
      //                                   12
      //                                   ? "$months" "months"
      //                                   : "$years",
      //                               style: BlackDescStyle,
      //                             ),
      //                           )
      //                         ],
      //                       ),
      //                       (data.offerData!
      //                           .offerLike! +
      //                           data.offerData!
      //                               .offerDisLike!) ==
      //                           0
      //                           ? Text(
      //                           "${Url.NoRating}",
      //                           style: BlackSubTitleStyle)
      //                           : Text(
      //                         ((data.offerData!
      //                             .offerLike! /
      //                             (data.offerData!
      //                                 .offerLike! +
      //                                 data
      //                                     .offerData!
      //                                     .offerDisLike!)) *
      //                             100) < 0
      //                             ? "00"
      //                             : "${((data
      //                             .offerData!
      //                             .offerLike! /
      //                             (data.offerData!
      //                                 .offerLike! +
      //                                 data
      //                                     .offerData!
      //                                     .offerDisLike!)) *
      //                             100)
      //                             .toStringAsFixed(
      //                             0)}%(${data
      //                             .offerData!
      //                             .offerLike! +
      //                             data.offerData!
      //                                 .offerDisLike!})",
      //                         style: primarySmallText,
      //                       ),
      //                       const SizedBox(
      //                         height: 5,
      //                       ),
      //                       data.offerData!
      //                           .buyORsell ==
      //                           "COUNTER SELL" ||
      //                           data.offerData!
      //                               .buyORsell ==
      //                               "COUNTER BUY"
      //                           ? SizedBox()
      //                           : Text(
      //                         data.offerData!
      //                             .counterdUser!
      //                             .isEmpty ||
      //                             data.offerData!
      //                                 .counterdUser ==
      //                                 null ||
      //                             data.offerData!
      //                                 .counterdUser ==
      //                                 "null"
      //                             ? "${Url
      //                             .peopleResponded}"
      //                             : "${data
      //                             .offerData!
      //                             .counterdUser!
      //                             .length} people responded",
      //                         style: greyHintStyle,
      //                       ),
      //                       data.offerData!
      //                           .buyORsell ==
      //                           "COUNTER SELL" ||
      //                           data.offerData!
      //                               .buyORsell ==
      //                               "COUNTER BUY"
      //                           ? SizedBox()
      //                           : const SizedBox(
      //                         height: 10,
      //                       ),
      //                       data.offerData!
      //                           .buyORsell ==
      //                           "COUNTER SELL" ||
      //                           data.offerData!
      //                               .buyORsell ==
      //                               "COUNTER BUY"
      //                           ? SizedBox()
      //                           : data.offerData!
      //                           .counterdUser!
      //                           .isEmpty ||
      //                           data.offerData!
      //                               .counterdUser ==
      //                               null
      //                           ? SizedBox()
      //                           : SizedBox(
      //                         height: 30,
      //                         width: isMobile?width*0.4:tabWidth*0.4,
      //                         child: ListView
      //                             .builder(
      //                           itemCount: data
      //                               .offerData!
      //                               .counterdUser!
      //                               .length,
      //                           shrinkWrap: true,
      //                           scrollDirection: Axis
      //                               .horizontal,
      //                           physics: ClampingScrollPhysics(),
      //                           itemBuilder: (
      //                               context, j) {
      //                             var counterData = data
      //                                 .offerData!
      //                                 .counterdUser![j];
      //                             return ClipOval(
      //                               child: Image
      //                                   .network(
      //                                 "${Url
      //                                     .IMAGE_URL}${counterData
      //                                     .image}",
      //                                 height: 30,
      //                                 width: 30,
      //                                 fit: BoxFit
      //                                     .fill,
      //                                 errorBuilder: (
      //                                     BuildContext context,
      //                                     Object exception,
      //                                     StackTrace? stackTrace) {
      //                                   return Image
      //                                       .network(
      //                                     "https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
      //                                     height: 30,
      //                                     width: 30,
      //                                     fit: BoxFit
      //                                         .fill,
      //                                   );
      //                                 },
      //                               ),
      //                             );
      //                           },
      //                         ),
      //                       ),
      //                       data.offerData!
      //                           .buyORsell ==
      //                           "COUNTER SELL" ||
      //                           data.offerData!
      //                               .buyORsell ==
      //                               "COUNTER BUY"
      //                           ? Text.rich(
      //                           TextSpan(
      //                               text: "Query by  ",
      //                               style: greySubTitleItalicStyle,
      //                               children: <
      //                                   InlineSpan>[
      //                                 TextSpan(
      //                                   text: data
      //                                       .offerData!
      //                                       .offerBids![data
      //                                       .offerData!
      //                                       .offerBids!
      //                                       .length -
      //                                       1]
      //                                       .fromCounter!
      //                                       .id
      //                                       .toString()
      //                                       .trim() ==
      //                                       DataManager
      //                                           .getInstance()
      //                                           .getuserId()
      //                                           .toString()
      //                                           .trim()
      //                                       ? "You"
      //                                       : "${data
      //                                       .offerData!
      //                                       .offerBids![data
      //                                       .offerData!
      //                                       .offerBids!
      //                                       .length -
      //                                       1]
      //                                       .fromCounter!
      //                                       .username
      //                                       .toString()}",
      //                                   style: greySubTitleItalicStyle900,
      //                                 ),
      //                               ]))
      //                           : SizedBox(),
      //                       data.offerData!
      //                           .buyORsell ==
      //                           "COUNTER SELL" ||
      //                           data.offerData!
      //                               .buyORsell ==
      //                               "COUNTER BUY"
      //                           ? Text.rich(
      //                           TextSpan(
      //                               text: "Query by  ",
      //                               style: greySubTitleItalicStyle,
      //                               children: <
      //                                   InlineSpan>[
      //                                 TextSpan(
      //                                   text: data
      //                                       .offerData!
      //                                       .offerBids!
      //                                       .last
      //                                       .fromCounter!
      //                                       .id
      //                                       .toString()
      //                                       .trim() ==
      //                                       DataManager
      //                                           .getInstance()
      //                                           .getuserId()
      //                                           .toString()
      //                                           .trim()
      //                                       ? "You"
      //                                       : "${data
      //                                       .offerData!
      //                                       .offerBids!
      //                                       .last
      //                                       .fromCounter!
      //                                       .username
      //                                       .toString()}",
      //                                   style: greySubTitleItalicStyle900,
      //                                 ),
      //                                 TextSpan(
      //                                   text: data
      //                                       .offerData!
      //                                       .offerBids!
      //                                       .length ==
      //                                       2
      //                                       ? ""
      //                                       : " -->${data
      //                                       .offerData!
      //                                       .offerBids!
      //                                       .length -
      //                                       2} More",
      //                                   style: greySubTitleItalicStyle900,
      //                                 ),
      //                               ]))
      //                           : SizedBox()
      //                     ],
      //                   ),
      //                 ),
      //                 data.offerData!.offerstatus
      //                     .toString()
      //                     .trim()
      //                     .toUpperCase() ==
      //                     "CLOSED"
      //                     ? Stack(
      //                   children: [
      //                     Container(
      //                       decoration: BoxDecoration(
      //                         borderRadius: const BorderRadius
      //                             .only(
      //                             bottomRight: Radius
      //                                 .circular(10),
      //                             topRight: Radius
      //                                 .circular(
      //                                 10)),
      //                         color: Constants
      //                             .closeOfferCard,
      //                       ),
      //                     ),
      //                     data.offerData!
      //                         .subscribers!.id
      //                         .toString().trim() ==
      //                         DataManager
      //                             .getInstance()
      //                             .getuserId() ||
      //                         data.offerData!
      //                             .buyORsell ==
      //                             "COUNTER SELL" ||
      //                         data.offerData!
      //                             .buyORsell ==
      //                             "COUNTER BUY"
      //                         ? Positioned(
      //                       top: 2,
      //                       right: 2,
      //                       child: InkWell(
      //                         onTap: () {
      //                           showDialog<void>(
      //                             context: context,
      //                             barrierDismissible: false,
      //                             builder: (
      //                                 BuildContext context) {
      //                               return StatefulBuilder(
      //                                 builder: (
      //                                     context,
      //                                     ModalState) {
      //                                   return Dialog(
      //                                       shape: RoundedRectangleBorder(
      //                                           borderRadius: BorderRadius
      //                                               .circular(
      //                                               5)),
      //                                       elevation: 16,
      //                                       child: Container(
      //                                         width:  isMobile?width:tabWidth*0.85,
      //                                         margin: EdgeInsets.symmetric(horizontal: 20),
      //                                         child: ListView(
      //                                           shrinkWrap: true,
      //                                           padding: const EdgeInsets
      //                                               .symmetric(
      //                                               vertical: 20),
      //                                           children: [
      //                                             Image
      //                                                 .asset(
      //                                               "assets/delete.png",
      //                                               height: 50,
      //                                               width: 50,
      //                                               color: Colors
      //                                                   .black,
      //                                             ),
      //                                             Padding(
      //                                               padding: EdgeInsets
      //                                                   .only(
      //                                                   top: 10,
      //                                                   bottom: 10),
      //                                               child: Text(
      //                                                   'DELETE OFFER!',
      //                                                   style: BlackFieldStyleBold,
      //                                                   textAlign: TextAlign
      //                                                       .center),
      //                                             ),
      //                                             const Padding(
      //                                               padding: EdgeInsets
      //                                                   .only(
      //                                                   bottom: 20.0),
      //                                               child: Text(
      //                                                   "ARE YOU SURE TO DELETE?",
      //                                                   style: Black87HintStyle,
      //                                                   textAlign: TextAlign
      //                                                       .center),
      //                                             ),
      //                                             Row(
      //                                               mainAxisAlignment: MainAxisAlignment
      //                                                   .spaceEvenly,
      //                                               children: [
      //                                                 ElevatedButton(
      //                                                     onPressed: () async {
      //                                                       Navigator
      //                                                           .pop(
      //                                                           context);
      //                                                     },
      //                                                     style: ElevatedButton
      //                                                         .styleFrom(
      //                                                       backgroundColor: Constants
      //                                                           .primaryColor,
      //                                                       fixedSize: Size(
      //                                                           isMobile?width*0.3:tabWidth*0.3,
      //                                                           35),
      //                                                       elevation: 1,
      //                                                       shape: RoundedRectangleBorder(
      //                                                           borderRadius: BorderRadius
      //                                                               .circular(
      //                                                               7)),
      //                                                     ),
      //                                                     child: const Text(
      //                                                       "Cancel",
      //                                                       style: WhiteButtonStyle,
      //                                                     )),
      //                                                 ElevatedButton(
      //                                                     onPressed: () async {
      //                                                       ModalState(() {
      //                                                         butttonLoader =
      //                                                         true;
      //                                                       });
      //                                                       var body = {
      //                                                         "offer_id": data
      //                                                             .offerData!
      //                                                             .id
      //                                                             .toString()
      //                                                       };
      //                                                       DrawAuraAPi
      //                                                           .CreateDataApi(
      //                                                           body: body,
      //                                                           ApiEndPoint: "deleteOffer")
      //                                                           .then((
      //                                                           value) {
      //                                                         ModalState(() {
      //                                                           butttonLoader =
      //                                                           false;
      //                                                         });
      //                                                         Navigator
      //                                                             .pop(
      //                                                             context);
      //                                                         if (value["status"] ==
      //                                                             200) {
      //                                                           Constants
      //                                                               .showToast(
      //                                                               value["message"]);
      //                                                           ModalState(() {
      //                                                             getMyOffersList
      //                                                                 .removeAt(
      //                                                                 index);
      //                                                           });
      //                                                           setState(() {});
      //                                                         } else {
      //                                                           Constants
      //                                                               .showToast(
      //                                                               value["message"]);
      //                                                         }
      //                                                       });
      //                                                     },
      //                                                     style: ElevatedButton
      //                                                         .styleFrom(
      //                                                       backgroundColor: Constants
      //                                                           .primaryColor,
      //                                                       fixedSize: Size(
      //                                                           isMobile?width * 0.3:tabWidth*0.3,
      //                                                           35),
      //                                                       elevation: 1,
      //                                                       shape: RoundedRectangleBorder(
      //                                                           borderRadius: BorderRadius
      //                                                               .circular(
      //                                                               7)),
      //                                                     ),
      //                                                     child: butttonLoader ==
      //                                                         true
      //                                                         ? SizedBox(
      //                                                         height: 24,
      //                                                         width: 24,
      //                                                         child: CircularProgressIndicator(
      //                                                           color: Colors
      //                                                               .white,
      //                                                           strokeWidth: 2.5,
      //                                                         ))
      //                                                         : Text(
      //                                                       "Yes",
      //                                                       style: WhiteButtonStyle,
      //                                                     )),
      //                                               ],
      //                                             ),
      //                                           ],
      //                                         ),
      //                                       ));
      //                                 },
      //                               );
      //                             },
      //                           );
      //                         },
      //                         child: CircleAvatar(
      //                             radius: 15,
      //                             backgroundColor: Constants
      //                                 .black,
      //                             child: Image
      //                                 .asset(
      //                               "assets/delete.png",
      //                               height: 20,
      //                               color: Colors
      //                                   .white,
      //                             )),
      //                       ),
      //                     )
      //                         : SizedBox(),
      //                   ],
      //                 )
      //                     : SizedBox(),
      //                 data.offerData!.offerstatus
      //                     .toString()
      //                     .trim()
      //                     .toUpperCase() !=
      //                     "CLOSED"
      //                     ? data.offerData!
      //                     .ConfirmingSubscriber!
      //                     .isEmpty && data
      //                     .offerData!.subscribers!
      //                     .id.toString().trim() ==
      //                     DataManager.getInstance()
      //                         .getuserId()
      //                     ? Positioned(
      //                   top: 2,
      //                   right: 2,
      //                   child: InkWell(
      //                     onTap: () {
      //                       showDialog<void>(
      //                         context: context,
      //                         barrierDismissible: false,
      //                         builder: (
      //                             BuildContext context) {
      //                           return StatefulBuilder(
      //                             builder: (context,
      //                                 ModalState) {
      //                               return Dialog(
      //                                   shape: RoundedRectangleBorder(
      //                                       borderRadius: BorderRadius
      //                                           .circular(
      //                                           5)),
      //                                   elevation: 16,
      //                                   child: Container(
      //                                     width:  isMobile?width:tabWidth*0.85,
      //                                     margin: EdgeInsets.symmetric(horizontal: 20),
      //                                     child: ListView(
      //                                       shrinkWrap: true,
      //                                       padding: const EdgeInsets
      //                                           .symmetric(
      //                                           vertical: 20),
      //                                       children: [
      //                                         Image
      //                                             .asset(
      //                                           "assets/delete.png",
      //                                           height: 50,
      //                                           width: 50,
      //                                           color: Colors
      //                                               .black,
      //                                         ),
      //                                         Padding(
      //                                           padding: EdgeInsets
      //                                               .only(
      //                                               top: 10,
      //                                               bottom: 10),
      //                                           child: Text(
      //                                               'DELETE OFFER!',
      //                                               style: BlackFieldStyleBold,
      //                                               textAlign: TextAlign
      //                                                   .center),
      //                                         ),
      //                                         const Padding(
      //                                           padding: EdgeInsets
      //                                               .only(
      //                                               bottom: 20.0),
      //                                           child: Text(
      //                                               "ARE YOU SURE TO DELETE?",
      //                                               style: Black87HintStyle,
      //                                               textAlign: TextAlign
      //                                                   .center),
      //                                         ),
      //                                         Row(
      //                                           mainAxisAlignment: MainAxisAlignment
      //                                               .spaceEvenly,
      //                                           children: [
      //                                             ElevatedButton(
      //                                                 onPressed: () async {
      //                                                   Navigator
      //                                                       .pop(
      //                                                       context);
      //                                                 },
      //                                                 style: ElevatedButton
      //                                                     .styleFrom(
      //                                                   backgroundColor: Constants
      //                                                       .primaryColor,
      //                                                   fixedSize: Size(
      //                                                       isMobile?width*0.3:tabWidth*0.3,
      //                                                       35),
      //                                                   elevation: 1,
      //                                                   shape: RoundedRectangleBorder(
      //                                                       borderRadius: BorderRadius
      //                                                           .circular(
      //                                                           7)),
      //                                                 ),
      //                                                 child: const Text(
      //                                                   "Cancel",
      //                                                   style: WhiteButtonStyle,
      //                                                 )),
      //                                             ElevatedButton(
      //                                                 onPressed: () async {
      //                                                   ModalState(() {
      //                                                     butttonLoader =
      //                                                     true;
      //                                                   });
      //                                                   var body = {
      //                                                     "offer_id": data
      //                                                         .offerData!
      //                                                         .id
      //                                                         .toString()
      //                                                   };
      //                                                   DrawAuraAPi
      //                                                       .CreateDataApi(
      //                                                       body: body,
      //                                                       ApiEndPoint: "deleteOffer")
      //                                                       .then((
      //                                                       value) {
      //                                                     ModalState(() {
      //                                                       butttonLoader =
      //                                                       false;
      //                                                     });
      //                                                     Navigator
      //                                                         .pop(
      //                                                         context);
      //                                                     if (value["status"] ==
      //                                                         200) {
      //                                                       Constants
      //                                                           .showToast(
      //                                                           value["message"]);
      //                                                       ModalState(() {
      //                                                         getMyOffersList
      //                                                             .removeAt(
      //                                                             index);
      //                                                       });
      //                                                       setState(() {});
      //                                                     } else {
      //                                                       Constants
      //                                                           .showToast(
      //                                                           value["message"]);
      //                                                     }
      //                                                   });
      //                                                 },
      //                                                 style: ElevatedButton
      //                                                     .styleFrom(
      //                                                   backgroundColor: Constants
      //                                                       .primaryColor,
      //                                                   fixedSize: Size(
      //                                                       isMobile?width * 0.3:tabWidth*0.3,
      //                                                       35),
      //                                                   elevation: 1,
      //                                                   shape: RoundedRectangleBorder(
      //                                                       borderRadius: BorderRadius
      //                                                           .circular(
      //                                                           7)),
      //                                                 ),
      //                                                 child: butttonLoader ==
      //                                                     true
      //                                                     ? SizedBox(
      //                                                     height: 24,
      //                                                     width: 24,
      //                                                     child: CircularProgressIndicator(
      //                                                       color: Colors
      //                                                           .white,
      //                                                       strokeWidth: 2.5,
      //                                                     ))
      //                                                     : Text(
      //                                                   "Yes",
      //                                                   style: WhiteButtonStyle,
      //                                                 )),
      //                                           ],
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ));
      //                             },
      //                           );
      //                         },
      //                       );
      //                     },
      //                     child: CircleAvatar(
      //                         radius: 15,
      //                         backgroundColor: Constants
      //                             .black,
      //                         child: Image.asset(
      //                           "assets/delete.png",
      //                           height: 20,
      //                           color: Colors.white,
      //                         )),
      //                   ),
      //                 )
      //                     : SizedBox()
      //                     : SizedBox(),
      //                 Positioned(
      //                     bottom:2,right: 2,
      //                     child:privetPublicLogo(isPrivet: data.offerData!.privacy.toString().toUpperCase() == "PRIVATE"?true:false)
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // );
    },
  );
}





