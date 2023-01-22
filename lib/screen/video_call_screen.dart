import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/jitsi_meet_methods.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/meeting_option.dart';

class VideoCallScreen extends StatefulWidget {
  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethod = AuthMethods();
  late TextEditingController _meetIdController;
  late TextEditingController _nameController;
  final JitsiMeetMethods jitsiMeetMethods = JitsiMeetMethods();
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    // TODO: implement initState
    _meetIdController = TextEditingController();
    _nameController = TextEditingController(text: _authMethod.user.displayName);
    super.initState();
  }

  joiningMeeting() {
    jitsiMeetMethods.createMeeting(
      roomName: _meetIdController.text,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      username: _nameController.text,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _meetIdController.dispose();
    _nameController.dispose();
    JitsiMeet.removeAllListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          'Join a meeting',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: _meetIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Meeting ID',
                // contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: _nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Your Name',
                // contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          Container(
            width: 300,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: joiningMeeting,
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Join',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.all(2),
            child: Center(
              child: Text(
                'If you received an invitation link, tap on link to join the meeting',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                EdgeInsets.only(right: MediaQuery.of(context).size.width - 110),
            child: Text(
              'JOIN OPTIONS',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            height: 2,
          ),
          MeetingOption(
            text: 'Don\'t join Audio',
            isMute: isAudioMuted,
            onChange: onAudioMuted,
          ),
          const Divider(
            height: 2,
          ),
          MeetingOption(
            text: 'Turn Off My Video',
            isMute: isVideoMuted,
            onChange: onVideoMuted,
          ),
          const Divider(
            height: 2,
          ),
        ],
      ),
    );
  }

  onAudioMuted(bool? val) {
    setState(() {
      isAudioMuted = val!;
    });
  }

  onVideoMuted(bool? val) {
    setState(() {
      isVideoMuted = val!;
    });
  }
}
