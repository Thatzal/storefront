// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:socialapps/Apis/api.dart';
// import 'package:socialapps/Auth/aboutFreeSubcription.dart';
// import 'package:socialapps/controller/DataManager.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:socialapps/screens/setting/manage_profile_screen.dart';
// // import 'package:razorpay_flutter/razorpay_flutter.dart';
// import '../common/style.dart';
// import '../constant/constatnt.dart';
// import '../constant/loading.dart';
// import '../model/GetSubscribePlanListModal.dart';
// import '../screens/Dashboard/dashboard_screen.dart';
// import 'about_subscription_screen.dart';
// import 'package:socialapps/common/ResponsiveBuilder.dart';
//
// class subcription_screen extends StatefulWidget {
//   String From;
//    subcription_screen({Key? key,required this.From}) : super(key: key);
//
//   @override
//   State<subcription_screen> createState() => _subcription_screenState();
// }
//
// class _subcription_screenState extends State<subcription_screen> {
//   bool loader = true;
//   int _current = 0;
//   final currentposition = 0.0;
//   GetSubscribePlanListApi? SubscriptionList;
//   // Razorpay _razorpay = Razorpay();
//   String? planId;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     load();
//     // _razorpay = Razorpay();
//     // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     // _razorpay.clear();
//   }
//
//   load(){
//
//     DrawAuraAPi.subscribePlanListApi().then((value) {
//       // print(value.result);
//       setState(() {
//         SubscriptionList=value;
//         loader=false;
//       });
//     });
//
//   }
//
//   // void _handleExternalWallet(ExternalWalletResponse response) {
//   //   Fluttertoast.showToast(
//   //       msg: "EXTERNAL_WALLET: ${response.walletName}", timeInSecForIosWeb: 4);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
//       body: responsiveContainer(context,
//           ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
//           Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               leading: InkWell(
//                   onTap: () {Navigator.pop(context);},
//                   child: const Icon(Icons.arrow_back, color: Colors.black,)),
//               title: const Text("Subscription", style: AppBarTitle,),
//               elevation: 0,
//               backgroundColor: Colors.white,
//             ),
//             body:loader==true?Center(child: LoadingWidget()):
//             CarouselSlider.builder(
//                 itemCount: SubscriptionList!.result!.length,
//                 itemBuilder: (context, index, realIndex) {
//                   var data = SubscriptionList!.result![index];
//                   Future.delayed(Duration(milliseconds:500),(){
//             if(mounted){
//               setState(() {
//                 planId = SubscriptionList!.result![index].id.toString();
//               });
//             }
//                   });
//                   return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             child: ListView(
//               physics: ScrollPhysics(),
//               children: [
//                 const SizedBox(height: 10,),
//                 Image.network("${data.image}",
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height * 0.3,
//                 ),
//                 const SizedBox(height: 40,),
//                 Center(child: Text("${data.title.toString()}", style: BlackBottomHeadStyle18500,)),
//                 const SizedBox(height: 4,),
//                 const SizedBox(width: 40, child: Divider(height: 2, color: Color(0xfff4CD964), thickness: 2,)),
//                 const SizedBox(height: 13,),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height*0.2,
//                   child:Text("${data.desc.toString()}", textAlign: TextAlign.center, style: const TextStyle(height: 1.5,fontSize: 14,fontFamily: "Open Sans Hebrew",fontWeight: FontWeight.w400,color:Color(0xFF9E9E9E),fontStyle: FontStyle.normal),
//                   ),
//                 ),
//                 const SizedBox(height: 15,),
//                 Text("${data.subTitle == null ? "": data.subTitle}", textAlign: TextAlign.center, style: greyFieldStyle),
//                 const SizedBox(height: 15,),
//                 Center(
//                   child: DotsIndicator(
//                     dotsCount: SubscriptionList!.result!.length,
//                     onTap: (position) => currentposition,
//                     position: _current.toDouble(),
//                     decorator: const DotsDecorator(color: Colors.black12, activeColor: Constants.primaryColor),
//                   ),
//                 ),
//                 const Spacer(),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: primaryColor,
//                       fixedSize: Size(ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width:ResponsiveHelper.TabModeWidth, 50)),
//                   onPressed: () {
//                     if(data.type=="FREE"){
//                       DrawAuraAPi().subscribePlanApi(userId:DataManager.getInstance().getuserId(),planId:data.id.toString()).then((value) {
//                         if(value["status"]==200){
//                           if(widget.From == "SignUp"){
//                             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ManageProfileScreen(From: "SignUp"),), (route) => false);
//                           }else{
//                             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 2),), (route) => false);
//
//                           }
//                         }else{
//                           Fluttertoast.showToast(
//                               msg: value["message"],
//                               toastLength: Toast.LENGTH_SHORT,
//                               gravity: ToastGravity.BOTTOM,
//                               timeInSecForIosWeb: 2,
//                               backgroundColor: Colors.red,
//                               textColor: Colors.white,
//                               fontSize: 18.0
//                           );
//                         }
//                       }
//                       );
//                     } else{
//                       DrawAuraAPi().subscribePlanApi(userId:DataManager.getInstance().getuserId(),planId:planId.toString()).then((value) {
//                         if(value["status"]==200){
//                           if(widget.From == "SignUp"){
//                             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ManageProfileScreen(From: "SignUp"),), (route) => false);
//
//                           }else{
//                             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 2),), (route) => false);
//                           }
//                         }else{
//                           Fluttertoast.showToast(
//                               msg: value["message"],
//                               toastLength: Toast.LENGTH_SHORT,
//                               gravity: ToastGravity.BOTTOM,
//                               timeInSecForIosWeb: 2,
//                               backgroundColor: Colors.red,
//                               textColor: Colors.white,
//                               fontSize: 18.0
//                           );
//                         }
//                       });
//                       var price = int.parse(data.price!.split(".").first.toString());
//                       print(price);
//                       var options = {
//                         'key': 'rzp_test_CYKqRkdy6RUcXc',
//                         'amount': price*100.toInt(),
//                         'name': 'Kishore',
//                         'description': 'Payment',
//                         'prefill': {'contact': '9988776655', 'email': 'test@razorpay.com'},
//                         'external': {
//                           'wallets': ['paytm']
//                         }
//                       };
//                       // try {
//                       // //  _razorpay.open(options);
//                       // } catch (e) {
//                       //   debugPrint(e.toString());
//                       // }
//                     }
//
//                   },
//                   child: Text(data.type=="MONTHLY"?"Subscribe monthly with Rs. ${data.price}/Month":data.type=="YEARLY"?"Subscribe annualy with Rs. ${data.price}/year":"Free For Now",style: WhiteTitleStyle,),
//                 ),
//                 const SizedBox(height: 8,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Learn about subscriptions.", textAlign: TextAlign.center,style: BlackSubTitleStyle,),
//                     TextButton(
//                         onPressed: () {
//                           if(data.type=="FREE"){
//                             Navigator.push(context, MaterialPageRoute(builder: (context) =>  Free_About_subscriptions(SubscriptionDetails: data),));
//                           }else{
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => const About_subscriptions(),));
//                           }
//
//                         },
//                         child: const Text("Click here",style: PrimaryColorTitleStyle,))
//                   ],
//                 ),
//                 const SizedBox(height: 5,),
//               ],
//             ),
//                   );
//                 },
//                 options: CarouselOptions(
//             height: MediaQuery.of(context).size.height,
//             autoPlay: false,
//             enlargeCenterPage: false,
//             animateToClosest: true,
//             enableInfiniteScroll: false,
//             viewportFraction: 0.9,
//             aspectRatio: 2.0,
//             initialPage: 0,
//             // scrollDirection: Axis.horizontal,
//             onPageChanged: (index, reason) {
//               setState(() {
//                 _current = index;
//               });
//             }),),
//           )),
//     );
//   }
//
//   // Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
//   //   print(response.paymentId);
//   //   print(response.orderId);
//   //   print(response.signature);
//   //
//   //   print("responseData");
//   //   Fluttertoast.showToast(
//   //       msg: "Success",
//   //       toastLength: Toast.LENGTH_SHORT,
//   //       gravity: ToastGravity.BOTTOM,
//   //       timeInSecForIosWeb: 2,
//   //       backgroundColor: Colors.red,
//   //       textColor: Colors.white,
//   //       fontSize: 18.0
//   //   );
//   //   DrawAuraAPi().subscribePlanApi(userId:DataManager.getInstance().getuserId(),planId:planId.toString()).then((value) {
//   //     if(value["status"]==200){
//   //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 2),), (route) => false);
//   //     }else{
//   //       Fluttertoast.showToast(
//   //           msg: value["message"],
//   //           toastLength: Toast.LENGTH_SHORT,
//   //           gravity: ToastGravity.BOTTOM,
//   //           timeInSecForIosWeb: 2,
//   //           backgroundColor: Colors.red,
//   //           textColor: Colors.white,
//   //           fontSize: 18.0
//   //       );
//   //     }
//   //   }
//   //   );
//   // }
//
// //   void _handlePaymentError(PaymentFailureResponse response) {
// //     Fluttertoast.showToast(msg: "ERROR: " + response.code.toString() + " - " + response.message.toString(), timeInSecForIosWeb: 4);
// // }
// }
