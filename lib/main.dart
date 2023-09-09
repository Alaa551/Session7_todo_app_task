import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/providers/todo_provider.dart';
import 'package:untitled2/screens/home.dart';
import 'package:untitled2/screens/login_page.dart';
import 'package:untitled2/shared_preferences/email_shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String email= await SharedPreferencesHelper.getEmail();
  runApp( MyApp(email: email));
}

class MyApp extends StatelessWidget {
  final String email;
  const MyApp({super.key, required this.email});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodoProvider(),
        ),
      ],
      child: MaterialApp(
        routes: {
          HomePage.id: (context) =>  HomePage(email: email,),
          LogIn.id: (context) => const LogIn(),
        },
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: email.isNotEmpty?  HomePage(email: email,):const LogIn(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
