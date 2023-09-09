

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/shared_preferences/email_shared_preferences.dart';

import '../models/entities/todo_model.dart';
import '../providers/todo_provider.dart';
import 'my_alert_dialog.dart';

class CustomTodoDesign extends StatelessWidget {
 final TodoModel todo;

 const CustomTodoDesign({super.key, required this.todo});
 @override
  Widget build(BuildContext context) {
   var todoProvider = Provider.of<TodoProvider>(context);
      return InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) =>
                  MyAlertDialog(isAdd: false,
                      onPress: (todoModel){
                        todoProvider.updateTodo(todo.id!, todoModel);
                      },todo: todo,
                    )
          );

        },
        child: Container(
          alignment: Alignment.center,
          height: 80,
          margin: const EdgeInsetsDirectional.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            //shape: BoxShape.circle
          ),
          child: CheckboxListTile(
              title: Text(todo.title),
              value: todo.value,
              onChanged: (value) {
                todoProvider.updateTodo(todo.id!,TodoModel(title: todo.title,value: value as bool, email: todo.email));
              }),
        ),
      );

  }
}
