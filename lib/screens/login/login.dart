import 'package:firebase_practice/providers/userProviders.dart';
import 'package:firebase_practice/screens/getall_Task.dart';
import 'package:firebase_practice/screens/login/resetUser_screen.dart';
import 'package:firebase_practice/screens/login/signup_screen.dart';
import 'package:firebase_practice/screens/profile_screen.dart';
import 'package:firebase_practice/serves/auth_servece.dart';
import 'package:firebase_practice/serves/user_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var user = Provider.of<Userproviders>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome back! ",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text("We are glad to see you again"),
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
                    width: 90,
                  ),
                  Text("Or SignIn with email"),
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    width: 90,
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
              Row(
                children: [
                  Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetuserScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        fontSize: 17,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
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
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 10),
              isloading
                  ? Center(child: CircularProgressIndicator())
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
                              .loginUser(
                                email: emailController.text,
                                password: pwdController.text,
                              )
                              .then((value) async {
                                await UserServices().getUser(value.uid).then((
                                  userData,
                                ) {
                                  user.setUser(userData);
                                });
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
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    GetallTask(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(
                                              color: Colors.white,
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Error: ${e.toString()}",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Text(
                        "SignIn",
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
      ),
    );
  }
}
