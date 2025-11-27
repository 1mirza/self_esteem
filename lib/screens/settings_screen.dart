import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // متغیرهای وضعیت (برای دمو)
  bool _dailyReminder = true;
  bool _nightReminder = true;
  bool _darkMode = false;
  TimeOfDay _morningTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _nightTime = const TimeOfDay(hour: 23, minute: 0);

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'تنظیمات',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'یادآوری‌ها',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F766E)),
          ),
          const SizedBox(height: 16),

          // یادآوری روزانه
          _buildSettingsCard(
            child: Column(
              children: [
                SwitchListTile(
                  value: _dailyReminder,
                  onChanged: (v) => setState(() => _dailyReminder = v),
                  title: const Text('یادآوری روزانه (مچ‌گیری)',
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
                if (_dailyReminder)
                  ListTile(
                    title: const Text('زمان یادآوری'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(_morningTime.format(context),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () => _pickTime(true),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // یادآوری شبانه
          _buildSettingsCard(
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
                if (_nightReminder)
                  ListTile(
                    title: const Text('زمان یادآوری'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(_nightTime.format(context),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    onTap: () => _pickTime(false),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          const Text(
            'ظاهر برنامه',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F766E)),
          ),
          const SizedBox(height: 16),

          _buildSettingsCard(
            child: SwitchListTile(
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
              title: const Text('حالت شب (Dark Mode)',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('فعلاً در مرحله آزمایشی است'),
              activeColor: const Color(0xFF0F766E),
              secondary: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.dark_mode, color: Colors.black87),
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
                  subtitle: Text('حمیدرضا علی‌میرزایی'),
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
              'ساخته شده با ❤️ برای رشد شما',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSettingsCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: child,
    );
  }
}
