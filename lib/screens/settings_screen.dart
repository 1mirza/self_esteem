import 'package:flutter/material.dart';
import '../models/data_models.dart';
import '../../main.dart'; // برای دسترسی به themeNotifier

class SettingsScreen extends StatefulWidget {
  final AppSettings? settings;

  const SettingsScreen({super.key, this.settings});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // متغیرهای وضعیت
  late bool _dailyReminder;
  late bool _nightReminder;
  late TimeOfDay _morningTime;
  late TimeOfDay _nightTime;

  @override
  void initState() {
    super.initState();
    // مقداردهی اولیه (در یک اپ واقعی این‌ها از دیتابیس خوانده می‌شوند)
    _dailyReminder = widget.settings?.isDailyCheckInEnabled ?? true;
    _nightReminder = widget.settings?.isNightReminderEnabled ?? true;
    _morningTime =
        widget.settings?.morningReminder ?? const TimeOfDay(hour: 9, minute: 0);
    _nightTime =
        widget.settings?.nightReminder ?? const TimeOfDay(hour: 23, minute: 0);
  }

  Future<void> _pickTime(bool isMorning) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isMorning ? _morningTime : _nightTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF0F766E)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isMorning) {
          _morningTime = picked;
        } else {
          _nightTime = picked;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ساعت یادآوری روی ${picked.format(context)} تنظیم شد.'),
          backgroundColor: const Color(0xFF0F766E),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // تشخیص تم فعلی
    final isDark = themeNotifier.value == ThemeMode.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final cardColor = isDark ? Colors.grey.shade900 : Colors.white;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'تنظیمات',
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
        centerTitle: true,
        backgroundColor: cardColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'یادآوری‌های هوشمند',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F766E)),
          ),
          const SizedBox(height: 16),

          // کارت یادآوری روزانه
          _buildSettingsCard(
            color: cardColor,
            child: Column(
              children: [
                SwitchListTile(
                  value: _dailyReminder,
                  onChanged: (v) => setState(() => _dailyReminder = v),
                  title: const Text('یادآوری صبحگاهی (مچ‌گیری)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  activeColor: const Color(0xFF0F766E),
                  secondary: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.wb_sunny, color: Colors.orange),
                  ),
                ),
                if (_dailyReminder) ...[
                  const Divider(indent: 60),
                  ListTile(
                    title: const Text('زمان ارسال'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(_morningTime.format(context),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey)),
                    ),
                    onTap: () => _pickTime(true),
                  ),
                ]
              ],
            ),
          ),

          const SizedBox(height: 16),

          // کارت یادآوری شبانه
          _buildSettingsCard(
            color: cardColor,
            child: Column(
              children: [
                SwitchListTile(
                  value: _nightReminder,
                  onChanged: (v) => setState(() => _nightReminder = v),
                  title: const Text('یادآوری شبانه (کودک درون)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  activeColor: const Color(0xFF0F766E),
                  secondary: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.nightlight_round,
                        color: Colors.indigo),
                  ),
                ),
                if (_nightReminder) ...[
                  const Divider(indent: 60),
                  ListTile(
                    title: const Text('زمان ارسال'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(_nightTime.format(context),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey)),
                    ),
                    onTap: () => _pickTime(false),
                  ),
                ]
              ],
            ),
          ),

          const SizedBox(height: 32),
          const Text(
            'شخصی‌سازی',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F766E)),
          ),
          const SizedBox(height: 16),

          // تنظیمات دارک مود
          _buildSettingsCard(
            color: cardColor,
            child: SwitchListTile(
              value: isDark,
              onChanged: (val) {
                // تغییر تم در کل برنامه
                themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
              },
              title: const Text('حالت شب (Dark Mode)',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              activeColor: const Color(0xFF0F766E),
              secondary: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.dark_mode),
              ),
            ),
          ),

          const SizedBox(height: 32),
          const Text(
            'درباره ما',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F766E)),
          ),
          const SizedBox(height: 16),

          _buildSettingsCard(
            color: cardColor,
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.info_outline, color: Colors.blue),
                  title: Text('نسخه برنامه'),
                  trailing: Text('1.0.0',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.code, color: Colors.purple),
                  title: Text('طراحی و توسعه'),
                  subtitle: Text('حمیدرضا علی‌میرزایی',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const Divider(),
                ListTile(
                  leading:
                      const Icon(Icons.feedback_outlined, color: Colors.green),
                  title: const Text('ارسال بازخورد'),
                  subtitle: const Text('نظرات شما به ما کمک می‌کند.'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'لطفاً نظرات خود را به ایمیل پشتیبانی ارسال کنید.')),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
          Center(
            child: Text(
              'ساخته شده با ❤️ و علم روانشناسی',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSettingsCard({required Widget child, required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: child,
    );
  }
}
