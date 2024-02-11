import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/TrandingSearchModel.dart';
import 'package:socialapps/screens/GlobalSearch.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';

class AllTrendingSearchScreen extends StatefulWidget {
  List<TrendingSearchData> TrendingSearchDataList;
   AllTrendingSearchScreen({super.key,required this.TrendingSearchDataList});

  @override
  State<AllTrendingSearchScreen> createState() => _AllTrendingSearchScreenState();
}

class _AllTrendingSearchScreenState extends State<AllTrendingSearchScreen> {
  @override
  Widget build(BuildContext context) {
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
              title: const Text("Trending Searches",style:AppBarTitle,),
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
                itemCount: widget.TrendingSearchDataList.length,
                itemBuilder: (context, index) {
                  var TrendingData = widget.TrendingSearchDataList[index];
                  final startTime = DateFormat('dd-MM-yyyy HH:mm').parse('${TrendingData.historyTimestamp.toString()}');
                  final currentTime = DateTime.now();
                  final diff_dy = currentTime.difference(startTime).inDays;
                  int years = diff_dy ~/ 365;
                  int months = (diff_dy-years*365) ~/ 30;
                  final diff_mi = currentTime.difference(startTime).inMinutes;
                  final diff_s = currentTime.difference(startTime).inSeconds;
                  final diff_hr = currentTime.difference(startTime).inHours;
                  return InkWell(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GlobalSearchScreen(SearchText:TrendingData.searchText.toString() ,RecentSearch: [], TreandingSearch: []),)).then((value) {
                        DrawAuraAPi.GetTrendingSearch(limit: 10.toString()).then((
                            TrendingSearchRes) {
                          if (TrendingSearchRes.isNotEmpty) {
                            Future.delayed(Duration.zero, () {
                              if (mounted) {
                                setState(() {
                                  widget.TrendingSearchDataList = TrendingSearchRes;
                                  // isLoadTrendingOffer = true;
                                });
                              }
                            },);
                          } else {
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
                      margin: const EdgeInsets.only(right: 5,top: 5,bottom: 5,left: 5),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Constants.greyLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "${TrendingData.searchText}",
                              style: BlackSubTitleStyle,
                            ),
                          ),
                          const SizedBox(width: 15,),
                          Image.asset("assets/trend.png",height: 24,color: Constants.black,)
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
