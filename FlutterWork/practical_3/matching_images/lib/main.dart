import 'package:flutter/material.dart';

void main() {
  runApp(const MatchWordApp());
}

class MatchWordApp extends StatelessWidget {
  const MatchWordApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Match Image & Word",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const MatchGamePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MatchGamePage extends StatefulWidget {
  const MatchGamePage({super.key});

  @override
  State<MatchGamePage> createState() => _MatchGamePageState();
}

class _MatchGamePageState extends State<MatchGamePage> {
  // Sample data
  final List<Map<String, dynamic>> questions = [
    {
      "image": "assets/images/apple.jpg",
      "answer": "Apple",
      "options": ["Apple", "Ball", "Cat"]
    },
    {
      "image": "assets/images/ball.jpg",
      "answer": "Ball",
      "options": ["Dog", "Ball", "Fish"]
    },
    {
      "image": "assets/images/cat.jpg",
      "answer": "Cat",
      "options": ["Cat", "Rat", "Sun"]
    },
  ];

  int currentIndex = 0;
  String feedbackMessage = "";

  void checkAnswer(String selected) {
    String correct = questions[currentIndex]["answer"];
    setState(() {
      if (selected == correct) {
        feedbackMessage = "✅ Correct!";
      } else {
        feedbackMessage = "❌ Try Again!";
      }
    });
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        feedbackMessage = "";
      });
    } else {
      setState(() {
        feedbackMessage = "🎉 Game Completed!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var question = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Match Image & Word", 
          style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      backgroundColor: Colors.purple.shade50,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image display
            Expanded(
              child: Center(
                child: Image.asset(
                  question["image"],
                  height: 200,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Options
            Column(
              children: question["options"].map<Widget>((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade400,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 3,
                    ),
                    onPressed: () => checkAnswer(option),
                    child: Text(option,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Feedback message
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: feedbackMessage.contains("Correct") 
                    ? Colors.green.shade100 
                    : feedbackMessage.contains("Try Again") 
                        ? Colors.red.shade100 
                        : feedbackMessage.contains("Completed")
                            ? Colors.blue.shade100
                            : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                feedbackMessage,
                style: TextStyle(
                  fontSize: 22, 
                  fontWeight: FontWeight.bold,
                  color: feedbackMessage.contains("Correct") 
                      ? Colors.green.shade700 
                      : feedbackMessage.contains("Try Again") 
                          ? Colors.red.shade700 
                          : feedbackMessage.contains("Completed")
                              ? Colors.blue.shade700
                              : Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Next button
            ElevatedButton(
              onPressed: nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
              ),
              child: const Text("Next", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}