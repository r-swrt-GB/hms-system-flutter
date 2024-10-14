import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String description;
  final bool isUnread; // New property to indicate if the notification is unread
  final DateTime createdAt;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    this.isUnread = false, // Default to false, meaning the notification is read
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger the pop-out effect
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blue circle for unread notifications
              if (isUnread)
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue, // Blue color for unread indicator
                  ),
                ),
              // Title and description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        DateFormat('dd/MM/yyyy at HH:mm').format(createdAt),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
