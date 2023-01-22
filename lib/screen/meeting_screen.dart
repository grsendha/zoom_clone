import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/jitsi_meet_methods.dart';
import 'package:zoom_clone/screen/video_call_screen.dart';

import '../widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    _jitsiMeetMethods.createMeeting(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, '/video-call');
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Navigator.of(context).pushReplacementNamed('/video-call');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMettingButton(
              onPressed: createNewMeeting,
              icon: Icons.videocam,
              text: "New Meeting",
            ),
            HomeMettingButton(
              onPressed: () {
                joinMeeting(context);
              },
              icon: Icons.add_box_rounded,
              text: "Join Meeting",
            ),
            HomeMettingButton(
              onPressed: () {},
              icon: Icons.calendar_today,
              text: "Schedule",
            ),
            HomeMettingButton(
              onPressed: () {},
              icon: Icons.arrow_upward_rounded,
              text: "Share Screen",
            )
          ],
        ),
        const Expanded(
            child: Center(
          child: Text(
            'Create/Join Meeting Just a Click!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ))
      ],
    );
  }
}
