import 'package:flutter/material.dart';
import 'screens/onboarding_flow.dart';

// ۱. متغیر سراسری برای مدیریت وضعیت تم (روشن/تاریک)
// این متغیر توسط صفحه تنظیمات تغییر می‌کند
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  // اطمینان از اینکه بایندینگ‌های فلاتر قبل از اجرا مقداردهی شده‌اند
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const SelfEsteemApp());
}

class SelfEsteemApp extends StatelessWidget {
  const SelfEsteemApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ۲. استفاده از ValueListenableBuilder برای گوش دادن به تغییرات تم
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'تقویت عزت نفس ',
          debugShowCheckedModeBanner: false,

          // ۳. تنظیمات تم روشن (Light Theme)
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF0F766E), // سبز کله‌غازی
              background: const Color(0xFFF8FAFC), // پس‌زمینه روشن
              brightness: Brightness.light,
            ),
            fontFamily: 'Vazirmatn',
          ),

          // ۴. تنظیمات تم تاریک (Dark Theme) - اضافه شده
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF0F766E),
              background: const Color(0xFF121212), // پس‌زمینه تیره
              brightness: Brightness.dark,
            ),
            fontFamily: 'Vazirmatn',
            scaffoldBackgroundColor: const Color(0xFF121212),
          ),

          // ۵. اعمال وضعیت فعلی تم (که از تنظیمات می‌آید)
          themeMode: currentMode,

          // تنظیم جهت متن برای زبان فارسی (راست‌چین - RTL)
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },

          home: const OnboardingFlow(),
        );
      },
    );
  }
}
