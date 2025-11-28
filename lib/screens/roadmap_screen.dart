import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/data_models.dart';
import 'daily_lesson_screen.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // دریافت لیست ۳۰ روز از دیتابیس
    final days = AppDataRepository.get30DayPlan();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F9FF), // پس‌زمینه آبی خیلی روشن
      appBar: AppBar(
        title: const Text(
          'نقشه راه ۳۰ روزه',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          return _buildBeautifulDayCard(context, day);
        },
      ),
    );
  }

  Widget _buildBeautifulDayCard(BuildContext context, DayPlanModel day) {
    // تعیین رنگ‌بندی کارت بر اساس نوع تمرین روزانه
    Color cardColor;
    Color accentColor;
    IconData icon;
    String label;

    switch (day.exerciseType) {
      case 'journaling':
        cardColor = const Color(0xFFFFF1F2); // صورتی روشن
        accentColor = const Color(0xFFE11D48); // صورتی تیره
        icon = Icons.edit_note;
        label = 'تمرین نوشتاری';
        break;
      case 'court':
        cardColor = const Color(0xFFEFF6FF); // آبی روشن
        accentColor = const Color(0xFF2563EB); // آبی تیره
        icon = Icons.gavel;
        label = 'تمرین منطقی';
        break;
      case 'voice':
        cardColor = const Color(0xFFFAF5FF); // بنفش روشن
        accentColor = const Color(0xFF9333EA); // بنفش تیره
        icon = Icons.mic;
        label = 'تمرین صوتی';
        break;
      default: // ladder
        cardColor = const Color(0xFFFFF7ED); // نارنجی روشن
        accentColor = const Color(0xFFEA580C); // نارنجی تیره
        icon = Icons.trending_up;
        label = 'تمرین عملی';
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DailyLessonScreen(day: day)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // نوار رنگی سمت راست (نشان‌دهنده نوع تمرین)
                Container(
                  width: 8,
                  color: accentColor,
                ),
                // محتوای اصلی کارت
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ردیف بالا: شماره روز و وضعیت
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'روز ${day.dayNumber}',
                                style: TextStyle(
                                  color: accentColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            // آیکون وضعیت (چون همه باز هستند، دکمه پلی نمایش داده می‌شود)
                            Icon(
                              day.isCompleted
                                  ? Icons.check_circle
                                  : Icons.play_circle_fill,
                              color: accentColor,
                              size: 28,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // عنوان روز
                        Text(
                          day.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // توضیحات کوتاه
                        Text(
                          day.description,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        // ردیف پایین: نوع تمرین
                        Row(
                          children: [
                            Icon(icon, size: 16, color: Colors.grey.shade400),
                            const SizedBox(width: 6),
                            Text(
                              label,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
