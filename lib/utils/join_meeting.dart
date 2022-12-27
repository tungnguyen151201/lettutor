import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

joinMeeting(nextClass) async {
  Map<FeatureFlagEnum, bool> featureFlags = {
    FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
  };
  if (!kIsWeb) {
    // Here is an example, disabling features for each platform
    if (Platform.isAndroid) {
      // Disable ConnectionService usage on Android to avoid issues (see README)
      featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
    } else if (Platform.isIOS) {
      // Disable PIP on iOS as it looks weird
      featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
    }
  }

  final base64Decoded = base64.decode(base64.normalize(
      nextClass!.studentMeetingLink.split('token=')[1].split('.')[1]));
  final urlObject = utf8.decode(base64Decoded);
  final jsonRes = json.decode(urlObject);
  final String roomId = jsonRes['room'];
  final String tokenMeeting = nextClass!.studentMeetingLink.split('token=')[1];

  final options = JitsiMeetingOptions(room: roomId)
    ..serverURL = 'https://meet.lettutor.com'
    ..audioOnly = true
    ..audioMuted = true
    ..token = tokenMeeting
    ..videoMuted = true
    ..featureFlags.addAll(featureFlags);

  await JitsiMeet.joinMeeting(options);
}
