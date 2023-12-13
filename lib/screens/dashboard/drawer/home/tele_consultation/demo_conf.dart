/* import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
/* import 'package:twilio_programmable_video_example/conference/conference_button_bar.dart';
import 'package:twilio_programmable_video_example/conference/conference_room.dart';
import 'package:twilio_programmable_video_example/conference/draggable_publisher.dart';
import 'package:twilio_programmable_video_example/conference/participant_widget.dart';
import 'package:twilio_programmable_video_example/debug.dart';
import 'package:twilio_programmable_video_example/room/room_model.dart';
import 'package:twilio_programmable_video_example/shared/widgets/noise_box.dart';
import 'package:twilio_programmable_video_example/shared/widgets/platform_alert_dialog.dart';
import 'package:wakelock/wakelock.dart'; */

class ConferencePage extends StatefulWidget {
  final RoomModel roomModel;

  const ConferencePage({
    Key? key,
    required this.roomModel,
  }) : super(key: key);

  @override
  _ConferencePageState createState() => _ConferencePageState();
}

class _ConferencePageState extends State<ConferencePage> {
  final StreamController<bool> _onButtonBarVisibleStreamController = StreamController<bool>.broadcast();
  final StreamController<double> _onButtonBarHeightStreamController = StreamController<double>.broadcast();
  ConferenceRoom? _conferenceRoom;
  StreamSubscription? _onConferenceRoomException;

  @override
  void initState() {
    super.initState();
    _lockInPortrait();
    _connectToRoom();
    _wakeLock(true);
  }

  void _connectToRoom() async {
    try {
      final conferenceRoom = ConferenceRoom(
        name: widget.roomModel.name!,
        token: widget.roomModel.token!,
        identity: widget.roomModel.identity!,
      );
      await conferenceRoom.connect();
      setState(() {
        _conferenceRoom = conferenceRoom;
        _onConferenceRoomException = conferenceRoom.onException.listen((err) async {
          await _showPlatformAlertDialog(err);
        });
        conferenceRoom.addListener(_conferenceRoomUpdated);
      });
    } catch (err) {
      Debug.log(err);
      await _showPlatformAlertDialog(err);
      Navigator.of(context).pop();
    }
  }

  Future _showPlatformAlertDialog(err) async {
    await PlatformAlertDialog(
      title: err is PlatformException ? err.message ?? 'An error occurred' : 'An error occurred',
      content: err is PlatformException ? (err.details ?? err.toString()) : err.toString(),
      defaultActionText: 'OK',
    ).show(context);
  }

  Future<void> _lockInPortrait() async {
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _freePortraitLock();
    _wakeLock(false);
    _disposeStreamsAndSubscriptions();
    _conferenceRoom?.removeListener(_conferenceRoomUpdated);
    super.dispose();
  }

  Future<void> _freePortraitLock() async {
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> _disposeStreamsAndSubscriptions() async {
    await _onButtonBarVisibleStreamController.close();
    await _onButtonBarHeightStreamController.close();
    await _onConferenceRoomException?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: buildLayout(),
      ),
    );
  }

  Widget buildLayout() {
    final conferenceRoom = _conferenceRoom;

    return conferenceRoom == null
        ? showProgress()
        : LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                children: <Widget>[
                  _buildParticipants(context, constraints.biggest, conferenceRoom),
                  ConferenceButtonBar(
                    audioEnabled: conferenceRoom.onAudioEnabled,
                    videoEnabled: conferenceRoom.onVideoEnabled,
                    flashState: conferenceRoom.flashStateStream,
                    speakerState: conferenceRoom.speakerStateStream,
                    onAudioEnabled: conferenceRoom.toggleAudioEnabled,
                    onVideoEnabled: conferenceRoom.toggleVideoEnabled,
                    onHangup: _onHangup,
                    onSwitchCamera: conferenceRoom.switchCamera,
                    onToggleSpeaker: conferenceRoom.toggleSpeaker,
                    toggleFlashlight: conferenceRoom.toggleFlashlight,
                    onPersonAdd: _onPersonAdd,
                    onPersonRemove: _onPersonRemove,
                    onHeight: _onHeightBar,
                    onShow: _onShowBar,
                    onHide: _onHideBar,
                  ),
                ],
              );
            },
          );
  }

  Widget showProgress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(child: CircularProgressIndicator()),
        SizedBox(
          height: 10,
        ),
        Text(
          'Connecting to the room...',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Future<void> _onHangup() async {
    Debug.log('onHangup');
    await _conferenceRoom?.disconnect();
    Navigator.of(context).pop();
  }

  void _onPersonAdd() {
    final conferenceRoom = _conferenceRoom;
    if (conferenceRoom == null) return;

    Debug.log('onPersonAdd');
    try {
      conferenceRoom.addDummy(
        child: Stack(
          children: <Widget>[
            const Placeholder(),
            Center(
              child: Text(
                (conferenceRoom.participants.length + 1).toString(),
                style: const TextStyle(
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    Shadow(
                      blurRadius: 8.0,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ],
                  fontSize: 80,
                ),
              ),
            ),
          ],
        ),
      );
    } on PlatformException catch (err) {
      _showPlatformAlertDialog(err);
    }
  }

  void _onPersonRemove() {
    Debug.log('onPersonRemove');
    _conferenceRoom?.removeDummy();
  }

  Widget _buildParticipants(BuildContext context, Size size, ConferenceRoom conferenceRoom) {
    final children = <Widget>[];
    final length = conferenceRoom.participants.length;

    if (length <= 2) {
      _buildOverlayLayout(context, size, children);
      return Stack(children: children);
    }

    void buildInCols(bool removeLocalBeforeChunking, bool moveLastOfEachRowToNextRow, int columns) {
      _buildLayoutInGrid(
        context,
        size,
        children,
        removeLocalBeforeChunking: removeLocalBeforeChunking,
        moveLastOfEachRowToNextRow: moveLastOfEachRowToNextRow,
        columns: columns,
      );
    }

    if (length <= 3) {
      buildInCols(true, false, 1);
    } else if (length == 5) {
      buildInCols(false, true, 2);
    } else if (length <= 6 || length == 8) {
      buildInCols(false, false, 2);
    } else if (length == 7 || length == 9) {
      buildInCols(true, false, 2);
    } else if (length == 10) {
      buildInCols(false, true, 3);
    } else if (length == 13 || length == 16) {
      buildInCols(true, false, 3);
    } else if (length <= 18) {
      buildInCols(false, false, 3);
    }

    return Column(
      children: children,
    );
  }

  void _buildOverlayLayout(BuildContext context, Size size, List<Widget> children) {
    final conferenceRoom = _conferenceRoom;
    if (conferenceRoom == null) return;

    final participants = conferenceRoom.participants;
    if (participants.length == 1) {
      children.add(_buildNoiseBox());
    } else {
      final remoteParticipant = participants.firstWhereOrNull((ParticipantWidget participant) => participant.isRemote);
      if (remoteParticipant != null) {
        children.add(remoteParticipant);
      }
    }

    final localParticipant = participants.firstWhereOrNull((ParticipantWidget participant) => !participant.isRemote);
    if (localParticipant != null) {
      children.add(DraggablePublisher(
        key: Key('publisher'),
        availableScreenSize: size,
        onButtonBarVisible: _onButtonBarVisibleStreamController.stream,
        onButtonBarHeight: _onButtonBarHeightStreamController.stream,
        child: localParticipant,
      ));
    }
  }

  void _buildLayoutInGrid(
    BuildContext context,
    Size size,
    List<Widget> children, {
    bool removeLocalBeforeChunking = false,
    bool moveLastOfEachRowToNextRow = false,
    int columns = 2,
  }) {
    final conferenceRoom = _conferenceRoom;
    if (conferenceRoom == null) return;

    final participants = conferenceRoom.participants;
    ParticipantWidget? localParticipant;
    if (removeLocalBeforeChunking) {
      localParticipant = participants.firstWhereOrNull((ParticipantWidget participant) => !participant.isRemote);
      if (localParticipant != null) {
        participants.remove(localParticipant);
      }
    }
    final chunkedParticipants = chunk(array: participants, size: columns);
    if (localParticipant != null) {
      chunkedParticipants.last.add(localParticipant);
      participants.add(localParticipant);
    }

    if (moveLastOfEachRowToNextRow) {
      for (var i = 0; i < chunkedParticipants.length - 1; i++) {
        var participant = chunkedParticipants[i].removeLast();
        chunkedParticipants[i + 1].insert(0, participant);
      }
    }

    for (final participantChunk in chunkedParticipants) {
      final rowChildren = <Widget>[];
      for (final participant in participantChunk) {
        rowChildren.add(
          Container(
            width: size.width / participantChunk.length,
            height: size.height / chunkedParticipants.length,
            child: participant,
          ),
        );
      }
      children.add(
        Container(
          height: size.height / chunkedParticipants.length,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: rowChildren,
          ),
        ),
      );
    }
  }

  NoiseBox _buildNoiseBox() {
    return NoiseBox(
      density: NoiseBoxDensity.xLow,
      backgroundColor: Colors.grey.shade900,
      child: Center(
        child: Container(
          color: Colors.black54,
          width: double.infinity,
          height: 40,
          child: Center(
            child: Text(
              'Waiting for another participant to connect to the room...',
              key: Key('text-wait'),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  List<List<T>> chunk<T>({required List<T> array, required int size}) {
    final result = <List<T>>[];
    if (array.isEmpty || size <= 0) {
      return result;
    }
    var first = 0;
    var last = size;
    final totalLoop = array.length % size == 0 ? array.length ~/ size : array.length ~/ size + 1;
    for (var i = 0; i < totalLoop; i++) {
      if (last > array.length) {
        result.add(array.sublist(first, array.length));
      } else {
        result.add(array.sublist(first, last));
      }
      first = last;
      last = last + size;
    }
    return result;
  }

  void _onHeightBar(double height) {
    _onButtonBarHeightStreamController.add(height);
  }

  void _onShowBar() {
    setState(() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    });
    _onButtonBarVisibleStreamController.add(true);
  }

  void _onHideBar() {
    setState(() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    });
    _onButtonBarVisibleStreamController.add(false);
  }

  Future<void> _wakeLock(bool enable) async {
    try {
      return await (enable ? Wakelock.enable() : Wakelock.disable());
    } catch (err) {
      Debug.log('Unable to change the Wakelock and set it to $enable');
      Debug.log(err);
    }
  }

  void _conferenceRoomUpdated() {
    setState(() {});
  }
}
 */

/* 
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void VideoCreatedCallback(VideoController controller);

class TwilioVideoTutorial extends StatefulWidget {
  TwilioVideoTutorial({
    Key? key,
    this.twilioToken,
    this.onVideoCreated,
  }) : super(key: key);
  final String twilioToken;
  final VideoCreatedCallback onVideoCreated;

  @override
  _TwilioVideoTutorialState createState() => _TwilioVideoTutorialState();
}

class _TwilioVideoTutorialState extends State {
  VideoController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: AndroidView(
          viewType: 'twilioVideoPlugin',
          onPlatformViewCreated: _onPlatformCreated,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.red.shade700,
        child: Icon(Icons.call_end, size: 32),
        onPressed: () async {
          try {
            await _controller!.hangup();
            Navigator.pop(context);
          } catch (error) {
            print("Error hanging up: ${error.toString()}");
          }
        },
      ),
    );
  }

  void _onPlatformCreated(int id) {
    if (_onVideoCreated == null) {
      return;
    }
    _onVideoCreated();
  }

  void _onVideoCreated() {
    _controller!.init(widget.twilioToken,);
  }
}

class VideoController {
  MethodChannel _methodChannel = new MethodChannel("twilioVideoPlugin");

  Future init(String token) {
    assert(token != null);
    return _methodChannel.invokeMethod('init', {'token': "tokentoken"});
  }

  Future hangup() {
    return _methodChannel.invokeMethod('hangup');
  }
}


class TwilioVideoTutorialView internal constructor(private var context: Context, twilioVideoTutorialPlugin: TwilioVideoTutorialPlugin, messenger: BinaryMessenger) : PlatformView, MethodCallHandler {
  private val methodChannel: MethodChannel = MethodChannel(messenger, "twilioVideoPlugin")
  // Initialize the cameraCapturer and default it to the front camera
  private val cameraCapturer: CameraCapturer = CameraCapturer(context, CameraCapturer.CameraSource.FRONT_CAMERA)
  // Create a local video track with the camera capturer
  private val localVideoTrack: LocalVideoTrack = LocalVideoTrack.create(context, true, cameraCapturer)!!

  var localParticipant: LocalParticipant? = null
  // The twilio room set up for the call
  private var room: Room? = null
  var roomName: String? = null
  // The twilio token passed through the method channel
  private var token: String? = null
  private val primaryVideoView: VideoView = VideoView(context)
  // Create the parent view, this will be used for the primary and future thumbnail video views
  private val view: FrameLayout = FrameLayout(context)

  // The tag for any logging
  val TAG = "TwilioVideoTutorial"

  override fun getView(): View {
    return view
  }

  init {
    // Initialize the method channel
    methodChannel.setMethodCallHandler(this)
    }


  private val roomListener = object : Room.Listener {
    override fun onConnected(room: Room) {
      localParticipant = room.localParticipant
      roomName = room.name
    }

    override fun onReconnected(room: Room) {
      Log.i("Reconnected", "Participant: $localParticipant")
    }

override fun onReconnecting(room: Room, twilioException: TwilioException) {
      // Send a message to the flutter ui to be displayed regarding this action
      Log.i("Reconnecting", "Participant: $localParticipant")
    }

    override fun onConnectFailure(room: Room, twilioException: TwilioException) {
      Log.e("Connection Failure Room", room.name)
      // Retry initializing the call
      init(token!!)
    }

    override fun onDisconnected(room: Room, twilioException: TwilioException?) {
      if (twilioException != null) {
        throw error("Twilio error on disconnect for room $roomName: ${twilioException.message}")
      }
      localParticipant = null
      Log.i("Disconnected", "room: $roomName")
      // Re init ui if not destroyed
    }

    override fun onParticipantConnected(room: Room, remoteParticipant: RemoteParticipant) {
      Log.i(TAG, "Participant connected")
      // Send a message to the flutter ui to be displayed regarding this action
      Log.i("Participant connected", "Participant: $remoteParticipant")
    }

    override fun onParticipantDisconnected(room: Room, remoteParticipant: RemoteParticipant) {
      // Create function to remove the remote participant properly
      Log.i("Participant disconnect", remoteParticipant.identity)
    }

    override fun onRecordingStarted(room: Room) {
      /** Will not be being implemented */
    }

    override fun onRecordingStopped(room: Room) {
      /** This will not be being implemented */
    }
  }
  

  override fun onMethodCall(methodCall: MethodCall, result: Result) {
    when (methodCall.method) {
      "init" -> {
        try {
          val callOptions: Map<*, *>? = methodCall.arguments as? Map<*, *>
          token = callOptions?.get("token") as String
          init(token!!)
        } catch (exception: Exception) {
          result.error("Twilio Initiation Error: ", "${exception.message}", exception.stackTrace)
        }
      }
      "hangup" -> hangup(result)
      else -> result.notImplemented()
    }
  }

 
  private fun init(token: String) {
    try {
      val connectOptions = ConnectOptions.Builder(token)
      localVideoTrack.let { connectOptions.videoTracks(listOf(it)) }

      room = Video.connect(context, connectOptions.build(), roomListener)
      localVideoTrack.addRenderer(primaryVideoView)
      primaryVideoView.mirror = true
      view.addView(primaryVideoView)
    } catch (exception: Exception) {
      Log.e("Initiation exception", "${exception.message}")
    }
  }


  private fun hangup(result: Result) {
    room?.disconnect()
    localVideoTrack.release()
    result.success(true)
  }

  override fun dispose() {}
} */

/* 
import 'package:flutter/material.dart';

class ConferencePage extends StatefulWidget {
  const ConferencePage({
    Key? key,
  }) : super(key: key);

  @override
  _ConferencePageState createState() => _ConferencePageState();
}

class _ConferencePageState extends State<ConferencePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<ConferenceCubit, ConferenceState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ConferenceInitial) {
              return showProgress();
            }
            if (state is ConferenceLoaded) {
              return Stack(
                children: <Widget>[
                  _buildParticipants(context),
                  Positioned(
                      bottom: 60,
                      child: IconButton(
                        color: Colors.red,
                        icon: Icon(
                          Icons.call_end_sharp,
                          color: Colors.white,
                        ),
                        onPressed: () async {},
                      ))
                ],
              );
            }
            return Container();
          }),
    );
  }

  Widget showProgress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(child: CircularProgressIndicator()),
        SizedBox(
          height: 10,
        ),
        Text(
          'Connecting to the room...',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildParticipants(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final children = <Widget>[];
    _buildOverlayLayout(context, size, children);
    return Stack(children: children);
  }

  void _buildOverlayLayout(
      BuildContext context, Size size, List<Widget> children) {
    // final conferenceRoom = context.read<ConferenceCubit>();
    final participants = conferenceRoom._participants;
    children.add(GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemCount: participants.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: participants[index],
          );
        }));
  }
} */
