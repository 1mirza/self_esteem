import 'package:flutter/material.dart';

class LadderTool extends StatefulWidget {
  const LadderTool({super.key});

  @override
  State<LadderTool> createState() => _LadderToolState();
}

class _LadderToolState extends State<LadderTool> {
  // وضعیت چک‌باکس‌ها
  bool _step1 = false;
  bool _step2 = false;
  bool _step3 = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'نردبان شجاعت (مواجهه)',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F766E)),
          ),
          const SizedBox(height: 8),
          const Text(
            'ترس‌های خود را به پله‌های کوچک تقسیم کنید. هر پله‌ای که بالا می‌روید، به مغزتان ثابت می‌کند که "من می‌توانم". فراموش نکنید که حتماً پاداش بگیرید!',
            style: TextStyle(color: Colors.grey, height: 1.5),
          ),
          const SizedBox(height: 20),

          // پله ۱
          _buildLadderStep(
            stepNumber: 1,
            title: 'پله آسان (شروع)',
            color: Colors.green,
            task: 'مثلاً: پرسیدن ساعت از یک غریبه.',
            reward: 'یک فنجان چای یا قهوه.',
            isChecked: _step1,
            onChanged: (v) => setState(() => _step1 = v!),
          ),

          // پله ۲
          _buildLadderStep(
            stepNumber: 2,
            title: 'پله متوسط (چالش)',
            color: Colors.orange,
            task: 'مثلاً: نه گفتن به یک درخواست کوچک.',
            reward: 'دیدن یک قسمت از سریال مورد علاقه.',
            isChecked: _step2,
            onChanged: (v) => setState(() => _step2 = v!),
          ),

          // پله ۳
          _buildLadderStep(
            stepNumber: 3,
            title: 'پله سخت (قهرمان)',
            color: Colors.red,
            task: 'مثلاً: ارائه نظر مخالف در جمع.',
            reward: 'خرید یک هدیه کوچک برای خود.',
            isChecked: _step3,
            onChanged: (v) => setState(() => _step3 = v!),
          ),

          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                int completed = 0;
                if (_step1) completed++;
                if (_step2) completed++;
                if (_step3) completed++;

                if (completed > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'تبریک! شما $completed قدم به سمت شجاعت برداشتید.'),
                      backgroundColor: const Color(0xFF0F766E),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('هنوز هیچ پله‌ای را تیک نزنیده‌اید.'),
                      backgroundColor: Colors.grey,
                    ),
                  );
                }
              },
              icon: const Icon(Icons.celebration),
              label: const Text('ثبت موفقیت‌ها'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF59E0B), // Amber for success
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

  Widget _buildLadderStep({
    required int stepNumber,
    required String title,
    required Color color,
    required String task,
    required String reward,
    required bool isChecked,
    required Function(bool?) onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withOpacity(0.3), width: 1),
      ),
      elevation: 0,
      color: color.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color,
                  radius: 14,
                  child: Text('$stepNumber',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ),
                const SizedBox(width: 10),
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: color)),
                const Spacer(),
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    value: isChecked,
                    onChanged: onChanged,
                    activeColor: color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Icon(Icons.task_alt, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(task, style: const TextStyle(fontSize: 13))),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.card_giftcard, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(reward,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
