import 'package:flutter/material.dart';
//declare class
class Task {
  String title;
  String description;
  DateTime deadline;

  Task(this.title, this.description, this.deadline);
}
//for listing crud
class TodoList {
  List<Task> tasks = [];

  void addTask(Task task) {
    tasks.add(task);
  }

  void updateTask(int index, Task updatedTask) {
    tasks[index] = updatedTask;
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoList todoList = TodoList();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  int? selectedTaskIndex;
// date selection
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
//To Do List ui
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        backgroundColor: Colors.deepPurple, // Customize app bar color
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Placeholder for search functionality
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple.shade100, Colors.red.shade100],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Task Title',
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Task Description',
                    prefixIcon: Icon(Icons.description),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.date_range),
                      SizedBox(width: 8.0),
                      Text('Select Deadline'),
                    ],
                  ),
                ),
                Text('Selected Deadline: ${selectedDate.toLocal().toString().split(' ')[0]}'),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Task newTask = Task(titleController.text, descriptionController.text, selectedDate);
                      if (selectedTaskIndex != null) {
                        // Update existing task
                        todoList.updateTask(selectedTaskIndex!, newTask);
                        setState(() {
                          selectedTaskIndex = null;
                        });
                      } else {
                        // Add new task
                        todoList.addTask(newTask);
                      }
                      // Clear form
                      titleController.clear();
                      descriptionController.clear();
                      setState(() {});
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(selectedTaskIndex != null ? Icons.update : Icons.add),
                      SizedBox(width: 8.0),
                      Text(selectedTaskIndex != null ? 'Update Task' : 'Add Task'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: todoList.tasks.length,
                    itemBuilder: (context, index) {
                      Task task = todoList.tasks[index];
                      return TaskTile(
                        task: task,
                        onDelete: () => _deleteTask(index),
                        onUpdate: () => _editTask(index),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteTask(int index) {
    setState(() {
      todoList.deleteTask(index);
    });
  }

  void _editTask(int index) {
    Task task = todoList.tasks[index];
    titleController.text = task.title;
    descriptionController.text = task.description;
    selectedDate = task.deadline;

    setState(() {
      selectedTaskIndex = index;
    });
  }
}

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  TaskTile({required this.task, required this.onDelete, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description),
            Text('Deadline: ${task.deadline.toLocal().toString().split(' ')[0]}'), // Display only the date
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onUpdate,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
