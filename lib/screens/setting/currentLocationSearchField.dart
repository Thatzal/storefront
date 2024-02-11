import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socialapps/constant/constatnt.dart';

import '../../common/style.dart';

/// Custom Search input field, showing the search and clear icons.
class CurrentLocationSearchInput extends StatefulWidget {
  final ValueChanged<String> onSearchInput;

  CurrentLocationSearchInput(this.onSearchInput);

  @override
  State<StatefulWidget> createState() => CurrentLocationSearchInputState();
}

class CurrentLocationSearchInputState extends State<CurrentLocationSearchInput> {
  TextEditingController editController = TextEditingController();

  Timer? debouncer;

  bool hasSearchEntry = false;

  //SearchInputState();

  @override
  void initState() {
    super.initState();
    this.editController.addListener(this.onSearchInputChange);
  }

  @override
  void dispose() {
    this.editController.removeListener(this.onSearchInputChange);
    this.editController.dispose();

    super.dispose();
  }

  void onSearchInputChange() {
    if (this.editController.text.isEmpty) {
      this.debouncer?.cancel();
      widget.onSearchInput(this.editController.text);
      return;
    }

    if (this.debouncer?.isActive ?? false) {
      this.debouncer?.cancel();
    }

    this.debouncer = Timer(Duration(milliseconds: 500), () {
      widget.onSearchInput(this.editController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(

     margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(

        children: <Widget>[
          Icon(Icons.search, color: Constants.primaryColor1),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search for area,street name...",
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                isDense: true,

                border: InputBorder.none,hintStyle: greyHintStyle,
              ),
              controller: this.editController,
              onChanged: (value) {
                setState(() {
                  this.hasSearchEntry = value.isNotEmpty;
                });
              },
            ),
          ),
          SizedBox(width: 8),
          if (this.hasSearchEntry)
            GestureDetector(
              child: Icon(Icons.clear),
              onTap: () {
                this.editController.clear();
                setState(() {
                  this.hasSearchEntry = false;
                });
              },
            ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFF565454),width: 0.5),
        color: Theme.of(context).canvasColor,
      ),
    );
  }
}
