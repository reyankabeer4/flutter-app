import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> todayNotifications = [
    {
      "name": "Chad Leaf",
      "message": "sent you a GIF",
      "time": "5 min ago",
      "avatar": "https://i.pravatar.cc/150?img=3",
    },
    {
      "name": "Sarah Roberts",
      "message": "Watch your upcoming lesson in Spanish Vocabulary",
      "time": "15 min ago",
      "avatar": "https://i.pravatar.cc/150?img=5",
    },
    {
      "name": "ChatEdu",
      "message": "Congratulations 🎉 You completed your course!",
      "time": "30 min ago",
      "avatar": "https://i.pravatar.cc/150?img=6",
    },
  ];

  final List<Map<String, dynamic>> weekNotifications = [];

  final List<Map<String, dynamic>> earlierNotifications = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8fc),
      appBar: AppBar(
        backgroundColor: const Color(0xff0d2b3c),
        // elevation: 0,
        title: const Text(
          "Notification",
          // textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,

            color: Colors.white,
          ),
        ),
      ),
      body: buildNotificationList(todayNotifications),
    );
  }

  Widget buildNotificationList(List<Map<String, dynamic>> notifications) {
    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.notifications_none, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              "You're all caught up",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "All notifications will be displayed here",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final n = notifications[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(n["avatar"]),
              radius: 25,
            ),
            title: Text(
              n["name"],
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(n["message"]),
            trailing: Text(
              n["time"],
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        );
      },
    );
  }
}
