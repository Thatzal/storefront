import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

typedef PickerConfirmCallbackItemTime = void Function(DateTime start, String end);

enum DateTimeRangePickerModeItemLavelTime {
  time,
  date,
  dateAndTime,
}

class DateTimeRangePickerItemLavelTime {
  final startText;
  final endText;
  final doneText;
  final cancelText;
  final bool use24hFormat;
  final DateTimeRangePickerModeItemLavelTime mode;
  final type;

  DateTime? initialStartTime;
  DateTime? initialEndTime;
  DateTime? minimumTime;
  DateTime? maximumFromTime;
  DateTime? maximumToTime;

  final VoidCallback? onCancel;
  final PickerConfirmCallbackItemTime? onConfirm;

  final int interval;

  DateTimeRangePickerItemLavelTime({
    Key? key,
    this.startText = "Start",
    this.endText = "End",
    this.doneText = "Done",
    this.cancelText = "Cancel",
    this.mode = DateTimeRangePickerModeItemLavelTime.dateAndTime,
    this.interval = 15,
    this.use24hFormat = false,
    this.minimumTime,
    this.maximumFromTime,
    this.maximumToTime,
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
          days: mode == DateTimeRangePickerModeItemLavelTime.time ? 0 : 1,
          hours: mode == DateTimeRangePickerModeItemLavelTime.time ? 2 : 0));
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
      case DateTimeRangePickerModeItemLavelTime.date:
        {
          pickerMode = CupertinoDatePickerMode.date;
        }
        break;

      case DateTimeRangePickerModeItemLavelTime.time:
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
                this.maximumFromTime!,
                this.maximumToTime!,
                this.use24hFormat,
                this.type),
          );
        });
  }
}

class PickerWidget extends StatefulWidget {
  final List<Tab> _tabs;
  final int _interval;
  final VoidCallback? _onCancel;
  final PickerConfirmCallbackItemTime? _onConfirm;

  final DateTime _initStart;
  final DateTime _initEnd;
  final CupertinoDatePickerMode _mode;

  final String _doneText;
  final String _cancelText;
  final DateTime _minimumTime;
  final DateTime _maximumFromTime;
  final DateTime _maximumToTime;
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
      this._maximumFromTime,
      this._maximumToTime,
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
  bool isChangeFromDate =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.topCenter,
              child: TabBarView(
                controller: _tabController,
                children: widget._tabs.map((Tab tab) {
                   print(widget._maximumFromTime);
                   print(widget._maximumToTime);
                   print(widget._minimumTime);
                  return CupertinoDatePicker(
                    mode: widget._mode,
                    dateOrder: DatePickerDateOrder.dmy,
                    use24hFormat: widget._use24hFormat,
                    minuteInterval: widget._interval,

                    minimumDate:  tab.text == widget._tabs.first.text ?
                    widget._maximumFromTime:
                    isChangeFromDate?TempFromDateTime:widget._maximumToTime,

                    maximumDate: widget._maximumToTime,

                    initialDateTime: widget.type.toString().trim() == "Today" ?
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
        ));
  }
}
