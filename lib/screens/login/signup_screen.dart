import 'package:firebase_practice/screens/login/login.dart';
import 'package:firebase_practice/screens/login/resetUser_screen.dart';
import 'package:firebase_practice/screens/login/signup_screen.dart';
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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create Your account",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text("Join us and start your journey!"),
            SizedBox(height: 30),
            SizedBox(
              width: 370,
              height: 60,
              child: OutlinedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/google.png", scale: 8),
                    SizedBox(width: 10),
                    Text(
                      "Google SignIn",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 370,
              height: 60,
              child: OutlinedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/apple.png", scale: 8),
                    SizedBox(width: 10),
                    Text(
                      "SignIn with Apple",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  width: 100,
                ),
                Text("Or SignIn with email"),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  width: 100,
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              "Email",
              style: TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Email",
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Password",
              style: TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            // SizedBox(height: 5),
            TextField(
              controller: pwdController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Password",
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SigninScreen()),
                );
              },
              child: Text(
                "Already have an account?",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            isloading
                ? CircularProgressIndicator()
                : MaterialButton(
                    minWidth: 370,
                    height: 50,
                    color: Colors.red,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
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
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
