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
        title: Text(widget.day.title, style: const TextStyle(fontSize: 16)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF0F766E),
            indicatorColor: const Color(0xFF0F766E),
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(
                  text: '۱. کلاس درس (یادگیری)',
                  icon: Icon(Icons.school_outlined)),
              Tab(
                  text: '۲. تمرین عملی (اقدام)',
                  icon: Icon(Icons.edit_note_outlined)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildLearningTab(context),
                _buildPracticeTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // متن درس
        Text(
          widget.day.lessonContent,
          style:
              const TextStyle(fontSize: 16, height: 2.0, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),

        const SizedBox(height: 30),

        // منبع علمی
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            border: Border(
                right: BorderSide(color: Colors.blue.shade800, width: 4)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('پشتوانه علمی:',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              const SizedBox(height: 4),
              Text(widget.day.scientificSource,
                  style: const TextStyle(
                      fontSize: 12, fontStyle: FontStyle.italic)),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // بخش کتاب مرتبط (اگر وجود داشته باشد)
        if (widget.day.relatedBook != null)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED), // Orange-50
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Column(
              children: [
                const Icon(Icons.menu_book, color: Colors.orange, size: 40),
                const SizedBox(height: 10),
                const Text('کتاب پیشنهادی مرتبط',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                const SizedBox(height: 10),
                Text(
                  '"${widget.day.relatedBook!.title}"',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'اثر ${widget.day.relatedBook!.author}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
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
                      side: const BorderSide(color: Colors.orange),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('خواندن خلاصه این کتاب',
                        style: TextStyle(color: Colors.deepOrange)),
                  ),
                )
              ],
            ),
          ),

        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () => _tabController.animateTo(1),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0F766E),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('درس را یاد گرفتم، برویم سراغ تمرین',
              style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPracticeTab() {
    // انتخاب ابزار مناسب بر اساس نوع تمرین تعریف شده در DayPlanModel
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
  }
}
