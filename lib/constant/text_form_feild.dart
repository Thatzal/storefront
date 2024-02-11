

import 'package:flutter/material.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';

class TextFormFieldCustom extends StatefulWidget {
  const TextFormFieldCustom({Key? key, required this.formText, required this.prefixIcon}) : super(key: key);
  final String formText;
  final Widget prefixIcon;
  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        labelText: widget.formText,
        labelStyle:   const TextStyle( color: Colors.grey),
        prefixIcon: widget.prefixIcon,


      ),

    );
  }
}
InputDecoration inputDecoration(BuildContext context, {Widget? prefixIcon, String? hint,suffixIcon}) {
  return InputDecoration(
      isDense: false,
      contentPadding:  const EdgeInsets.symmetric(horizontal: 9,vertical:10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
         borderSide:  const BorderSide(color:Constants.lightGreen, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide:  const BorderSide(color:Constants.lightGreen, width: 1.0),
      ),
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      suffixIcon: suffixIcon,
      suffixIconConstraints: const BoxConstraints(maxHeight: 40,maxWidth: 40,minWidth: 30),
      hintStyle:  const TextStyle(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.w400),
      // suffixIconConstraints: BoxConstraints(maxHeight: 20),
      border: OutlineInputBorder
        (
          borderRadius: BorderRadius.circular(5,),
          borderSide:  const BorderSide(width: 1,color: Constants.lightGreen),gapPadding: 0)
  );
}

InputDecoration inputDecorationBorder(BuildContext context, {Widget? prefixIcon, String? hint,suffixIcon}) {
  return InputDecoration(
      isDense: true,
      contentPadding:  const EdgeInsets.symmetric(horizontal: 9,vertical:10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide:  const BorderSide(color: Colors.grey, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide:  const BorderSide(color:Colors.grey, width: 1.0),
      ),
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      suffixIcon: suffixIcon,
      suffixIconConstraints: const BoxConstraints(maxHeight: 40,maxWidth: 40,minWidth: 30),
      hintStyle:  const TextStyle(color: Colors.grey,fontSize: 12),
      // suffixIconConstraints: BoxConstraints(maxHeight: 20),
      border: OutlineInputBorder
        (
          borderRadius: BorderRadius.circular(5,),
          borderSide:  const BorderSide(width: 1,color: Colors.grey),gapPadding: 0)
  );
}

InputDecoration inputDecorationtransparent(BuildContext context, {Widget? prefixIcon, String? hint,suffixIcon}) {
  return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 9,horizontal: 12),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide:  const BorderSide(color: Colors.grey, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide:  const BorderSide(color: Colors.grey, width: 1.0),
      ),
      filled: true,
      fillColor: Colors.transparent,
      hintText: hint,
      suffixIcon: suffixIcon,
      suffixIconConstraints: const BoxConstraints(maxHeight: 25,maxWidth: 30),
      hintStyle:  const TextStyle(color: Colors.grey),
      // suffixIconConstraints: BoxConstraints(maxHeight: 20),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6,),
          borderSide:  const BorderSide(width: 1,color: Colors.grey),gapPadding: 0)
  );

}


InputDecoration inputDecorationAddAddress(BuildContext context, { String? hint} ) {
  return InputDecoration(
      isDense: true,
      contentPadding:   EdgeInsets.symmetric(horizontal: 12,vertical:12),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:   BorderSide(color: Constants.primaryColor1, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:   BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),

      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      labelText: "$hint",
      labelStyle:  PrimaryColor13500Style ,
      hintStyle:   greyHintStyle,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      // suffixIconConstraints: BoxConstraints(maxHeight: 20),
      border: OutlineInputBorder
        (
          borderRadius: BorderRadius.circular(5,),
          borderSide:  const BorderSide(width: 1,color: Colors.grey),gapPadding: 0)
  );
}

commanInputDecoration({label,hint,suffixIcon,required isOptional}){
  return InputDecoration(
    filled: true,
    fillColor:Colors.white,
    isDense: true,
    hintText: hint,
    hintStyle:AddressHintStyle,
    suffixIcon: suffixIcon,
    floatingLabelAlignment: FloatingLabelAlignment.start,
    // floatingLabelBehavior: FloatingLabelBehavior.always,
    floatingLabelStyle:PrimaryColor13500Style,
    labelStyle: AddressHintStyle,
    label: Text.rich(
        TextSpan (
            text:  "${label}",
            children: [
              TextSpan(text: isOptional ?"": "*",style: PrimaryColor13500Style,),
            ]
        )
    ),
    // Row(
    //   children: [
    //   Flexible(child: Text(lable == null ? "":lable)),
    // //  Text("*",style: TextStyle(color: Colors.red,fontSize: 15),),
    // ],),
    suffixIconConstraints: BoxConstraints(minWidth: 16,maxHeight: 17,minHeight: 16,maxWidth: 30),
    //  label: lable==null?null:Text(lable,style: CommonStyle.hintTextStyle),
    contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5,), borderSide:  const BorderSide(width: 1,color: Color(0xFFd8d9de)),gapPadding: 0),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5,), borderSide:  const BorderSide(width: 1,color: Color(0xFFd8d9de)),gapPadding: 0),
  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5,), borderSide:  const BorderSide(width: 1,color: Color(0xFFd8d9de)),gapPadding: 0)
  );
}


