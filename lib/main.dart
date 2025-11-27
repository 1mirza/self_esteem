import 'package:flutter/material.dart';
import 'screens/onboarding_flow.dart';

void main() {
  runApp(const SelfEsteemApp());
}

class SelfEsteemApp extends StatelessWidget {
  const SelfEsteemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'رویش پلاس',
      debugShowCheckedModeBanner: false,
      // تنظیمات تم و رنگ‌بندی کلی اپلیکیشن
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F766E), // رنگ اصلی: سبز کله‌غازی (Teal)
          background: const Color(0xFFF8FAFC), // رنگ پس‌زمینه صفحات
        ),
        fontFamily:
            'Vazirmatn', // فونت فارسی (باید در pubspec.yaml تعریف شده باشد)
      ),
      // تنظیم جهت متن برای زبان فارسی (راست‌چین)
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      // صفحه شروع برنامه: فلو ورود (نام، سلب مسئولیت، آزمون)
      home: const OnboardingFlow(),
    );
  }
}
