import 'package:flutter/material.dart';

import '../../common/style.dart';

class CurrentLocationSelectPlaceAction extends StatelessWidget {
  final String locationName;
  final String tapToSelectActionText;
  final VoidCallback onTap;

  CurrentLocationSelectPlaceAction(this.locationName, this.onTap, this.tapToSelectActionText);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.location_pin,color: Colors.red,size: 32,),
              SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(locationName, style: BlackHeadingStyle),
                    Text(this.tapToSelectActionText, style: greyHintStyle),
                  ],
                ),
              ),
             // Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }
}
