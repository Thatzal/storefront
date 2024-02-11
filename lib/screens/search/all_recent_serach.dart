import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/RecentSearchModel.dart';
import 'package:socialapps/screens/GlobalSearch.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';

class AllRecentSearchScreen extends StatefulWidget {
  List<RecentSearchData> RecentSearchList ;
   AllRecentSearchScreen({super.key,required this.RecentSearchList});

  @override
  State<AllRecentSearchScreen> createState() => _AllRecentSearchScreenState();
}

class _AllRecentSearchScreenState extends State<AllRecentSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              title: const Text("Recent Searches",style:AppBarTitle,),
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 6 ,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 5, ),
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.RecentSearchList.length,
                itemBuilder: (context, index) {
                  var RecentSearchData = widget.RecentSearchList[index];
                  final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${RecentSearchData.historyTimestamp.toString()}');
                  final currentTime = DateTime.now();
                  final diff_dy = currentTime.difference(startTime).inDays;
                  int years = diff_dy ~/ 365;
                  int months = (diff_dy-years*365) ~/ 30;
                  final diff_mi = currentTime.difference(startTime).inMinutes;
                  final diff_s = currentTime.difference(startTime).inSeconds;
                  final diff_hr = currentTime.difference(startTime).inHours;
                  return InkWell(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GlobalSearchScreen(SearchText:RecentSearchData.searchText.toString(),RecentSearch: [], TreandingSearch: []),)).then((value) {

                        DrawAuraAPi.GerRecentSearch(user_Id: DataManager.getInstance().getuserId().toString(),limit: 10.toString()).then((RecentSearchRes) {
                          if(RecentSearchRes.isNotEmpty) {
                            Future.delayed(Duration.zero, () {
                              if (mounted) {
                                setState(() {
                                  widget.RecentSearchList = RecentSearchRes;
                                  // isLoadTrendingOffer = true;
                                });
                              }
                            },);
                          }else{
                            if (mounted) {
                              setState(() {
                                //isLoadTrendingOffer = true;
                              });
                            }
                          }
                        });
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10,top: 5,bottom: 5),
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(color: Constants.greyLight, borderRadius: BorderRadius.circular(8),),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:  [
                          Text("${RecentSearchData.searchText}", style: BlackFieldStyle,),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: Icon(Icons.access_time_outlined,color: Colors.black,size: 18,),
                          ),
                          10.width,
                          Text(
                            diff_s <= 60? "$diff_s""s":
                            diff_mi <= 60 ?"$diff_mi""m":
                            diff_hr <= 24 ? "$diff_hr""h":
                            diff_dy <= 30 ? "$diff_dy""d":
                            months <= 12 ? "$months""mo":
                            "$years"
                            ,style: BlackDescStyle,)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )),

    );
  }
}
