import 'package:flutter/material.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import '../common/style.dart';
import '../constant/constatnt.dart';
import 'about_subscription_screen.dart';

class AboutFreeUsageScreen extends StatefulWidget {
  const AboutFreeUsageScreen({Key? key}) : super(key: key);

  @override
  State<AboutFreeUsageScreen> createState() => _AboutFreeUsageScreenState();
}

class _AboutFreeUsageScreenState extends State<AboutFreeUsageScreen> {
  String? aboutsub;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(
          context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                title: const Text("About Free Usage", style: AppBarTitle,),
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Image.asset("assets/bro.png",
                      width:  ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width*0.8:ResponsiveHelper.TabModeWidth*0.8,
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    const SizedBox(height: 15,),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 35,
                              child: Radio(
                                activeColor:Constants.primaryColor1,
                                fillColor: MaterialStateColor.resolveWith(
                                        (states) =>Constants.primaryColor1),
                                value: "Month",
                                groupValue: aboutsub,
                                onChanged: (String? value) {
                                  setState(() {
                                    aboutsub = value;
                                  });
                                },
                              ),
                            ),
                            const Text("Use it free for now!", style: BlackTitleStyle,),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 45),
                          child: Column(
                            children: const [
                              Text("As a buyer / consumer, counter any order posted with your queries and counter offers and buy / avail as much products and services as possible. ",
                                textAlign: TextAlign.left,
                                style: TextStyle(height: 1.8,fontSize: 14,fontFamily: "Open Sans Hebrew",fontWeight: FontWeight.w400,color:Color(0xFF9E9E9E),fontStyle: FontStyle.normal),
                              ),
                              SizedBox(height: 30,),
                              Text("subscribe only when you want to define a BUY your own unique needs or when you want to sell; till then use it free!",
                                textAlign: TextAlign.left,
                                style: TextStyle(height: 1.8,fontSize: 14,fontFamily: "Open Sans Hebrew",fontWeight: FontWeight.w400,color:Color(0xFF9E9E9E),fontStyle: FontStyle.normal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style:ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xfff52b46b),
                          fixedSize: Size( ResponsiveHelper.isMobile(context)?  MediaQuery.sizeOf(context).width*0.9:ResponsiveHelper.TabModeWidth*0.9, 50)
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text("Subscribe Now",style: WhiteTitleStyle,),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Learn about subscriptions.", textAlign: TextAlign.center,),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const About_subscriptions(),));
                            },
                            child: const Text("Click here",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize: 14),))
                      ],
                    ),
                    const SizedBox(height: 5,),
                  ],
                ),
              ))
      ),
    );
  }
}
