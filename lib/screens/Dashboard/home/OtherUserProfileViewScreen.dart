
import 'dart:convert';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/CommentsModel.dart';
import 'package:socialapps/model/FollowersListModel.dart';
import 'package:socialapps/model/OfferDataModel.dart';
import 'package:socialapps/model/PrefillOfferDataModel.dart';
import 'package:socialapps/model/getSubrciberDetailsModel.dart';
import 'package:socialapps/model/serviceAreaModel.dart';
import 'package:socialapps/screens/Dashboard/home/home_detail_screen.dart';
import 'package:socialapps/screens/Dashboard/notify/followers_following_screen.dart';
import 'package:socialapps/screens/OfferCounterPage.dart';
import 'package:socialapps/screens/Reaction/reactionList.dart';
import 'package:socialapps/screens/updateOfferPage.dart';
import 'package:socialapps/screens/newOfferPage.dart';
import 'package:socialapps/screens/widgets/CommonOfferCardBuilderAndTap.dart';
import 'package:socialapps/screens/widgets/ImageGalleryByUrl.dart';
import 'package:socialapps/screens/widgets/OfferCradCommonFunction.dart';
import 'package:socialapps/screens/widgets/commonCards.dart';
import '../../../common/style.dart';
import '../../../model/GetUserAccountModal.dart';
import '../../lastCounterScreen.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';


class ProfileViewScreen extends StatefulWidget {
  var userID;
  ProfileViewScreen({Key? key,this.userID}) : super(key: key);

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  getSubscriberDetailsResult ? SubscriberDetails;
  GetUserAccountModal ? UserAccountDetails;
  OfferDataModel ? SubscriberOfferDetails;
  OfferDataModel ? SubscriberCouterOfferDetails;
  OfferDataModel ? TemplateOfferDetails;
  OfferDataModel ? FavoriteOfferDetails;
  var SubscriberOfferDetailsWithoutModel;
  bool loader = false;
  List<String> filter = [
    'open',
    'Confirmed',
    'Executed',
    'Sign off',
    'Cancelled',
    'Disputes',
    'No Counters',
  ];
  String user = "acc";
  List<String> selectedItems = [];


  String? selectedValue;
  TabController? _tabController;
  bool listGrid = false;
  String chooseAccount="";
  String userProfileImage="";
  String backPageImage="";

  String followersCount="";
  String followingCount="";
  String placeOrperson="";
  List<OfferDataModelResult> getMyOffersList=[];
  List<OfferDataModelResult> getMyCounterOffersList=[];
  List<OfferDataModelResult> ShortingOffersList=[];
  List<OfferDataModelResult> getTemplateOfferList=[];
  List<OfferDataModelResult> getFavoriteOfferList=[];
  List<FollowersListModel> FollowersList=[];
  bool isFollowYou = false;
  bool accountSwitchLoader = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
    RefreshAfter8Sec();
    scrollCommentsController = ScrollController();

  }
 getSuscriberOffer (){
   DrawAuraAPi.getSubscriberOfferApi(SubcriberId:widget.userID.toString()).then((SubscriberOfferRes) {
     print("getSubscriberOfferApi Call Done");

     if(SubscriberOfferRes["status"] == "200"){
      if(mounted){
        setState(() {
          getMyOffersList.clear();
          SubscriberOfferDetailsWithoutModel = SubscriberOfferRes["result"];
          SubscriberOfferDetails = OfferDataModel.fromJson(SubscriberOfferRes);
          SubscriberOfferDetails!.result!.forEach((element) { if(element.offerData!.privacy.toString().toUpperCase() == "PUBLIC"){
            getMyOffersList.add(element);
          } });
          print( getMyOffersList.length);
        });
      }
     }

     DrawAuraAPi.getSubscriberTemplateOfferApi(SubcriberId: widget.userID.toString()).then((getSubscriberTemplateOfferRes) {
       print("getSubscriberTemplateOfferApi Call Done");
       if(getSubscriberTemplateOfferRes["status"] == "200"){
         TemplateOfferDetails = OfferDataModel.fromJson(getSubscriberTemplateOfferRes);
         TemplateOfferDetails!.result!.forEach((element) { if(element.offerData!.privacy.toString().toUpperCase() == "PUBLIC"){
           getTemplateOfferList.add(element);
         } });
       }

       DrawAuraAPi.getSubscriberFavouriteOfferApi(SubcriberId: widget.userID.toString()).then((SubscriberFavouriteOfferRes) {
         getFavoriteOfferList.clear();
         print("getSubscriberFavouriteOfferApi Call Done");
         if(SubscriberFavouriteOfferRes["status"] == "200") {
           FavoriteOfferDetails = OfferDataModel.fromJson(SubscriberFavouriteOfferRes);
           FavoriteOfferDetails!.result!.forEach((element) { if(element.offerData!.privacy.toString().toUpperCase() == "PUBLIC"){
             getFavoriteOfferList.add(element);
           } });
         }
         Future.delayed(Duration(milliseconds: 200),() {
           if (mounted) {
             setState(() {
               loader = true;
             });
           }
         },);
       });
     });
   });
 }
  load() async{
    DrawAuraAPi.getSubscriberDetailsApi(userId: widget.userID).then((value) {
      print("getSubscriberDetailsApi Call Done");
      if(value["status"] == "200"){
        SubscriberDetails = GetSubcriberDetailsModel.fromJson(value).result;

        placeOrperson=SubscriberDetails!.placeORperson == null ? "":SubscriberDetails!.placeORperson.toString();
        followersCount=SubscriberDetails!.followers == null?"0":SubscriberDetails!.followers.toString();
        followingCount=SubscriberDetails!.following==null ?"0":SubscriberDetails!.following.toString();
        userProfileImage=SubscriberDetails!.profilePicture == null ? "0":SubscriberDetails!.profilePicture.toString();
        backPageImage=SubscriberDetails!.pagePicture== null ?"":SubscriberDetails!.pagePicture.toString();
        // Future.delayed(Duration(milliseconds: 200),() {
        //   setState(() {});
        // },);
      }
      DrawAuraAPi.getFollowersList(userId: SubscriberDetails!.id.toString()).then((getFollowersListRes) {
        FollowersList =  List.from( getFollowersListRes["result"]).map<FollowersListModel>((item) => FollowersListModel.fromJson(item)).toList();
        for(var i = 0 ; i<FollowersList.length;i++){
          if(FollowersList[i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
            if(mounted){
              setState(() {
                isFollowYou = true;
              });
            }
          }
        }
        getSuscriberOffer();

      });


    });

  }
  RefreshAfter8Sec(){
    Future.delayed(Duration(seconds: 8),() {
      if(mounted){
        setState(() {

        });
      }
    },);
  }
  TextEditingController SearchOfferController = TextEditingController();

  TextEditingController messageController = TextEditingController();
  FocusNode focusNode = FocusNode();
  late ScrollController scrollCommentsController;
  bool enableNotification = false;
  @override
  void dispose() {
    scrollCommentsController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    final bottomOffset = scrollCommentsController.position.maxScrollExtent;
    scrollCommentsController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    var isMobile = ResponsiveHelper.isMobile(context);
    return Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              titleSpacing: 0,
              leading:  InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back,color: Colors.black,size: 24,)),
              title: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      "${Url.IMAGE_URL}${DataManager.getInstance().getuserImage()}",
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                          width: 40,
                          height: 40,
                          fit: BoxFit.fill,);
                      },),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${DataManager.getInstance().getUserDisplayName()}", style: BlackHeadingStyle,),
                        Text(DataManager.getInstance().getuserName(), style: greyFieldStyle,),
                      ],
                    ),
                  ),
                ],
              ),

            ),
            body:loader==true?
            Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                     // height: isMobile ? height * 0.18: tabHeight*0.18,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network(
                            "${Url.IMAGE_URL}${backPageImage}",
                            width:ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width:ResponsiveHelper.TabModeWidth,
                            height: isMobile ? height * 0.18: tabHeight*0.3,
                            fit: BoxFit.fill,
                            errorBuilder: (BuildContext context, Object exception,
                                StackTrace? stackTrace) {
                              return  Image.asset("assets/backhome.png",
                                width:ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width:ResponsiveHelper.TabModeWidth,
                                height: isMobile? height * 0.18:tabHeight * 0.3,
                                fit: BoxFit.fill,);
                            },),
                          const SizedBox(height: 20,),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    if(isFollowYou == true){
                                      DrawAuraAPi.UnFollowUser(follower_id: SubscriberDetails!.id.toString(),following_id: DataManager.getInstance().getuserId().toString().trim()).then((value) {
                                        print(value);
                                        if(value["status"] == "200"){
                                          setState(() {
                                            isFollowYou = false;
                                          });
                                        }
                                      });
                                    }else{
                                      DrawAuraAPi.FollowUser(follower_id: SubscriberDetails!.id.toString(),following_id: DataManager.getInstance().getuserId().toString().trim() ).then((value) {
                                        print(value);
                                        if(value["status"] == "200"){
                                          Constants.showToast("${value["message"]}");
                                          setState(() {
                                            isFollowYou = true;
                                          });
                                        }
                                      });
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:  [
                                      Image.asset("assets/addUser.png",height: 28,),
                                      SizedBox(width: 5,),
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color:isFollowYou == true?Constants.primaryColor20: Constants.primaryColor1
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                          child: Text(isFollowYou == true? "Following": "Follow", style:isFollowYou == true? BlackSubTitleStyle: WhiteSubTitleStyle, textAlign: TextAlign.center,)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => FollowersFollowingScreen(tabIndex: "0",userId: widget.userID),));
                                      },
                                      child: Row(
                                        children:[
                                          Text("${followersCount}",style: PrimaryColorStyle16700,
                                          ),
                                          const SizedBox(width: 5,),
                                          const Text("Followers", style: PrimaryColorStyle16500,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    const Center(
                                        child: Text(".", style: PrimaryColorStyle16700)),
                                    const SizedBox(width: 5,),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => FollowersFollowingScreen(tabIndex: "1",userId:widget.userID),));
                                      },
                                      child: Row(
                                        children:[
                                          Text("${followingCount}", style: PrimaryColorStyle16700,),
                                          const SizedBox(width: 5,),
                                          const Text("Following", style: PrimaryColorStyle16500,),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text("${SubscriberDetails!.displayname == null ? "":SubscriberDetails!.displayname}",style: BlackTitleLargeBoldStyle,textAlign: TextAlign.start,),
                                const SizedBox(height: 5,),
                                Text("${placeOrperson}",style: greySubTitleItalicStyle20400, textAlign: TextAlign.start,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 70,
                      left: 20,
                      child:  ClipOval(
                        child: Image.network(
                          "${Url.IMAGE_URL}${userProfileImage}",
                          height: 120,
                          width: 120,
                          fit: BoxFit.fill,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return  Image.asset("assets/home.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.fill,);
                          },),
                      ),
                    )
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 0.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       InkWell(
                //           onTap: () {
                //             setState(() {
                //               listGrid = false;
                //             });
                //           },
                //           child: Container(
                //               padding: EdgeInsets.all(5),
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(4),
                //                   color: listGrid == true? Colors.white:Constants.lightGreen
                //               ),
                //               child:const Image(image: AssetImage("assets/griedView.png"),height: 20,width: 20,color: Colors.black)
                //           )
                //       ),
                //       const SizedBox(width: 10,),
                //       InkWell(
                //           onTap: () {
                //             setState(() {
                //               listGrid = true;
                //             });
                //           },
                //           child: Container(
                //               padding: EdgeInsets.all(5),
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(4),
                //                   color: listGrid == false? Colors.white:Constants.lightGreen
                //               ),
                //               child:const Image(image: AssetImage("assets/listView.png"),height: 20,width: 20,color: Colors.black,)
                //           )),
                //       const SizedBox(width: 15,),
                //     ],
                //   ),
                // ),
                Expanded(
                  child:  DefaultTabController(
                    length: 3,
                    animationDuration: const Duration(milliseconds: 200),
                    initialIndex: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(color: Colors.white, ),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          height: 35,
                          child: TabBar(
                            labelColor: Colors.black,
                            controller: _tabController,
                            isScrollable: true,
                            indicatorWeight: 2.0,
                            indicatorColor: Colors.black,
                            indicatorPadding: const EdgeInsets.only(top: 7,bottom: 5),
                            labelPadding: EdgeInsets.symmetric(horizontal: 10),
                            unselectedLabelColor: Colors.black,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelStyle: BlackTabStyle,
                            unselectedLabelStyle:  BlackHeadingStyle,
                            tabs: <Widget>[
                              Tab(
                                text: "My Offers",

                              ),
                              Tab(
                                text: "Templates",
                              ),
                              Tab(
                                text: "Favourites",
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              getMyOffersList.isEmpty? Center(
                                  child: NotAvailableText("Not found!")
                              ):
                              RefreshIndicator(
                                onRefresh: () async {
                                  await load();
                                  return Future.value();
                                },
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount:getMyOffersList.length,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: isMobile ? 2 / 2.5 : 2 / 2.8,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    physics: const AlwaysScrollableScrollPhysics (),
                                    itemBuilder: (context, index) {
                                      var data = getMyOffersList[index];
                                      bool isConfirmingUser = false;
                                      for (var i = 0; i < data.offerData!.ConfirmingSubscriber!.length; i++) {
                                        if (data.offerData!.ConfirmingSubscriber![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()) {
                                          isConfirmingUser = true;
                                          break;
                                        } else {
                                          isConfirmingUser = false;
                                        }
                                      }
                                      bool  isCounterSellBuy = false ;
                                      for(var i = 0 ; i<data.offerData!.counterdUser!.length; i++){
                                        if(data.offerData!.counterdUser![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                                          isCounterSellBuy = true;
                                          break ;
                                        }else{
                                          isCounterSellBuy = false;
                                        }
                                      }
                                      List <bool>isAllItemDone1 = [] ;
                                      for(var p = 0 ; p < data.offerData!.offerItems!.length ; p++){
                                        if( data.offerData!.offerItems![p].quantity.toString().trim() == "0"){
                                          isAllItemDone1.add(true);
                                        }else{
                                          isAllItemDone1.add(false);
                                        }
                                      }
                                      return FutureBuilder(
                                          future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                                          builder: (BuildContext
                                          context, AsyncSnapshot<String>snapshot) {
                                            return CommonVerticalForGridView(context,data,snapshot,
                                                isCounterSellBuy,
                                                getMyOffersList,index, (){
                                                  tapOnOffer(context,data, isCounterSellBuy, isConfirmingUser,isAllItemDone1).then((value) {
                                                    print("ThenRun");
                                                    getSuscriberOffer();
                                                  });
                                                }, false,isAllItemDone1
                                                ,isConfirmingUser
                                            );
                                          });
                                    }),
                              ),
                              // getTemplateOfferList==null?const ButtonLoaderGreen():
                              getTemplateOfferList.isEmpty? Center(
                                  child:NotAvailableText("Not found!")
                              ):
                              GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: getTemplateOfferList.length,
                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 2.4,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  physics: const AlwaysScrollableScrollPhysics (),
                                  itemBuilder: (context, index) {
                                    var data = getTemplateOfferList[index];
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
                                        return TemplateCardGridView(context,data,snapshot,isCounterSellBuy,getTemplateOfferList,index);
                                      },
                                    );
                                  }),
                              // getFavoriteOfferList==null?const ButtonLoaderGreen():
                              getFavoriteOfferList.isEmpty? Center(
                                  child:NotAvailableText("Not found!")
                              ):
                              RefreshIndicator(
                                onRefresh: () async {
                                  await load();
                                  return Future.value();
                                },
                                child: GridView.builder(
                                    shrinkWrap: true,

                                    itemCount: getFavoriteOfferList.length,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: isMobile ? 2 / 2.5 : 2 / 2.8,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    physics: const AlwaysScrollableScrollPhysics (),
                                    itemBuilder: (context, index) {
                                      var data = getFavoriteOfferList[index];
                                      bool isConfirmingUser = false;
                                      for (var i = 0; i < data.offerData!.ConfirmingSubscriber!.length; i++) {
                                        if (data.offerData!.ConfirmingSubscriber![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()) {
                                          isConfirmingUser = true;
                                          break;
                                        } else {
                                          isConfirmingUser = false;
                                        }
                                      }
                                      bool  isCounterSellBuy = false ;
                                      for(var i = 0 ; i<data.offerData!.counterdUser!.length; i++){
                                        if(data.offerData!.counterdUser![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                                          isCounterSellBuy = true;
                                          break ;
                                        }else{
                                          isCounterSellBuy = false;
                                        }
                                      }
                                      List <bool>isAllItemDone1 = [] ;
                                      for(var p = 0 ; p < data.offerData!.offerItems!.length ; p++){
                                        if( data.offerData!.offerItems![p].quantity.toString().trim() == "0"){
                                          isAllItemDone1.add(true);
                                        }else{
                                          isAllItemDone1.add(false);
                                        }
                                      }
                                      return FutureBuilder(
                                          future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                                          builder: (BuildContext
                                          context, AsyncSnapshot<String>snapshot) {
                                            return CommonVerticalForGridView(context,data,snapshot,
                                                isCounterSellBuy,
                                                getFavoriteOfferList,index, (){tapOnOffer(context,data, isCounterSellBuy, isConfirmingUser,isAllItemDone1).then((value) {
                                                  DrawAuraAPi.getSubscriberFavouriteOfferApi(SubcriberId: widget.userID.toString()).then((SubscriberFavouriteOfferRes) {
                                                    getFavoriteOfferList.clear();
                                                    print("getSubscriberFavouriteOfferApi Call Done");
                                                    if(SubscriberFavouriteOfferRes["status"] == "200") {
                                                      FavoriteOfferDetails = OfferDataModel.fromJson(SubscriberFavouriteOfferRes);
                                                      FavoriteOfferDetails!.result!.forEach((element) { if(element.offerData!.privacy.toString().toUpperCase() == "PUBLIC"){
                                                        getFavoriteOfferList.add(element);
                                                      } });
                                                    }
                                                    Future.delayed(Duration(milliseconds: 200),() {
                                                      if (mounted) {
                                                        setState(() {
                                                          loader = true;
                                                        });
                                                      }
                                                    },);
                                                  });
                                                });}, false,isAllItemDone1
                                                ,isConfirmingUser
                                            );
                                          });
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ],
            ):const Center(child: LoadingWidget()),
          )),
    );
  }

}


