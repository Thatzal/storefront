import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

typedef PickerConfirmCallback = void Function(DateTime DateTime);


class OnlyDateTimeRangePicker {

  final PickerConfirmCallback? onConfirm;
  OnlyDateTimeRangePicker({Key? key,this.onConfirm,});

  void showPicker(BuildContext context) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            child:  PickerWidget(onConfirm: this.onConfirm,),
          );
        });
  }
}

class PickerWidget extends StatefulWidget {

  final PickerConfirmCallback? onConfirm;
  PickerWidget({Key? key,this. onConfirm}) : super(key: key);

  _PickerWidgetState createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget>
    with SingleTickerProviderStateMixin {



  @override
  void initState() {
    super.initState();



  }

  @override
  void dispose() {

    super.dispose();
  }
  DateTime TempFromDateTime = DateTime.now();
  DateTime ?TempToDateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        body: Stack(
          children: <Widget>[
            Container(
              height: 180,
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.topCenter,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                dateOrder: DatePickerDateOrder.dmy,
                use24hFormat: false,
                minuteInterval: 1,
                minimumDate:DateTime.now(),
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newDateTime) {

                    setState(() {
                      TempFromDateTime = newDateTime;
                    });

                },
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
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                        widget.onConfirm!(TempFromDateTime);
                    },
                    child: Text("Done"),
                  )
                ],
              ),
            )

          ],
        ));
  }
}
