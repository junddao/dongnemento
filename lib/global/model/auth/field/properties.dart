import 'dart:convert';

class Properties {
  String? updateUrlIos;
  String? updateUrlAndroid;
  String? minVersion;
  String? lastedVersion;
  bool? emergency;
  bool? noticePopupEnable;
  String? message;
  // String? noticePopupMessage;
  String? minBuildNumber;
  String? lastedBuildNumber;
  // DateTime? noticePopupStart;
  // DateTime? noticePopupEnd;
  Properties({
    this.updateUrlIos,
    this.updateUrlAndroid,
    this.minVersion,
    this.lastedVersion,
    this.emergency,
    this.noticePopupEnable,
    this.message,
    // this.noticePopupMessage,
    this.minBuildNumber,
    this.lastedBuildNumber,
    // this.noticePopupStart,
    // this.noticePopupEnd,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'update_url_ios': updateUrlIos,
      'update_url_android': updateUrlAndroid,
      'min_version': minVersion,
      'lasted_version': lastedVersion,
      'emergency': emergency,
      'notice_popup_enable': noticePopupEnable,
      'message': message,
      // 'notice_popup_message': noticePopupMessage,
      'min_buildnumber': minBuildNumber,
      'lasted_buildnumber': lastedBuildNumber,
      // 'notice_popup_start': noticePopupStart?.toIso8601String(),
      // 'noticePopupEnd': noticePopupEnd?.toIso8601String(),
    };
  }

  factory Properties.fromMap(Map<String, dynamic> map) {
    return Properties(
      updateUrlIos: map['update_url_ios'],
      updateUrlAndroid: map['update_url_android'],
      minVersion: map['min_version'],
      lastedVersion: map['lasted_version'],
      emergency: map['emergency'],
      noticePopupEnable: map['notice_popup_enable'],
      message: map['message'],
      // noticePopupMessage: map['notice_popup_message'],
      minBuildNumber: map['min_buildnumber'],
      lastedBuildNumber: map['lasted_buildnumber'],
      // noticePopupStart: map['notice_popup_start'] != null ? DateTime.parse(map['notice_popup_start']).toLocal() : null,
      // noticePopupEnd: map['notice_popup_end'] != null ? DateTime.parse(map['notice_popup_end']).toLocal() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Properties.fromJson(String source) => Properties.fromMap(json.decode(source));
}
