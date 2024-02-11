import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/screens/widgets/AppBar.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';


class AboutThatZalScreen extends StatefulWidget {
  const AboutThatZalScreen({Key? key}) : super(key: key);

  @override
  State<AboutThatZalScreen> createState() => _AboutThatZalScreenState();
}

class _AboutThatZalScreenState extends State<AboutThatZalScreen> {

  PackageInfo? packageInfo;
  bool Loader = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAppInfo();
  }
  getAppInfo() async{
    if(mounted){
      packageInfo = await PackageInfo.fromPlatform();
      Loader = false;
      setState(() {});
    }
  }
  // String GetAppReleaseDate() {
  //   return const String.fromEnvironment('AppReleaseDate', defaultValue: '');
  // }

//  String ReDate  = FlutterConfig.get("ReleaseDate").toString();
  String ReDate  = Platform.isAndroid?Url.AndroidReleaseDate:Url.IOSReleaseDate;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    var isMobile= ResponsiveHelper.isMobile(context);
    return Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Scaffold(
            appBar: CommonAppBar("About Thatzal", () {Navigator.pop(context); }),
            body: Loader == true ? Center(child: LoadingWidget()):
            ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                20.height,
                Container(
                  width: 230,height: 200,
                  decoration: BoxDecoration(

                      image: DecorationImage(
                          image: AssetImage("assets/AppIcon.png",),fit: BoxFit.contain
                      )
                  ),
                ),
                //Image.asset(Images.appLogo(context),width: 200,height: 200,color: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Colors.white:Colors.black ,),
                10.height,
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:isMobile?width*0.15: tabWidth*0.15),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(140),
                      1: FixedColumnWidth(20),
                    },
                    children:   [
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 0.0,top: 15),
                          child: Text("App Name",style: BlackTitleStyle,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text(":",style: BlackTitleStyle,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text("${packageInfo!.appName}",style: BlackSubTitleStyle,),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 0.0,top: 15),
                          child: Text("Version",style: BlackTitleStyle,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text(":",style: BlackTitleStyle,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text("${packageInfo!.version}",style: BlackSubTitleStyle,),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 0.0,top: 15),
                          child: Text("App release date",style: BlackTitleStyle,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text(":",style: BlackTitleStyle,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text("Aug 28, 2023",style: BlackSubTitleStyle,),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 0.0,top: 15),
                          child: Text("Latest release date",style: BlackTitleStyle,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text(":",style: BlackTitleStyle,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text("$ReDate",style: BlackSubTitleStyle,),
                        ),
                      ]),

                    ],),
                ),
                20.height,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text('''Connect to buy, sell, avail, offer anything, anywhere, anytime from / to anyone!

Thatzal is a Multi-domain & Multi-Vertical Social app that creates a market community to connect and synergise itself leading to a self-supporting BUYER, SELLER, DELIVERER ecosystem that’s dynamic and grows on-demand on its own. Thatzal facilitates BUY-SELL that's transactional till the last mile reach supporting Multi-BIDs and Negotiations. Thatzal provides all services yet with no constraints, no intermediaries, no limits and boundaries, and no commissions whatsoever. Just BUY, SELL anything, anytime, to anyone, and anywhere, That’s all.

With THATZAL, you are never left alone! Because you are market and it’s your market as well!''',style: greyFieldStyle,textAlign: TextAlign.center,),
                ),
                const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //             elevation: 0,
                //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                //             backgroundColor: Constants.primaryColor,
                //             fixedSize: Size(ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width*0.7:ResponsiveHelper.TabModeWidth*0.7, 45)
                //         ),
                //         onPressed: () async {
                //           showFeedBackDialog(context);
                //
                //           // final appPackageName = (await PackageInfo.fromPlatform()).packageName;
                //           // try {
                //           //   launchUrl(Uri.parse(
                //           //       "market://details?id=$appPackageName"));
                //           // } on PlatformException catch (e) {
                //           //   launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName"));
                //           // }
                //         }, child: Center(
                //       child: Text("Rate Us",style: WhiteButtonStyle,),
                //     )),
                //   ],
                // ),
                20.height,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //             elevation: 0,
                //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                //             backgroundColor: Constants.primaryColor,
                //             fixedSize: Size(MediaQuery.of(context).size.width*0.7, 45)
                //         ),
                //         onPressed: () async{
                //           final appPackageName = (await PackageInfo.fromPlatform()).packageName;
                //           try {
                //           launchUrl(Uri.parse(
                //           "market://details?id=$appPackageName"));
                //           } on PlatformException catch (e) {
                //           launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName"));
                //           }
                //         }, child: Center(
                //       child: Text("Update",style: WhiteButtonStyle,),
                //     )),
                //   ],
                // ),
                // const SizedBox(height: 20,),

              ],
            ),
          )),
    );
  }
}



