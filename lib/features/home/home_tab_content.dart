import 'package:flutter/material.dart';
import '../flashcards/add_vocab_screen.dart';


// Đây là nội dung đơn giản của Tab đầu tiên (Trang chủ)
class HomeTabContent extends StatelessWidget {
  const HomeTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tổng quan')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 80, color: Colors.teal),
            const SizedBox(height: 20),
            Text(
              'Chào mừng bạn trở lại!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            const Text('Hôm nay bạn có 20 từ vựng cần ôn tập.'),

            const SizedBox(height: 40), // Tạo khoảng trống

            // THÊM NÚT BẤM NÀY ĐỂ CHUYỂN TRANG
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Thêm từ mới ngay'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // SỬ DỤNG NAVIGATOR ĐỂ CHUYỂN TRANG (PUSH)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddVocabScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
