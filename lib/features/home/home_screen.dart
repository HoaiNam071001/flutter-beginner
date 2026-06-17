import 'package:flutter/material.dart';
import '../flashcards/add_vocab_screen.dart';
import '../flashcards/flashcard_screen.dart';
import '../settings/settings_screen.dart';
import './home_tab_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Danh sách 3 trang tương ứng với 3 tab
  final List<Widget> _pages = [
    const HomeTabContent(),    // Trang 0: Home
    const FlashcardScreen(),   // Trang 1: Flashcard (Nút giữa)
    const SettingsScreen(),    // Trang 2: Cài đặt
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      // 1. NÚT GIỮA NỔI BẬT (Giống MoMo)
      floatingActionButton: SizedBox(
        height: 65, // Tăng kích thước nút
        width: 65,
        child: FloatingActionButton(
          onPressed: () => _onItemTapped(1), // Bấm vào sẽ chuyển sang tab Flashcard
          backgroundColor: Colors.teal, // Màu nền nổi bật
          foregroundColor: Colors.white, // Màu icon
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35), // Bo tròn hoàn toàn
          ),
          child: const Icon(Icons.style, size: 32), // Icon to hơn
        ),
      ),

      // 2. VỊ TRÍ CỦA NÚT NỔI (Neo vào chính giữa thanh đáy)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 3. THANH ĐIỀU HƯỚNG ĐÁY CÓ RÃNH KHOÉT
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), // Tạo rãnh khoét hình tròn
        notchMargin: 8.0, // Khoảng cách từ nút đến rãnh
        color: Colors.white70,
        elevation: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Tab Trái
              _buildTabItem(
                index: 0,
                icon: Icons.home,
                label: 'Trang chủ',
              ),

              const SizedBox(width: 48), // Tạo khoảng trống ở giữa để nhường chỗ cho nút nổi

              // Tab Phải
              _buildTabItem(
                index: 2,
                icon: Icons.settings,
                label: 'Cài đặt',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm hỗ trợ vẽ từng Tab để code gọn gàng hơn
  Widget _buildTabItem({required int index, required IconData icon, required String label}) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? Colors.teal : Colors.grey; // Đổi màu nếu đang được chọn

    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(50), // Hiệu ứng ripple bo tròn khi bấm
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

