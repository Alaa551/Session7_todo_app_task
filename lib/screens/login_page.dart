

import 'package:flutter/material.dart';
import 'package:untitled2/screens/home.dart';

import '../shared_preferences/email_shared_preferences.dart';

class LogIn extends StatefulWidget {
  static const String id = "log_in";

  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController emailController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Log in page",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: formState,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (value){
                          if (value!.isEmpty) {
                            return "please enter your email";

                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () async {
                if(formState.currentState!.validate()){
                 await SharedPreferencesHelper.setEmail(emailController.text);
                 String newEmail= await SharedPreferencesHelper.getEmail();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage(email: newEmail)));
                }
              },
              minWidth: 360,
              height: 50,
              elevation: 10,
              color: Colors.orange,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.orange)),
              child: const Text(
                "Save email",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Todo App",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        leading: const Text(""),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
