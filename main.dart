import 'package:flutter/material.dart'; // Import the Flutter Material package for UI components.

void main() {
  runApp(
      const TaskApp()); // The main function initializes the app by running the TaskApp widget.
}

class TaskApp extends StatelessWidget {
  // Stateless widget since it doesn't need to store state.
  const TaskApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Removes the "debug" banner from the top-right corner of the app.
      home: TaskHomePage(), // Sets the home screen of the app to TaskHomePage.
    );
  }
}

class TaskHomePage extends StatefulWidget {
  // Stateful widget since the task list can change dynamically.
  @override
  State<TaskHomePage> createState() =>
      _TaskHomePageState(); // Creates the state of TaskHomePage.
}

class _TaskHomePageState extends State<TaskHomePage> {
  final List<String> _tasks = []; // List to store tasks added by the user.
  final TextEditingController _taskController =
      TextEditingController(); // Controller for managing text input.

  void _addTask() {
    // Function to add a new task.
    String task =
        _taskController.text; // Retrieve the text entered in the input field.
    if (task.isNotEmpty) {
      // Add the task only if it's not empty.
      setState(() {
        _tasks.add(task); // Add the task to the list.
      });
      _taskController.clear(); // Clear the input field after adding the task.
    }
  }

  void _removeTask(int index) {
    // Function to remove a task based on its index in the list.
    setState(() {
      _tasks.removeAt(index); // Remove the selected task from the list.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Builds the UI for the app.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task App'), // App title displayed in the app bar.
        centerTitle: true, // Centers the title text in the app bar.
      ),
      body: Column(
        // The main layout is a column containing the input section and the task list.
        children: [
          Padding(
            padding: const EdgeInsets.all(
                16.0), // Adds spacing around the input section.
            child: Row(
              // Horizontal arrangement for the input field and button.
              children: [
                Expanded(
                  child: TextField(
                    controller:
                        _taskController, // Connects the text field to the controller.
                    decoration: const InputDecoration(
                      hintText:
                          'Enter a task', // Placeholder text in the input field.
                      border:
                          OutlineInputBorder(), // Adds a border around the input field.
                    ),
                  ),
                ),
                const SizedBox(
                    width:
                        8), // Adds spacing between the input field and the button.
                ElevatedButton(
                  onPressed:
                      _addTask, // Calls the _addTask function when pressed.
                  child: const Text('Add'), // Button label.
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              // Dynamically generates a scrollable list of tasks.
              itemCount: _tasks
                  .length, // Sets the number of list items to the task count.
              itemBuilder: (context, index) {
                // Builds each list item.
                return ListTile(
                  title: Text(_tasks[index]), // Displays the task text.
                  trailing: IconButton(
                    // Delete button located at the end of the list item.
                    icon: const Icon(
                        Icons.delete), // Trash icon for deleting tasks.
                    color: Colors.red, // Sets the icon color to red.
                    onPressed: () => _removeTask(
                        index), // Calls the _removeTask function when pressed.
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
