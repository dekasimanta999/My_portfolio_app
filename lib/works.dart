import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WorksPage extends StatelessWidget {
  const WorksPage({super.key});

  final List<Map<String, String>> projects = const [
    {
      'title': 'My Portfolio App',
      'description': 'A beautiful mobile portfolio built with Flutter and Dart.',
      'url': 'https://github.com/yourprofile/portfolio-app'
    },
    {
      'title': 'Attendance System',
      'description': 'A biometric attendance system using ESP32 and mobile notifications.',
      'url': 'https://github.com/yourprofile/attendance-system'
    },
    {
      'title': 'Snapigo (UI)',
      'description': 'UI/UX design for a next-gen social media app with stunning features.',
      'url': 'https://github.com/yourprofile/snapigo-ui'
    },
  ];

  Future<void> _launchProject(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Works"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: projects.length,
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final project = projects[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(project['title']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(project['description']!, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () => _launchProject(project['url']!),
                          icon: const Icon(Icons.link),
                          label: const Text("View Project"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
