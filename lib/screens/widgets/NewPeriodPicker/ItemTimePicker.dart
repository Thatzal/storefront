import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';



typedef PickerConfirmCallback = void Function(DateTime start, String end);

enum ItemTimePickerMode {
  time,
  date,
  dateAndTime,
}

class ItemTimePicker {
  final startText;
  final endText;
  final doneText;
  final cancelText;
  final bool use24hFormat;
  final ItemTimePickerMode mode;
  DateTime? initialStartTime;
  DateTime? initialEndTime;

  final VoidCallback? onCancel;
  final PickerConfirmCallback? onConfirm;
  final int interval;
  final type;

  ItemTimePicker({
    Key? key,
    this.startText = "Start",
    this.endText = "End",
    this.doneText = "Done",
    this.cancelText = "Cancel",
    this.mode = ItemTimePickerMode.dateAndTime,
    this.interval = 15,
    this.use24hFormat = false,

    this.initialStartTime,
    this.initialEndTime,
    this.onCancel,
    this.onConfirm,this.type

  });

  void showPicker(BuildContext context) {
    if (initialStartTime == null) {
      initialStartTime = DateTime.now();
    }

    // Remove minutes and seconds to prevent exception of cupertino picker: initial minute is not divisible by minute interval
    initialStartTime = initialStartTime;
    if (initialEndTime == null) {
      initialEndTime = initialStartTime!.add(Duration(
          days: mode == ItemTimePickerMode.time ? 0 : 1,
          hours: mode == ItemTimePickerMode.time ? 2 : 0));
    }

    initialEndTime = initialEndTime;


    var pickerMode = CupertinoDatePickerMode.dateAndTime;

    switch (mode) {
      case ItemTimePickerMode.date:
        {
          pickerMode = CupertinoDatePickerMode.date;
        }
        break;

      case ItemTimePickerMode.time:
        {
          pickerMode = CupertinoDatePickerMode.time;
        }
        break;

      default:
        {
          pickerMode = CupertinoDatePickerMode.dateAndTime;
        }
        break;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            widthFactor: ResponsiveHelper.isMobile(context)?0.9:ResponsiveHelper.TabModeWidth*0.5,
            heightFactor:  ResponsiveHelper.isMobile(context)?0.4:0.6,
            child: PickerWidget([
              Tab(text: startText),
              Tab(text: endText),
            ],
                initialStartTime!,
                initialEndTime!,
                interval,
                this.onCancel,
                this.onConfirm,
                pickerMode,
                this.doneText,
                this.cancelText,
                this.use24hFormat,this.type),
          );
        });
  }
}

class PickerWidget extends StatefulWidget {
  final List<Tab> _tabs;
  final int _interval;
  final VoidCallback? _onCancel;
  final PickerConfirmCallback? _onConfirm;

  final DateTime _initStart;
  final DateTime _initEnd;
  final CupertinoDatePickerMode _mode;

  final String _doneText;
  final String _cancelText;

  final bool _use24hFormat;
  final type;

  PickerWidget(
      this._tabs,
      this._initStart,
      this._initEnd,
      this._interval,
      this._onCancel,
      this._onConfirm,
      this._mode,
      this._doneText,
      this._cancelText,
      this._use24hFormat,
      this.type,
      {Key? key})
      : super(key: key);

  _PickerWidgetState createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;


  @override
  void initState() {
    super.initState();


    _tabController = TabController(vsync: this, length: widget._tabs.length);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
  DateTime TempFromDateTime = DateTime.now();
  DateTime ?TempToDateTime;
  bool isChangeFromDate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 2,
                title: Container(
                  child: TabBar(
                    controller: _tabController,
                    tabs: widget._tabs,
                    labelColor: Theme.of(context).primaryColor,
                    indicatorColor: Theme.of(context).primaryColor ,
                  ),
                ),
              ),
              body: Stack(
                children: <Widget>[
                  Container(
                    height: 180,
                    width: ResponsiveHelper.isMobile(context)?null:ResponsiveHelper.TabModeWidth,
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.topCenter,
                    child: TabBarView(
                      controller: _tabController,
                      children: widget._tabs.map((Tab tab) {

                        return CupertinoTheme(
                          data: CupertinoThemeData(
                            textTheme: CupertinoTextThemeData(
                                dateTimePickerTextStyle: BlackBottomHeadStyle18500
                            ),
                          ),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            dateOrder: DatePickerDateOrder.dmy,
                            minuteInterval: widget._interval,
                            minimumDate: widget.type == "Today" ? tab.text == widget._tabs.first.text ? DateTime.now(): isChangeFromDate?TempFromDateTime:DateTime.now().add(Duration(hours: 1)):
                            DateFormat("yyyy-MM-dd HH:mm:ss").parse("${DateFormat("yyyy-MM-dd").parse(DateTime.now().toString())} 00:00:00")
                            ,
                            maximumDate: DateFormat("yyyy-MM-dd HH:mm:ss").parse("${DateFormat("yyyy-MM-dd").parse(DateTime.now().add(Duration(days: 1)).toString())} 00:00:00"),
                            initialDateTime:tab.text == widget._tabs.first.text?widget._initStart:isChangeFromDate?TempFromDateTime:widget._initEnd ,
                            use24hFormat: false,
                            onDateTimeChanged: (DateTime newDateTime) {
                              if (tab.text == widget._tabs.first.text) {
                                setState(() {
                                  isChangeFromDate = true;
                                  TempFromDateTime = newDateTime;
                                });
                              } else {
                                setState(() {
                                  TempToDateTime = newDateTime;
                                });
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            if (widget._onCancel != null) {
                              widget._onCancel!();
                            }
                          },
                          child: Text(widget._cancelText),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (widget._onConfirm != null) {
                              widget._onConfirm!(TempFromDateTime,TempToDateTime==null? "NotPick":TempToDateTime.toString());
                            }
                          },
                          child: Text(widget._doneText),
                        )
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
