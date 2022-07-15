class  Todo {
  final int? id ; 
  final int? taskId ; 
 final String? title ; 
 final int? price; 
 final int? etat; 
 final int? temp ; 


  Todo({this.id ,this.taskId, this.title,this.price,this.etat,this.temp});  

  Map<String,dynamic> toMap(){ 
    return { 
      'id': id, 
      "taskId": taskId, 
      "title": title, 
      "price": price, 
      "etat": etat, 
      "temp": temp, 
    }; 
  } 
}