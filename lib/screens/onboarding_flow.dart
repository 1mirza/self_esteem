import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // برای ذخیره‌سازی
import 'home_screen.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();

  // متغیرهای وضعیت
  String? _savedName;
  int? _savedScore;
  bool _isLoading = true;

  // داده‌های کاربر جدید
  String _userName = '';
  int _score = 0;
  final Map<int, int> _answers = {};

  final List<String> _questions = [
    '۱. احساس می‌کنم فردی با ارزش هستم، حداقل برابر با دیگران.',
    '۲. احساس می‌کنم ویژگی‌های خوب زیادی دارم.',
    '۳. به طور کلی، خودم را یک شکست‌خورده می‌بینم.', // معکوس
    '۴. من توانایی انجام کارها را به خوبیِ دیگران دارم.',
    '۵. احساس می‌کنم چیز زیادی برای افتخار ندارم.', // معکوس
    '۶. نگرش مثبتی به خودم دارم.',
    '۷. از خودم راضی هستم.',
    '۸. کاش احترام بیشتری برای خودم قائل بودم.', // معکوس
    '۹. گاهی احساس بی‌مصرفی می‌کنم.', // معکوس
    '۱۰. گاهی فکر می‌کنم اصلاً خوب نیستم.', // معکوس
  ];

  // سوالاتی که نمره معکوس دارند
  final Set<int> _reverseScored = {2, 4, 7, 8, 9};

  @override
  void initState() {
    super.initState();
    _checkSavedData();
  }

  // بررسی اینکه آیا کاربر قبلاً ثبت نام کرده است؟
  Future<void> _checkSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedName = prefs.getString('user_name');
      _savedScore = prefs.getInt('user_score');
      _isLoading = false;
    });
  }

  // ذخیره اطلاعات کاربر جدید
  Future<void> _saveAndFinish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _userName);
    await prefs.setInt('user_score', _score);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen(userName: _userName)),
      );
    }
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuart,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // جلوگیری از اسکرول دستی
        children: [
          _buildDisclaimer(), // همیشه نمایش داده می‌شود
          if (_savedName == null) _buildNameInput(), // فقط اگر کاربر جدید باشد
          if (_savedName == null) _buildAssessment(), // فقط اگر کاربر جدید باشد
          if (_savedName == null) _buildResult(), // فقط اگر کاربر جدید باشد
        ],
      ),
    );
  }

  // --- صفحه ۱: سلب مسئولیت (بهبود یافته) ---
  Widget _buildDisclaimer() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xFFF0FDFA)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.gpp_maybe_rounded, size: 80, color: Colors.orange),
            const SizedBox(height: 24),
            const Text(
              'هشدارهای مهم و سلب مسئولیت',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.orange.shade100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.orange.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ],
              ),
              child: const Column(
                children: [
                  _DisclaimerItem(
                    icon: Icons.medical_information,
                    text:
                        'این برنامه جایگزین روان‌درمانی یا دارو نیست. این فقط یک ابزار کمکی و آموزشی است.',
                  ),
                  SizedBox(height: 12),
                  _DisclaimerItem(
                    icon: Icons.warning_amber,
                    text:
                        'مسیر تغییر عزت‌نفس ساده نیست. ممکن است با احساسات ناخوشایندی روبرو شوید. این بخشی از درمان است.',
                  ),
                  SizedBox(height: 12),
                  _DisclaimerItem(
                    icon: Icons.call,
                    text:
                        'اگر افکار آسیب‌رسان یا خودکشی دارید، لطفاً فوراً با اورژانس اجتماعی (۱۲۳) تماس بگیرید.',
                    isBold: true,
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (_savedName != null) {
                    // اگر قبلاً ثبت نام کرده، مستقیم برو خانه
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => HomeScreen(userName: _savedName!)),
                    );
                  } else {
                    // اگر کاربر جدید است، برو مرحله بعد
                    _nextPage();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F766E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
                child: const Text('متوجه شدم و می‌پذیرم',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- صفحه ۲: نام (شیک‌تر) ---
  Widget _buildNameInput() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🌱', style: TextStyle(fontSize: 60)),
          const SizedBox(height: 20),
          const Text('شروع یک دوستی تازه',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F766E))),
          const SizedBox(height: 8),
          const Text('دوست داری چی صدات کنیم؟',
              style: TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 40),
          TextField(
            controller: _nameController,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: 'نام شما...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey.shade200)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: Color(0xFF0F766E), width: 2)),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                if (_nameController.text.trim().isNotEmpty) {
                  setState(() => _userName = _nameController.text.trim());
                  _nextPage();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F766E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('ادامه',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // --- صفحه ۳: آزمون (زیباسازی شده) ---
  Widget _buildAssessment() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('سنجش اولیه',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // نوار پیشرفت
          LinearProgressIndicator(
            value: _answers.length / 10,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0F766E)),
            minHeight: 6,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('سوال ${_answers.length} از ۱۰',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFF0F766E))),
                const Text('پرسشنامه روزنبرگ',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                final isAnswered = _answers.containsKey(index);
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: isAnswered
                      ? 0.5
                      : 1.0, // سوالات پاسخ داده شده کمرنگ می‌شوند
                  child: Card(
                    elevation: isAnswered ? 0 : 4,
                    shadowColor: const Color(0xFF0F766E).withOpacity(0.2),
                    margin: const EdgeInsets.only(bottom: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: isAnswered
                          ? BorderSide(color: Colors.grey.shade200)
                          : BorderSide.none,
                    ),
                    color: isAnswered ? Colors.grey.shade50 : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _questions[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                              color: isAnswered ? Colors.grey : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: [
                              _buildChoiceChip(index, 3, 'کاملاً موافقم'),
                              _buildChoiceChip(index, 2, 'موافقم'),
                              _buildChoiceChip(index, 1, 'مخالفم'),
                              _buildChoiceChip(index, 0, 'کاملاً مخالفم'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // دکمه پایین
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5))
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _answers.length == 10
                    ? () {
                        // محاسبه نمره
                        int total = 0;
                        _answers.forEach((idx, score) {
                          if (_reverseScored.contains(idx)) {
                            total += (3 - score); // معکوس
                          } else {
                            total += score;
                          }
                        });
                        setState(() => _score = total);
                        _nextPage();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F766E),
                  disabledBackgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  _answers.length == 10
                      ? 'مشاهده تحلیل و ورود'
                      : '${10 - _answers.length} سوال دیگر باقی مانده',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceChip(int qIndex, int score, String label) {
    final isSelected = _answers[qIndex] == score;
    return InkWell(
      onTap: () => setState(() => _answers[qIndex] = score),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F766E) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // --- صفحه ۴: نتیجه و ذخیره ---
  Widget _buildResult() {
    String status = _score < 15
        ? 'عزت‌نفس پایین'
        : (_score < 25 ? 'عزت‌نفس متوسط' : 'عزت‌نفس بالا');
    Color statusColor = _score < 15
        ? Colors.orange
        : (_score < 25 ? Colors.blue : Colors.green);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.analytics_rounded,
                size: 80, color: Color(0xFF0F766E)),
            const SizedBox(height: 30),
            Text(
              'تحلیل اولیه وضعیت $_userName',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              'نمره شما: $_score از ۳۰',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: statusColor),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(status,
                  style: TextStyle(
                      color: statusColor, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 40),
            const Text(
              'این نمره فقط نقطه شروع ماست. \nدر ۳۰ روز آینده با هم روی این عدد کار می‌کنیم.',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.6, color: Colors.black87),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _saveAndFinish, // ذخیره و رفتن به خانه
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F766E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 5,
                ),
                child: const Text('ساخت پروفایل و شروع',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ویجت کمکی برای آیتم‌های سلب مسئولیت
class _DisclaimerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isBold;

  const _DisclaimerItem(
      {required this.icon, required this.text, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: isBold ? Colors.red : Colors.grey.shade700),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              height: 1.6,
              color: isBold ? Colors.red.shade900 : Colors.black87,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
