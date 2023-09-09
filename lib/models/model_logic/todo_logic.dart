


import 'dart:convert';

import 'package:untitled2/models/entities/todo_model.dart';

import '../../constants/end_points.dart';
import '../api_handler.dart';

class TodoLogic {
  static final ApiHandler apiHandler = ApiHandler();

  static Future getTodos() async {
    const url = BASE_URL + NOTES_ENDPOINT;
    try {
      final response = await apiHandler.makeRequest(url);
      final mapResponse= jsonDecode(response.body) as List;
      return mapResponse.map((e) => TodoModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future addTodo(TodoModel note) async {
    String url = BASE_URL + NOTES_ENDPOINT;
    try {
      final response = await apiHandler.makeRequest(url,method: "POST",body: note.toJson());
      final mapResponse= jsonDecode(response.body);
      print(mapResponse);
    } catch (e) {
      rethrow;
    }
  }

  static Future deleteTodo(String id) async {
    String url = "$BASE_URL$NOTES_ENDPOINT/$id";
    try {
      final response = await apiHandler.makeRequest(url,method: "DELETE");
      final mapResponse= jsonDecode(response.body) ;
      print(mapResponse);
    } catch (e) {
      rethrow;
    }
  }

  static Future updateTodo(String id,TodoModel note) async {
    String url = "$BASE_URL$NOTES_ENDPOINT/$id";
    try {
      final response = await apiHandler.makeRequest(url,method: "PUT",body: note.toJson());
      final mapResponse= jsonDecode(response.body) ;
      print(mapResponse);
    } catch (e) {
      rethrow;
    }
  }





}
