import 'package:flutter/material.dart';
import '../models/data_models.dart';
import 'tools/journal_tool.dart';
import 'tools/mind_court_tool.dart';
import 'tools/audio_studio_tool.dart';
import 'tools/ladder_tool.dart';
import 'library_screen.dart'; // برای باز کردن جزئیات کتاب

class DailyLessonScreen extends StatefulWidget {
  final DayPlanModel day;
  const DailyLessonScreen({super.key, required this.day});

  @override
  State<DailyLessonScreen> createState() => _DailyLessonScreenState();
}

class _DailyLessonScreenState extends State<DailyLessonScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.day.title,
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF0F766E),
          indicatorColor: const Color(0xFF0F766E),
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontFamily: 'Vazirmatn'),
          tabs: const [
            Tab(text: 'کلاس درس (یادگیری)', icon: Icon(Icons.school_outlined)),
            Tab(text: 'تمرین عملی (اقدام)', icon: Icon(Icons.directions_run)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLearningTab(context),
          _buildPracticeTab(),
        ],
      ),
    );
  }

  Widget _buildLearningTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // متن اصلی درس
        Text(
          widget.day.lessonContent,
          style:
              const TextStyle(fontSize: 16, height: 2.0, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),

        const SizedBox(height: 30),

        // بخش مثال‌های واقعی
        const Row(
          children: [
            Icon(Icons.lightbulb_outline, color: Colors.orange),
            SizedBox(width: 8),
            Text('مثال‌های واقعی در زندگی:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),

        // لیست مثال‌ها
        ...widget.day.lessonExamples.map((example) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withOpacity(0.2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle,
                      size: 18, color: Colors.orange),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      example,
                      style: const TextStyle(fontSize: 14, height: 1.6),
                    ),
                  ),
                ],
              ),
            )),

        const SizedBox(height: 30),

        // کارت منبع علمی و کتاب
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.menu_book, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'منبع علمی این درس',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      height: 1.6,
                      fontFamily: 'Vazirmatn'),
                  children: [
                    const TextSpan(
                        text: 'پروتکل درمانی: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${widget.day.scientificSource}\n'),
                    const TextSpan(
                        text: 'کتاب مرجع: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: widget.day.sourceBookName),
                  ],
                ),
              ),
              if (widget.day.relatedBook != null) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BookDetailScreen(book: widget.day.relatedBook!),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text('مطالعه خلاصه کامل کتاب',
                        style: TextStyle(color: Colors.blue)),
                  ),
                ),
              ]
            ],
          ),
        ),

        const SizedBox(height: 40),

        // دکمه رفتن به تمرین
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => _tabController.animateTo(1),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F766E),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
            ),
            child: const Text('درس را یاد گرفتم، برویم سراغ تمرین',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPracticeTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Builder(builder: (context) {
        // انتخاب ابزار مناسب بر اساس نوع تمرین
        switch (widget.day.exerciseType) {
          case 'journaling':
            return const JournalTool();
          case 'court':
            return const MindCourtTool();
          case 'voice':
            return const AudioStudioTool();
          case 'ladder':
            return const LadderTool();
          default:
            return const Center(
                child: Text('برای این روز تمرین عمومی در نظر گرفته شده است.'));
        }
      }),
    );
  }
}
