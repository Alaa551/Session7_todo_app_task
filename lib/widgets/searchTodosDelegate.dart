import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todo_provider.dart';
import 'custom_todo_design.dart';
import 'my_alert_dialog.dart';

class SearchTodosDelegate extends SearchDelegate {
  Widget buildSearchBar(BuildContext context) {
    return TextField(
      onChanged: (value) {
        query = value;
      },
      decoration: const InputDecoration(
        labelText: "Search...",
        border: OutlineInputBorder(),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: () {
        query = "";
      }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    var provider= Provider.of<TodoProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey,
      body:
       FutureBuilder(
          future: provider.searchTodos(query),
          builder: (context,snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            else if (snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()),);
            }
            else if(snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: ValueKey(snapshot.data![index]),
                            onDismissed: (direction) {
                              provider.deleteTodo(snapshot.data![index].id);
                            },
                            child: CustomTodoDesign(
                              todo: snapshot.data[index],
                            ),
                          );
                        },
                        itemCount: snapshot.data!.length,
                      ),
                    ),
                  )
                  ,
                  //    const SizedBox(height: 20,),
                  //        Consumer<UserProvider>(
                  //          builder: (context,userProvider,child) {
                  //            return Row(
                  //              mainAxisAlignment: MainAxisAlignment.center,
                  //              crossAxisAlignment: CrossAxisAlignment.center,
                  //              children: [
                  //
                  //                ElevatedButton(
                  //                  onPressed: () {
                  //                    if(userProvider.currentNumber>0) {
                  //                      userProvider.currentNumber--;
                  //                    }
                  //                  },
                  //                  child: const Icon(Icons.remove),
                  //                ),
                  //                Padding(
                  //                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //                  child: Text("${userProvider.currentNumber}", style: const TextStyle(fontSize: 30),),
                  //                ),
                  //                ElevatedButton(
                  //                  onPressed: () {
                  //                    userProvider.currentNumber++;
                  //                  },
                  //                  child: const Icon(Icons.add),
                  //                ),
                  //              ],
                  //            );
                  //
                  //          },
                  //        ),
                  //    const SizedBox(height: 20,),
                  // CupertinoSwitch(
                  //   onChanged: (value){
                  //     userProvider.toggleMode();
                  //   },
                  //   value: userProvider.isDark,
                  // )
                ]
                ,
              );
            }
            return const Center(child: Text("no data"),);

          }
      ),
    );

  }
}
