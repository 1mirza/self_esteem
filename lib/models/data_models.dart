import 'package:flutter/material.dart';

// تنظیمات برنامه
class AppSettings {
  bool isDarkMode;
  double fontSize;
  TimeOfDay morningReminder;
  TimeOfDay nightReminder;
  bool enableNotifications;
  bool isDailyCheckInEnabled;
  bool isNightReminderEnabled;

  AppSettings({
    this.isDarkMode = false,
    this.fontSize = 14.0,
    this.morningReminder = const TimeOfDay(hour: 9, minute: 0),
    this.nightReminder = const TimeOfDay(hour: 23, minute: 0),
    this.enableNotifications = true,
    this.isDailyCheckInEnabled = true,
    this.isNightReminderEnabled = true,
  });
}

// مدل کتاب
class BookModel {
  final String id;
  final String title;
  final String author;
  final String category;
  final String summary;
  final List<String> keyLearnings;
  final List<String> realLifeExamples;
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

// مدل برنامه روزانه (آپدیت شده)
class DayPlanModel {
  final int dayNumber;
  final String title;
  final String description;
  final String lessonContent; // توضیحات درس
  final List<String> lessonExamples; // ۵ مثال واقعی (جدید)
  final String scientificSource; // منبع علمی (متد)
  final String sourceBookName; // نام کتاب مرجع (جدید)
  final BookModel? relatedBook;
  final String exerciseType;
  final bool isLocked;
  final bool isCompleted;

  DayPlanModel({
    required this.dayNumber,
    required this.title,
    required this.description,
    required this.lessonContent,
    required this.lessonExamples, // فیلد جدید
    required this.scientificSource,
    required this.sourceBookName, // فیلد جدید
    this.relatedBook,
    required this.exerciseType,
    this.isLocked = false,
    this.isCompleted = false,
  });
}
