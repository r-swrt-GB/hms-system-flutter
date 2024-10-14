import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hms_system_application/components/notification_tile_component.dart';
import 'package:hms_system_application/models/module.dart';
import 'package:hms_system_application/models/notification_model.dart';
import 'package:hms_system_application/providers/module_provider.dart';
import 'package:hms_system_application/providers/notification_provider.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Module> modules = [];
  List<NotificationModel> notifications = [];
  List<NotificationModel> selectedModuleNotifications = [];
  Module? selectedModule;

  @override
  void initState() {
    super.initState();
    getModules();
    getNotifications();
  }

  void getModules() async {
    ModuleProvider moduleProvider = context.read<ModuleProvider>();
    setState(() {
      modules = moduleProvider.modules;
      selectedModule = modules.isNotEmpty ? modules[0] : null;
    });
  }

  void getNotifications() async {
    NotificationProvider notificationProvider =
        context.read<NotificationProvider>();
    setState(() {
      notifications = notificationProvider.notifications;
    });
  }

  void _onModuleSelected(Module module) {
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
          Module module = modules[index];
          return GestureDetector(
            onTap: () => _onModuleSelected(module),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: selectedModule == module
                    ? const Color(0xFF22489E)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  module.moduleCode,
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

  void _showNotificationDetail(int notificationId, int moduleId, String title,
      String description) async {
    NotificationProvider notificationProvider =
        context.read<NotificationProvider>();
    notificationProvider.markAsRead(moduleId, notificationId, modules);

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

  void updateSelectedModuleNotifications() {
    selectedModuleNotifications = notifications
        .where(
            (notification) => notification.moduleId == selectedModule?.moduleId)
        .toList();
  }

  Widget buildNotificationList() {
    updateSelectedModuleNotifications();

    if (selectedModuleNotifications.isEmpty) {
      return Center(
        child: Text(
          "No notifications for ${selectedModule?.moduleCode} 📬",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: selectedModuleNotifications.length,
      itemBuilder: (context, index) {
        NotificationModel notification = selectedModuleNotifications[index];
        bool isUnread = notification.readAt == null;

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: NotificationTile(
            title: notification.notificationTitle,
            description: notification.notificationMessage,
            isUnread: isUnread,
            createdAt: notification.createdAt!,
            onTap: () => _showNotificationDetail(
              notification.notificationId,
              notification.moduleId,
              notification.notificationTitle,
              notification.notificationMessage,
            ),
          ),
        );
      },
    );
  }

  Widget buildNoNotificationsMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No notifications assigned 📚",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "You don't have any notifications assigned yet.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[900],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF22489E),
      ),
      body: modules.isEmpty
          ? buildNoNotificationsMessage()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  buildModuleSelector(),
                  const SizedBox(height: 16),
                  Expanded(child: buildNotificationList()),
                ],
              ),
            ),
    );
  }
}
