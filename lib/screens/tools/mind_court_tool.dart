import 'package:flutter/material.dart';

class MindCourtTool extends StatefulWidget {
  const MindCourtTool({super.key});

  @override
  State<MindCourtTool> createState() => _MindCourtToolState();
}

class _MindCourtToolState extends State<MindCourtTool> {
  final _accusationController = TextEditingController();
  final _defenseController = TextEditingController();
  final _verdictController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'دادگاه ذهن ⚖️',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo),
          ),
          const SizedBox(height: 8),
          const Text(
            'وکیل مدافع خودت باش! اجازه نده افکار منفی بدون مدرک محکومت کنند. نقش دادستان (فکر منفی) و وکیل مدافع (واقعیت) را بازی کن و در نهایت حکم عادلانه بده.',
            style: TextStyle(color: Colors.grey, height: 1.5),
          ),
          const SizedBox(height: 20),

          // بخش ۱: دادستان
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.gavel, size: 20, color: Colors.red),
                    SizedBox(width: 8),
                    Text('دادستان (اتهام/فکر منفی)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red)),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _accusationController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'مثلاً: من در ارائه خراب کردم، پس بی‌عرضه‌ام...',
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // بخش ۲: وکیل مدافع
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.shield, size: 20, color: Colors.green),
                    SizedBox(width: 8),
                    Text('وکیل مدافع (شواهد واقعی)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _defenseController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText:
                        'مثلاً: ولی بقیه اسلایدها خوب بود. همه اشتباه می‌کنند. این فقط یک تپق بود نه فاجعه...',
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // بخش ۳: قاضی (حکم نهایی)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.indigo.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.balance, size: 20, color: Colors.indigo),
                    SizedBox(width: 8),
                    Text('قاضی (حکم نهایی/فکر سالم)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.indigo)),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _verdictController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'یک نتیجه‌گیری منصفانه بنویس...',
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_accusationController.text.isNotEmpty &&
                    _verdictController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('حکم برائت صادر شد! ذهنت آرام‌تر شد؟'),
                      backgroundColor: Colors.indigo,
                    ),
                  );
                  // پاک کردن فیلدها برای شروع جدید
                  _accusationController.clear();
                  _defenseController.clear();
                  _verdictController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('لطفاً اتهام و حکم نهایی را کامل کنید.'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              icon: const Icon(Icons.check_circle),
              label: const Text('ختم جلسه و صدور حکم'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
