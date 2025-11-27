import 'package:flutter/material.dart';

// تنظیمات برنامه
class AppSettings {
  bool isDarkMode;
  double fontSize;
  TimeOfDay morningReminder;
  TimeOfDay nightReminder;
  bool enableNotifications;

  AppSettings({
    this.isDarkMode = false,
    this.fontSize = 14.0,
    this.morningReminder = const TimeOfDay(hour: 9, minute: 0),
    this.nightReminder = const TimeOfDay(hour: 23, minute: 0),
    this.enableNotifications = true,
  });
}

// مدل کتاب
class BookModel {
  final String id;
  final String title;
  final String author;
  final String category;
  final String summary; // خلاصه طولانی
  final List<String> keyLearnings; // نکات کلیدی
  final List<String> realLifeExamples; // ۲۰ مثال واقعی
  final Color coverColor;
  final IconData icon;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.summary,
    required this.keyLearnings,
    required this.realLifeExamples,
    required this.coverColor,
    required this.icon,
  });
}

// مدل برنامه روزانه
class DayPlanModel {
  final int dayNumber;
  final String title;
  final String description;
  final String lessonContent; // درس‌نامه
  final String scientificSource; // منبع علمی
  final BookModel? relatedBook; // کتاب مرتبط
  final String exerciseType; // نوع ابزار: journaling, court, voice, ladder
  final bool isLocked;
  final bool isCompleted;

  DayPlanModel({
    required this.dayNumber,
    required this.title,
    required this.description,
    required this.lessonContent,
    required this.scientificSource,
    this.relatedBook,
    required this.exerciseType,
    this.isLocked = false,
    this.isCompleted = false,
  });
}
