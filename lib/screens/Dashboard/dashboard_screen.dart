import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/screens/Dashboard/notify/NotificationTapBarScreen.dart';
import 'package:socialapps/screens/Dashboard/search_screen.dart';
import 'package:socialapps/screens/Dashboard/setting_screen.dart';
import 'package:socialapps/screens/Dashboard/feed_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapps/screens/widgets/GuestLogInScreen.dart';
import '../../common/style.dart';
import '../../main.dart';
import 'home/home_screen.dart';

class  Dashboard_screen extends StatefulWidget {
  var backIndex;
  Dashboard_screen({Key? key,required this.backIndex}) : super(key: key);
  @override
  _Dashboard_screenState createState() => _Dashboard_screenState();
}

class _Dashboard_screenState extends State<Dashboard_screen > with TickerProviderStateMixin{


  static const int totalPage = 5;
  bool isExtended =true;
  int _selectedIndex = 2;
  final _widgetOptions = <Widget>[
    const feed_screen(),
    const setting_screen(),
    const SearchScreen(),
    DataManager.getInstance().getuserId().toString() == "1"?GuestUserLogInScreen(): NotifyScreen(),
    DataManager.getInstance().getuserId().toString() == "1"?GuestUserLogInScreen(): HomePageScreen(),
  ];
  var userImage = "";
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  var _token='';

  @override
  void initState(){

    FirebaseMessaging.instance.getToken().then((newToken){

      setState(() {
        _token = newToken!;
      });

    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
              enableVibration: true,
              colorized: true,
              importance: Importance.max,
              priority: Priority.high,
              styleInformation: BigTextStyleInformation("${notification.body}"),
            ),
          ),

        );
      }
    });

    super.initState();
    loadImage();
    _selectedIndex = widget.backIndex;
  }

  loadImage() async{
    final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    userImage = sharedpreferences.getString("userImage")??"";
  }
  void _onItemTapped(int index) {

    setState(() {
      _selectedIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,

        body: responsiveContainer(
          context,Constants.primaryColor1,
            _widgetOptions[_selectedIndex]
        ),
        bottomNavigationBar: bottomNavigationBar
    );
  }
  Widget get bottomNavigationBar {

    return Row(

      children: [
        Spacer(),
        Container(
          margin: EdgeInsets.zero,
          height: Platform.isIOS?110:85,
          width: ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width: ResponsiveHelper.TabModeWidth,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            boxShadow: [BoxShadow(color: Constants.greyDark.withOpacity(0.45), spreadRadius: 4, blurRadius: 10),],
          ),
          child: ClipRRect(
            borderRadius:  BorderRadius.only(
              topLeft:ResponsiveHelper.isMobile(context)? Radius.circular(25.0):Radius.circular(0),
              topRight:ResponsiveHelper.isMobile(context)? Radius.circular(25.0):Radius.circular(0),
            ),
            child: BottomNavigationBar(
              showSelectedLabels: true,selectedFontSize: 0,
              showUnselectedLabels: true,unselectedFontSize: 0,
              backgroundColor: Colors.white,
              selectedItemColor: Constants.primaryColor1,
              items:   <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  activeIcon: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Constants.primaryColor1
                    ),
                    child: Center(child: SizedBox(
                        height: 24,width: 24,
                        child: Image.asset("assets/feed.png",height: 24,width: 24,color:Constants.white))),
                  ),
                  icon:Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Constants.white
                    ),
                    child: const Center(child: ImageIcon(AssetImage("assets/feed.png"),size: 24,color: Constants.greyDark,)),
                  ),
                  label: "Feed",
                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Constants.primaryColor1
                    ),
                    child: Center(child: SizedBox(
                        height: 24,width: 24,
                        child: Image.asset("assets/settings.png",height: 24,width: 24,color:Constants.white))),
                  ),
                  icon:Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Constants.white
                    ),
                    child: const Center(child: ImageIcon(AssetImage("assets/settings.png"),size: 24,color: Constants.greyDark,)),
                  ),
                  label: "Settings",
                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Constants.primaryColor1
                    ),
                    child: Center(child: SizedBox(
                        height: 24,width: 24,
                        child: Image.asset("assets/search.png",height: 24,width: 24,color:Constants.white))),
                  ),
                  icon:Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Constants.white
                    ),
                    child: const Center(child: ImageIcon(AssetImage("assets/search.png"),size: 24,color: Constants.greyDark,)),
                  ),
                  label: "Search",

                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Constants.primaryColor1
                    ),
                    child: Center(child: SizedBox(
                        height: 24,width: 24,
                        child: Image.asset("assets/notify.png",height: 24,width: 24,color:Constants.white))),
                  ),
                  icon: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Constants.white
                    ),
                    child: const Center(child: ImageIcon(AssetImage("assets/notify.png"),size: 24,color: Constants.greyDark,)),
                  ),
                  label: "Notify",
                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Constants.primaryColor1
                    ),
                    child: Center(child: Container(
                      height: 35,width: 35,
                      decoration: DataManager.getInstance().getuserImage().toString() == "null" ||  DataManager.getInstance().getuserImage() == null ||DataManager.getInstance().getuserImage()=="" ? BoxDecoration(
                        // border: Border.all(color: Constants.white,width: 4),
                          shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg"),)
                      ):  BoxDecoration(
                          border: Border.all(color: Constants.white,width: 2),
                          shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${DataManager.getInstance().getuserImage()}"),fit: BoxFit.fill)
                      ),
                    )),
                  ),
                  icon:  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Constants.greyDark
                    ),
                    child: Center(child: Container(
                      height: 35,width: 35,
                      decoration: DataManager.getInstance().getuserImage().toString() == "null" ||  DataManager.getInstance().getuserImage() == null ||DataManager.getInstance().getuserImage()=="" ? BoxDecoration(
                        // border: Border.all(color: Constants.white,width: 4),
                          shape: BoxShape.circle,
                          image: DecorationImage( image:  NetworkImage("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg"),)
                      ):  BoxDecoration(
                          border: Border.all(color: Constants.white,width: 2),
                          shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${DataManager.getInstance().getuserImage()}"),fit: BoxFit.fill)
                      ),
                    )),
                  ),
                  label: "Home",
                ),
              ],
              unselectedLabelStyle: greyFieldStyle,
              selectedLabelStyle: PrimaryColorFieldStyle,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              iconSize: 20,
              onTap: _onItemTapped,
              elevation: 0,
            ),
          ),
        ),
        Spacer()
      ],
    );
  }
}