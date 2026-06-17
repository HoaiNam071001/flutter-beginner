import 'dart:convert'; // Để dùng jsonEncode, jsonDecode
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'vocab_detail_screen.dart'; // Import màn hình chi tiết

class AddVocabScreen extends StatefulWidget {
  const AddVocabScreen({super.key});

  @override
  State<AddVocabScreen> createState() => _AddVocabScreenState();
}

class _AddVocabScreenState extends State<AddVocabScreen> {
  // Biến state lưu trữ danh sách từ vựng
  List<Map<String, String>> _vocabList = [];

  @override
  void initState() {
    super.initState();
    _loadVocabFromLocal(); // Chạy hàm đọc dữ liệu khi màn hình vừa khởi tạo
  }

  // 1. Hàm ĐỌC dữ liệu từ Local Storage
  Future<void> _loadVocabFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final String? vocabString = prefs.getString('my_vocabs');

    if (vocabString != null) {
      // Ép kiểu dữ liệu từ JSON String về dạng List<Map>
      final List<dynamic> decodedList = jsonDecode(vocabString);
      setState(() {
        _vocabList = decodedList.map((item) => Map<String, String>.from(item)).toList();
      });
    }
  }

  // 2. Hàm LƯU dữ liệu xuống Local Storage
  Future<void> _saveVocabToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    // Chuyển List<Map> thành JSON String để lưu
    await prefs.setString('my_vocabs', jsonEncode(_vocabList));
  }

  // 3. Hàm hiển thị Dialog thêm từ mới
  void _showAddDialog() {
    // Khởi tạo các controller để lấy text từ ô input
    final enController = TextEditingController();
    final viController = TextEditingController();

    // Tạo FocusNode cho ô Tiếng Việt
    final viFocusNode = FocusNode();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thêm từ mới'),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Để dialog chỉ cao bằng nội dung bên trong
            children: [
              TextField(
                controller: enController,
                decoration: const InputDecoration(labelText: 'Tiếng Anh', hintText: 'VD: Hello'),
                autofocus: true, // Tự động bật bàn phím tại ô này
                textInputAction: TextInputAction.next, // Đổi nút dưới bàn phím thành "Next" (Tiếp tục)
                onSubmitted: (_) {
                  // Khi bấm nút Next trên bàn phím, nhảy sang ô Tiếng Việt
                  FocusScope.of(context).requestFocus(viFocusNode);
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: viController,
                focusNode: viFocusNode, // Gán focusNode vào đây
                decoration: const InputDecoration(labelText: 'Tiếng Việt', hintText: 'VD: Xin chào'),
                textInputAction: TextInputAction.done, // Đổi nút dưới bàn phím thành "Done" (Hoàn thành)
                onSubmitted: (_) {
                  // (Tùy chọn) Bấm Done trên bàn phím thì tự động kích hoạt lưu luôn giống như bấm nút "Lưu"
                  _handleSave(enController, viController);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                viFocusNode.dispose(); // Giải phóng focus node khi hủy
                Navigator.pop(context);
              },
              child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                viFocusNode.dispose(); // Giải phóng focus node khi lưu
                _handleSave(enController, viController);
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  // Tách hàm xử lý lưu riêng cho gọn sạch code
  void _handleSave(TextEditingController enController, TextEditingController viController) {
    if (enController.text.trim().isEmpty || viController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      _vocabList.insert(0, {
        'en': enController.text.trim(),
        'vi': viController.text.trim(),
      });
    });
    _saveVocabToLocal();
    Navigator.pop(context); // Tắt dialog
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách từ vựng'),
      ),
      // 4. Vẽ danh sách hoặc màn hình trống
      body: _vocabList.isEmpty
          ? const Center(child: Text('Chưa có từ vựng nào. Hãy thêm từ mới!'))
          : ListView.builder(
        itemCount: _vocabList.length,
        itemBuilder: (context, index) {
          final vocab = _vocabList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(vocab['en'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(vocab['vi'] ?? ''),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // 5. Chuyển hướng sang trang Chi tiết khi bấm vào item
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VocabDetailScreen(vocab: vocab),
                  ),
                );
              },
            ),
          );
        },
      ),
      // Nút mở Dialog
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        icon: const Icon(Icons.add),
        label: const Text('Thêm từ'),
      ),
    );
  }
}
