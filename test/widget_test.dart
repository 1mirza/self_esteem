import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// نام پکیج باید با نامی که در pubspec.yaml انتخاب کردید یکی باشد
import 'package:self_esteam_mirza/main.dart';

void main() {
  testWidgets('تست اجرای اولیه اپلیکیشن', (WidgetTester tester) async {
    // 1. ساختن (Build) اپلیکیشن و اجرای فریم اول
    await tester.pumpWidget(const SelfEsteemApp());

    // 2. بررسی اینکه آیا صفحه اول (سلب مسئولیت) لود شده است؟
    // جستجو برای متن "بیانیه سلب مسئولیت"
    expect(find.text('بیانیه سلب مسئولیت'), findsOneWidget);

    // 3. جستجو برای دکمه "می‌پذیرم"
    expect(find.text('می‌پذیرم'), findsOneWidget);

    // اگر این تست پاس شود، یعنی اپلیکیشن بدون کرش کردن بالا می‌آید
  });
}
