

import 'package:flutter/material.dart';//asking flutter to access to the Material Design widgets and classes.
import 'countries_page.dart';


class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

//TasksPage = the widget itself.

//_TasksPageState = where the changing data/UI logic is maintained.
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
          );
        
  }
}
