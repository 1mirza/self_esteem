import 'package:flutter/material.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
          0xFFFEE2E2), // پس‌زمینه قرمز ملایم برای حس اضطرار اما نه ترسناک
      appBar: AppBar(
        title: const Text(
          'جعبه کمک‌های اولیه (SOS)',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFFEF4444), // قرمز استاندارد
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'وقتی اضطراب شدید داری یا حالت بده، یکی از این‌ها رو انتخاب کن:',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF991B1B)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildSosCard(
            context,
            title: 'تکنیک تنفس ۴-۷-۸',
            subtitle: 'آرام‌سازی فوری سیستم عصبی',
            icon: Icons.air,
            color: Colors.blue,
            onTap: () {
              _showDetailDialog(
                  context,
                  'تکنیک تنفس ۴-۷-۸',
                  '۱. زبان خود را پشت دندان‌های بالا قرار دهید.\n'
                      '۲. با صدای "هوو" بازدم کنید.\n'
                      '۳. دهان را ببندید و ۴ ثانیه با بینی دم بگیرید.\n'
                      '۴. نفس را ۷ ثانیه حبس کنید.\n'
                      '۵. با صدای "هوو" به مدت ۸ ثانیه بازدم کنید.\n\n'
                      'این چرخه را ۴ بار تکرار کنید.');
            },
          ),
          _buildSosCard(
            context,
            title: 'گراندینگ (۵ حس)',
            subtitle: 'کنترل پنیک و بازگشت به لحظه حال',
            icon: Icons.touch_app,
            color: Colors.green,
            onTap: () {
              _showDetailDialog(
                  context,
                  'تکنیک ۵ حس (Grounding)',
                  'به اطراف نگاه کن و نام ببر:\n\n'
                      '👀 ۵ چیزی که می‌بینی\n'
                      '✋ ۴ چیزی که می‌تونی لمس کنی\n'
                      '👂 ۳ صدایی که می‌شنوی\n'
                      '👃 ۲ بویی که حس می‌کنی\n'
                      '👅 ۱ مزه‌ای که در دهان داری');
            },
          ),
          _buildSosCard(
            context,
            title: 'تماس با دوست امن',
            subtitle: 'کسی که قضاوتت نمی‌کنه',
            icon: Icons.phone_in_talk,
            color: Colors.orange,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('لیست مخاطبین باز شد... (شبیه‌سازی)')),
              );
            },
          ),
          _buildSosCard(
            context,
            title: 'اورژانس اجتماعی (۱۲۳)',
            subtitle: 'اگر افکار آسیب‌رسان داری',
            icon: Icons.local_hospital,
            color: Colors.red,
            isEmergency: true,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تماس با ۱۲۳...')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSosCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isEmergency = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: isEmergency ? 8 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: isEmergency
            ? const BorderSide(color: Colors.red, width: 2)
            : BorderSide.none,
      ),
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isEmergency ? Colors.red : Colors.black87,
          ),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded,
            size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _showDetailDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF0F766E))),
        content: Text(content,
            style: const TextStyle(height: 1.8, fontSize: 16),
            textAlign: TextAlign.justify),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('باشه، انجام میدم',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
