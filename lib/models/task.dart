class Task{ 
  final int? id ; 
  final String? title ; 
  final int? total ; 

  Task({this.id,this.title,this.total});

  Map<String,dynamic> toMap(){ 
    return { 
      'id': id, 
      "title": title, 
      "total": total, 
    }; 
  } 
}