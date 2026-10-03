import 'dart:convert';

import 'package:flutter/material.dart';//asking flutter to access to the Material Design widgets and classes.
import 'countries_page.dart';
import 'package:http/http.dart' as http;


class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

//TasksPage = the widget itself.

//_TasksPageState = where the changing data/UI logic is maintained.
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  int selectedSession = 0;//which session is currently selected. 0 = first session, 1 = second session, etc.

//controllers for sessioncontent text fields. Each session has its own controller to manage the text input.
  List<TextEditingController> sessionControllers = [
    TextEditingController(text: 'I want to learn Flutter'),
    TextEditingController(),
    TextEditingController(),
  ];

  // Controllers for questions in each session
  List<TextEditingController> questionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  // Answers received from FastAPI for each session
  List<String> answers = [
    '',
    '',
    '',
  ];

  // Shows whether FastAPI is processing the question
  bool isLoading = false;

  // Send question to FastAPI
  Future<void> askQuestion(String question) async {
    if (question.trim().isEmpty) {
      setState(() {
        answers[selectedSession] = 'Please enter a question.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      answers[selectedSession] = '';
    });

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/ask'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'question': question,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          answers[selectedSession] = data['answer'];
        });
      } else {
        setState(() {
          answers[selectedSession] =
              'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        answers[selectedSession] =
            'Could not connect to the FastAPI server.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Dispose controllers
  @override
  void dispose() {
    for (var controller in sessionControllers) {
      controller.dispose();
    }

    for (var controller in questionControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Learning Sessions'),
//navigator to countries_page
        actions: [
    IconButton(
      icon: const Icon(Icons.public),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CountriesPage(),
          ),
        );
      },
    ),
  ],
      ),

      // LEFT SIDE - DRAWER
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  'SESSIONS',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

      
                Expanded(
                  child: ListView.builder(
                    itemCount: sessionControllers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Session ${index + 1}'),

                        onTap: () {
                          setState(() { //setstate will re build the UI
                            selectedSession = index;
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        sessionControllers.add(
                          TextEditingController(),
                        );

                         // Add question controller
                    questionControllers.add(
                      TextEditingController(),
                    );

                    // Add answer
                    answers.add('');

                        selectedSession =
                            sessionControllers.length - 1;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('+ Add Session'),
                  ),
                ),
              ],
            ),
          ),
          

          // RIGHT SIDE: Session content
          
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Session ${selectedSession + 1}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Session Content',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    height: 150,
                    child: TextField(
                      controller:
                          sessionControllers[selectedSession],
                      maxLines: null,
                      expands: true,
                      textAlignVertical:
                          TextAlignVertical.top,
                      decoration: const InputDecoration(
                        hintText:
                            'Write your session content here...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

            // Question
            const Text(
              'Ask a Question',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller:
                  questionControllers[selectedSession],
              decoration: const InputDecoration(
                hintText:
                    'Example: What is the capital of India?',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (question) {
                askQuestion(question);
              },
            ),

            const SizedBox(height: 10),

            // Ask Button
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      askQuestion(
                        questionControllers[
                                selectedSession]
                            .text,
                      );
                    },
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Ask'),
            ),

            const SizedBox(height: 20),

            // Answer
            const Text(
              'Answer',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius:
                      BorderRadius.circular(5),
                ),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        answers[selectedSession].isEmpty
                            ? 'Answer will appear here...'
                            : answers[selectedSession],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
                ],
              ),
            ),
          );
        
  }
}
