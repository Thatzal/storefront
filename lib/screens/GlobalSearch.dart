import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:get/get.dart';
import 'package:socialapps/Apis/CommonApis.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/PrefillOfferDataModel.dart';
import 'package:socialapps/model/RecentSearchModel.dart';
import 'package:socialapps/model/SerachDataModel.dart';
import 'package:socialapps/model/TrandingSearchModel.dart';
import 'package:socialapps/screens/Reaction/reactionList.dart';
import 'package:socialapps/screens/newOfferPage.dart';
import 'Dashboard/home/OtherUserProfileViewScreen.dart';
import 'package:socialapps/model/OfferDataModel.dart';
import 'widgets/ImageGalleryByUrl.dart';
import 'widgets/commonCards.dart';
import 'widgets/CommonOfferCardBuilderAndTap.dart';

class GlobalSearchScreen extends StatefulWidget {
  String SearchText;
  List<RecentSearchData> RecentSearch;
  List <TrendingSearchData> TreandingSearch;
   GlobalSearchScreen({Key? key,required this.SearchText,required this.RecentSearch,required this.TreandingSearch}) : super(key: key);
  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  TextEditingController SearchController = TextEditingController();
  List <SearchDataPerson> PersonDataList = [];
  List <SearchDataPlace> PLaceDataList = [];
  List <OfferDataModelResult> SearchOfferList = [];
  List <OfferDataModelResult> FilterSearchOfferList = [];
  bool butttonLoader = false;
  int selectedValueFilterIndex = 3;

  String selectedValueFilter ="All";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollCommentsController = ScrollController();
    widget.SearchText != "" ?initSearch():null;

    if(widget.SearchText.toString() == ""){
      isShowRecentBox = true;
      TrendingSearch();
      RecentSearch();
      // FocusScope.of(context).requestFocus(new FocusNode());
    }
  }
  initSearch() {
    SearchController.text = widget.SearchText.toString();
    initSearchLoading = true;

    DrawAuraAPi().getSearchData(widget.SearchText.toString()).then((SearchRes) {
      var res = json.decode(utf8.decode(SearchRes.bodyBytes));

      if (SearchRes.statusCode == 200) {
        SearchOfferList.clear();
        // SearchSubDataList.clear();
        if (res['status'] == "200") {
          if(mounted){
            setState(() {
              SearchOfferList =    List.from(res['offers']).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
              PLaceDataList =    List.from(res['place']).map<SearchDataPlace>((item) => SearchDataPlace.fromJson(item)).toList();
              PersonDataList =    List.from(res['person']).map<SearchDataPerson>((item) => SearchDataPerson.fromJson(item)).toList();
              // SearchSubDataList =    List.from(res['subscriber']).map<SerachOfferData>((item) => SerachOfferData.fromJson(item)).toList();
              initSearchLoading = false;
            });
          }
        }
      }
      else {
        Constants.showToast("Internal server error");
        setState(() {
          initSearchLoading = false;
        });
      }
    });
  }

  void scrollToBottom() {
    final bottomOffset = scrollCommentsController.position.maxScrollExtent;
    scrollCommentsController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }
  bool initSearchLoading = false;
  bool isShowRecentBox = false;
  @override
  void dispose() {
    scrollCommentsController.dispose();
    super.dispose();
  }

  TextEditingController messageController = TextEditingController();
  FocusNode focusNode = FocusNode();
  late ScrollController scrollCommentsController;


  List<String> filter = [
    "New",
    'Open',
    'Sign-Off',
    "Template"
  ];
  List<String> selectedItems = [];
  List <TrendingSearchData> TrendingSearchDataList = [];
  List <RecentSearchData> RecentSearchList = [];
  bool isLoadRTrendingSearch = false;
  bool isLoadRRecentSearch = false;
  TrendingSearch() async {
    var BodyParam = {
      "limit" : "5"
    };
    await  ThatZalApis.fromDataPost(BodyParam:BodyParam,Endpoint: ApiUrls.getTrendingSearches).then((value) {
      print(value);
      print("getTrendingSearches");
      if(value != null ){
       if(mounted){
         setState(() {
           TrendingSearchDataList =  List.from(value["result"]).map<TrendingSearchData>((item) => TrendingSearchData.fromJson(item)).toList();
         });
       }
      }else{
        TrendingSearchDataList = [];
      }
    });
     if(mounted){
       setState(() {
         isLoadRTrendingSearch = true;
       });
     }
  }
  RecentSearch() async{
    var RBodyParam = {
      "user_id" :  DataManager.getInstance().getuserId().toString(),
      "limit" : "3"
    };
    print(RBodyParam);
    await ThatZalApis.fromDataPost(BodyParam:RBodyParam,Endpoint: ApiUrls.getRecentSearches).then((value) {
      if(value != null ){
       if(mounted){
         setState(() {
           List <RecentSearchData> TempList =  List.from(value["result"]).map<RecentSearchData>((item) => RecentSearchData.fromJson(item)).toList();
           RecentSearchList =  TempList.reversed.toList();
           print(value);
           print("getRecentSearches");
         });
       }
      }else{
        RecentSearchList = [];
      }
    });
     if(mounted){
       setState(() {
         isLoadRRecentSearch = true;
       });
     }
  }
  bool isClickOnSearchString = false;
  List  SearchContentList = [];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var height = MediaQuery.of(context).size.height;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    var isMobile = ResponsiveHelper.isMobile(context);
    return  Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: 60,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Flexible(
                          child: Container(
                            width: isMobile?width:tabWidth,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color:Colors.grey.shade400,
                                  blurRadius: 2.5,
                                  spreadRadius: 2.5,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),

                            margin: EdgeInsets.only(bottom: 2.0,left: 2,right: 2,top: 2),
                            child:Center(
                              child: TextFormField(
                                style:  BlackHeadingStyle,
                                controller: SearchController,
                                cursorColor: primaryColor,
                                autofocus: widget.SearchText.toString() == ""?true:false,
                                cursorHeight: 20,
                                cursorRadius: Radius.circular(2),
                                cursorWidth: 2.5,
                                onChanged: (value){
                                  print(value);
                                  setState(() {
                                    SearchContentList.clear();
                                    // SearchOfferList.clear();
                                    isClickOnSearchString = false;
                                  });
                                  if(value == "" || value.isEmpty || value.length == 0 ){
                                    setState(() {
                                      SearchContentList.clear();
                                      PersonDataList.clear();
                                      SearchOfferList.clear();
                                      PLaceDataList.clear();
                                      initSearchLoading = false;
                                    });
                                    setState(() {

                                    });
                                  }else{
                                    if(value.length >= 2){
                                      setState(() {
                                        isShowRecentBox = false;
                                        initSearchLoading = true;
                                        SearchContentList = [];
                                        SearchOfferList = [];
                                        PersonDataList = [];
                                        PLaceDataList = [];
                                      });
                                      DrawAuraAPi().getSearchData(value.trim()).then((SearchRes) {
                                        var res = json.decode(utf8.decode(SearchRes.bodyBytes));

                                        if (SearchRes.statusCode == 200) {
                                          SearchOfferList.clear();
                                          // SearchSubDataList.clear();
                                          if (res['status'] == "200") {
                                            print(res);
                                            if(mounted){
                                              setState(() {
                                                SearchOfferList =  List.from(res['offers']).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
                                                PLaceDataList =    List.from(res['place']).map<SearchDataPlace>((item) => SearchDataPlace.fromJson(item)).toList();
                                                PersonDataList =   List.from(res['person']).map<SearchDataPerson>((item) => SearchDataPerson.fromJson(item)).toList();
                                                // SearchSubDataList =    List.from(res['subscriber']).map<SerachOfferData>((item) => SerachOfferData.fromJson(item)).toList();
                                                SearchContentList = [];
                                                SearchOfferList.forEach((element) {
                                                  SearchContentList.add({"data":element.offerData!.slug.toString(),"EndPoint":
                                                  element.offerData!.offertemplate == true ? " TEMPLATE" :
                                                  element.offerData!.offerstatus.toString().trim().toUpperCase() == "CLOSED"?
                                                      " CLOSED" : " OPEN"
                                                
                                                  });
                                                });
                                                PLaceDataList.forEach((element) {
                                                  SearchContentList.add({"data":element.displayname.toString(),"EndPoint":""});
                                                });
                                                PersonDataList.forEach((element) {
                                                  SearchContentList.add({"data":element.displayname.toString(),"EndPoint":""});
                                                });
                                                initSearchLoading = false;
                                              });
                                            }
                                          }
                                        }
                                        else {
                                          Constants.showToast("Internal server error");
                                        }
                                      });
                                    }

                                  }
                                },
                                onFieldSubmitted: (search_letter){
                                  setState(() {
                                    isClickOnSearchString = true;
                                  });
                                  if(search_letter.length >3){
                                    DrawAuraAPi.CreateSearchHistory(search_text: search_letter).then((value) {

                                      // if(value("status") == 200){
                                      //   Constants.showToast("Search Data saved !");
                                      // }
                                    });
                                  }else{
                                    Constants.showToast("For saving in history you need minimum 3 latter word.");
                                  }
                                },
                                decoration:   InputDecoration(
                                    isDense: true,
                                    prefixIcon:  InkWell(
                                      onTap: (){Navigator.pop(context);},
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 5),
                                        child: Icon(Icons.arrow_back_outlined,size: 22,color: Colors.black,),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    prefixIconConstraints: BoxConstraints(maxWidth: 40),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: '${Url.searchHint}',
                                    hintStyle: greyHintStyle
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        InkWell(
                          onTap:(){
                            Get.to(()=> NewOfferCreateScreen(Address: "",AddressTitle: "",From: "New",PrefillOfferData: PrefillOfferDataModel(),Type: "",OfferId: "",SubId: ""));
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: const BoxDecoration(shape: BoxShape.circle, color:Constants.primaryColor1,
                              boxShadow: [
                                BoxShadow(
                                  color:Constants.primaryColor20,
                                  blurRadius: 2.5,
                                  spreadRadius: 3.5,
                                  offset: Offset(
                                    0,
                                    3,
                                  ),
                                )
                              ],
                            ),
                            child: Center(child: Image.asset("assets/edit.png",height: 22,width: 22,color: Constants.white),),
                          ),
                        ),
                      ],

                    ),
                  ),

                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
                  child:
                  isShowRecentBox == false?
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            SizedBox(
                              height: 35,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: (){
                                      setState(() {
                                        // selectedBook = MainBookListModel(bookNum: -1);
                                        index == 0 ? selectedValueFilter = "Offers" :
                                        index == 1 ? selectedValueFilter = "People" :
                                        index == 2 ? selectedValueFilter = "Places" :
                                        selectedValueFilter = "All";
                                        selectedValueFilterIndex = index;
                                        // filterSelectedVersesContent.clear();
                                        // _searchFilter(searchController.text);
                                      });
                                    },
                                    child: SizedBox(
                                      width: index==3?50: 70,
                                      height: 32,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        elevation: 0,
                                        color:selectedValueFilterIndex == index?primaryColor:
                                        Color(0x4dbdf6e1),
                                        margin: EdgeInsets.only(right: 10),
                                        child: Center(
                                          child:index==0? Text("Offers",style:selectedValueFilter == "Offers"?WhiteSubTitleStyle: BlackDescStyle,):index==1?Text("People",style:selectedValueFilter == "People"?WhiteSubTitleStyle: BlackDescStyle,):index==2?Text("Places",style: selectedValueFilter == "Places"?WhiteSubTitleStyle: BlackDescStyle,):Text("All",style: selectedValueFilter == "All"?WhiteSubTitleStyle: BlackDescStyle,),),
                                      ),
                                    ),

                                  );
                                },),
                            ),
                            AnimatedSwitcher(
                              switchOutCurve: Curves.easeIn,
                              duration: Duration(milliseconds: 500),
                              child:   selectedValueFilterIndex == 0 || selectedValueFilterIndex == 3?
                              Stack(
                                children: [
                                  SizedBox(
                                    width: 35,
                                    height: 35,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      elevation: 0,
                                      color:primaryColor,
                                      margin: EdgeInsets.only(right: 0),
                                      child: Center(
                                          child:Icon(Icons.filter_alt_outlined,color: Colors.white,size: 24,)
                                      ),
                                    ),),
                                  Positioned(
                                      top: 0,
                                      child:  DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          isExpanded: true,
                                          // hint: Align(
                                          //   alignment: AlignmentDirectional.center,
                                          //   child: Text('', style: TextStyle(fontSize: 14, color: Theme.of(context).hintColor,),),
                                          // ),
                                          items: filter.map((item) {
                                            return DropdownMenuItem<String>(
                                              value: item,
                                              //disable default onTap to avoid closing menu when selecting an item
                                              child: StatefulBuilder(
                                                builder: (context, menuSetState) {
                                                  return InkWell(
                                                    onTap: () {
                                                      menuSetState((){
                                                        selectedItems.contains(item) ?  selectedItems.remove(item) : selectedItems.add(item);
                                                      });
                                                      //This rebuilds the StatefulWidget to update the button's text
                                                      setState(() {});
                                                      //This rebuilds the dropdownMenu Widget to update the check mark
                                                      if(selectedItems.contains(item)){
                                                        FilterSearchOfferList.clear();
                                                        menuSetState(() {
                                                          if(selectedItems.contains("NEW")){
                                                            for(var j = 0 ; j < SearchOfferList.length; j++ ){
                                                              if(SearchOfferList[j].offerData!.counterdUser!.isEmpty ){
                                                                FilterSearchOfferList.add(SearchOfferList[j]);
                                                              }
                                                            }
                                                          }
                                                          if(selectedItems.contains("OPEN")){
                                                            for(var j = 0 ; j < SearchOfferList.length; j++ ){
                                                              if(SearchOfferList[j].offerData!.counterdUser!.isEmpty && SearchOfferList[j].offerData!.offertemplate != true && SearchOfferList[j].offerData!.offerstatus.toString().trim().toUpperCase() != "CLOSED" ){
                                                                FilterSearchOfferList.add(SearchOfferList[j]);
                                                              }
                                                            }
                                                          }

                                                          if(selectedItems.contains("TEMPLATE")){
                                                            for(var j = 0 ; j < SearchOfferList.length; j++ ){
                                                              if(SearchOfferList[j].offerData!.offertemplate == true){
                                                                FilterSearchOfferList.add(SearchOfferList[j]);
                                                              }
                                                            }
                                                          }
                                                          if(selectedItems.contains("SIGN-OFF")){
                                                            for(var j = 0 ; j < SearchOfferList.length; j++ ){
                                                              if(SearchOfferList[j].offerData!.offerstatus.toString().trim().toUpperCase() == "CLOSED"){
                                                                FilterSearchOfferList.add(SearchOfferList[j]);
                                                              }
                                                            }
                                                          }
                                                        });
                                                      }else{
                                                        menuSetState(() {
                                                          FilterSearchOfferList.clear();
                                                          if(selectedItems.contains("NEW")){
                                                            for(var j = 0 ; j < SearchOfferList.length; j++ ){
                                                              if(SearchOfferList[j].offerData!.counterdUser!.isEmpty ){
                                                                FilterSearchOfferList.remove(SearchOfferList[j]);
                                                              }
                                                            }
                                                          }
                                                          if(selectedItems.contains("OPEN")){
                                                            for(var j = 0 ; j < SearchOfferList.length; j++ ){
                                                              if(SearchOfferList[j].offerData!.counterdUser!.isEmpty && SearchOfferList[j].offerData!.offertemplate != true && SearchOfferList[j].offerData!.offerstatus.toString().trim().toUpperCase() != "CLOSED"){
                                                                FilterSearchOfferList.remove(SearchOfferList[j]);
                                                              }
                                                            }
                                                          }
                                                          if(selectedItems.contains("TEMPLATE")){
                                                            for(var j = 0 ; j < SearchOfferList.length; j++ ){
                                                              if(SearchOfferList[j].offerData!.offertemplate == true){
                                                                FilterSearchOfferList.remove(SearchOfferList[j]);
                                                              }
                                                            }
                                                          }

                                                          if(selectedItems.contains("SIGN-OFF")){
                                                            for(var j = 0 ; j < SearchOfferList.length; j++ ){
                                                              if(SearchOfferList[j].offerData!.offerstatus.toString().trim().toUpperCase() == "CLOSED"){
                                                                FilterSearchOfferList.remove(SearchOfferList[j]);
                                                              }
                                                            }
                                                          }
                                                        });
                                                      }

                                                    },
                                                    child: Container(
                                                      height: double.infinity,
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 16.0),
                                                      child: Row(
                                                        children: [
                                                          selectedItems.contains(item) ? const Icon(Icons.check_box_rounded,color: Constants.primaryColor1,)
                                                              :  Icon(
                                                              Icons.check_box_outline_blank,color: Colors.grey.shade600),
                                                          const SizedBox(width: 14),
                                                          Text(item, style: BlackFieldStyle,),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          }).toList(),
                                          value:null,
                                          onChanged: (value) {
                                          },
                                          iconStyleData: IconStyleData(icon: Icon(Icons.filter_alt_outlined,color: Colors.transparent,size: 10,)),
                                          buttonStyleData: const ButtonStyleData(
                                            height: 35,width: 35,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                                color:Colors.transparent
                                            ),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                              width: isMobile?width*0.45:tabWidth*0.45,
                                              decoration:  BoxDecoration(
                                                  color:Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(8))
                                              ),
                                              offset: Offset(isMobile?0:-tabWidth*0.4,-10),
                                              elevation: 1
                                          ),
                                          menuItemStyleData: const MenuItemStyleData(
                                            height: 40,
                                            padding: EdgeInsets.zero,
                                          ),
                                        ),
                                      )),
                                ],
                              ):SizedBox(),)

                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          physics: AlwaysScrollableScrollPhysics(),
                          children: [

                            selectedValueFilterIndex == 3 && SearchOfferList.isNotEmpty ? Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Divider(
                                      height: 2,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text("Offers",style: BlackTitleBoldStyle15500,),
                                  ),
                                  Flexible(
                                    child: Divider(
                                      height: 2,
                                      color: primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ):SizedBox(),

                            initSearchLoading ?Padding(
                              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                              child: SearchLoading(),
                            ):  selectedValueFilterIndex == 0 || selectedValueFilterIndex == 3 ?  SearchOfferList.isEmpty && PLaceDataList.isEmpty &&PersonDataList.isEmpty?
                            Padding(
                              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  NotAvailableText("Not found!")
                                ],
                              ),
                            ) :
                            GridView.builder(
                                shrinkWrap: true,
                                itemCount:selectedItems.isEmpty? SearchOfferList.length:FilterSearchOfferList.length,
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: isMobile ? 2 / 2.5 : 2 / 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var data = selectedItems.isEmpty? SearchOfferList[index]:FilterSearchOfferList[index];
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
                                      print("");
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
                                          selectedItems.isEmpty? SearchOfferList:FilterSearchOfferList,index, (){tapOnOffer(context,data, isCounterSellBuy, isConfirmingUser,isAllItemDone1).then((value) {
                                              print("ThenRun");
                                              initSearch();
                                            });}, false,isAllItemDone1
                                          ,isConfirmingUser
                                        );
                                      });
                                }):SizedBox(),

                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   physics: ScrollPhysics(),
                            //   itemCount:selectedItems.isEmpty? SearchOfferList.length:FilterSearchOfferList.length,
                            //   padding: const EdgeInsets.symmetric(vertical: 0),
                            //   itemBuilder: (context, index) {
                            //     var data = selectedItems.isEmpty?  SearchOfferList[index]:FilterSearchOfferList[index];
                            //
                            //     bool isConfirmingUser = false;
                            //     for(var i = 0 ; i<data.offerData!.ConfirmingSubscriber!.length; i++){
                            //       if(data.offerData!.ConfirmingSubscriber![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                            //         isConfirmingUser = true;
                            //         break ;
                            //       }else{
                            //         isConfirmingUser = false;
                            //       }
                            //     }
                            //
                            //     bool  isCounterSellBuy = false ;
                            //     for(var i = 0 ; i<data.offerData!.counterdUser!.length; i++){
                            //       if(data.offerData!.counterdUser![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                            //         isCounterSellBuy = true;
                            //         break ;
                            //       }else{
                            //         isCounterSellBuy = false;
                            //       }
                            //     }
                            //     return FutureBuilder(
                            //         future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                            //         builder: (BuildContext
                            //         context, AsyncSnapshot<String>snapshot) {
                            //           return CommonOfferCardListView(context,data,snapshot,
                            //             isCounterSellBuy,
                            //             selectedItems.isEmpty?  SearchOfferList:FilterSearchOfferList,index,
                            //                 (){tapOnOffer(context,data,isCounterSellBuy, isConfirmingUser);}, false,
                            //           );
                            //         });
                            //   },
                            // ):SizedBox(),

                            selectedValueFilterIndex == 3 && PersonDataList.isNotEmpty ?  Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Divider(
                                      height: 2,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text("People",style: BlackTitleBoldStyle15500,),
                                  ),
                                  Flexible(
                                    child: Divider(
                                      height: 2,
                                      color: primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ):SizedBox(),

                            selectedValueFilterIndex == 1 || selectedValueFilterIndex == 3 ?  ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: PersonDataList.isEmpty?0:PersonDataList.length,
                              itemBuilder: (context, index) {
                                var data = PersonDataList[index];

                                return InkWell(
                                  onTap: (){
                                    Get.to(()=>ProfileViewScreen(userID: data.id.toString(),));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color:  Constants.greyLight,)),
                                    child: ListTile(
                                      leading: ClipOval(
                                        child: Image.network(
                                          "${Url.IMAGE_URL}${data.profilePicture}",
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
                                      title: Text("${data.displayname ?? ""}",overflow: TextOverflow.ellipsis),
                                      subtitle: data.desc.toString() == "null" ?Text(""): Text("${data.desc}"),
                                      trailing:   data.optDelivery == true? Builder(
                                        builder: (ctx) {
                                          return ReactionButton<String>(
                                            onReactionChanged: (String? value) {
                                              var body = {
                                                "from_user": DataManager.getInstance().getuserId().toString(),
                                                "to_user":data.id.toString()
                                              };

                                              if(value == "like"){
                                                DrawAuraAPi.CreateDataApi(body:body,ApiEndPoint:"likeUser").then((value) {
                                                  print(value);
                                                  Constants.showToast("${value["message"]}");
                                                });
                                              }else{
                                                DrawAuraAPi.CreateDataApi(body:body,ApiEndPoint:"dislikeUser").then((value) {
                                                  print(value);
                                                  Constants.showToast("${value["message"]}");

                                                });                                                        }
                                              if(value == "like"){
                                                Constants.showToast("Liked");
                                                print("Liked");
                                              }else{
                                                Constants.showToast("DisLiked");
                                                print("DisLiked");
                                              }
                                            },
                                            reactions: flagsReactions,
                                            initialReaction: 0 == 0 ?  Reaction<String>(
                                              value: null,
                                              icon:  CircleAvatar(
                                                radius: 12,backgroundColor:Constants.primaryColor1,
                                                child: Icon(
                                                  Icons.thumb_up_outlined,color: Colors.white,size: 18,
                                                ),
                                              ),
                                            ): Reaction<String>(
                                              value: 'like',
                                              icon: CircleAvatar(
                                                radius: 12,backgroundColor:Colors.white,
                                                child: Icon(
                                                  Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18,
                                                ),
                                              ),
                                            ),
                                            boxColor:Colors.amber.shade300 ,
                                            boxRadius: 10,
                                            boxElevation: 0,
                                            boxDuration: const Duration(milliseconds: 200),
                                            itemScaleDuration: const Duration(milliseconds: 100),
                                          );
                                        },
                                      ):SizedBox(),
                                    ),
                                  ),
                                );
                              },):SizedBox(),

                            selectedValueFilterIndex == 3 &&  PLaceDataList.isNotEmpty? Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Divider(
                                      height: 2,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text("Places",style: BlackTitleBoldStyle15500,),
                                  ),
                                  Flexible(
                                    child: Divider(
                                      height: 2,
                                      color: primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ):SizedBox(),

                            selectedValueFilterIndex == 2 || selectedValueFilterIndex == 3 ?   ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              itemCount:PLaceDataList.isEmpty?0: PLaceDataList.length,
                              itemBuilder: (context, index) {
                                var data = PLaceDataList[index];
                                return InkWell(
                                  onTap: (){
                                    Get.to(()=>ProfileViewScreen(userID: data.id.toString(),));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color:  Constants.greyLight,)),
                                    child: ListTile(
                                      leading: ClipOval(
                                        child: Image.network(
                                          "${Url.IMAGE_URL}${data.profilePicture}",
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
                                      title: Text("${data.displayname ?? ""}",overflow: TextOverflow.ellipsis),
                                      subtitle: data.desc.toString() == "null" ?Text(""): Text("${data.desc}"),
                                    ),
                                  ),
                                );
                              },):SizedBox()

                          ],
                        ),
                      ),
                    ],
                  ):
                  isLoadRTrendingSearch == true && isLoadRRecentSearch == true?
                  ListView(
                    children: [
                       Container(
                         height: 45,
                         width: isMobile?width:tabWidth,
                         color: Colors.grey.shade200,
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             10.width,
                             Text("Recent",style: grey15500,)
                           ],
                         ),
                       ),
                      ListView.builder(
                        shrinkWrap: true,itemCount:RecentSearchList.length ,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = RecentSearchList[index];
                        return  RecentFiled(searchText: "${data.searchText}",time: "${ data.historyTimestamp}");
                      },),
                      Container(
                        height: 45,
                        width: isMobile?width:tabWidth,
                        color: Colors.grey.shade200,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            10.width,
                            Text("Trending",style: grey15500,)
                          ],
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,itemCount: TrendingSearchDataList.length ,
                        itemBuilder: (context, index) {
                          var data = TrendingSearchDataList[index];
                          return  TrendingField(searchText: "${data.searchText}");
                        },)
                    ],
                  ):
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: LoadingWidgetWithoutBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              isClickOnSearchString  || SearchController.text.isEmpty?SizedBox():
              Positioned(
                top: 90,
                  child:  (SearchContentList.isEmpty) ?SizedBox():
                  Padding(
                    padding:  EdgeInsets.only(left: 15.0),
                    child: SizedBox(
                      height: SearchContentList.length  == 1 ?45 :
                              SearchContentList.length == 2 ?80:
                              SearchContentList.length == 3 ?120:
                              SearchContentList.length == 4 ?160:
                              SearchContentList.length == 5 ?200:
                              SearchContentList.length == 6 ?240:height*0.3,
                      width: isMobile?width*0.79:tabWidth*0.79,
                      child: Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        child: ListView.builder(
                          itemCount: SearchContentList.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                          itemBuilder: (context, index) {
                            var data = SearchContentList[index];
                            return SearchString(searchText: data);
                          },),
                      ),
                    ),
                  ),

              )
            ],
          )),
    );
  }

  Widget RecentFiled({String? searchText,String ?time,}){
    return InkWell(
      onTap: (){
        setState(() {
          isClickOnSearchString =true;
          widget.SearchText = searchText.toString();
          isShowRecentBox = false;
          FocusScope.of(context).requestFocus(new FocusNode());
        });
        initSearch();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade300,width: 1))

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Padding(padding: EdgeInsets.only(bottom: 0), child: Icon(Icons.access_time,color: Colors.grey.shade500,size: 16),),
            12.width,
            Text("${searchText}", style: BlackFieldStyle,),
          ],
        ),
      ),
    );
  }
  Widget TrendingField({String? searchText}){
    return InkWell(
      onTap: (){
        setState(() {
          isClickOnSearchString =true;
          isShowRecentBox = false;
          widget.SearchText = searchText.toString();
          FocusScope.of(context).requestFocus(new FocusNode());
        });
        initSearch();
      },
      child:  Container(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey.shade300,width: 1))

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Image.asset("assets/trend.png",height: 16,color: Colors.grey.shade500,)
            ),
            12.width,
            Text("${searchText}", style: BlackFieldStyle,),
          ],
        ),
      ),
    );
  }

  Widget SearchString({var searchText}){
    return InkWell(
      onTap: (){
        setState(() {
          isClickOnSearchString = true;
          isShowRecentBox = false;
          widget.SearchText = searchText["data"];
          FocusScope.of(context).requestFocus(new FocusNode());
          initSearch();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            //border: Border(bottom: BorderSide(color: Colors.grey.shade300,width: 1))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            0.width,
            Flexible(
              child: Text.rich(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                TextSpan(
                  children: highlightOccurrences(searchText["data"].toString(), SearchController.text ),
                  style: BlackFieldStyle,
                ),
              ),
            ),
           Text("${searchText["EndPoint"]}",style: BlackTitleBoldStyle15500,)
          ],
        ),
      ),
    );
  }


}
List<TextSpan> highlightOccurrences(String source, String query) {
  if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
    return [ TextSpan(text: source) ];
  }
  final matches = query.toLowerCase().allMatches(source.toLowerCase());

  int lastMatchEnd = 0;

  final List<TextSpan> children = [];
  for (var i = 0; i < matches.length; i++) {
    final match = matches.elementAt(i);

    if (match.start != lastMatchEnd) {
      children.add(TextSpan(
        text: source.substring(lastMatchEnd, match.start),
      ));
    }

    children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style:BlackTitleStyle
    ));

    if (i == matches.length - 1 && match.end != source.length) {
      children.add(TextSpan(
        text: source.substring(match.end, source.length),
      ));
    }

    lastMatchEnd = match.end;
  }
  return children;
}