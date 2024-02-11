import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/model/GetPrivacyPolicyModal.dart';

class PrivacyPolicyAgree extends StatefulWidget {
  String From ;
   PrivacyPolicyAgree({Key? key,required this.From}) : super(key: key);

  @override
  State<PrivacyPolicyAgree> createState() => _PrivacyPolicyAgreeState();
}

class _PrivacyPolicyAgreeState extends State<PrivacyPolicyAgree> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTC();
  }
  bool loader = true;
  GetPrivacyPolicyModal? TermsConditionsContent;
  loadTC(){
    DrawAuraAPi.getPrivacyPolicyApi().then((value) {

     if(mounted){
       setState(() {
         TermsConditionsContent =GetPrivacyPolicyModal.fromJson(value["result"][0]) ;
         loader=false;
       });
     }
    });
  }
  @override
  Widget build(BuildContext context) {
    var isMobile = ResponsiveHelper.isMobile(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    return  Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(
        context,
        ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
         Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(loader ?"":"${TermsConditionsContent!.name}",style: AppBarTitle,),
            elevation: 1,
            backgroundColor: Colors.white,
          ),
          body:
          loader?Center(
            child: LoadingWidget(),
          ):
          CupertinoScrollbar(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: [
                Html(data:"${TermsConditionsContent!.content}"),
                widget.From == "Setting"?SizedBox():SizedBox(height: 65,)
              ],
            ),
          ),
          // bottomSheet:widget.From == "Setting"? SizedBox(): Container(
          //
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     border: Border(top: BorderSide(color: Constants.lightGreen,width: 1)),
          //   ),
          //   height: 60,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       ElevatedButton(
          //         child:   Text("I Agree",
          //           style: WhiteButtonStyle,
          //         ),
          //         onPressed:  () {
          //           Navigator.pop(context);
          //         },
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: Constants.primaryColor,
          //           elevation: 1,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(40),
          //           ),
          //           fixedSize:
          //           Size(ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width * 0.42:ResponsiveHelper.TabModeWidth*0.42, 45),
          //         ),
          //       ),
          //       ElevatedButton(
          //         child:   Text("Decline",
          //           style: GreyButtonStyle16500,
          //         ),
          //         onPressed:  () {
          //           Navigator.pop(context);
          //         },
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: Colors.white,
          //           elevation: 0,
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(40),
          //               side: BorderSide(width: 1,color: Constants.lightGreen)
          //           ),
          //           fixedSize:
          //           Size(ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width * 0.42:ResponsiveHelper.TabModeWidth*0.42, 45),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
