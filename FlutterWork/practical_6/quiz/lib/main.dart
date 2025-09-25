// Subject-wise IT Quiz
// Single-file Flutter app (main.dart)
// Instructions:
// 1) Create a new Flutter project: `flutter create it_quiz`
// 2) Replace lib/main.dart with this file's contents.
// 3) Run: `flutter run`.
// Notes: This is a fully-working starter app focused on UI, UX and subject-wise quizzes.
// You can expand the `sampleData` map with more subjects/questions or load from JSON/remote API.

import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(ITQuizApp());
}

class ITQuizApp extends StatelessWidget {
  const ITQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SubjectListScreen(),
    );
  }
}

// ---------------------- Sample Data ----------------------
final Map<String, List<Question>> sampleData = {
  'Data Structures': [
    Question(text: 'Which data structure uses LIFO order?', options: ['Queue', 'Stack', 'Tree', 'Graph'], answerIndex: 1),
    Question(text: 'Which traversal uses root-left-right?', options: ['Inorder', 'Preorder', 'Postorder', 'Level order'], answerIndex: 1),
    Question(text: 'Which data structure uses FIFO?', options: ['Queue', 'Stack', 'Tree', 'Graph'], answerIndex: 0),
    Question(text: 'Which is used for priority scheduling?', options: ['Queue', 'Heap', 'Stack', 'Linked List'], answerIndex: 1),
    Question(text: 'Which structure represents hierarchical data?', options: ['Array', 'Stack', 'Tree', 'Queue'], answerIndex: 2),
  ],
  'Operating Systems': [
    Question(text: 'What is a process?', options: ['An instance of a program in execution', 'A file on disk', 'A thread pool', 'A system call'], answerIndex: 0),
    Question(text: 'Which scheduling is preemptive?', options: ['FCFS', 'SJF (non-preemptive)', 'Round Robin', 'None'], answerIndex: 2),
    Question(text: 'What is a thread?', options: ['A lightweight process', 'A program', 'A CPU core', 'A process queue'], answerIndex: 0),
    Question(text: 'Which is not a deadlock condition?', options: ['Mutual Exclusion', 'Hold and Wait', 'Circular Wait', 'Preemption'], answerIndex: 3),
    Question(text: 'Which memory management uses paging?', options: ['Contiguous Allocation', 'Paging', 'Segmentation', 'Swapping'], answerIndex: 1),
  ],
  'DBMS': [
    Question(text: 'What does ACID stand for?', options: ['Atomicity Consistency Isolation Durability', 'Access Control Is Durable', 'Atomicity Connectivity Isolation Durability', 'None of the above'], answerIndex: 0),
    Question(text: 'Which normal form removes partial dependency?', options: ['1NF', '2NF', '3NF', 'BCNF'], answerIndex: 1),
    Question(text: 'Which SQL command is used to retrieve data?', options: ['SELECT', 'INSERT', 'UPDATE', 'DELETE'], answerIndex: 0),
    Question(text: 'Which key uniquely identifies a row?', options: ['Primary Key', 'Foreign Key', 'Candidate Key', 'Composite Key'], answerIndex: 0),
    Question(text: 'Which constraint ensures referential integrity?', options: ['Primary Key', 'Foreign Key', 'Unique', 'Check'], answerIndex: 1),
  ],
};

class Question {
  final String text;
  final List<String> options;
  final int answerIndex;

  Question({required this.text, required this.options, required this.answerIndex});
}

// (Rest of the code remains the same)

// ---------------------- Subject List Screen ----------------------
class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = sampleData.keys.toList();

    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Subject-wise',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 6),
                      Text('IT Quiz',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.school, color: Colors.white, size: 28),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Choose a Subject',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(height: 16),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: subjects.length,
                        itemBuilder: (context, index) {
                          final subject = subjects[index];
                          return SubjectCard(
                            title: subject,
                            questionCount: sampleData[subject]!.length,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => QuizHome(
                                    subject: subject,
                                    questions: sampleData[subject]!,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String title;
  final int questionCount;
  final VoidCallback onTap;

  const SubjectCard({super.key, 
    required this.title,
    required this.questionCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.book, color: Colors.blue[600], size: 28),
              SizedBox(height: 12),
              Text(title,
                  style: TextStyle(
                      color: Colors.grey[800], fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 4),
              Text('$questionCount Questions',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('Start', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------- Quiz Home (Info + Start) ----------------------
class QuizHome extends StatelessWidget {
  final String subject;
  final List<Question> questions;

  const QuizHome({super.key, required this.subject, required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text('Ready for the quiz?',
                style: TextStyle(color: Colors.grey[600], fontSize: 16)),
            SizedBox(height: 8),
            Text(subject,
                style: TextStyle(color: Colors.grey[800], fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.quiz, color: Colors.blue[600], size: 20),
                        SizedBox(width: 8),
                        Text('${questions.length} Questions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.timer, color: Colors.orange[600], size: 20),
                        SizedBox(width: 8),
                        Text('Duration: ${questions.length * 30} seconds (suggested)',
                            style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber[600], size: 20),
                        SizedBox(width: 8),
                        Text('Marks: ${questions.length} points', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[400]!),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text('Back', style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuizScreen(
                            subject: subject,
                            questions: questions,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text('Start Quiz', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ---------------------- Quiz Screen ----------------------
class QuizScreen extends StatefulWidget {
  final String subject;
  final List<Question> questions;

  const QuizScreen({super.key, required this.subject, required this.questions});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  int? selectedIndex;
  bool answered = false;
  Timer? timer;
  int remaining = 30;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    remaining = 30; // simple per-question timer
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        remaining--;
        if (remaining <= 0) {
          t.cancel();
          revealAnswer();
        }
      });
    });
  }

  void revealAnswer() {
    setState(() {
      answered = true;
      selectedIndex ??= -1; // mark as no answer if null
    });
    Future.delayed(Duration(seconds: 2), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    timer?.cancel();
    if (currentIndex < widget.questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedIndex = null;
        answered = false;
      });
      startTimer();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(score: score, total: widget.questions.length),
        ),
      );
    }
  }

  void choose(int idx) {
    if (answered) return;
    setState(() {
      selectedIndex = idx;
      answered = true;
      if (idx == widget.questions[currentIndex].answerIndex) {
        score += 1;
      }
    });
    Future.delayed(Duration(seconds: 1), () => nextQuestion());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        elevation: 1,
        foregroundColor: Colors.white,
        title: Text(widget.subject),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // top bar with progress
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Question ${currentIndex + 1} of ${widget.questions.length}',
                      style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500)),
                  Row(children: [
                    Icon(Icons.timer, color: Colors.orange[600], size: 18),
                    SizedBox(width: 6),
                    Text('$remaining s', style: TextStyle(color: Colors.orange[600], fontWeight: FontWeight.w500))
                  ])
                ],
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(q.text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[800])),
                    SizedBox(height: 20),
                    ...List.generate(q.options.length, (i) {
                      final option = q.options[i];
                      final isSelected = selectedIndex == i;
                      final isCorrect = q.answerIndex == i;

                      Color? tileColor;
                      Color borderColor = Colors.grey[300]!;
                      
                      if (answered) {
                        if (isCorrect) {
                          tileColor = Colors.green[50];
                          borderColor = Colors.green;
                        } else if (isSelected && !isCorrect) {
                          tileColor = Colors.red[50];
                          borderColor = Colors.red;
                        }
                      } else if (isSelected) {
                        tileColor = Colors.blue[50];
                        borderColor = Colors.blue;
                      }

                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => choose(i),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: tileColor ?? Colors.white,
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: borderColor),
                                    color: isSelected ? borderColor : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      String.fromCharCode(65 + i),
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : borderColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(child: Text(option, style: TextStyle(fontSize: 16, color: Colors.grey[800]))),
                                if (answered && isCorrect)
                                  Icon(Icons.check_circle, color: Colors.green, size: 24),
                                if (answered && isSelected && !isCorrect)
                                  Icon(Icons.cancel, color: Colors.red, size: 24),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[400]!),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text('Quit', style: TextStyle(color: Colors.grey[700])),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      revealAnswer();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Text('Show Answer', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ---------------------- Result Screen ----------------------
class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    final percent = ((score / total) * 100).round();
    String grade = percent >= 80 ? 'Excellent!' : percent >= 60 ? 'Good!' : percent >= 40 ? 'Average' : 'Needs Improvement';

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Quiz Results'),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Column(
                children: [
                  Icon(Icons.check_circle, color: Colors.green[600], size: 64),
                  SizedBox(height: 16),
                  Text('Quiz Completed!', style: TextStyle(color: Colors.green[800], fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(grade, style: TextStyle(color: Colors.green[700], fontSize: 18)),
                ],
              ),
            ),
            SizedBox(height: 32),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text('Your Score', style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text('$score', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                        Text(' / $total', style: TextStyle(fontSize: 24, color: Colors.grey[600])),
                      ],
                    ),
                    SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: score / total,
                      minHeight: 8,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                    ),
                    SizedBox(height: 8),
                    Text('$percent%', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                  ],
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: Text('Back to Subjects', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            SizedBox(height: 12),
            TextButton(
              onPressed: () {
                // Optionally show review answers screen in future
              },
              child: Text('Review Answers', style: TextStyle(color: Colors.grey[600])),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

/*
  Next steps / Suggestions (not included in code):
  - Persist user progress & high scores using shared_preferences or Firebase.
  - Add authentication (Firebase Auth) to track users & leaderboards.
  - Load questions from remote JSON or CMS for dynamic updates.
  - Add timed quizzes, categories (Easy/Medium/Hard), and analytics dashboard.
  - Include images, diagrams as question types and support multiple correct answers.
  - Improve UI with Google Fonts package, Lottie animations, confetti, and custom icons.
*/
