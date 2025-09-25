import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

void main() {
  runApp(const ResumeMakerApp());
}

class ResumeMakerApp extends StatelessWidget {
  const ResumeMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Maker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
      home: const ResumeHomePage(),
    );
  }
}

class ResumeHomePage extends StatefulWidget {
  const ResumeHomePage({super.key});

  @override
  State<ResumeHomePage> createState() => _ResumeHomePageState();
}

class _ResumeHomePageState extends State<ResumeHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController educationController = TextEditingController();

  // ✅ Dynamic Skills
  final TextEditingController skillInputController = TextEditingController();
  final List<String> skills = [];

  // ✅ Dynamic Work Experience
  final TextEditingController experienceInputController =
      TextEditingController();
  final List<String> experiences = [];

  void addSkill() {
    final skill = skillInputController.text.trim();
    if (skill.isNotEmpty) {
      setState(() => skills.add(skill));
      skillInputController.clear();
    }
  }

  void removeSkill(String skill) {
    setState(() => skills.remove(skill));
  }

  void addExperience() {
    final exp = experienceInputController.text.trim();
    if (exp.isNotEmpty) {
      setState(() => experiences.add(exp));
      experienceInputController.clear();
    }
  }

  void removeExperience(String exp) {
    setState(() => experiences.remove(exp));
  }

  void clearAll() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    educationController.clear();
    skills.clear();
    experiences.clear();
    skillInputController.clear();
    experienceInputController.clear();
    setState(() {});
  }

  void generateResume() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  nameController.text,
                  style: pw.TextStyle(
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                    '${emailController.text} ${phoneController.text.isNotEmpty ? " • ${phoneController.text}" : ""}'),
                pw.Divider(thickness: 2, color: PdfColors.grey),

                pw.SizedBox(height: 10),
                pw.Text('Education',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.Text(educationController.text),

                pw.SizedBox(height: 10),
                pw.Text('Experience',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                ...experiences.map((exp) => pw.Bullet(text: exp)),

                pw.SizedBox(height: 10),
                pw.Text('Skills',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: skills
                      .map((skill) => pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            decoration: pw.BoxDecoration(
                              color: PdfColors.indigo100,
                              borderRadius: pw.BorderRadius.circular(4),
                            ),
                            child: pw.Text(skill),
                          ))
                      .toList(),
                )
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  Widget buildTextField(
      String label, IconData icon, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Skills", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: skillInputController,
                decoration: const InputDecoration(
                  labelText: "Add skill",
                  prefixIcon: Icon(Icons.star_outline),
                ),
                onSubmitted: (_) => addSkill(),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: addSkill,
              child: const Text("Add"),
            )
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: skills
              .map((skill) => Chip(
                    label: Text(skill),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () => removeSkill(skill),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Work Experience", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: experienceInputController,
                decoration: const InputDecoration(
                  labelText: "Job title, Company, Duration",
                  prefixIcon: Icon(Icons.work_outline),
                ),
                onSubmitted: (_) => addExperience(),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: addExperience,
              child: const Text("Add"),
            )
          ],
        ),
        const SizedBox(height: 12),
        Column(
          children: experiences
              .map((exp) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.work_outline, size: 20),
                        const SizedBox(width: 12),
                        Expanded(child: Text(exp)),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => removeExperience(exp),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Resume Builder'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Personal Information', 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  buildTextField('Full Name', Icons.person, nameController),
                  buildTextField('Email Address', Icons.email, emailController),
                  buildTextField('Phone Number', Icons.phone, phoneController),
                  buildTextField('Education', Icons.school, educationController,
                      maxLines: 3),
                  const SizedBox(height: 16),
                  buildExperienceSection(),
                  const SizedBox(height: 16),
                  buildSkillsSection(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: generateResume,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.description),
                label: const Text('Generate PDF Resume'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: clearAll,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                ),
                icon: const Icon(Icons.clear),
                label: const Text('Clear All Fields'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
