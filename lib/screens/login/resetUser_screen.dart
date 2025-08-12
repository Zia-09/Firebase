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
      appBar: AppBar(title: Text("Reset Password"), centerTitle: true),
      body: Column(
        children: [
          Text("Reset Your Password", style: TextStyle(fontSize: 22)),
          TextField(
            controller: emailController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          isloading
              ? CircularProgressIndicator()
              : MaterialButton(
                  color: Colors.blue,
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
                      await AuthServece().resetPassword(emailController.text).then((
                        value,
                      ) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Massege"),
                              content: Text(
                                "Password reset link has been sent to your mail box.",
                              ),
                              actions: [
                                MaterialButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Okay",
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
                  child: Text(
                    "Reset Password",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        ],
      ),
    );
  }
}
