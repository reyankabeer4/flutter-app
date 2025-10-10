import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'All Users',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No users found.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final users = snapshot.data!.docs;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final user = users[index];
              final data = user.data() as Map<String, dynamic>;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    (data['name']?.substring(0, 1) ?? '?').toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
                title: Text(
                  data['name'] ?? 'No Name',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(data['email'] ?? 'No Email'),
                trailing: Icon(
                  data['userType'] == 1
                      ? Icons.admin_panel_settings
                      : Icons.person,
                  color: data['userType'] == 1 ? Colors.orange : Colors.grey,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
