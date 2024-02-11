//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:socialapps/Apis/api.dart';
// import 'package:socialapps/constant/loader.dart';
// import 'package:socialapps/constant/text_form_feild.dart';
// import 'package:socialapps/controller/DataManager.dart';
// import 'package:socialapps/screens/setting/currentlocation.dart';
// import 'package:socialapps/screens/setting/manage_adress_screen.dart';
//
// import '../../constant/constatnt.dart';
// class addaddress extends StatefulWidget {
//   const addaddress({Key? key}) : super(key: key);
//
//   @override
//   State<addaddress> createState() => _addaddressState();
// }
//
// class _addaddressState extends State<addaddress> {
//   bool loader = false;
//   TextEditingController buildingNameController = TextEditingController();
//   TextEditingController LandmarkNameController = TextEditingController();
//   TextEditingController SaveAdress1Controller = TextEditingController();
//   TextEditingController SaveAdress2Controller = TextEditingController();
//   TextEditingController SaveAdress3Controller = TextEditingController();
//   TextEditingController pinCodeController = TextEditingController();
//   TextEditingController areaController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController stateController = TextEditingController();
//   TextEditingController countryController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   final List<String> adressList = [
//     'Home',
//     'Work',
//     'Area',
//     'Other',
//   ];
//
//   int addressValue =0;
//   String? Adress;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: InkWell(
//             onTap: (){
//               Navigator.of(context).pop();
//             },
//             child: const Icon(Icons.arrow_back,color: Colors.black,)),
//         title: const Text("Enter Address Details",style: TextStyle(color: Colors.black),),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//         child: SingleChildScrollView(
//           physics: ScrollPhysics(),
//           child: Column(
//             children: [
//              Container(
//                child: Row(
//                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: [
//                    const Text("Save address as* ",style: TextStyle(fontSize: 12,color: Color(0xFFF8F8F8F)),),
//                    SizedBox(
//                      height: 30,
//                      child: ListView.builder(
//                        physics: const ScrollPhysics(),
//                        shrinkWrap: true,
//                        itemCount: adressList.length,
//                        scrollDirection: Axis.horizontal,
//                        itemBuilder: (context, index) {
//                          var data = adressList[index];
//                        return InkWell(
//                          onTap: (){
//                            setState(() {
//                              addressValue=index;
//                              Adress=data.toString();
//                              // print(addressValue);
//                              // print(Adress);
//                            });
//                          },
//                          child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                             margin: const EdgeInsets.symmetric(horizontal: 3),
//                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color:addressValue==index?Constants.primaryColor:Colors.grey)),
//                            child: Center(child: Text("${data.toString()}",style: TextStyle(color: Colors.grey,fontSize: 10),)),
//                          ),
//                        );
//                      },),
//                    ),
//                  ],
//                )
//              ),
//               const SizedBox(height: 15,),
//                Form(
//                  key: formKey,
//                  child: Column(
//                    children: [
//                      TextFormField(
//                        validator: (value) {
//                          if(value!.isEmpty){
//                            return "Please enter Building Floor";
//                          }
//                          return null;
//                        },
//                        controller: buildingNameController,
//                        decoration: inputDecorationBorder(context,hint:"Name of the Building Floor etc"),
//                      ),
//                      const SizedBox(height: 7,),
//                      TextFormField(
//                        validator: (value) {
//                          if(value!.isEmpty){
//                            return "Please enter Nearest Landmark";
//                          }
//                          return null;
//                        },
//                        controller: LandmarkNameController,
//                        decoration: inputDecorationBorder(context,hint:"Nearest Landmark etc."),
//                      ),
//                      const SizedBox(height: 7,),
//                      TextFormField(
//                        validator: (value) {
//                          if(value!.isEmpty){
//                            return "Please enter address Details 1";
//                          }
//                          return null;
//                        },
//                        controller: SaveAdress1Controller,
//                        decoration: inputDecorationBorder(context,hint:"Save address Details 1"),
//                      ),
//                      const SizedBox(height: 7,),
//                      TextFormField(
//                        validator: (value) {
//                          if(value!.isEmpty){
//                            return "Please enter address Details 2";
//                          }
//                          return null;
//                        },
//                        controller: SaveAdress2Controller,
//                        decoration: inputDecorationBorder(context,hint:"Save address Details 2"),
//                      ),
//                      const SizedBox(height: 7,),
//                      TextFormField(
//                        validator: (value) {
//                          if(value!.isEmpty){
//                            return "Please enter address Details 3";
//                          }
//                          return null;
//                        },
//                        controller: SaveAdress3Controller,
//                        decoration: inputDecorationBorder(context,hint:"Save address Details 3"),
//                      ),
//                      const SizedBox(height: 7,),
//                      TextFormField(
//                        validator: (value) {
//                          if(value!.isEmpty){
//                            return "Please enter area";
//                          }
//                          return null;
//                        },
//                        controller: areaController,
//                        decoration: inputDecorationBorder(context,hint:"Enter area"),
//                      ),
//                      const SizedBox(height: 7,),
//                      TextFormField(
//                        validator: (value) {
//                          if(value!.isEmpty){
//                            return "Please enter city";
//                          }
//                          return null;
//                        },
//                        controller: cityController,
//                        decoration: inputDecorationBorder(context,hint:"Enter city"),
//                      ),
//                      const SizedBox(height: 7,),
//                      TextFormField(
//                        validator: (value) {
//                          if(value!.isEmpty){
//                            return "Please enter state";
//                          }
//                          return null;
//                        },
//                        controller: stateController,
//                        decoration: inputDecorationBorder(context,hint:"Enter state"),
//                      ),
//                      const SizedBox(height: 7,),
//                      TextFormField(
//                        validator: (value) {
//                          if(value!.isEmpty){
//                            return "Please enter country";
//                          }
//                          return null;
//                        },
//                        controller: countryController,
//                        decoration: inputDecorationBorder(context,hint:"Enter country"),
//                      ),
//                      InkWell(
//                        onTap: (){
//                          Navigator.push(context, MaterialPageRoute(builder: (context) => currentlocation(),));
//                        },
//                        child: Container(
//                          height: 30,
//                          child: Row(
//                            children: const [
//                              Icon(Icons.my_location,color: Colors.blue,size: 15,),
//                              SizedBox(width: 3,),
//                              Text("Search near your Current Location",style: TextStyle(color: Colors.blue,fontSize: 13),),
//                            ],
//                          ),
//
//                        ),
//                      ),
//                      const SizedBox(height: 10,),
//                      TextFormField(
//                        maxLength: 6,
//                        validator: (value) {
//                          if(value!.isEmpty){
//                            return "Please enter pincode";
//                          }
//                          return null;
//                        },
//                        keyboardType: TextInputType.number,
//                        controller: pinCodeController,
//                        decoration: inputDecorationBorder(context,hint:"Pincode"),
//                      ),
//                    ],
//                  ),
//                ),
//               const SizedBox(height: 10,),
//               ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       elevation: 0,
//                       backgroundColor:const Color(0xFFF52B46B),
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                       ),
//
//                       fixedSize: Size(MediaQuery.of(context).size.width*0.9, 20)
//                   ),
//                   onPressed: (){
//
//                     if(formKey.currentState!.validate()){
//                       var addAdress = {
//                         "user":DataManager.getInstance().userId.toString(),
//                         "name":buildingNameController.text.toString(),
//                         "description_line_1":SaveAdress1Controller.text.toString(),
//                         "description_line_2":SaveAdress2Controller.text.toString(),
//                         "description_line_3":SaveAdress3Controller.text.toString(),
//                         "landmark":LandmarkNameController.text.toString(),
//                         "area":areaController.text.toString(),
//                         "city":cityController.text.toString(),
//                         "state":stateController.text.toString(),
//                         "country":countryController.text.toString(),
//                         "pincode":pinCodeController.text.toString(),
//                         "geolocation": " ",
//                       };
//
//                       // print("createAdress");
//                       // print(addAdress);
//                       setState(() {
//                         loader=true;
//                       });
//                       DrawAuraAPi().createAdressApi(adress:addAdress).then((value) {
//                         if(value["status"]=="200"){
//                           Fluttertoast.showToast(
//                               msg: value["message"].toString(),
//                               toastLength: Toast.LENGTH_SHORT,
//                               gravity: ToastGravity.BOTTOM,
//                               timeInSecForIosWeb: 2,
//                               backgroundColor:Constants.primaryColor,
//                               textColor: Colors.white,
//                               fontSize: 18.0
//                           );
//                          // Navigator.push(context, MaterialPageRoute(builder: (context) =>  manageadress(),));
//                           setState(() {
//                             loader=false;
//                           });
//                         }else{
//                           Fluttertoast.showToast(
//                               msg: value["message"].toString(),
//                               toastLength: Toast.LENGTH_SHORT,
//                               gravity: ToastGravity.BOTTOM,
//                               timeInSecForIosWeb: 2,
//                               backgroundColor: Colors.red,
//                               textColor: Colors.white,
//                               fontSize: 18.0
//                           );
//                         }
//                         setState(() {
//                           loader=false;
//                         });
//
//                       });
//
//                     }
//                   }, child: loader==false?Text("Save Address",):ButtonLoaderWhite()),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
