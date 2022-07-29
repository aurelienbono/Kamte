class Task{ 
  final int? id ; 
  final String? title ; 
  final int? total ; 
  final int? status;  // 0 signifie unArchived  // 1 signifie unArchived 

  Task({this.id,this.title,this.total,this.status});

  Map<String,dynamic> toMap(){ 
    return { 
      'id': id, 
      "title": title, 
      "total": total, 
      'status' : status
    }; 
  }


  


}