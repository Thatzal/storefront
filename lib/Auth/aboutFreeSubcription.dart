import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../common/style.dart';
import '../constant/constatnt.dart';
import '../model/GetSubscribePlanListModal.dart';
import '../screens/Dashboard/dashboard_screen.dart';

class Free_About_subscriptions extends StatefulWidget {
  SubcriptionResult? SubscriptionDetails;
   Free_About_subscriptions({Key? key , this.SubscriptionDetails}) : super(key: key);

  @override
  State<Free_About_subscriptions> createState() => _about_subscriptionsState();
}

class _about_subscriptionsState extends State<Free_About_subscriptions> {


  // Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // load();

    // _razorpay = Razorpay();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  bool subcriptionSelect = false;

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   Fluttertoast.showToast(
  //       msg: "EXTERNAL_WALLET: ${response.walletName}", timeInSecForIosWeb: 4);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("About Free Usage", style: AppBarTitle,),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body:
         Column(
          children: [
            Image.asset("assets/freeSub.png", width: MediaQuery.of(context).size.width * 0.8, height: MediaQuery.of(context).size.height * 0.25,),
            const SizedBox(height: 15,),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 35,
                      child: Radio(
                        activeColor:Constants.primaryColor1,
                        fillColor: MaterialStateColor.resolveWith((states) => Constants.primaryColor1),
                        value: subcriptionSelect == true ? true :false,
                        groupValue: subcriptionSelect,
                        onChanged: (value) {
                          setState(() {
                            subcriptionSelect = !subcriptionSelect;
                          });
                        },
                      ),
                    ),
                    Text("${widget.SubscriptionDetails!.title.toString()}", style: BlackTitleStyle,),
                    const Spacer(),
                    Text(" ", style: BlackTitleStyle,),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45),
                  child: Text("${widget.SubscriptionDetails!.desc.toString()}",
                    textAlign: TextAlign.left,
                    style: const TextStyle(height: 1.8,fontSize: 14,fontFamily: "Open Sans Hebrew",fontWeight: FontWeight.w400,color:Color(0xFF9E9E9E),fontStyle: FontStyle.normal),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40,),
            SizedBox(height: MediaQuery.of(context).size.height*0.05,
                child:const Text(" ")
            ),
          ],
        ),

      bottomSheet:
      Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        child: ElevatedButton(
          style:ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: const Color(0xfff52b46b),
              fixedSize: Size(MediaQuery.of(context).size.width, 50)
          ),
          onPressed: () {
           if(subcriptionSelect == false ){
             Constants.showToast("Please select plan ");
           }else{
             DrawAuraAPi().subscribePlanApi(userId:DataManager.getInstance().getuserId(),planId:widget.SubscriptionDetails!.id.toString().toString()).then((value) {
               if(value["status"]==200){
                 Fluttertoast.showToast(
                     msg: "Free For Now",
                     toastLength: Toast.LENGTH_SHORT,
                     gravity: ToastGravity.BOTTOM,
                     timeInSecForIosWeb: 2,
                     backgroundColor: Constants.primaryColor1,
                     textColor: Colors.white,
                     fontSize: 18.0
                 );
                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 2),), (route) => false);
               }else{
                 Fluttertoast.showToast(
                     msg: value["message"],
                     toastLength: Toast.LENGTH_SHORT,
                     gravity: ToastGravity.BOTTOM,
                     timeInSecForIosWeb: 2,
                     backgroundColor: Colors.red,
                     textColor: Colors.white,
                     fontSize: 18.0
                 );
               }
             }
             );
           }
          },
          child: const Text("Subscribe Now",style: WhiteTitleStyle,),
        ),
      ),
    );
  }

// Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
//   Fluttertoast.showToast(
//       msg: "Success",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 2,
//       backgroundColor: Constants.primaryColor,
//       textColor: Colors.white,
//       fontSize: 18.0
//   );
//   DrawAuraAPi().subscribePlanApi(userId:DataManager.getInstance().getuserId(),planId:planId.toString()).then((value) {
//     print("plan subscribe");
//     print(planId);
//     print(DataManager.getInstance().getuserId());
//     if(value["status"]==200){
//       Fluttertoast.showToast(
//           msg: value["message"],
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 2,
//           backgroundColor: Constants.primaryColor,
//           textColor: Colors.white,
//           fontSize: 18.0
//       );
//       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 2),), (route) => false);
//     }else{
//       Fluttertoast.showToast(
//           msg: value["message"],
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 2,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 18.0
//       );
//     }
//   });
//
// }

// void _handlePaymentError(PaymentFailureResponse response) {
//   Fluttertoast.showToast(
//       msg: "ERROR: " + response.code.toString() + " - " + response.message.toString(), timeInSecForIosWeb: 4);
// }
}
