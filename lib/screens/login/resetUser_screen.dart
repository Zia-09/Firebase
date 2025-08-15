import 'package:firebase_practice/screens/login/login.dart';
import 'package:firebase_practice/serves/auth_servece.dart';
import 'package:flutter/material.dart';

class ResetuserScreen extends StatefulWidget {
  const ResetuserScreen({super.key});

  @override
  State<ResetuserScreen> createState() => _ResetuserScreenState();
}

class _ResetuserScreenState extends State<ResetuserScreen> {
  TextEditingController emailController = TextEditingController();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Reset Password"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "Forgot your password?",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Enter your email to reset your password.",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
            Text(
              "UserName",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email",
              ),
            ),
            SizedBox(height: 20),
            isloading
                ? Center(child: CircularProgressIndicator())
                : MaterialButton(
                    minWidth: 370,
                    height: 50,
                    color: Colors.red,
                    onPressed: () async {
                      if (emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Email can't be empty")),
                        );
                        return null;
                      }
                      try {
                        isloading = true;
                        setState(() {});
                        await AuthServece()
                            .resetPassword(emailController.text)
                            .then((value) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Massege"),
                                    content: Text(
                                      "Password reset link has been sent to your mail box.",
                                    ),
                                    actions: [
                                      Center(
                                        child: MaterialButton(
                                          minWidth: 270,
                                          color: Colors.red,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SigninScreen(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Okay",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
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
                    child: Text(
                      "Reset Password",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
            SizedBox(height: 50),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SigninScreen()),
                  );
                },
                child: Text(
                  "<< Go back to login ",
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
