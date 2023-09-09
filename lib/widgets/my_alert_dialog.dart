
import 'package:flutter/material.dart';
import 'package:untitled2/shared_preferences/email_shared_preferences.dart';
import '../models/entities/todo_model.dart';



class MyAlertDialog extends StatelessWidget {
  // if true -> add
  // if false -> update
 final bool isAdd;
 final Function (TodoModel) onPress;
 final TodoModel? todo;



 const MyAlertDialog({super.key, required this.isAdd, required this.onPress, this.todo});

  @override
  Widget build(BuildContext context) {
   late String title;
    if(isAdd){
      title= "";
    }
    else if(todo!=null){
      title=todo!.title;
    }

    final GlobalKey<FormState> formState = GlobalKey<FormState>();
    return AlertDialog(
      title: const Text("warning"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: formState,
            child: TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return "Can't be empty";
                }
                return null;
              },
              onChanged: (value){
                title=value;
              },
              initialValue: title,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter title",
              ),
            ),
          ),

        ],
      ),
      actions: [
        FutureBuilder(
          future: SharedPreferencesHelper.getEmail(),
          builder: (context, snapshot) =>
           ElevatedButton(onPressed: () {
            if (formState.currentState!.validate()) {
              onPress(TodoModel(title: title,email: (todo!=null) ? todo!.email : snapshot.data!));
              Navigator.pop(context);
            }

          },
            child: Text(isAdd? "Add":"Save"),
          ),
        ),
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        },
          child: const Text("Cancel"),
        )
      ],
    );
  }
}
