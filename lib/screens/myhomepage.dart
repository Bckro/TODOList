import 'package:flutter/material.dart';
import 'package:todolist/model/usermanager.dart';
import 'package:todolist/screens/registerpage.dart';
import 'package:todolist/screens/todolistpage.dart';

import '../model/user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  TextEditingController kontrolerLogin = TextEditingController();
  TextEditingController kontrolerHaslo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.account_box,
              size: 100,
              color: Color(0xFF1A237E), // Dark Blue Color
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 20),
              child: Text(
                "To Do List App",
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF1A237E), // Dark Blue Color
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: TextField(
                controller: kontrolerLogin,
                decoration: InputDecoration(
                  labelText: "Enter login",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF1A237E)), // Dark Blue Color
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: TextField(
                controller: kontrolerHaslo,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Enter password",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF1A237E)), // Dark Blue Color
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  User user = UserManager.findUser(
                    kontrolerLogin.text,
                    kontrolerHaslo.text,
                  );

                  if (user.id == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Login or password is incorrect."),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Signed in successfully! Welcome ${user.name}.",
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ToDoListPage(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF1A237E), // Dark Blue Color
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF1A237E), // Dark Blue Color
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
