import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';

showDurationPicker(context,setState,TextEditingController DurationController) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var tabWidth = ResponsiveHelper.TabModeWidth;
  var tabHeight = ResponsiveHelper.TabModeHeight;
  var isMobile= ResponsiveHelper.isMobile(context);
  showDialog(
    context: context, builder: (context) {
      bool isContainYear = DurationController.text.toString().contains("Years");
      bool isContainMonth = DurationController.text.toString().contains("Months");
      bool isContainDay = DurationController.text.toString().contains("Days");
      bool isContainHour = DurationController.text.toString().contains("Hours");
      bool isContainMin = DurationController.text.toString().contains("Minutes");
    String selectedYear = DurationController.text.isEmpty ||DurationController.text == "" ? "0": isContainYear == false? "0": getPreFillValue(DurationController.text," "," Years");
    String selectedMonth = DurationController.text.isEmpty ||DurationController.text == "" ? "0": isContainMonth == false?"0":isContainYear? getPreFillValue(DurationController.text,"Years "," Months"):getPreFillValue(DurationController.text," "," Months");
    String selectedDay = DurationController.text.isEmpty ||DurationController.text == "" ? "0":isContainDay == false?"0":isContainMonth? getPreFillValue(DurationController.text,"Months "," Days"):isContainYear? getPreFillValue(DurationController.text,"Years "," Days"): getPreFillValue(DurationController.text," "," Days");
    String selectedHours = DurationController.text.isEmpty ||DurationController.text == "" ? "0":isContainHour == false?"0": isContainDay?getPreFillValue(DurationController.text,"Days "," Hours"):isContainMonth?getPreFillValue(DurationController.text,"Months "," Hours"):isContainYear?getPreFillValue(DurationController.text,"Years "," Hours"): getPreFillValue(DurationController.text," "," Hours");
    String selectedMin = DurationController.text.isEmpty ||DurationController.text == "" ? "0":isContainMin == false ?"0": isContainHour?getPreFillValue(DurationController.text,"Hours "," Minutes"):isContainDay? getPreFillValue(DurationController.text,"Days"," Minutes"):isContainMonth? getPreFillValue(DurationController.text,"Months"," Minutes"):isContainYear? getPreFillValue(DurationController.text,"Years"," Minutes"): getPreFillValue(DurationController.text," "," Minutes");
  return Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15)
    ),
    child:  Container(
      width:  isMobile ?width*0.9:tabWidth*0.85,
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Select Duration( YY : MM : DD : HH : MI)",style: BlackTitleStyle,),
          ),
          SizedBox(height: 20,),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("YY",style: BlackFieldStyleBold,),
                Text("MM",style: BlackFieldStyleBold,),
                Text("DD",style: BlackFieldStyleBold,),
                Text("HH",style: BlackFieldStyleBold,),
                Text("MI",style: BlackFieldStyleBold,),
              ]),
          Container(
            height: 200,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: CupertinoPicker(
                        scrollController: new FixedExtentScrollController(
                          initialItem: int.parse(selectedYear.toString()),
                        ),

                        itemExtent: 30,
                        backgroundColor: Colors.white,
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            selectedYear = YearList[index];
                          });
                        },
                        children: YearList.map(
                              (item) => Center(
                            child: Text(
                              item,
                              style: BlackHeadingStyle
                            ),
                          ),
                        )
                            .toList()),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                        scrollController: new FixedExtentScrollController(
                          initialItem:  int.parse(selectedMonth.toString()),
                        ),
                        itemExtent: 30,
                        backgroundColor: Colors.white,
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            selectedMonth = MonthList[index];
                          });
                        },
                        children: MonthList
                            .map(
                              (item) => Center(
                            child: Text(
                              item,
                              style:BlackHeadingStyle
                            ),
                          ),
                        )
                            .toList()),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                        scrollController: new FixedExtentScrollController(
                          initialItem: int.parse(selectedDay.toString()),
                        ),
                        itemExtent: 30,
                        backgroundColor: Colors.white,
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            selectedDay = DayList[index];
                          });
                        },
                        children: DayList
                            .map(
                              (item) => Center(
                            child: Text(
                              item,
                              style:BlackHeadingStyle
                            ),
                          ),
                        )
                            .toList()),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                        scrollController: new FixedExtentScrollController(
                          initialItem: int.parse(selectedHours.toString()),
                        ),
                        itemExtent: 30,
                        backgroundColor: Colors.white,
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            selectedHours = HourList[index];
                          });
                        },
                        children: HourList
                            .map(
                              (item) => Center(
                            child: Text(
                              item,
                              style:BlackHeadingStyle
                            ),
                          ),
                        )
                            .toList()),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                        scrollController: new FixedExtentScrollController(
                          initialItem:int.parse(selectedMin.toString()),
                        ),
                        itemExtent: 30,
                        backgroundColor: Colors.white,
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            selectedMin = MinList[index];
                          });
                        },
                        children: MinList
                            .map(
                              (item) => Center(
                            child: Text(
                              item,
                              style: BlackHeadingStyle
                            ),
                          ),
                        )
                            .toList()),
                  ),
                ]),
          ),
          SizedBox(height: 20,),

          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                InkWell(
                    onTap: (){
                      Navigator.pop(context,"");
                    },
                    child: Text("Cancel",style: PrimaryColorStyle16700,)),
                SizedBox(width: 30,),
                InkWell(
                    onTap: (){
                      String Years = selectedYear != "0" ?  "$selectedYear Years" : "";
                      String Months = selectedMonth != "0" ?  "$selectedMonth Months" : "";
                      String Days = selectedDay != "0" ?  "$selectedDay Days" : "";
                      String Hours = selectedHours != "0" ?  "$selectedHours Hours" : "";
                      String Min = selectedMin != "0" ?  "$selectedMin Minutes" : "";
                      String data = " $Years $Months $Days $Hours $Min";
                      //String data = " $selectedYear Years $selectedMonth Months $selectedDay Days $selectedHours Hours $selectedMin Minutes";
                      Navigator.pop(context,data);
                    },
                    child: Text("Done",style: PrimaryColorStyle16700,)),
                SizedBox(width: 20,),

              ]),
          SizedBox(height: 20,),
        ],
      ),
    ),
  );
  }
  ).then((value) {
    setState((){
      if(value == ""){

      }else{
        DurationController.text = value;
      }
    });
    print(value);
  });
}
List <String> YearList = [
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "30",
  "31",
  "32",
  "33",
  "34",
  "35",
  "36",
  "37",
  "37",
  "38",
  "39",
  "40",
  "41",
  "42",
  "43",
  "44",
  "45",
  "46",
  "47",
  "48",
  "49",
  "50",
  "51",
  "52",
  "53",
  "54",
  "55",
  "56",
  "57",
  "58",
  "59",
  "60",
  "61",
  "62",
  "63",
  "64",
  "65",
  "66",
  "67",
  "68",
  "69",
  "70",
  "71",
  "72",
  "73",
  "74",
  "75",
  "76",
  "77",
  "78",
  "79",
  "80",
  "81",
  "82",
  "83",
  "84",
  "85",
  "86",
  "87",
  "88",
  "89",
  "90",
  "91",
  "92",
  "93",
  "94",
  "95",
  "96",
  "97",
  "98",
  "99",
];
List <String> MonthList = [
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11"
];
List <String> DayList   = [
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "30",
  "31"
];
List <String> HourList   = [
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23"
];
List <String> MinList   = [
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "30",
  "31",
  "32",
  "33",
  "34",
  "35",
  "36",
  "37",
  "37",
  "38",
  "39",
  "40",
  "41",
  "42",
  "43",
  "44",
  "45",
  "46",
  "47",
  "48",
  "49",
  "50",
  "51",
  "52",
  "53",
  "54",
  "55",
  "56",
  "57",
  "58",
  "59"
];

String getPreFillValue(FullString,start,end){
  final startIndex = FullString.indexOf(start);
  final endIndex = FullString.indexOf(end);
  final result = FullString.substring(startIndex + start.length, endIndex).trim();
  String value = result.toString();
  return value;
}

showDurationPickerNew(context,setState,setModalState,TextEditingController DurationController) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var tabWidth = ResponsiveHelper.TabModeWidth;
  var tabHeight = ResponsiveHelper.TabModeHeight;
  var isMobile= ResponsiveHelper.isMobile(context);
  showDialog(
      context: context, builder: (context) {
    bool isContainYear = DurationController.text.toString().contains("Years");
    bool isContainMonth = DurationController.text.toString().contains("Months");
    bool isContainDay = DurationController.text.toString().contains("Days");
    bool isContainHour = DurationController.text.toString().contains("Hours");
    bool isContainMin = DurationController.text.toString().contains("Minutes");
    String selectedYear = DurationController.text.isEmpty ||DurationController.text == "" ? "0": isContainYear == false? "0": getPreFillValue(DurationController.text," "," Years");
    String selectedMonth = DurationController.text.isEmpty ||DurationController.text == "" ? "0": isContainMonth == false?"0":isContainYear? getPreFillValue(DurationController.text,"Years "," Months"):getPreFillValue(DurationController.text," "," Months");
    String selectedDay = DurationController.text.isEmpty ||DurationController.text == "" ? "0":isContainDay == false?"0":isContainMonth? getPreFillValue(DurationController.text,"Months "," Days"):isContainYear? getPreFillValue(DurationController.text,"Years "," Days"): getPreFillValue(DurationController.text," "," Days");
    String selectedHours = DurationController.text.isEmpty ||DurationController.text == "" ? "0":isContainHour == false?"0": isContainDay?getPreFillValue(DurationController.text,"Days "," Hours"):isContainMonth?getPreFillValue(DurationController.text,"Months "," Hours"):isContainYear?getPreFillValue(DurationController.text,"Years "," Hours"): getPreFillValue(DurationController.text," "," Hours");
    String selectedMin = DurationController.text.isEmpty ||DurationController.text == "" ? "0":isContainMin == false ?"0": isContainHour?getPreFillValue(DurationController.text,"Hours "," Minutes"):isContainDay? getPreFillValue(DurationController.text,"Days"," Minutes"):isContainMonth? getPreFillValue(DurationController.text,"Months"," Minutes"):isContainYear? getPreFillValue(DurationController.text,"Years"," Minutes"): getPreFillValue(DurationController.text," "," Minutes");
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child:  Container(
        width:  isMobile ?width*0.9:tabWidth*0.85,
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("Select Duration( YY : MM : DD : HH : MI)",style: BlackTitleStyle,),
            ),
            SizedBox(height: 20,),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("YY",style: BlackFieldStyleBold,),
                  Text("MM",style: BlackFieldStyleBold,),
                  Text("DD",style: BlackFieldStyleBold,),
                  Text("HH",style: BlackFieldStyleBold,),
                  Text("MI",style: BlackFieldStyleBold,),
                ]),
            Container(
              height: 200,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: CupertinoPicker(
                          scrollController: new FixedExtentScrollController(
                            initialItem: int.parse(selectedYear.toString()),
                          ),

                          itemExtent: 30,
                          backgroundColor: Colors.white,
                          onSelectedItemChanged: (int index) {
                            setState(() {
                              selectedYear = YearList[index];
                            });setModalState((){});
                          },
                          children: YearList.map(
                                (item) => Center(
                              child: Text(
                                  item,
                                  style: BlackHeadingStyle
                              ),
                            ),
                          )
                              .toList()),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                          scrollController: new FixedExtentScrollController(
                            initialItem:  int.parse(selectedMonth.toString()),
                          ),
                          itemExtent: 30,
                          backgroundColor: Colors.white,
                          onSelectedItemChanged: (int index) {
                            setState(() {
                              selectedMonth = MonthList[index];
                            });setModalState((){});
                          },
                          children: MonthList
                              .map(
                                (item) => Center(
                              child: Text(
                                  item,
                                  style:BlackHeadingStyle
                              ),
                            ),
                          )
                              .toList()),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                          scrollController: new FixedExtentScrollController(
                            initialItem: int.parse(selectedDay.toString()),
                          ),
                          itemExtent: 30,
                          backgroundColor: Colors.white,
                          onSelectedItemChanged: (int index) {
                            setState(() {
                              selectedDay = DayList[index];
                            });setModalState((){});
                          },
                          children: DayList
                              .map(
                                (item) => Center(
                              child: Text(
                                  item,
                                  style:BlackHeadingStyle
                              ),
                            ),
                          )
                              .toList()),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                          scrollController: new FixedExtentScrollController(
                            initialItem: int.parse(selectedHours.toString()),
                          ),
                          itemExtent: 30,
                          backgroundColor: Colors.white,
                          onSelectedItemChanged: (int index) {
                            setState(() {
                              selectedHours = HourList[index];
                            });setModalState((){});
                          },
                          children: HourList
                              .map(
                                (item) => Center(
                              child: Text(
                                  item,
                                  style:BlackHeadingStyle
                              ),
                            ),
                          )
                              .toList()),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                          scrollController: new FixedExtentScrollController(
                            initialItem:int.parse(selectedMin.toString()),
                          ),
                          itemExtent: 30,
                          backgroundColor: Colors.white,
                          onSelectedItemChanged: (int index) {
                            setState(() {
                              selectedMin = MinList[index];
                            });setModalState((){});
                          },
                          children: MinList
                              .map(
                                (item) => Center(
                              child: Text(
                                  item,
                                  style: BlackHeadingStyle
                              ),
                            ),
                          )
                              .toList()),
                    ),
                  ]),
            ),
            SizedBox(height: 20,),

            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  InkWell(
                      onTap: (){
                        Navigator.pop(context,"");
                      },
                      child: Text("Cancel",style: PrimaryColorStyle16700,)),
                  SizedBox(width: 30,),
                  InkWell(
                      onTap: (){
                        String Years = selectedYear != "0" ?  "$selectedYear Years" : "";
                        String Months = selectedMonth != "0" ?  "$selectedMonth Months" : "";
                        String Days = selectedDay != "0" ?  "$selectedDay Days" : "";
                        String Hours = selectedHours != "0" ?  "$selectedHours Hours" : "";
                        String Min = selectedMin != "0" ?  "$selectedMin Minutes" : "";
                        String data = " $Years $Months $Days $Hours $Min";
                        //String data = " $selectedYear Years $selectedMonth Months $selectedDay Days $selectedHours Hours $selectedMin Minutes";
                        Navigator.pop(context,data);
                      },
                      child: Text("Done",style: PrimaryColorStyle16700,)),
                  SizedBox(width: 20,),

                ]),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
  ).then((value) {
    setState((){
      if(value == ""){

      }else{
        DurationController.text = value;
      }
    });setModalState((){});
    print(value);
  });
}