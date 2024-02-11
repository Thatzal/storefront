import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';

import '../../Apis/urls.dart';
import '../../common/style.dart';
import '../../model/CommentsModel.dart';

Future getCommentBottomSheet(context,offerId,) async {
  bool isCommentsLoading = true;
  List<CommentsDataList> CommentsList = [];
 await DrawAuraAPi().getOfferCommentsList(offer_id: offerId).then((value) {
    CommentsList = value;
    isCommentsLoading = false;
  });
  late ScrollController scrollCommentsController;
  TextEditingController messageController = TextEditingController();
  FocusNode focusNode = FocusNode();
  scrollCommentsController = ScrollController();
  void scrollToBottom() {
    final bottomOffset = scrollCommentsController.position.maxScrollExtent;
    scrollCommentsController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }
  return Get.bottomSheet(
      barrierColor: Colors.black12,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
  ),
  enableDrag: true,
    Container(
        height: MediaQuery.of(context).size.height*0.8,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
          color: Colors.white,
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 3.5,
                margin: EdgeInsets.only(top: 13),
                width: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black54,
                )),
            20.height,
            Text("Comments",style:BlackSubTitleStyle,),
            10.height,
            Divider(color: Colors.black,height: 2.5,thickness: 1.2),
            2.height,
            isCommentsLoading?
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
              child: LoadingWidget(),
            )
                :

            CommentsList.isEmpty?
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
              child:  NotAvailableText("No commends available!")
            )
                : Expanded(
              child: ListView.builder(
                controller: scrollCommentsController,
                itemCount: CommentsList.length,
                padding: EdgeInsets.only(bottom: 100),
                itemBuilder: (context, i) {
                  var CommentsData = CommentsList[i];
                  final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${CommentsData.createdAt.toString()}');
                  final currentTime = DateTime.now();
                  final diff_dy = currentTime.difference(startTime).inDays;
                  final diff_mi = currentTime.difference(startTime).inMinutes;
                  final diff_s = currentTime.difference(startTime).inSeconds;
                  final diff_hr = currentTime.difference(startTime).inHours;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15,right: 0,top: 5),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image:
                            CommentsData.user!.profilePicture == null ||
                                CommentsData.user!.profilePicture.toString() == "null" ||
                                CommentsData.user!.profilePicture.toString()  == "" ?
                            DecorationImage(image:   AssetImage("assets/home.png"),fit: BoxFit.fill):
                            DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${CommentsData.user!.profilePicture}"),fit: BoxFit.fill)
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Constants.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("${CommentsData.user!.username}",style: BlackSubTitleStyle,),
                                  10.width,
                                  Text(diff_s <= 60 ?"$diff_s""s":diff_mi <= 60 ?"$diff_mi"'m':diff_hr <= 24 ?"$diff_hr"'h':"$diff_dy"'d',style: greyDescItalicStyle,)
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text('''${CommentsData.comment}''',style: Black87DescStyle,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },),
            ),
            Container(

              decoration: BoxDecoration(
                  color: Colors.white,

                  border: Border(top: BorderSide(color: Constants.greyLight,width: 1.5))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  10.width,
                  Container(
                    height: 35,
                    width: 35,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Constants.greyDark
                    ),
                    child: Center(child: Container(
                      height: 35,width: 35,
                      decoration: DataManager.getInstance().getuserImage() == "null" ||  DataManager.getInstance().getuserImage() == null ||DataManager.getInstance().getuserImage()=="" ? BoxDecoration(
                        // border: Border.all(color: Constants.white,width: 4),
                          shape: BoxShape.circle,
                          image: DecorationImage(image: AssetImage("assets/home.png"),)
                      ):  BoxDecoration(
                          border: Border.all(color: Constants.white,width: 2),
                          shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${DataManager.getInstance().getuserImage()}"),fit: BoxFit.fill)
                      ),
                    )),
                  ),

                  Flexible(
                    child: TextFormField(
                      controller: messageController,
                      keyboardType: TextInputType.text,
                      // maxLines: ,
                      onChanged: (value){
                        // setState(() {
                        //
                        // });
                        // modalState((){});
                      },
                      autofocus: false,
                      focusNode: focusNode,
                      // style: black14500,
                      cursorColor: Colors.black,textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Write your comments",
                        hintStyle: greySubTitleItalicStyle,
                      ),
                    ),
                  ),
                  messageController.text.isEmpty?SizedBox():InkWell(
                    onTap: (){
                      // messageController.clear();
                      DrawAuraAPi.CreateOfferComments(offer_id: offerId,user_id: DataManager.getInstance().getuserId().toString(),Comments: messageController.text).then((value) {
                        if(value["status"] == "200"){
                          var CommentRes =  CommentsDataList(
                            id: value["result"]["id"],
                            user:CommentsUser(
                                id: value["result"]["user"]["id"],
                                displayname:  value["result"]["user"]["displayname"],
                                profilePicture:  value["result"]["user"]["profile_picture"],
                                username:  value["result"]["user"]["username"]
                            ),
                            offer: value["result"]["offer"],
                            comment: value["result"]["comment"],
                            createdAt: value["result"]["created_at"],
                            updatedAt: value["result"]["updated_at"],
                          );
                          // modalState((){
                          CommentsList.add(CommentRes);
                          messageController.clear();
                          scrollToBottom();
                          // });
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Constants.greyLight,width: 1),
                          color:Constants.primaryColor1
                      ),
                      child: Center(child:Icon(Icons.send,color: Colors.white,size: 24,)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
    ),

  );

}