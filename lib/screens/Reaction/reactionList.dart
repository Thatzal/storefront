import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:socialapps/constant/constatnt.dart';

List<Reaction<String>> flagsReactions = [
  Reaction<String>(
    value: 'like',
    previewIcon: _buildFlagsPreviewIcon(
        'assets/like_reac.png', 'Like'),
    icon: Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18,),
  ),
  Reaction<String>(
    value: 'dislike',
    previewIcon:
    _buildFlagsPreviewIcon('assets/dislike.png', 'Dislike'),
    icon: Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18,),
  ),
];

final defaultInitialReaction = Reaction<String>(
  value: null,
  icon: const Text('No reaction'),
);



Padding _buildFlagsPreviewIcon(String path, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Column(
      children: [


        Image.asset(path, height: 24),
        const SizedBox(height: 2),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}



Image _buildIcon(String path) {
  return Image.asset(
    path,
    height: 22,
    width: 22,
  );
}


