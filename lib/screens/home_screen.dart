import 'dart:ui';
import 'package:flutter/material.dart';
import 'roadmap_screen.dart';
import 'library_screen.dart';
import 'settings_screen.dart';
import 'sos_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userName;
  const HomeScreen({super.key, this.userName = 'کاربر'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // پس‌زمینه گرادیانت ملایم
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE0F7FA), Color(0xFFF3E5F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // محتوای اصلی
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // هدر: خوش‌آمدگویی و دکمه SOS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('سلام $userName 👋',
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00695C))),
                          const Text('امروز برای خودت چه می‌کنی؟',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.support_agent, color: Colors.red),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SosScreen())),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),

                  // گرید کارت‌های منو
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 1,
                      mainAxisSpacing: 20,
                      childAspectRatio: 2.2,
                      children: [
                        _menuCard(
                            context,
                            'مسیر ۳۰ روزه',
                            'نقشه راه تغییر',
                            Icons.map,
                            [const Color(0xFFEF5350), const Color(0xFFFFCDD2)],
                            () => const RoadmapScreen()),
                        _menuCard(
                            context,
                            'کتابخانه رشد',
                            'خلاصه ۲۰ کتاب مرجع',
                            Icons.library_books,
                            [const Color(0xFF42A5F5), const Color(0xFFBBDEFB)],
                            () => const LibraryScreen()),
                        _menuCard(
                            context,
                            'تنظیمات',
                            'شخصی‌سازی',
                            Icons.settings,
                            [const Color(0xFF66BB6A), const Color(0xFFC8E6C9)],
                            () => const SettingsScreen()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ویجت سازنده کارت منو با افکت شیشه‌ای
  Widget _menuCard(BuildContext context, String title, String sub,
      IconData icon, List<Color> colors, Function() page) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page())),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // پس‌زمینه رنگی گرادیانت
            Container(
                decoration:
                    BoxDecoration(gradient: LinearGradient(colors: colors))),

            // افکت مات شیشه‌ای (Glassmorphism)
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.white.withOpacity(0.1))),

            // آیکون بزرگ و شفاف در پس‌زمینه کارت
            Positioned(
                right: -20,
                bottom: -20,
                child: Icon(icon,
                    size: 120, color: Colors.white.withOpacity(0.3))),

            // متن و اطلاعات کارت
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Text(sub,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
