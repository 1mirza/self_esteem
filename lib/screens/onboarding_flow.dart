import 'package:flutter/material.dart';
import 'home_screen.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  String _userName = '';
  int _score = 0;
  final Map<int, int> _answers = {};

  final List<String> _questions = [
    '۱. احساس می‌کنم فردی با ارزش هستم.',
    '۲. احساس می‌کنم ویژگی‌های خوب زیادی دارم.',
    '۳. به طور کلی، خودم را یک شکست‌خورده می‌بینم.',
    '۴. من توانایی انجام کارها را دارم.',
    '۵. احساس می‌کنم چیز زیادی برای افتخار ندارم.',
    '۶. نگرش مثبتی به خودم دارم.',
    '۷. از خودم راضی هستم.',
    '۸. کاش احترام بیشتری برای خودم قائل بودم.',
    '۹. گاهی احساس بی‌مصرفی می‌کنم.',
    '۱۰. گاهی فکر می‌کنم اصلاً خوب نیستم.',
  ];

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildDisclaimer(),
          _buildNameInput(),
          _buildAssessment(),
          _buildResult(),
        ],
      ),
    );
  }

  Widget _buildDisclaimer() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.security, size: 80, color: Color(0xFF0F766E)),
          const SizedBox(height: 20),
          const Text(
            'بیانیه سلب مسئولیت',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'این اپلیکیشن ابزار آموزشی است و جایگزین درمان نیست.\nدر صورت نیاز با متخصص تماس بگیرید.',
            textAlign: TextAlign.center,
            style: TextStyle(height: 1.8),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F766E),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('می‌پذیرم'),
          ),
        ],
      ),
    );
  }

  Widget _buildNameInput() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'نام شما چیست؟',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'نام...',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty) {
                setState(() => _userName = _nameController.text);
                _nextPage();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F766E),
              foregroundColor: Colors.white,
            ),
            child: const Text('ادامه'),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessment() {
    return Column(
      children: [
        const SizedBox(height: 50),
        const Text(
          'پرسشنامه روزنبرگ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _questions.length,
            itemBuilder: (ctx, idx) => ListTile(
              title: Text(_questions[idx]),
              subtitle: Row(
                children: [0, 1, 2, 3].map((s) {
                  return TextButton(
                    onPressed: () => setState(() => _answers[idx] = s),
                    style: TextButton.styleFrom(
                      backgroundColor: _answers[idx] == s ? Colors.teal : null,
                      foregroundColor:
                          _answers[idx] == s ? Colors.white : Colors.black,
                    ),
                    child: Text('$s'),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _answers.length == 10
                ? () {
                    int total = 0;
                    // محاسبه ساده نمره
                    _answers.forEach((k, v) => total += v);
                    setState(() => _score = total);
                    _nextPage();
                  }
                : null,
            child: const Text('ثبت'),
          ),
        )
      ],
    );
  }

  Widget _buildResult() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'سلام $_userName',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'نمره شما: $_score',
            style: const TextStyle(fontSize: 40, color: Colors.teal),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(userName: _userName),
              ),
            ),
            child: const Text('ورود به برنامه'),
          ),
        ],
      ),
    );
  }
}
