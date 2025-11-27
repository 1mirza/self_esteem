import 'package:flutter/material.dart';

class JournalTool extends StatefulWidget {
  const JournalTool({super.key});

  @override
  State<JournalTool> createState() => _JournalToolState();
}

class _JournalToolState extends State<JournalTool> {
  final _controller = TextEditingController();
  double _intensity = 50;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'دفترچه ثبت افکار منفی',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F766E)),
          ),
          const SizedBox(height: 8),
          const Text(
            'هر بار حس بدی داشتی، اینجا بنویس تا از ذهنت خارج شود. نوشتن اولین قدم برای رهایی است.',
            style: TextStyle(color: Colors.grey, height: 1.5),
          ),
          const SizedBox(height: 20),
          const Text('چه اتفاقی افتاد و چه فکری کردی؟',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            maxLines: 5,
            decoration: InputDecoration(
              hintText:
                  'مثلاً: دوستم جواب پیامم را نداد، فکر کردم از من بدش می‌آید...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xFF0F766E), width: 2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('شدت این حس (۰ تا ۱۰۰):',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${_intensity.round()}%',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF0F766E))),
            ],
          ),
          Slider(
            value: _intensity,
            min: 0,
            max: 100,
            divisions: 20,
            activeColor: const Color(0xFF0F766E),
            label: _intensity.round().toString(),
            onChanged: (double value) {
              setState(() {
                _intensity = value;
              });
            },
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('ثبت شد! آفرین به این آگاهی.'),
                      backgroundColor: Color(0xFF0F766E),
                    ),
                  );
                  _controller.clear();
                  setState(() {
                    _intensity = 50;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('لطفاً ابتدا فکر خود را بنویسید.'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              icon: const Icon(Icons.check),
              label: const Text('ثبت مشاهده'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFE91E63), // Pink accent for action
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
