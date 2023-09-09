import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/screens/login_page.dart';

import '../providers/todo_provider.dart';
import '../shared_preferences/email_shared_preferences.dart';
import '../widgets/my_alert_dialog.dart';
import '../widgets/custom_todo_design.dart';
import '../widgets/searchTodosDelegate.dart';

class HomePage extends StatelessWidget {
  static const id = "home";
final String email;
  const HomePage({super.key,required this.email});

  @override
  Widget build(BuildContext context) {
    var todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: FutureBuilder(
            future: todoProvider.getTodos(email),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.data!.length>0) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ListView.builder(
                      itemBuilder: (context, index) =>  Dismissible(
                            key: ValueKey(snapshot.data[index]),
                            background: Container(
                              color: Colors.red[100],
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              todoProvider.deleteTodo(snapshot.data[index].id);
                            },
                            child: CustomTodoDesign(
                              todo: snapshot.data[index],
                            ),

                      ),
                      itemCount: snapshot.data!.length),
                );
              }
              else {
                return const Center(child: Text("no todos yet!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),));
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => MyAlertDialog(
                isAdd: true,
                onPress: (todoModel) {
                  todoProvider.addTodo(todoModel);
                }),
          );
        },
      ),
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Todo App",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchTodosDelegate());
              },
            ),
          ]),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
             accountEmail: Text("Welcome $email"),
             accountName: const Text(""),
              ),
            ListTile(
              onTap: (){
                Navigator.popAndPushNamed(context, LogIn.id);
                SharedPreferencesHelper.removeEmail();
              },
              title: const Text("Log out"),
              trailing: const Icon(Icons.logout),
            )
          ],
        ),
      ),
    );
  }
}
