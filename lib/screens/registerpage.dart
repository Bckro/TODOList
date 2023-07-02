import 'package:flutter/material.dart';
import 'package:todolist/screens/myhomepage.dart';
import '../model/user.dart';
import '../model/usermanager.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key});

  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<RegisterPage> {
  TextEditingController kontrolerImie = TextEditingController();
  TextEditingController kontrolerLogin = TextEditingController();
  TextEditingController kontrolerHaslo = TextEditingController();
  TextEditingController kontrolerHaslo2 = TextEditingController();

  Color _passwordStrengthIndicatorColor = Colors.transparent;
  String _passwordStrengthText = '';
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Page',
          style: TextStyle(
            fontFamily: 'Cambria',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
              child: TextField(
                controller: kontrolerImie,
                decoration: InputDecoration(
                  labelText: "Enter name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: kontrolerLogin,
                decoration: InputDecoration(
                  labelText: "Enter login",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: kontrolerHaslo,
                obscureText: true,
                onChanged: (value) {
                  _updatePasswordStrength(value);
                },
                decoration: InputDecoration(
                  labelText: "Enter password",
                  border: OutlineInputBorder(),
                  suffixIcon: Tooltip(
                    message:
                        'Minimum 8 characters, at least 1 uppercase letter, 1 lowercase letter, 1 digit, and 1 special character',
                    child: Icon(Icons.info),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: kontrolerHaslo2,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Repeat password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Password Strength",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Container(
                width: double.infinity,
                height: 10,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _passwordStrengthIndicatorColor == Colors.green
                      ? 1.0
                      : 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _passwordStrengthIndicatorColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              _passwordStrengthText,
              style: TextStyle(
                color: _passwordStrengthIndicatorColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  _register();
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validatePassword(String password) {
    // Password validation: Minimum 8 characters, at least 1 uppercase letter, 1 lowercase letter, 1 digit, and 1 special character
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  void addUser(String imie, String login, String haslo) {
    setState(() {
      UserManager.users.add(
        User(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: imie,
          login: login,
          password: haslo,
        ),
      );

      kontrolerImie.clear();
      kontrolerLogin.clear();
      kontrolerHaslo.clear();
      kontrolerHaslo2.clear();
    });
  }

  void _updatePasswordStrength(String password) {
    setState(() {
      if (password.length < 8) {
        _passwordStrengthIndicatorColor = Colors.transparent;
        _passwordStrengthText = '';
      } else if (validatePassword(password)) {
        _passwordStrengthIndicatorColor = Colors.green;
        _passwordStrengthText = 'Strong';
      } else {
        _passwordStrengthIndicatorColor = Colors.red;
        _passwordStrengthText = 'Weak';
      }
    });
  }

  void _register() {
    String name = kontrolerImie.text.trim();
    String login = kontrolerLogin.text.trim();
    String password = kontrolerHaslo.text;
    String repeatedPassword = kontrolerHaslo2.text;

    setState(() {
      if (name.isEmpty ||
          login.isEmpty ||
          password.isEmpty ||
          repeatedPassword.isEmpty) {
        _showSnackBar('All fields are required');
      } else if (password != repeatedPassword) {
        _showSnackBar('Passwords do not match');
      } else if (!validatePassword(password)) {
        _showSnackBar('Password does not meet the requirements');
      } else {
        _showSnackBar('Registered successfully');
        addUser(name, login, password);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ),
        );
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
