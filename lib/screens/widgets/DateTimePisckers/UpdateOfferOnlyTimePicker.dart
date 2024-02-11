import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/constatnt.dart';

typedef OfferConditionTimePickerConfirmCallback = void Function(DateTime start, String end);

enum UpdateOfferConditionTimePickerMode {
  time,
  date,
  dateAndTime,
}

class UpdateOfferConditionTimePicker {
  final startText;
  final endText;
  final doneText;
  final cancelText;
  final bool use24hFormat;
  final UpdateOfferConditionTimePickerMode mode;
  final type;

  DateTime? initialStartTime;
  DateTime? initialEndTime;
  DateTime? minimumTime;
  DateTime? maximumTime;

  final VoidCallback? onCancel;
  final OfferConditionTimePickerConfirmCallback? onConfirm;

  final int interval;

  UpdateOfferConditionTimePicker({
    Key? key,
    this.startText = "Start",
    this.endText = "End",
    this.doneText = "Done",
    this.cancelText = "Cancel",
    this.mode = UpdateOfferConditionTimePickerMode.dateAndTime,
    this.interval = 15,
    this.use24hFormat = false,
    this.minimumTime,
    this.maximumTime,
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
    initialStartTime = initialStartTime!.subtract(Duration(
        minutes: initialStartTime!.minute, seconds: initialStartTime!.second));

    if (initialEndTime == null) {
      initialEndTime = initialStartTime!.add(Duration(
          days: mode == UpdateOfferConditionTimePickerMode.time ? 0 : 1,
          hours: mode == UpdateOfferConditionTimePickerMode.time ? 2 : 0));
    }

    initialEndTime = initialEndTime!.subtract(Duration(
        minutes: initialEndTime!.minute, seconds: initialEndTime!.second));

    if (minimumTime != null) {
      minimumTime = minimumTime!.subtract(
          Duration(minutes: minimumTime!.minute, seconds: minimumTime!.second));
    }

    if (maximumTime != null) {
      maximumTime = maximumTime!.subtract(
          Duration(minutes: maximumTime!.minute, seconds: maximumTime!.second));
    }

    var pickerMode = CupertinoDatePickerMode.dateAndTime;

    switch (mode) {
      case UpdateOfferConditionTimePickerMode.date:
        {
          pickerMode = CupertinoDatePickerMode.date;
        }
        break;

      case UpdateOfferConditionTimePickerMode.time:
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
            widthFactor: 0.9,
            heightFactor: 0.4,
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
                this.maximumTime!,
                this.use24hFormat,this.type),
          );
        });
  }
}

class PickerWidget extends StatefulWidget {
  final List<Tab> _tabs;
  final int _interval;
  final VoidCallback? _onCancel;
  final OfferConditionTimePickerConfirmCallback? _onConfirm;

  final DateTime _initStart;
  final DateTime _initEnd;
  final CupertinoDatePickerMode _mode;

  final String _doneText;
  final String _cancelText;
  final DateTime _minimumTime;
  final DateTime _maximumTime;
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
      this._minimumTime,
      this._maximumTime,
      this._use24hFormat,this.type,
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
      backgroundColor:ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
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
                    height: ResponsiveHelper.isMobile(context)?180:ResponsiveHelper.TabModeWidth,
                    alignment: Alignment.topCenter,
                    child: TabBarView(
                      controller: _tabController,
                      children: widget._tabs.map((Tab tab) {
                        print(widget.type);
                        return CupertinoDatePicker(

                          mode: widget._mode,
                          dateOrder: DatePickerDateOrder.dmy,
                          use24hFormat: widget._use24hFormat,
                          minuteInterval: widget._interval,
                          minimumDate: tab.text == widget._tabs.first.text ?
                          widget.type.toString().trim() == "Tomorrow" ?
                          DateFormat("yyyy-MM-dd HH:mm:ss").parse("${DateFormat("yyyy-MM-dd").parse(DateTime.now().add(Duration(days: 1)).toString())} 00:00:00"):
                          DateTime.now(): isChangeFromDate?TempFromDateTime: DateTime.now(),
                          initialDateTime:
                          widget.type.toString().trim() == "Tomorrow" ?
                          tab.text == widget._tabs.first.text ? widget._initStart: isChangeFromDate ?TempFromDateTime:widget._initEnd:
                          tab.text == widget._tabs.first.text ? widget._initStart: isChangeFromDate ?TempFromDateTime:widget._initEnd,

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
