import 'package:flutter/material.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  // Our list of to-do items, each with a task and a completion status.
  final List<Map<String, dynamic>> _tasks = [
    {'task': 'Learn Flutter widgets', 'isCompleted': false},
    {'task': 'Build a simple app', 'isCompleted': true},
    {'task': 'Explore more widgets', 'isCompleted': false},
  ];

  void _addTask() {
    setState(() {
      _tasks.add({'task': 'New Task', 'isCompleted': false});
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index]['isCompleted'] = !_tasks[index]['isCompleted'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 4,
            child: CheckboxListTile(
              title: Text(
                _tasks[index]['task'],
                style: TextStyle(
                  decoration: _tasks[index]['isCompleted']
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              value: _tasks[index]['isCompleted'],
              onChanged: (bool? value) {
                _toggleTaskCompletion(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}