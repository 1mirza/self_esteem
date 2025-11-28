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
      backgroundColor: const Color(0xFFF8FAFC), // پس‌زمینه خیلی روشن
      body: Stack(
        children: [
          // تزئینات پس‌زمینه (حباب‌های رنگی محو)
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0F766E).withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange.withOpacity(0.1),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
              child: Column(
                children: [
                  // هدر: خوش‌آمدگویی
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('سلام $userName عزیز 👋',
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF1E293B))),
                          const SizedBox(height: 4),
                          Text('آماده‌ی یک تغییر بزرگی؟',
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFF0F766E), width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFF0F766E),
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // لیست کارت‌ها
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        // کارت ۱: مسیر ۳۰ روزه (بزرگ)
                        _buildMenuCard(
                          context,
                          title: 'مسیر ۳۰ روزه',
                          subtitle: 'نقشه راه تغییر و رشد',
                          icon: Icons.map_outlined,
                          // گرادیانت نارنجی/صورتی (Sunset)
                          gradientColors: [
                            const Color(0xFFFF512F),
                            const Color(0xFFDD2476)
                          ],
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RoadmapScreen())),
                        ),

                        const SizedBox(height: 20),

                        // کارت ۲: کتابخانه (بزرگ)
                        _buildMenuCard(
                          context,
                          title: 'کتابخانه رشد',
                          subtitle: 'خلاصه ۲۰ کتاب مرجع',
                          icon: Icons.auto_stories_outlined,
                          // گرادیانت آبی/فیروزه‌ای (Ocean)
                          gradientColors: [
                            const Color(0xFF2193b0),
                            const Color(0xFF6dd5ed)
                          ],
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LibraryScreen())),
                        ),

                        const SizedBox(height: 20),

                        // ردیف کارت‌های کوچک (SOS و تنظیمات)
                        Row(
                          children: [
                            Expanded(
                              child: _buildMenuCard(
                                context,
                                title: 'جعبه ابزار',
                                subtitle: 'SOS',
                                icon: Icons.medical_services_outlined,
                                // گرادیانت سبز/یشمی (Lush)
                                gradientColors: [
                                  const Color(0xFF11998e),
                                  const Color(0xFF38ef7d)
                                ],
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const SosScreen())),
                                isSmall: true,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: _buildMenuCard(
                                context,
                                title: 'تنظیمات',
                                subtitle: 'شخصی‌سازی',
                                icon: Icons.settings_outlined,
                                // گرادیانت بنفش/آبی (Royal)
                                gradientColors: [
                                  const Color(0xFF8E2DE2),
                                  const Color(0xFF4A00E0)
                                ],
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const SettingsScreen())),
                                isSmall: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
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

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradientColors,
    required VoidCallback onTap,
    bool isSmall = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isSmall ? 160 : 140, // ارتفاع کارت‌ها
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // افکت گلس (دایره شیشه‌ای تزئینی)
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),

            // آیکون بزرگ در پس‌زمینه
            Positioned(
              bottom: -20,
              left: -20,
              child: Icon(
                icon,
                size: isSmall ? 80 : 100,
                color: Colors.white.withOpacity(0.15),
              ),
            ),

            // محتوا
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // آیکون کوچک داخل کادر شیشه‌ای
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),

                  const Spacer(),

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900, // فونت خیلی ضخیم
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),

                  if (!isSmall) ...[
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // فلش جهت‌نما (فقط برای کارت‌های بزرگ)
            if (!isSmall)
              const Positioned(
                top: 24,
                left: 24,
                child: Icon(Icons.arrow_outward_rounded, color: Colors.white70),
              ),
          ],
        ),
      ),
    );
  }
}
