

class TodoModel {
  String? id;
  String title;
  bool value;
  String email;


  TodoModel(
      {required this.title,
        required this.email,
        this.value=false,
        this.id
      });



  factory TodoModel.fromJson(Map<String,dynamic> json){

    return TodoModel(
        title: json["title"],
        value: json["status"],
        id: json["id"],
      email: json["email"],

    );
  }
  Map<String,dynamic> toJson(){
    return {
      "title":title,
      "status":value,
      "email": email
    };
  }
}


