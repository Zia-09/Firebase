import 'package:firebase_practice/screens/login/resetUser_screen.dart';
import 'package:firebase_practice/screens/login/signup_screen.dart';
import 'package:firebase_practice/serves/auth_servece.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      body: Column(
        children: [
          Text("Login "),
          SizedBox(height: 20),
          TextField(controller: emailController),
          SizedBox(height: 20),
          TextField(controller: pwdController),
          SizedBox(height: 30),
          isloading
              ? CircularProgressIndicator()
              : MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        pwdController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Fields Cont't be empty")),
                      );
                      return null;
                    }
                    try {
                      isloading = true;
                      setState(() {});
                      await AuthServece()
                          .loginUser(
                            email: emailController.text,
                            password: pwdController.text,
                          )
                          .then((value) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Massege"),
                                  content: Text("User Login successfully"),
                                  actions: [
                                    MaterialButton(
                                      color: Colors.blue,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Ok",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    } catch (e) {
                      isloading = false;
                      setState(() {});
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("SignIn", style: TextStyle(color: Colors.white)),
                ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupScreen()),
              );
            },
            child: Text("Don't have an account?"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResetuserScreen()),
              );
            },
            child: Text("reset pasword"),
          ),
        ],
      ),
    );
  }
}
