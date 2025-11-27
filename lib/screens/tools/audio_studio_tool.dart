import 'package:flutter/material.dart';

class AudioStudioTool extends StatefulWidget {
  const AudioStudioTool({super.key});

  @override
  State<AudioStudioTool> createState() => _AudioStudioToolState();
}

class _AudioStudioToolState extends State<AudioStudioTool> {
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onLongPress: () {
              setState(() => isRecording = true);
            },
            onLongPressEnd: (_) {
              setState(() => isRecording = false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('پیام شما با موفقیت ضبط شد!')),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: isRecording ? Colors.red : Colors.purple,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (isRecording ? Colors.red : Colors.purple)
                        .withOpacity(0.4),
                    blurRadius: isRecording ? 40 : 20,
                    spreadRadius: isRecording ? 10 : 5,
                  )
                ],
              ),
              child: Icon(
                isRecording ? Icons.mic : Icons.mic_none_outlined,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            isRecording
                ? 'در حال ضبط...'
                : 'دکمه را نگه دارید و متن زیر را بخوانید:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isRecording ? Colors.red : Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.purple.shade200),
            ),
            child: const Text(
              '«عزیزم، من اینجام. تو مقصر نیستی. من مراقبتم و دوستت دارم. تو ارزشمندی، فقط به خاطر اینکه هستی.»',
              style: TextStyle(
                  fontSize: 16, height: 1.8, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
