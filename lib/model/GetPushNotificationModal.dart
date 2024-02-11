/// status : 200
/// message : "Subscriber Push Notification settings"
/// result : {"id":1,"notify_offer_response":false,"notify_offer_confirmation":false,"notify_offer_executions":true,"notify_offer_cancellation":true,"notify_offer_copy":true,"notify_offer_favorited":true,"notify_follower":true,"notify_mentions":true,"notify_views":true,"notify_expiry":true,"notify_matched_offers":true,"notify_current_loc_connect":true,"subscriber":1}

class GetPushNotificationModal {
  GetPushNotificationModal({
      String? status,
      String? message, 
      GetPushNotificationResult? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  GetPushNotificationModal.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _result = json['result'] != null ? GetPushNotificationResult.fromJson(json['result']) : null;
  }
  String? _status;
  String? _message;
  GetPushNotificationResult? _result;
GetPushNotificationModal copyWith({  String? status,
  String? message,
  GetPushNotificationResult? result,
}) => GetPushNotificationModal(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  String? get status => _status;
  String? get message => _message;
  GetPushNotificationResult? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }

}

/// id : 1
/// notify_offer_response : false
/// notify_offer_confirmation : false
/// notify_offer_executions : true
/// notify_offer_cancellation : true
/// notify_offer_copy : true
/// notify_offer_favorited : true
/// notify_follower : true
/// notify_mentions : true
/// notify_views : true
/// notify_expiry : true
/// notify_matched_offers : true
/// notify_current_loc_connect : true
/// subscriber : 1

class GetPushNotificationResult {
  GetPushNotificationResult({
      num? id, 
      bool? notifyOfferResponse, 
      bool? notifyOfferConfirmation, 
      bool? notifyOfferExecutions, 
      bool? notifyOfferCancellation, 
      bool? notifyOfferCopy, 
      bool? notifyOfferFavorited, 
      bool? notifyFollower, 
      bool? notifyMentions, 
      bool? notifyViews, 
      bool? notifyExpiry, 
      bool? notifyMatchedOffers, 
      bool? notifyCurrentLocConnect, 
      num? subscriber,}){
    _id = id;
    _notifyOfferResponse = notifyOfferResponse;
    _notifyOfferConfirmation = notifyOfferConfirmation;
    _notifyOfferExecutions = notifyOfferExecutions;
    _notifyOfferCancellation = notifyOfferCancellation;
    _notifyOfferCopy = notifyOfferCopy;
    _notifyOfferFavorited = notifyOfferFavorited;
    _notifyFollower = notifyFollower;
    _notifyMentions = notifyMentions;
    _notifyViews = notifyViews;
    _notifyExpiry = notifyExpiry;
    _notifyMatchedOffers = notifyMatchedOffers;
    _notifyCurrentLocConnect = notifyCurrentLocConnect;
    _subscriber = subscriber;
}

  GetPushNotificationResult.fromJson(dynamic json) {
    _id = json['id'];
    _notifyOfferResponse = json['notify_offer_response'];
    _notifyOfferConfirmation = json['notify_offer_confirmation'];
    _notifyOfferExecutions = json['notify_offer_executions'];
    _notifyOfferCancellation = json['notify_offer_cancellation'];
    _notifyOfferCopy = json['notify_offer_copy'];
    _notifyOfferFavorited = json['notify_offer_favorited'];
    _notifyFollower = json['notify_follower'];
    _notifyMentions = json['notify_mentions'];
    _notifyViews = json['notify_views'];
    _notifyExpiry = json['notify_expiry'];
    _notifyMatchedOffers = json['notify_matched_offers'];
    _notifyCurrentLocConnect = json['notify_current_loc_connect'];
    _subscriber = json['subscriber'];
  }
  num? _id;
  bool? _notifyOfferResponse;
  bool? _notifyOfferConfirmation;
  bool? _notifyOfferExecutions;
  bool? _notifyOfferCancellation;
  bool? _notifyOfferCopy;
  bool? _notifyOfferFavorited;
  bool? _notifyFollower;
  bool? _notifyMentions;
  bool? _notifyViews;
  bool? _notifyExpiry;
  bool? _notifyMatchedOffers;
  bool? _notifyCurrentLocConnect;
  num? _subscriber;
GetPushNotificationResult copyWith({  num? id,
  bool? notifyOfferResponse,
  bool? notifyOfferConfirmation,
  bool? notifyOfferExecutions,
  bool? notifyOfferCancellation,
  bool? notifyOfferCopy,
  bool? notifyOfferFavorited,
  bool? notifyFollower,
  bool? notifyMentions,
  bool? notifyViews,
  bool? notifyExpiry,
  bool? notifyMatchedOffers,
  bool? notifyCurrentLocConnect,
  num? subscriber,
}) => GetPushNotificationResult(  id: id ?? _id,
  notifyOfferResponse: notifyOfferResponse ?? _notifyOfferResponse,
  notifyOfferConfirmation: notifyOfferConfirmation ?? _notifyOfferConfirmation,
  notifyOfferExecutions: notifyOfferExecutions ?? _notifyOfferExecutions,
  notifyOfferCancellation: notifyOfferCancellation ?? _notifyOfferCancellation,
  notifyOfferCopy: notifyOfferCopy ?? _notifyOfferCopy,
  notifyOfferFavorited: notifyOfferFavorited ?? _notifyOfferFavorited,
  notifyFollower: notifyFollower ?? _notifyFollower,
  notifyMentions: notifyMentions ?? _notifyMentions,
  notifyViews: notifyViews ?? _notifyViews,
  notifyExpiry: notifyExpiry ?? _notifyExpiry,
  notifyMatchedOffers: notifyMatchedOffers ?? _notifyMatchedOffers,
  notifyCurrentLocConnect: notifyCurrentLocConnect ?? _notifyCurrentLocConnect,
  subscriber: subscriber ?? _subscriber,
);
  num? get id => _id;
  bool? get notifyOfferResponse => _notifyOfferResponse;
  bool? get notifyOfferConfirmation => _notifyOfferConfirmation;
  bool? get notifyOfferExecutions => _notifyOfferExecutions;
  bool? get notifyOfferCancellation => _notifyOfferCancellation;
  bool? get notifyOfferCopy => _notifyOfferCopy;
  bool? get notifyOfferFavorited => _notifyOfferFavorited;
  bool? get notifyFollower => _notifyFollower;
  bool? get notifyMentions => _notifyMentions;
  bool? get notifyViews => _notifyViews;
  bool? get notifyExpiry => _notifyExpiry;
  bool? get notifyMatchedOffers => _notifyMatchedOffers;
  bool? get notifyCurrentLocConnect => _notifyCurrentLocConnect;
  num? get subscriber => _subscriber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['notify_offer_response'] = _notifyOfferResponse;
    map['notify_offer_confirmation'] = _notifyOfferConfirmation;
    map['notify_offer_executions'] = _notifyOfferExecutions;
    map['notify_offer_cancellation'] = _notifyOfferCancellation;
    map['notify_offer_copy'] = _notifyOfferCopy;
    map['notify_offer_favorited'] = _notifyOfferFavorited;
    map['notify_follower'] = _notifyFollower;
    map['notify_mentions'] = _notifyMentions;
    map['notify_views'] = _notifyViews;
    map['notify_expiry'] = _notifyExpiry;
    map['notify_matched_offers'] = _notifyMatchedOffers;
    map['notify_current_loc_connect'] = _notifyCurrentLocConnect;
    map['subscriber'] = _subscriber;
    return map;
  }

}