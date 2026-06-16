import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _enableNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt')),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Hồ sơ cá nhân'),
            subtitle: Text('Chỉnh sửa thông tin tài khoản'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
          const Divider(), // Đường kẻ ngang
          SwitchListTile(
            secondary: const Icon(Icons.notifications_active),
            title: const Text('Thông báo nhắc nhở'),
            subtitle: const Text('Nhắc nhở ôn tập từ vựng mỗi ngày'),
            value: _enableNotifications,
            onChanged: (bool value) {
              setState(() {
                _enableNotifications = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
