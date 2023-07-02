import 'package:flutter/material.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/model/user.dart';
import 'package:todolist/model/usermanager.dart';
import 'package:todolist/screens/myhomepage.dart';

void main() {
  runApp(ToDoListPage());
}

class ToDoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primaryColor: Colors.lightBlue[50],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF1A237E),
            textStyle: TextStyle(fontFamily: 'InkFree'),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1A237E)),
          ),
        ),
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> userTasks = [];

  @override
  void initState() {
    super.initState();
    // Odczytaj listę zadań użytkownika
    userTasks = UserManager.loggedUser?.tasks ?? [];
  }

  void addTask(String taskName) {
    setState(() {
      // Dodaj zadanie do listy zadań użytkownika
      userTasks.add(Task(name: taskName, done: false));
    });
  }

  void deleteTask(Task task) {
    setState(() {
      // Usuń zadanie z listy zadań użytkownika
      userTasks.remove(task);
    });
  }

  void editTask(Task task, String newTaskName) {
    setState(() {
      // Zaktualizuj nazwę zadania
      task.name = newTaskName;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Odczytaj nazwę obecnie zalogowanego użytkownika
    String? loggedInUserName = UserManager.loggedUser?.name;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome ${loggedInUserName ?? ""}!',
          style: TextStyle(fontFamily: 'Cambria'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ),
            );
          },
        ),
        backgroundColor: Color(0xFF1A237E),
        elevation: 0,
        toolbarHeight: 70,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'My to-do list',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                    fontFamily: 'Cambria',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            if (userTasks.isEmpty)
              Center(
                child: Text(
                  'Task list is empty',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: userTasks.length,
                  itemBuilder: (context, index) {
                    Task task = userTasks[index];
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        deleteTask(task);
                      },
                      background: Container(
                        color: Colors.red,
                        child: Icon(Icons.delete, color: Colors.white),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            task.name!,
                            style: TextStyle(
                              fontSize: 18,
                              decoration: task.done != null && task.done!
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: Color(0xFF1A237E),
                            ),
                          ),
                          leading: Checkbox(
                            value: task.done != null && task.done!,
                            onChanged: (value) {
                              setState(() {
                                task.done = value;
                              });
                            },
                            checkColor: Colors.white,
                            activeColor: Color(0xFF1A237E),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                color: Color(0xFF1A237E),
                                onPressed: () {
                                  TextEditingController taskNameController =
                                      TextEditingController(text: task.name!);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Edit Task',
                                          style: TextStyle(
                                            color: Color(0xFF1A237E),
                                          ),
                                        ),
                                        content: TextField(
                                          controller: taskNameController,
                                          style: TextStyle(
                                            color: Color(0xFF1A237E),
                                          ),
                                          decoration: InputDecoration(
                                            labelText: 'Task Name',
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF1A237E),
                                              ),
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Color(0xFF1A237E),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ElevatedButton(
                                            child: Text('Save'),
                                            onPressed: () {
                                              String newTaskName =
                                                  taskNameController.text
                                                      .trim();
                                              if (newTaskName.isNotEmpty) {
                                                editTask(task, newTaskName);
                                                Navigator.pop(context);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xFF1A237E),
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                color: Color(0xFF1A237E),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Delete Task',
                                          style: TextStyle(
                                            color: Color(0xFF1A237E),
                                          ),
                                        ),
                                        content: Text(
                                            'Are you sure you want to delete this task?'),
                                        actions: [
                                          TextButton(
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Color(0xFF1A237E),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ElevatedButton(
                                            child: Text('Delete'),
                                            onPressed: () {
                                              deleteTask(task);
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                TextEditingController taskNameController =
                    TextEditingController();
                return AlertDialog(
                  title: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      'Add Task',
                      style: TextStyle(
                        color: Color(0xFF1A237E),
                      ),
                    ),
                  ),
                  content: TextField(
                    controller: taskNameController,
                    style: TextStyle(
                      color: Color(0xFF1A237E),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Task Name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1A237E),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFF1A237E),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text('Add'),
                        onPressed: () {
                          String taskName = taskNameController.text.trim();
                          if (taskName.isNotEmpty) {
                            addTask(taskName);
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF1A237E),
                          textStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF1A237E),
        ),
      ),
    );
  }
}
