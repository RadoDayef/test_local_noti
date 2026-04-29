import 'package:flutter/material.dart';
import 'package:test_local_noti/noti_controller.dart';

class TestLocalNotiApp extends StatelessWidget {
  const TestLocalNotiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await NotiController.showInstanceNotification(id: 0, body: "This is an instance notification", title: "Instance Notification");
                },
                child: Text("Send Instance Notification"),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  await NotiController.showScheduledNotification(
                    id: 0,
                    body: "This is an Scheduled notification",
                    title: "Scheduled Notification",
                    schedule: DateTime.now().add(Duration(seconds: 10)),
                  );
                },
                child: Text("Send Scheduled Notification"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
