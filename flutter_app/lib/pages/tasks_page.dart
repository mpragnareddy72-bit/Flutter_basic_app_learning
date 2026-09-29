
import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  int selectedSession = 0;

  List<TextEditingController> sessionControllers = [
    TextEditingController(text: 'I want to learn Flutter'),
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Learning Sessions'),
      ),

      body: Row(
        children: [
          // LEFT SIDE: Sessions panel
          SizedBox(
            width: 180,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'SESSIONS',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
                          setState(() {
                            selectedSession = index;
                          });
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

                        selectedSession =
                            sessionControllers.length - 1;
                      });
                    },
                    child: const Text('+ Add Session'),
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(
            width: 1,
            thickness: 1,
          ),

          // RIGHT SIDE: Session content
          Expanded(
            child: Padding(
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

                  Expanded(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
