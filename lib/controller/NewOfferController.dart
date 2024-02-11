import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialapps/Apis/CommonApis.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/Auth/login_screen.dart';
import 'package:socialapps/constant/CustomMultiselect.dart';
import 'package:socialapps/constant/constant_function.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/GetCategoryListModal.dart';
import 'package:socialapps/model/GetKYCListModel.dart';
import 'package:socialapps/model/GetSegmentListModal.dart';
import 'package:socialapps/model/PrefillOfferDataModel.dart';
import 'package:socialapps/model/ServicePersonListModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapps/model/UnitListModel.dart';
import 'package:socialapps/model/filtterOfferDetailsModel.dart';
import 'package:socialapps/screens/GlobalSearch.dart';
import 'package:socialapps/screens/widgets/ImagePickeBottomSheet.dart';
import 'package:socialapps/screens/widgets/NewAddressPickers/NewAddressPickerList.dart';
import 'package:socialapps/screens/widgets/NewOfferPageWidget.dart';
import 'package:socialapps/screens/widgets/NewPeriodPicker/FromToDatePicker.dart';
import 'package:socialapps/screens/widgets/ShowDurationPicker.dart';
import 'package:socialapps/screens/widgets/SimmerLoadingBuilder.dart';
import 'package:socialapps/screens/widgets/upload_image_camera.dart';
import '../common/style.dart';
import '../constant/loading.dart';
import '../model/GetSubSegmentListModal.dart';


class NewOfferController extends GetxController{
  ///TODO Controller
  final adressLocationController = TextEditingController().obs;


  ///TODO String and Other Var

  final PrintV = "".obs;
  final saveAddressTitle = "".obs;
  final _currentTapindex = 0;
  final LatitudeLongitude = Rxn<LatLng>().obs;


  ///TODO Bool
  final isViewOfferToLocation = false.obs;
  final cateLoader=false.obs;





}