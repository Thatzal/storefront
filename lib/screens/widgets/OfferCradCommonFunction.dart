
import 'package:intl/intl.dart';



String OfferCreateTime(String date){

  final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${date}');
  final currentTime = DateTime.now();
  final diff_dy = currentTime.difference(startTime).inDays;
  int years = diff_dy ~/ 365;
  int months = (diff_dy-years*365) ~/ 30;
  final diff_mi = currentTime.difference(startTime).inMinutes;
  final diff_s = currentTime.difference(startTime).inSeconds;
  final diff_hr = currentTime.difference(startTime).inHours;
  return diff_s <= 60? "$diff_s""s":
  diff_mi <= 60 ?"$diff_mi""mi":
  diff_hr <= 24 ? "$diff_hr""h":
  diff_dy <= 30 ? "$diff_dy""d":
  months <= 12 ? "$months""m":
  "$years";
}


String OfferExpiry(String date){


  final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${date}');
  print(startTime);
  final currentTime = DateTime.now();


  final diff_dy = currentTime.difference(startTime).inDays;

  int years = diff_dy ~/ 365;
  int months = (diff_dy-years*365) ~/ 30;
  final diff_mi = currentTime.difference(startTime).inMinutes;
  final diff_s = currentTime.difference(startTime).inSeconds;
  final diff_hr = currentTime.difference(startTime).inHours;
  return diff_s <= 60? "$diff_s" "Seconds":

  diff_mi <= 60 ?"$diff_mi" "Minutes":
  diff_hr <= 24 ? "$diff_hr" "Hours":
  diff_dy <= 30 ? "$diff_dy" "Days":
  months <= 12 ? "$months" "Months":
  "$years Years";
}
