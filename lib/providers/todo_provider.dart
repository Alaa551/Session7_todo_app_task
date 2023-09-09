import 'package:flutter/cupertino.dart';
import 'package:untitled2/models/model_logic/todo_logic.dart';
import 'package:untitled2/shared_preferences/email_shared_preferences.dart';

import '../models/entities/todo_model.dart';

class TodoProvider extends ChangeNotifier{
 // late List<TodoModel> todos;

  Future addTodo(TodoModel todo) async{
    try{
      await TodoLogic.addTodo(todo);
      notifyListeners();
    }
    catch(e){
      rethrow;
    }
  }

  Future getTodos(String email) async{
    try{
      final response= await TodoLogic.getTodos() as List<TodoModel>;
      //todos=response;
      return response.where((element) => element.email==email).toList();
    }
    catch(e){
      rethrow;
    }
  }

  Future deleteTodo(String id) async{
    try{
      await TodoLogic.deleteTodo(id);
      notifyListeners();
    }
    catch(e){
      rethrow;
    }

  }

  Future updateTodo(String id,TodoModel note) async {
    try{
      await TodoLogic.updateTodo(id,note);
      notifyListeners();
    }
    catch(e){
      rethrow;
    }

  }


  Future searchTodos(String query) async{
    try{
      String email=await SharedPreferencesHelper.getEmail();
      final response=await getTodos(email) as List<TodoModel>;
      return response.where((element) =>
          element.title.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }catch(e){

      return [];
    }
  }


}