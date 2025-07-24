import 'package:flutter/material.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      appBar: AppBar(title: const Text("About Me")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/abtMe.jpg',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.error, size: 200),
                ),
              ),
              const SizedBox(height: 20),
              Text("Simanta Deka",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 10),
              Text(
                "UX/UI Designer • Front-end Developer • Flutter Enthusiast",
                style: TextStyle(fontSize: 16, color: textColor.withAlpha(204)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              Text(
                "Hello! 👋 I'm passionate about creating visually appealing and user-friendly apps. I enjoy crafting smooth mobile experiences using Flutter and developing stylish websites with modern front-end tech.",
                style: TextStyle(fontSize: 15, color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text("🔧 Interests:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 5),
              Text(
                "• Mobile App Development\n• UI/UX Design\n• Creative Problem Solving\n• Clean & Minimalist Code",
                style: TextStyle(fontSize: 15, color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text("💼 Experience:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 5),
              Text(
                "• Worked on various personal projects using Flutter & React\n• Completed internship building responsive portfolio apps\n• Currently exploring advanced animations & UI logic",
                style: TextStyle(fontSize: 15, color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
