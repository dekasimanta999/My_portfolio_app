import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about_me.dart';
import 'contact_me.dart';
import 'works.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatefulWidget {
  const MyPortfolioApp({super.key});

  @override
  State<MyPortfolioApp> createState() => _MyPortfolioAppState();
}

class _MyPortfolioAppState extends State<MyPortfolioApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? true;
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  Future<void> _toggleTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simanta's Portfolio",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: _themeMode,
      home: HomePage(
        isDark: _themeMode == ThemeMode.dark,
        onThemeToggle: _toggleTheme,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final bool isDark;
  final Function(bool) onThemeToggle;

  const HomePage({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> rotatingTexts = [
    "I love Flutter",
    "I love Dart",
    "I love Problems",
    "I Develop Mobile Apps",
    "I Code Cool Websites"
  ];

  int currentIndex = 0;
  int charIndex = 0;
  String displayedText = "";
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _startTypingAnimation();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % rotatingTexts.length;
        displayedText = "";
        charIndex = 0;
      });
      _startTypingAnimation();
    });
  }

  void _startTypingAnimation() {
    _typingTimer?.cancel();
    _typingTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (charIndex < rotatingTexts[currentIndex].length) {
        setState(() {
          displayedText += rotatingTexts[currentIndex][charIndex];
          charIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        title: const Text("My Portfolio"),
        actions: [
          Icon(widget.isDark ? Icons.dark_mode : Icons.light_mode),
          Switch(
            value: widget.isDark,
            onChanged: widget.onThemeToggle,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/dj.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.error, size: 200),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Hello, I’m", style: TextStyle(fontSize: 18)),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 28),
                children: [
                  TextSpan(
                    text: "Simanta ",
                    style: TextStyle(color: Color.fromARGB(255, 255, 82, 82)),
                  ),
                  TextSpan(
                    text: "Deka",
                    style: TextStyle(color: Color.fromARGB(255, 255, 82, 82)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "UX/UI Designer | Front-end Developer | Flutter Developer\n",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 27, fontFamily: 'Courier'),
                children: _buildAnimatedTextSpan(displayedText),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => _openLink("https://example.com/resume.pdf"),
              icon: const Icon(Icons.download),
              label: const Text("Download Resume"),
            ),
            const SizedBox(height: 30),
            const Text("Skills", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            _buildSkill("HTML", 1),
            _buildSkill("CSS", 0.95),
            _buildSkill("JavaScript", 0.8),
            _buildSkill("Flutter", 0.95),
            _buildSkill("React", 0.80),
            const SizedBox(height: 30),
            const Text("Connect with Me", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _iconButton(icon: FontAwesomeIcons.linkedin, url: "http://www.linkedin.com/in/simanta-kusum-deka090909"),
                _iconButton(icon: FontAwesomeIcons.github, url: "https://github.com/dekasimanta999"),
                _iconButton(icon: FontAwesomeIcons.facebook, url: "https://www.facebook.com/simanta.deka.94695"),
                _iconButton(icon: FontAwesomeIcons.instagram, url: "https://instagram.com/__simanta__999"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkill(String label, double level) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: level,
          minHeight: 8,
          color: Colors.greenAccent,
          backgroundColor: Colors.grey.shade300,
        ),
      ]),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(padding: const EdgeInsets.all(20), children: [
        const DrawerHeader(child: Text("Menu", style: TextStyle(fontSize: 24))),
        ListTile(title: const Text("Home"), onTap: () => Navigator.pop(context)),
        ListTile(
          title: const Text("Works"),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const WorksPage()));
          },
        ),
        ListTile(title: const Text("Resume"), onTap: () => Navigator.pop(context)),
        ListTile(
          title: const Text("About Me"),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutMePage()));
          },
        ),
        ListTile(
          title: const Text("Contact"),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactMePage()));
          },
        ),
      ]),
    );
  }

  Widget _iconButton({required IconData icon, required String url}) {
    return IconButton(
      icon: FaIcon(icon, size: 30, color: Theme.of(context).colorScheme.primary),
      onPressed: () => _openLink(url),
      splashRadius: 26,
    );
  }

  List<TextSpan> _buildAnimatedTextSpan(String fullText) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dynamicColor = isDark ? Colors.white : Colors.black;
    final fixedColor = const Color(0xFF0A5175);
    final map = {
      "I love Flutter": "I love ",
      "I love Dart": "I love ",
      "I love Problems": "I love ",
      "I Develop Mobile Apps": "I Develop ",
      "I Code Cool Websites": "I Code Cool ",
    };

    final prefix = map[rotatingTexts[currentIndex]];
    final soFar = displayedText;
    if (prefix != null) {
      if (soFar.length <= prefix.length) {
        return [TextSpan(text: soFar, style: TextStyle(color: dynamicColor))];
      } else {
        return [
          TextSpan(text: soFar.substring(0, prefix.length), style: TextStyle(color: dynamicColor)),
          TextSpan(text: soFar.substring(prefix.length), style: TextStyle(color: fixedColor)),
        ];
      }
    }
    return [TextSpan(text: soFar, style: TextStyle(color: fixedColor))];
  }
}
