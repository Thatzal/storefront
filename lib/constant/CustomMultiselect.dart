library custom_searchable_dropdown;



import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';


// ignore: must_be_immutable
class CustomSearchableDropDownForUs extends StatefulWidget {
  List items=[];
  List? initialValue;
  double? searchBarHeight;
  Color? primaryColor;
  Color? backgroundColor;
  Color? dropdownBackgroundColor;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? menuPadding;
  String? label;
  String? dropdownHintText;
  TextStyle? labelStyle;
  TextStyle? dropdownItemStyle;
  String? hint='';
  String? multiSelectTag;
  int? initialIndex;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool? hideSearch;
  bool? enabled;
  bool? showClearButton;
  bool? menuMode;
  double? menuHeight;
  bool? multiSelect;
  bool? multiSelectValuesAsWidget;
  bool? showLabelInMenu;
  String? itemOnDialogueBox;
  Decoration? decoration;
  List dropDownMenuItems=[];
  final TextAlign? labelAlign;
  final ValueChanged onChanged;

  CustomSearchableDropDownForUs({
    required this.items,
    required this.label,
    required this.onChanged,
    this.hint,
    this.initialValue,
    this.labelAlign,
    this.searchBarHeight,
    this.primaryColor,
    this.padding,
    this.menuPadding,
    this.labelStyle,
    this.enabled,
    this.showClearButton,
    this.itemOnDialogueBox,
    required this.dropDownMenuItems,
    this.prefixIcon,
    this.suffixIcon,
    this.menuMode,
    this.menuHeight,
    this.initialIndex,
    this.multiSelect,
    this.multiSelectTag,
    this.multiSelectValuesAsWidget,
    this.hideSearch,
    this.decoration,
    this.showLabelInMenu,
    this.dropdownItemStyle,
    this.backgroundColor,
    this.dropdownBackgroundColor,
    this.dropdownHintText,
  });

  @override
  _CustomSearchableDropDownForUsState createState() => _CustomSearchableDropDownForUsState();
}

class _CustomSearchableDropDownForUsState extends State<CustomSearchableDropDownForUs>
    with WidgetsBindingObserver, TickerProviderStateMixin {



  String onSelectLabel='';
  final searchC = TextEditingController();
  List  menuData = [];
  List  mainDataListGroup = [];
  List  newDataList = [];

  List selectedValues=[];

  late AnimationController _menuController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _menuController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

  }


  @override
  Widget build(BuildContext context) {
    if(widget.initialIndex!=null && widget.dropDownMenuItems.isNotEmpty)
    {
      onSelectLabel=widget.dropDownMenuItems[widget.initialIndex!].toString();
    }


    if(widget.multiSelect?? false){
      if(selectedValues.isEmpty)
      {
        if(widget.initialValue!=null && widget.items.isNotEmpty)
        {

          if(widget.initialValue!=null && widget.initialValue!.isNotEmpty)
          {
            selectedValues.clear();
          }

          for(int i=0;i<widget.items.length; i++)
          {

            for(int j=0;j<widget.initialValue!.length; j++) {
              if(widget.initialValue!=null && widget.initialValue!.isNotEmpty)
              {
                if (widget.initialValue![j].toString().trim() == widget.items[i].id.toString().trim()) {
                  setState(() {
                    selectedValues.add(widget.dropDownMenuItems[i].toString() + '-_-' + i.toString());
                  });
                }
              }
            }
          }
        }
      }
    }
    else{
      if(onSelectLabel=='')
      {
        if(widget.initialValue!=null && widget.items.isNotEmpty)
        {


          for(int i=0;i<widget.items.length; i++)
          {

            if(widget.initialValue!=null && widget.initialValue!.isNotEmpty)
            {
              if(widget.initialValue![0]['value']==widget.items[i][widget.initialValue![0]['parameter']]){
                onSelectLabel=widget.dropDownMenuItems[i].toString();
                setState(() {

                });
              }
            }

          }
        }
      }

    }




    if(widget.items.isEmpty)
    {
      onSelectLabel='';
      selectedValues.clear();
      widget.onChanged(null);
      setState(() {

      });
    }
    return  Column(
      children: [
        Stack(
          children: [
            Container(
              height: 38,

              decoration: widget.decoration,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: widget.backgroundColor,
                    primary: widget.primaryColor?? Colors.black,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                child: Padding(
                  padding: widget.padding?? EdgeInsets.only(left: 5),
                  child: Row(
                    children: [
                      widget.prefixIcon?? Container(),
                      ((widget.multiSelect==true && widget.multiSelect!=null) && selectedValues.isNotEmpty)?
                      Expanded(
                          child: (widget.multiSelectValuesAsWidget==true && widget.multiSelectValuesAsWidget!=null)?
                          Wrap(
                            children: List.generate(
                              selectedValues.length,
                                  (index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(5,0,5,0),
                                  child: Container(
                                    decoration: new BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:  BorderRadius.all(Radius.circular(5.0),)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(5,5,5,5),
                                      child: Text(selectedValues[index].split('-_-')[0].toString(),
                                        style: widget.labelStyle??TextStyle(
                                            color: Colors.white,
                                            fontSize: 12
                                        ),),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                              :Text(selectedValues.length==1? widget.multiSelectTag==null?  selectedValues.length.toString()+' values selected': selectedValues.length.toString()+' '+widget.multiSelectTag!+' selected':
                          widget.multiSelectTag==null?  selectedValues.length.toString()+' values selected': selectedValues.length.toString()+' '+widget.multiSelectTag!+' selected',
                            style: widget.labelStyle??TextStyle(
                                color: Colors.grey
                            ),)
                      ):
                      Expanded(child: Text(onSelectLabel==''? widget.label==null?
                      'Select Value':widget.label!:onSelectLabel,
                        textAlign: widget.labelAlign??TextAlign.start,
                        style:  widget.labelStyle!=null?  widget.labelStyle!.copyWith(
                          color: onSelectLabel==''? Colors.grey[600]:null,
                        ):TextStyle(
                          color: onSelectLabel==''? Colors.grey[600]:Colors.grey[800],
                        ),)),
                      Visibility(
                          visible: (widget.showClearButton!=null && widget.showClearButton==true && onSelectLabel!=null),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                primary: widget.primaryColor?? Colors.black

                            ),
                            child: Icon(Icons.clear,),
                            onPressed: (){
                              widget.onChanged(null);
                              onSelectLabel='';
                              setState(() {

                              });
                            },
                          )),
                      widget.suffixIcon?? Icon(Icons.arrow_drop_down,
                        color: widget.primaryColor?? Colors.black,)
                    ],
                  ),
                ),
                onPressed: (){
                  if(widget.enabled==null || widget.enabled==true)
                  {
                    menuData.clear();
                    if(widget.items.isNotEmpty)
                    {
                      for(int i=0; i<widget.dropDownMenuItems.length; i++)
                      {
                        menuData.add(widget.dropDownMenuItems[i].toString()+'-_-'+i.toString());
                      }
                      mainDataListGroup=menuData;
                      newDataList=mainDataListGroup;
                      searchC.clear();
                      if(widget.menuMode!=null && widget.menuMode==true)
                      {
                        if (_menuController.value !=1) {
                          _menuController.forward();
                        } else {
                          _menuController.reverse();
                        }
                      }
                      else{
                        showDialogueBox(context);
                      }
                    }
                  }
                  setState(() {

                  });
                },
              ),
            ),
            SizeTransition(
              sizeFactor: _menuController,
              child: searchBox(setState),
            )
          ],
        ),
        Visibility(
            visible: (widget.menuMode?? false),
            child: _shoeMenuMode()),
      ],
    );
  }




  Widget _shoeMenuMode() {
    return SizeTransition(
      sizeFactor: _menuController,
      child: mainScreen(setState),
    );
  }

  Future<void> showDialogueBox(context) async{

    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          var width = MediaQuery.of(context).size.width;
          var height = MediaQuery.of(context).size.height;
          var tabWidth = ResponsiveHelper.TabModeWidth;
          var tabHeight = ResponsiveHelper.TabModeHeight;
          var isMobile= ResponsiveHelper.isMobile(context);
          return Container(

            width: ResponsiveHelper.isMobile(context)?width*0.95:ResponsiveHelper.TabModeWidth*0.95,
            child: Padding(
              padding: widget.menuPadding?? EdgeInsets.all( 15),
              child: StatefulBuilder(
                  builder: (context,setState)
                  {
                    return Material(
                      color: Colors.transparent,
                      child: mainScreen(setState),
                    );
                  }

              ),
            ),
          );
        }).then((valueFromDialog){
      // use the value as you wish
      setState(() {

      });
    });
  }

  mainScreen(setState){
    return Padding(
      padding: widget.menuPadding?? EdgeInsets.all( 0),
      child: Container(
        color: Colors.white,
        width: ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width*0.95:ResponsiveHelper.TabModeWidth*0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Visibility(
                visible: ((widget.showLabelInMenu?? false) &&widget.label!=null),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.label.toString(),
                    style:  widget.labelStyle!=null?
                    widget.labelStyle!.copyWith(
                      color: widget.primaryColor?? Colors.blue,
                    )
                        :TextStyle(
                      color: widget.primaryColor?? Colors.blue,
                    ),),
                )
            ),
            Visibility(
                visible: widget.multiSelect?? false,
                child: Row(
                  children: [
                    // TextButton(
                    //   style: TextButton.styleFrom(
                    //       primary: widget.primaryColor??Colors.black,
                    //       tapTargetSize: MaterialTapTargetSize.shrinkWrap
                    //   ),
                    //   child: Text('Select All',
                    //     style:  widget.labelStyle!=null?
                    //     widget.labelStyle!.copyWith(
                    //       color: widget.primaryColor?? Colors.blue,
                    //     )
                    //         :TextStyle(
                    //       color: widget.primaryColor?? Colors.blue,
                    //     ),),
                    //   onPressed: (){
                    //     selectedValues.clear();
                    //     for(int i=0; i<newDataList.length; i++)
                    //     {
                    //       selectedValues.add(newDataList[i]);
                    //     }
                    //     setState(() {
                    //     });
                    //   },
                    // ),
                    TextButton(
                      style: TextButton.styleFrom(
                          primary: widget.primaryColor??Colors.black,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap
                      ),
                      child: Text('Clear All',
                        style:  widget.labelStyle!=null?
                        widget.labelStyle!.copyWith(
                          color: widget.primaryColor?? Colors.blue,
                        )
                            :TextStyle(
                          color: widget.primaryColor?? Colors.blue,
                        ),),
                      onPressed: (){
                        setState(() {
                          selectedValues.clear();
                        });
                      },
                    ),
                  ],
                )
            ),
            Visibility(
              visible: !(widget.menuMode?? false),
              child:  searchBox(setState),
            ),
            (widget.menuMode?? false)? SizedBox(
              height: widget.menuHeight??150,
              child: mainList(setState),
            ):Expanded(
              child: mainList(setState),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      primary: widget.primaryColor??Colors.black,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap
                  ),
                  child: Text('Close',
                    style:  widget.labelStyle!=null?
                    widget.labelStyle!.copyWith(
                      color: widget.primaryColor?? Colors.blue,
                    )
                        :TextStyle(
                      color: widget.primaryColor?? Colors.blue,
                    ),),
                  onPressed: (){
                    if( widget.menuMode?? false)
                    {
                      _menuController.reverse();
                    }
                    else{
                      Navigator.pop(context);
                    }
                    setState((){

                    });
                  },
                ),
                Visibility(
                  visible: (widget.multiSelect?? false),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: widget.primaryColor??Colors.black,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap
                    ),
                    child: Text('Done',
                      style:  widget.labelStyle!=null?
                      widget.labelStyle!.copyWith(
                        color: widget.primaryColor?? Colors.blue,
                      )
                          :TextStyle(
                        color: widget.primaryColor?? Colors.blue,
                      ),),
                    onPressed: (){
                      // Navigator.pop(context);
                      // setState((){
                      //
                      // });
                      var sendList=[];
                      for( int i=0; i<menuData.length; i++)
                      {
                        if(selectedValues.contains(menuData[i]))
                        {
                          sendList.add(widget.items[i]);
                        }
                      }
                      widget.onChanged(jsonEncode(sendList));
                      if( widget.menuMode?? false)
                      {
                        _menuController.reverse();
                      }
                      else{
                        Navigator.pop(context);
                      }
                      setState((){

                      });
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }





  searchBox(setState){
    return  Visibility(
      visible: widget.hideSearch==null? true:!widget.hideSearch!,
      child: SizedBox(
        height: widget.searchBarHeight,
        child: Padding(
          padding:  EdgeInsets.all((widget.menuMode?? false)? 0.0:8.0),
          child: TextField(
            controller: searchC,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                    color: widget.primaryColor??Colors.grey,
                    width: 2
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                    color: widget.primaryColor??Colors.grey,
                    width: 2
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                    color: widget.primaryColor??Colors.grey,
                    width: 2
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                    color: widget.primaryColor??Colors.grey,
                    width: 2
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                    color: widget.primaryColor??Colors.grey,
                    width: 2
                ),
              ),
              suffixIcon: Icon(Icons.search,
                color: widget.primaryColor?? Colors.black,),
              contentPadding: EdgeInsets.all(8),
              hintText: widget.dropdownHintText?? 'Search Here...',
              isDense: true,

            ),
            onChanged:(v){
              onItemChanged(v);
              setState((){

              });
            },
          ),
        ),
      ),
    );
  }


  mainList(setState){
    return Scrollbar(
      child: Container(
        color: widget.dropdownBackgroundColor,
        child: ListView.builder
          (
            padding: EdgeInsets.zero,
            itemCount: newDataList.length,
            itemBuilder: (BuildContext context, int index) {
              return TextButton(
                style: TextButton.styleFrom(
                    primary: widget.primaryColor?? Colors.black,
                    padding: EdgeInsets.all(8),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8,0,8,0),
                  child: Row(
                    children: [
                      Visibility(
                        visible: widget.multiSelect?? false,
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,8,0,),
                            child: Checkbox(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: selectedValues.contains(newDataList[index])? true: false,
                                activeColor: primaryColor,
                                onChanged:(newValue){

                                  if(selectedValues.contains("NOT NEEDED-_-1")){
                                    if(selectedValues.contains(newDataList[index])){
                                      setState(() {
                                        selectedValues.remove(newDataList[index]);
                                      });
                                    }else{
                                      Constants.showToast("You select 'NOT NEEDED' now not allowed to select service person");
                                    }

                                  }else if(selectedValues.contains("NEEDED-_-0")){
                                    if(selectedValues.contains(newDataList[index])){
                                      setState(() {
                                        selectedValues.remove(newDataList[index]);
                                      });
                                    }else{
                                      Constants.showToast("You select 'NEEDED' now not allowed to select service person");
                                    }
                                  }else{
                                    if(selectedValues.contains(newDataList[index])){
                                      setState(() {
                                        selectedValues.remove(newDataList[index]);
                                      });
                                    }
                                    else{
                                      if( selectedValues.length == 5){
                                        Constants.showToast("Maximum 5 Service / Delivery person are allowed");
                                      }else{
                                        if(newDataList[index] == "NEEDED-_-0" ||  newDataList[index] == "NOT NEEDED-_-1" ){
                                          if(selectedValues.isEmpty){
                                            selectedValues.add(newDataList[index]);
                                          }else{
                                            Constants.showToast("With Service / Delivery person NEEDED or NOT NEEDED are not allowed");
                                          }
                                        }else{
                                          selectedValues.add(newDataList[index]);
                                        }
                                      }
                                    }
                                  }

                                  setState((){

                                  });
                                }),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(newDataList[index].split('-_-')[0].toString(),
                          style: widget.dropdownItemStyle??TextStyle(
                              color: Colors.grey[700]
                          ),),
                      ),
                    ],
                  ),
                ),
                onPressed: () {


                  if(selectedValues.contains("NOT NEEDED-_-1")){
                    if(selectedValues.contains(newDataList[index])){
                      setState(() {
                        selectedValues.remove(newDataList[index]);
                      });
                    }else{
                      Constants.showToast("You select 'NOT NEEDED' now not allowed to select service person");
                    }

                  }else if(selectedValues.contains("NEEDED-_-0")){
                    if(selectedValues.contains(newDataList[index])){
                      setState(() {
                        selectedValues.remove(newDataList[index]);
                      });
                    }else{
                      Constants.showToast("You select 'NEEDED' now not allowed to select service person");
                    }
                  }else{
                    if(selectedValues.contains(newDataList[index])){
                      setState(() {
                        selectedValues.remove(newDataList[index]);
                      });
                    }
                    else{
                      if( selectedValues.length == 5){
                        Constants.showToast("Maximum 5 Service / Delivery person are allowed");
                      }else{
                        if(newDataList[index] == "NEEDED-_-0" ||  newDataList[index] == "NOT NEEDED-_-1" ){
                            if(selectedValues.isEmpty){
                              selectedValues.add(newDataList[index]);
                            }else{
                              Constants.showToast("With Service / Delivery person NEEDED or NOT NEEDED are not allowed");
                            }
                        }else{
                          selectedValues.add(newDataList[index]);
                        }
                      }
                    }
                  }

                  setState((){

                  });
                },
              );
            }
        ),
      ),
    );
  }



  onItemChanged(String value) {
    setState(() {
      newDataList = mainDataListGroup.where((string) => string.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }


}





