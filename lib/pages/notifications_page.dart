import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hms_system_application/components/notification_tile_component.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<String> modules = ['CMPG321', 'CMPG322', 'CMPG323', 'CMPG324'];

  final Map<String, List<Map<String, String>>> notifications = {
    'CMPG321': [
      {
        'title': 'Assignment Due',
        'description':
            'Assignment 1 due on Friday. Please note that when you submit this assignment you should use a pdf'
      },
      {
        'title': 'Lecture Update',
        'description':
            'Lecture moved to Thursday. Please try to be on time as we will be going through new work and techniques \n\n We are also going to do a quiz in that class'
      },
    ],
    'CMPG322': [
      {'title': 'Exam Schedule', 'description': 'Exam on next Monday.'},
    ],
    'CMPG323': [
      {'title': 'Project Milestone', 'description': 'Submit milestone 2.'},
    ],
    'CMPG324': [
      {'title': 'Lab Attendance', 'description': 'Lab attendance mandatory.'},
    ],
  };

  String selectedModule = 'CMPG321';

  void _onModuleSelected(String module) {
    setState(() {
      selectedModule = module;
    });
  }

  Widget buildModuleSelector() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: modules.length,
        itemBuilder: (context, index) {
          String module = modules[index];
          return GestureDetector(
            onTap: () => _onModuleSelected(module),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color:
                    selectedModule == module ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  module,
                  style: TextStyle(
                    color:
                        selectedModule == module ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showNotificationDetail(String title, String description) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Notification",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, _, __) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: anim1,
            curve: Curves.easeOutBack,
          ),
          child: child,
        );
      },
    );
  }

  Widget buildNotificationList() {
    return Expanded(
      child: ListView.builder(
        itemCount: notifications[selectedModule]?.length ?? 0,
        itemBuilder: (context, index) {
          var notification = notifications[selectedModule]![index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: NotificationTile(
              title: notification['title']!,
              description: notification['description']!,
              onTap: () => _showNotificationDetail(
                notification['title']!,
                notification['description']!,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildModuleSelector(),
            const SizedBox(height: 16),
            buildNotificationList(),
          ],
        ),
      ),
    );
  }
}
