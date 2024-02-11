import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';



typedef PickerConfirmCallback = void Function(DateTime start, String end);

enum ItemDatePickerMode {
  time,
  date,
  dateAndTime,
}

class ItemDatePicker {
  final startText;
  final endText;
  final doneText;
  final cancelText;
  final bool use24hFormat;
  final ItemDatePickerMode mode;
  DateTime? initialStartTime;
  DateTime? initialEndTime;
  DateTime? minimumTime;
  DateTime? maximumFromTime;
  DateTime? maximumToTime;
  final VoidCallback? onCancel;
  final PickerConfirmCallback? onConfirm;

  final int interval;

  ItemDatePicker({
    Key? key,
    this.startText = "Start",
    this.endText = "End",
    this.doneText = "Done",
    this.cancelText = "Cancel",
    this.mode = ItemDatePickerMode.dateAndTime,
    this.interval = 15,
    this.use24hFormat = false,

    this.initialStartTime,
    this.initialEndTime,
    this.minimumTime,
    this.maximumFromTime,
    this.maximumToTime,
    this.onCancel,
    this.onConfirm

  });

  void showPicker(BuildContext context) {
    if (initialStartTime == null) {
      initialStartTime = DateTime.now();
    }

    // Remove minutes and seconds to prevent exception of cupertino picker: initial minute is not divisible by minute interval
    initialStartTime = initialStartTime!.subtract(Duration(
        minutes: initialStartTime!.minute, seconds: initialStartTime!.second));

    if (initialEndTime == null) {
      initialEndTime = initialStartTime!.add(Duration(
          days: mode == ItemDatePickerMode.time ? 0 : 1,
          hours: mode == ItemDatePickerMode.time ? 2 : 0));
    }

    initialEndTime = initialEndTime!.subtract(Duration(
        minutes: initialEndTime!.minute, seconds: initialEndTime!.second));

    if (minimumTime != null) {
      minimumTime = minimumTime!.subtract(
          Duration(minutes: minimumTime!.minute, seconds: minimumTime!.second));
    }

    if (maximumFromTime != null) {
      maximumFromTime = maximumFromTime!.subtract(
          Duration(minutes: maximumFromTime!.minute, seconds: maximumFromTime!.second));
    }

    if (maximumToTime != null) {
      maximumToTime = maximumToTime!.subtract(
          Duration(minutes: maximumToTime!.minute, seconds: maximumToTime!.second));
    }

    var pickerMode = CupertinoDatePickerMode.dateAndTime;

    switch (mode) {
      case ItemDatePickerMode.date:
        {
          pickerMode = CupertinoDatePickerMode.date;
        }
        break;

      case ItemDatePickerMode.time:
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
                this.minimumTime!,
                this.maximumFromTime!,
                this.maximumToTime!,
                this.use24hFormat),
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
  final DateTime _minimumTime;
  final DateTime _maximumFromTime;
  final DateTime _maximumToTime;
  final bool _use24hFormat;


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
      this._minimumTime,
      this._maximumFromTime,
      this._maximumToTime,
      this._use24hFormat,
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
                            mode: CupertinoDatePickerMode.date,
                            dateOrder: DatePickerDateOrder.dmy,
                            minuteInterval: widget._interval,
                            minimumDate:  tab.text == widget._tabs.first.text ?
                            widget._maximumFromTime:
                            isChangeFromDate?TempFromDateTime:widget._maximumFromTime,
                            maximumDate: widget._maximumToTime,
                            initialDateTime:tab.text == widget._tabs.first.text?widget._initStart:isChangeFromDate?TempFromDateTime:widget._initEnd ,
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
