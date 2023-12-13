import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twilio_programmable_video/twilio_programmable_video.dart';
import 'package:wehealth/screens/dashboard/drawer/home/tele_consultation/perticipant_widget.dart';

class TwilioConferenceController extends GetxController {
  Room? _room;
  final List<StreamSubscription> _streamSubscriptions = [];
  final List<ParticipantWidget> participants = [];
  final List<LocalAudioTrack> audioTracks = [];
  final List<LocalVideoTrack> videoTracks = [];

  final List<LocalDataTrack> localDataTracks = [];

  List<ParticipantWidget> get getParticipantWidgets {
    _room!.remoteParticipants.map((e) => e);
    return <ParticipantWidget>[];
  }

  late final CameraCapturer _cameraCapturer;
  bool isAudio = true;
  bool isVideo = true;
  bool isBackFacing = true;

  setCameraCapturer() async {
    final sources = await CameraSource.getSources();
    _cameraCapturer = CameraCapturer(
      sources.firstWhereOrNull((source) {
        return isBackFacing ? source.isBackFacing : source.isBackFacing;
      }),
    );
  }

  inserVideoTrack(CameraCapturer camera) async {
    videoTracks.add(LocalVideoTrack(isVideo, camera, name: "video_track"));
    update();
  }

  toggleVideoTrack() async {
    await videoTracks.first.enable(!isVideo);
    isVideo = !isVideo;
    update();
  }

  rotateCam() async {
    final source = await CameraSource.getSources();
    _cameraCapturer.switchCamera(source.firstWhere((element) =>
        !isBackFacing ? element.isBackFacing : element.isBackFacing));
    isBackFacing = !isBackFacing;
    update();
  }

  insertAudioTrack() {
    audioTracks.add(LocalAudioTrack(isAudio, "audio_track"));
    update();
  }

  toggleAudioTrack() async {
    await audioTracks.first.enable(!isAudio);
    isAudio = !isAudio;
    update();
  }

  insertLocalDataTrack() {
    localDataTracks.add(LocalDataTrack(
      DataTrackOptions(name: 'data_track'),
    ));
    update();
  }

  connect(String token, String name) async {
    log('[ ###APPDEBUG ] ConferenceRoom.connect()');
    try {
      await TwilioProgrammableVideo.setAudioSettings(
          speakerphoneEnabled: true, bluetoothPreferred: false);

      await insertAudioTrack();
      await setCameraCapturer();
      await inserVideoTrack(_cameraCapturer);
      insertLocalDataTrack();
      var connectOptions = ConnectOptions(
        token,
        roomName: name,
        audioTracks: audioTracks,
        videoTracks: videoTracks,
        preferredAudioCodecs: [OpusCodec()],
        dataTracks: localDataTracks,
        enableNetworkQuality: true,
        networkQualityConfiguration: NetworkQualityConfiguration(
          remote: NetworkQualityVerbosity.NETWORK_QUALITY_VERBOSITY_MINIMAL,
        ),
        enableDominantSpeaker: true,
      );

      try {
        log('[ ###APPDEBUG ] just before calling connect!');

        _room = await TwilioProgrammableVideo.connect(connectOptions);

        log("Room Name => ${_room?.name}");
      } catch (error) {
        log("###${error.toString()}");
      }

      final create = _room!.onConnected.listen(
        (event) {
          _onConnected(_room!);
          log('[ ###APPDEBUG ]  Check Call!');
          update();
        },
      );
      _room!.onParticipantConnected.listen((event) {
        event.remoteParticipant.onVideoTrackSubscribed
            .listen((RemoteVideoTrackSubscriptionEvent videoTrack) {});
      });
      _streamSubscriptions.add(create);

    /* 
     _streamSubscriptions.add(_room!.onDisconnected.listen((event) {
       
     },));
     _streamSubscriptions.add(_room!.onReconnecting.listen((event) {
       
     },));
     _streamSubscriptions
         .add(_room!.onConnectFailure.listen((event) {
           
         },)); 
    */
    
    } catch (err) {
      log('[ ###APPDEBUG Error ] $err');
      rethrow;
    }
  }

  roomDispose() {
    _room?.disconnect();
    _room?.dispose();
    for (var stream in _streamSubscriptions) {
      stream.cancel();
    }
    _streamSubscriptions.clear();
    participants.clear();
  }

  void _onConnected(Room room) {
    log('[ APPDEBUG ####Room Connected ] ConferenceRoom._onConnected => state: ${room.state}');

    // When connected for the first time, add remote participant listeners
    _streamSubscriptions
        .add(_room!.onParticipantConnected.listen(_onParticipantConnected));

    _streamSubscriptions.add(
        _room!.onParticipantDisconnected.listen(_onParticipantDisconnected));

    final localParticipant = room.localParticipant;

    log("User Connected!");
    if (localParticipant == null) {
      log('[ APPDEBUG #####Room user not connected] ConferenceRoom._onConnected => localParticipant is null');
      return;
    }

    // Only add ourselves when connected for the first time too.
    participants.add(_buildParticipant(
        child: localParticipant.localVideoTracks[0].localVideoTrack.widget(),
        id: localParticipant.localVideoTracks.first.trackName));

    for (final remoteParticipant in room.remoteParticipants) {
      var participant = participants.firstWhereOrNull(
          (participant) => participant.id == remoteParticipant.sid);
      if (participant == null) {
        log('[ APPDEBUG ] Adding participant that was already present in the room ${remoteParticipant.sid}, before I connected');
        _addRemoteParticipantListeners(remoteParticipant);
      }
    }
    //  reload();
    update();
  }

  ParticipantWidget _buildParticipant({
    required Widget child,
    required String? id,
  }) {
    return ParticipantWidget(
      id: id,
      child: child,
    );
  }

  void _onParticipantConnected(RoomParticipantConnectedEvent event) {
    log('[ APPDEBUG ] ConferenceRoom._onParticipantConnected, ${event.remoteParticipant.sid}');
    _addRemoteParticipantListeners(event.remoteParticipant);
    //  reload();
    update();
  }

  void _addRemoteParticipantListeners(RemoteParticipant remoteParticipant) {
    _streamSubscriptions.add(remoteParticipant.onVideoTrackSubscribed
        .listen(_addOrUpdateParticipant));
    _streamSubscriptions.add(remoteParticipant.onAudioTrackSubscribed
        .listen(_addOrUpdateParticipant));
  }

  void _addOrUpdateParticipant(RemoteParticipantEvent event) {
    log('[ APPDEBUG ] ConferenceRoom._addOrUpdateParticipant(), ${event.remoteParticipant.sid}');
    final participant = participants.firstWhereOrNull(
      (ParticipantWidget participant) =>
          participant.id == event.remoteParticipant.sid,
    );

    if (participant != null) {
      log('[ APPDEBUG ] Participant found: ${participant.id}, updating A/V enabled values');
      participants.add(participant);
      update();
    } else {
      if (event is RemoteVideoTrackSubscriptionEvent) {
        log('[ APPDEBUG ] New participant, adding: ${event.remoteParticipant.sid}');
        participants.insert(
          0,
          _buildParticipant(
            child: event.remoteVideoTrack.widget(),
            id: event.remoteParticipant.sid,
          ),
        );
      } else {
        log("[### APPDEBUG]: Issue found a different type => ${event.runtimeType}");
      }
    }
    update();
  }

  void _onParticipantDisconnected(RoomParticipantDisconnectedEvent event) {
    log('[ APPDEBUG ] ConferenceRoom._onParticipantDisconnected: ${event.remoteParticipant.sid}');
    participants.removeWhere(
        (ParticipantWidget p) => p.id == event.remoteParticipant.sid);
    //  reload();
    update();
  }
}
