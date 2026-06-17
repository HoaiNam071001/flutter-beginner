import 'package:flutter/material.dart';

class FlashcardScreen extends StatelessWidget {
  const FlashcardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu mẫu (Giả lập list từ vựng)
    final words = [
      {"en": "Ubiquitous", "vi": "Có mặt ở khắp mọi nơi"},
      {"en": "Ephemeral", "vi": "Phù du, chóng vánh"},
      {"en": "Eloquent", "vi": "Có tài hùng biện, lưu loát"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Thẻ Flashcard')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: words.length,
        itemBuilder: (context, index) {
          return VocabCard(
            englishWord: words[index]["en"]!,
            vietnameseMeaning: words[index]["vi"]!,
          );
        },
      ),
    );
  }
}

// Widget thẻ từ vựng (Có trạng thái lật/chưa lật)
class VocabCard extends StatefulWidget {
  final String englishWord;
  final String vietnameseMeaning;

  const VocabCard({super.key, required this.englishWord, required this.vietnameseMeaning});

  @override
  State<VocabCard> createState() => _VocabCardState();
}

class _VocabCardState extends State<VocabCard> {
  bool _isFlipped = false; // Trạng thái thẻ: false = Tiếng Anh, true = Tiếng Việt

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFlipped = !_isFlipped; // Đảo trạng thái khi chạm
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300), // Hiệu ứng chuyển màu mượt
        margin: const EdgeInsets.only(bottom: 16),
        height: 120,
        decoration: BoxDecoration(
          color: _isFlipped ? Colors.teal.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
          border: Border.all(color: Colors.teal.shade200),
        ),
        child: Center(
          child: Text(
            _isFlipped ? widget.vietnameseMeaning : widget.englishWord,
            style: TextStyle(
              fontSize: 22, 
              fontWeight: FontWeight.bold,
              color: _isFlipped ? Colors.teal.shade900 : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
