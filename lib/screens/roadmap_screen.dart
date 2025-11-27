import 'package:flutter/material.dart';
import '../data/app_data.dart';
import 'daily_lesson_screen.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // دریافت لیست ۳۰ روز از دیتابیس
    final days = AppDataRepository.get30DayPlan();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'نقشه راه ۳۰ روزه 🗺️',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          // تعیین رنگ آواتار بر اساس نوع تمرین
          Color avatarColor;
          IconData avatarIcon;

          switch (day.exerciseType) {
            case 'journaling':
              avatarColor = Colors.pinkAccent;
              avatarIcon = Icons.edit;
              break;
            case 'court':
              avatarColor = Colors.blueAccent;
              avatarIcon = Icons.gavel;
              break;
            case 'voice':
              avatarColor = Colors.purpleAccent;
              avatarIcon = Icons.mic;
              break;
            case 'ladder':
              avatarColor = Colors.orangeAccent;
              avatarIcon = Icons.trending_up;
              break;
            default:
              avatarColor = const Color(0xFF0F766E);
              avatarIcon = Icons.star;
          }

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                backgroundColor: avatarColor.withOpacity(0.1),
                child: Text(
                  '${day.dayNumber}',
                  style: TextStyle(
                      color: avatarColor, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                day.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    Icon(avatarIcon, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        day.description,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: const Icon(Icons.lock_open,
                  color: Colors.green), // نشان می‌دهد که همه مراحل باز هستند
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DailyLessonScreen(day: day)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
