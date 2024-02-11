import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loader.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/screens/Dashboard/dashboard_screen.dart';
import 'package:socialapps/screens/Dashboard/home/OtherUserProfileViewScreen.dart';

import '../../../Apis/urls.dart';
import '../../../common/ResponsiveBuilder.dart';
import '../../../common/style.dart';
import '../../../model/GetFollowersListModel.dart';
import '../../../model/GetFollowingListModal.dart';



class FollowersFollowingScreen extends StatefulWidget {
  var tabIndex;
  var userId;
   FollowersFollowingScreen({Key? key,this.tabIndex,required this.userId}) : super(key: key);

  @override
  State<FollowersFollowingScreen> createState() => _FollowersFollowingScreenState();
}

class _FollowersFollowingScreenState extends State<FollowersFollowingScreen> {
  bool loader = false;
  List<bool> removeLoader=[];
  // bool removeLoader = false;


  String? selectedValue;

  List<GetFollowersResult> ?FollowersList;
  List<GetFollowingResult> ?FollowingList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  load(){
    setState(() {
      loader=true;
    });
    DrawAuraAPi.getFollowersListApi(UserId: widget.userId.toString()).then((value) {
      if(value.status=="200"){

        setState(() {
          FollowersList=value.result;
          loader=false;
        });
        for(var i=0;i<value.result!.length;i++){
          setState(() {
            removeLoader.add(false);
          });
        }

      }else{
        setState(() {
          loader=false;
        });
        Fluttertoast.showToast(
            msg: value.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18.0
        );
      }

    });



    DrawAuraAPi.getFollowingListApi().then((value) {
      if(value.status=="200"){

        setState(() {
          FollowingList = value.result!;
          loader=false;
        });
      }else{
        setState(() {
          loader=false;
        });
        Fluttertoast.showToast(
            msg: value.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18.0
        );

      }
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   setState(() {
  //     FollowersList;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    var isMobile = ResponsiveHelper.isMobile(context);
    return  Scaffold(
        backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
    body: responsiveContainer(context,
    ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
       DefaultTabController(
        initialIndex:widget.tabIndex=="0"?0:1,
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            titleSpacing: 0,
            leadingWidth: 30,
            backgroundColor: Colors.white,toolbarHeight: 40,
            leading: InkWell(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex:4),));},
                child: const Icon(Icons.arrow_back)),
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text("",style: AppBarTitle,),
            bottom:TabBar(
              labelColor: Colors.black,
              labelStyle: BlackFieldStyleBold,
              indicatorColor: Colors.grey,
              unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    child:loader==true || FollowersList == null?const ButtonLoaderGreen():FollowersList!.isEmpty ?Text("0 Followers",style: BlackSubTitleStyle,):Text("${FollowersList!.length} Followers",style: BlackSubTitleStyle),
                  ),
                  Tab(
                    child:loader==true || FollowingList == null?const ButtonLoaderGreen():FollowingList!.isEmpty?Text("0 Following",style: BlackSubTitleStyle,):Text("${FollowingList!.length} Following",style: BlackSubTitleStyle),
                  ),
                ]
            ),
          ),
          body:  TabBarView(
              children: [
                FollowersList==null?
                const Center(child: LoadingWidget()):
                FollowersList!.isEmpty?
                Center(child: Container(
                  padding: const EdgeInsets.all(5),
                  // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(width: 5,color: Colors.green)),
                  child: const Text("Followers List is Empty",style: PrimaryColorHeadStyleBold,),)):
                AnimationLimiter(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: FollowersList!.length,
                    itemBuilder: (context, index) {
                      var data = FollowersList![index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      Get.to(()=>ProfileViewScreen(userID: data.id.toString(),));
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration:data.profilePicture==null?BoxDecoration(borderRadius: BorderRadius.circular(50),image: const DecorationImage(image:AssetImage("assets/home.png"),fit: BoxFit.fill)):BoxDecoration(borderRadius: BorderRadius.circular(50),image: DecorationImage(image:NetworkImage("${Url.IMAGE_URL}${data.profilePicture.toString()}"),fit: BoxFit.fill)),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  InkWell(
                                      onTap:(){
                                        Get.to(()=>ProfileViewScreen(userID: data.id.toString(),));
                                      },
                                      child: Text(data.displayname.toString(),style: BlackFieldStyleBold,)),
                                  const Spacer(),
                                  SizedBox(
                                    height: 32,

                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: Color(0xFFDFEAE4)
                                        ),
                                        onPressed: (){
                                            var userId={
                                              "following_id":DataManager.getInstance().userId.toString(),
                                              "follower_id":data.id.toString(),
                                            };
                                            setState(() {
                                              removeLoader[index]=true;
                                            });
                                            DrawAuraAPi().unfollowSubscriberApi(ids:userId).then((value) {
                                                if(value["status"]=="200"){
                                                  FollowersList!.remove(data);
                                                  Fluttertoast.showToast(
                                                      msg: value["message"].toString(),
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 2,
                                                      backgroundColor: Colors.green,
                                                      textColor: Colors.white,
                                                      fontSize: 18.0
                                                  );
                                                  setState(() {
                                                    removeLoader[index]=false;
                                                  });
                                                //  Navigator.push(context, MaterialPageRoute(builder:  (context) => FollowersFollowingScreen(tabIndex: "0"),));
                                                }else{
                                                  Fluttertoast.showToast(
                                                      msg: value["message"].toString(),
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 2,
                                                      backgroundColor: Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 18.0
                                                  );
                                                  setState(() {
                                                    removeLoader[index]=false;
                                                  });
                                                }
                                            });

                                        },
                                        child: removeLoader[index]==false?const Text("Remove",style: BlackTitleItalicStyle,):const ButtonLoaderWhite()),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                      },
                  ),
                ),

                FollowingList==null?
                const Center(child: LoadingWidget()):
                FollowingList!.isEmpty?
                Center(child: Container(
                  padding: const EdgeInsets.all(5),
                  // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(width: 5,color: Colors.green)),
                  child: const Text("Following List Is Empty",style: PrimaryColorHeadStyleBold,),)):
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: FollowingList!.length,
                  itemBuilder: (context, index) {
                    var data = FollowingList![index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                              child:Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          InkWell(
                            onTap:(){
                              Get.to(()=>ProfileViewScreen(userID: data.id.toString(),));
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration:data.profilePicture==null?BoxDecoration(borderRadius: BorderRadius.circular(50),image: const DecorationImage(image:AssetImage("assets/home.png"),fit: BoxFit.fill)):BoxDecoration(borderRadius: BorderRadius.circular(50),image: DecorationImage(image:NetworkImage("${Url.IMAGE_URL}${data.profilePicture.toString()}"),fit: BoxFit.fill)),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          InkWell(
                              onTap:(){
                                Get.to(()=>ProfileViewScreen(userID: data.id.toString(),));
                              },
                              child: Text(data.username.toString(),style: BlackFieldStyleBold,)),
                          const Spacer(),
                          SizedBox(
                            height: 32,
                            // width: isMobile?width*0.25:tabWidth*0.25,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Color(0xFFDFEAE4)
                                ),
                                onPressed: (){
                                  var userId={
                                    "following_id":DataManager.getInstance().userId.toString(),
                                    "follower_id":data.id.toString(),
                                  };
                                  print("userId");
                                  print(userId);
                                  setState(() {
                                    removeLoader[index]=true;
                                  });
                                  DrawAuraAPi().unfollowSubscriberApi(ids:userId).then((value) {
                                    if(value["status"]=="200"){
                                      FollowingList!.remove(data);
                                      Fluttertoast.showToast(
                                          msg: value["message"].toString(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 18.0
                                      );
                                      setState(() {
                                        removeLoader[index]=false;
                                      });
                                     // Navigator.push(context, MaterialPageRoute(builder:  (context) => FollowersFollowingScreen(tabIndex: "1"),));
                                    }else{
                                      Fluttertoast.showToast(
                                          msg: value["message"].toString(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 18.0
                                      );
                                      setState(() {
                                        removeLoader[index]=false;
                                      });
                                    }
                                  });

                                },
                                child: removeLoader[index]==false?const Text("Remove",style: BlackTitleItalicStyle,):const ButtonLoaderWhite()),
                          )
                        ],
                      ),
                    )
                          ),
                      ),
                    );
                  },
                ),
          ]),
        ),
      ),
    )
    );
  }
}
