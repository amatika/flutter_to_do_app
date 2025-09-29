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
      debugShowCheckedModeBanner: false,
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
    {'task': 'Go to market', 'isCompleted': true},
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



// Add a new method to your _ToDoListScreenState class
  void _editTask(int index) {
    TextEditingController _controller = TextEditingController(text: _tasks[index]['task']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter new task name'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  _tasks[index]['task'] = _controller.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('To-Do List'),
      ),

      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          // Wrap the Card with Dismissible
          return Dismissible(
            key: UniqueKey(), // A unique key is required for Dismissible
            direction: DismissDirection.endToStart, // Swipe from right to left
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                _tasks.removeAt(index);
              });
              // Optional: show a snackbar to confirm deletion
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task deleted')),
              );
            },
            child: Card(
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
  }*/
  // The build method of _ToDoListScreenState
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                _tasks.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task deleted')),
              );
            },
            // Wrap the Card with a GestureDetector to handle the long press
            child: GestureDetector(
              onLongPress: () {
                // Call the edit function when the user long-presses on the card
                _editTask(index);
              },
              child: Card(
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
              ),
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