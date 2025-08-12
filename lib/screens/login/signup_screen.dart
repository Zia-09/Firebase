import 'package:firebase_practice/screens/login/login.dart';
import 'package:firebase_practice/serves/auth_servece.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Signup",
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      body: Column(
        children: [
          Text("Signup "),
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
                          .registerUser(
                            email: emailController.text,
                            password: pwdController.text,
                          )
                          .then((value) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Massege"),
                                  content: Text("User SignUp successfully"),
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
                  child: Text("SignUp", style: TextStyle(color: Colors.white)),
                ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SigninScreen()),
              );
            },
            child: Text("already have an account?"),
          ),
        ],
      ),
    );
  }
}
