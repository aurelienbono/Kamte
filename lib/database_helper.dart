// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_conditional_assignment, unnecessary_null_comparison

import 'package:keep_note/models/todo.dart';
import 'package:path/path.dart';
import 'package:keep_note/models/task.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper{ 

  Future<Database> database() async{
    return openDatabase( 
        join(await getDatabasesPath(), 'todo.db'),

    onCreate: (db, version) async {
    // Run the CREATE TABLE statement on the database.
    await db.execute( '''CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, total INTEGER , status INTEGER )''');
    await db.execute('''CREATE TABLE todo(id INTEGER PRIMARY KEY,taskId  INTEGER, title TEXT, price INTEGER , etat INTEGER , temp INTEGER )''');
  },
 version: 1,
    ); 
  }

// Define a function that inserts Tasks into the database
Future<void> insertTask(Task task) async {
  Database _db = await database();

  await _db.insert(
    'tasks',
    task.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// Define a function that inserts Todo into the database
Future<void> insertTodo(Todo todo) async {
  Database _db = await database();

  await _db.insert(
    'todo',
    todo.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}


Future<List<Task>> getTask() async{ 
  Database _db  = await database(); 
  List<Map<String,dynamic>> taskMap = await _db.query('tasks',where: "status=0"); 
   print(taskMap);
  return List.generate(taskMap.length, (index) { 
    return Task( id: taskMap[index]['id'], title:taskMap[index]['title'] , total: taskMap[index]['total'],status: taskMap[index]['status']); 
  }); 
}

Future<List<Task>> getTaskArchive() async{ 
  Database _db  = await database(); 

  List<Map<String,dynamic>> taskMap = await _db.query('tasks',where: "status=1"); 
  print(taskMap); 
  return List.generate(taskMap.length, (index) { 
    return Task( id: taskMap[index]['id'], title:taskMap[index]['title'] , total: taskMap[index]['total'],status: taskMap[index]['status']); 
  }); 
}

Future<void> updateTaskTitle(int id , String title) async{ 
  Database _db = await database() ; 
  await _db.rawUpdate("UPDATE tasks SET title='$title 'where id = '$id'");
  
}
Future<void> deleteTodo(int id ) async{ 
  Database _db = await database() ; 
  await _db.rawDelete("DELETE FROM  todo  WHERE id = '$id'");
  
}




Future<void> deleteTask(int id ) async{ 
  Database _db = await database() ; 
  await _db.rawDelete("DELETE FROM  tasks  WHERE id = '$id'");
  await _db.rawDelete("DELETE FROM  todo  WHERE taskId = '$id'");
}

Future<void> updateTaskPriceTotal(int id , int priceTotal) async{ 
  Database _db = await database() ; 
  List<Map<String, dynamic>> value = await _db.rawQuery("SELECT total FROM tasks WHERE id=$id"); 
  Map<String, dynamic> theNew = value[0]; 
  print("La valeur total au depart : ${theNew}"); 
  int _sum =0; 
  int _resquestValue = 0 ; 
  theNew.forEach((_key, _value) { 
    if(_value ==null){ 
       _resquestValue = 0; 
    }else { 
      _resquestValue = _value; 
    }
   
   }); 
   _resquestValue += priceTotal;  
     print("La valeur total a la fin  : ${_resquestValue}"); 
  await _db.rawUpdate(" UPDATE tasks SET total='$_resquestValue 'where id = '$id'");
 
}



Future<void> updateTaskRetrait(int id, int _idTodo , int ma_value) async{ 
  Database _db = await database() ; 
  List<Map<String, dynamic>> value = await _db.rawQuery("SELECT total FROM tasks WHERE id=$id"); 

  Map<String, dynamic> _theTotalValue = value[0]; 
  int _resquestTotalValue =0; 
  _theTotalValue.forEach((_key, _value) { 
    if(_value ==null){ 
       _resquestTotalValue = 0; 
    }else { 
      _resquestTotalValue = _value; 
    }
   }); 
      _resquestTotalValue -= ma_value;  

      int _nulVal = 0;

       await _db.rawUpdate(" UPDATE tasks SET total='$_resquestTotalValue 'where id = '$id'");
       await _db.rawUpdate(" UPDATE todo SET price='$ma_value 'where id = '$_idTodo'");
       await _db.rawUpdate(" UPDATE todo SET temp='$_nulVal' where id = '$_idTodo'");
}


Future<void> updateTaskCredit(int id, int _idTodo , int ma_value) async{ 
  Database _db = await database() ; 
  List<Map<String, dynamic>> value = await _db.rawQuery("SELECT total FROM tasks WHERE id=$id"); 

  Map<String, dynamic> _theTotalValue = value[0]; 
  int _resquestTotalValue =0; 
  _theTotalValue.forEach((_key, _value) { 
    if(_value ==null){ 
       _resquestTotalValue = 0; 
    }else { 
      _resquestTotalValue = _value; 
    }
   }); 
      _resquestTotalValue += ma_value;  
      int _nulVal = 0;

       await _db.rawUpdate(" UPDATE tasks SET total='$_resquestTotalValue 'where id = '$id'");
       await _db.rawUpdate(" UPDATE todo SET price='$ma_value 'where id = '$_idTodo'");
       await _db.rawUpdate(" UPDATE todo SET temp='$_nulVal' where id = '$_idTodo'");
}
// recuperation de la valeur temporaire stocker dans le tableau 
Future<int> getTemp(int id) async{ 
  Database _db = await database() ; 
  List<Map<String, dynamic>> value = await _db.rawQuery("SELECT temp FROM todo WHERE id=$id");  
  Map<String, dynamic> _theTotalValue = value[0]; 
    int _resquestTotalValue =0; 
    _theTotalValue.forEach((_key, _value) { 
    if(_value ==null){ 
       _resquestTotalValue = 0; 
    }else { 
      _resquestTotalValue = _value; 
    }
   }); 
   return _resquestTotalValue ; 
}

// recuperation de la valeur temporaire stocker dans le tableau 
Future<int> getPrice(int id) async{ 
  Database _db = await database() ; 
  List<Map<String, dynamic>> value = await _db.rawQuery("SELECT price FROM todo WHERE id=$id");  
  Map<String, dynamic> _theTotalValue = value[0]; 
    int _resquestTotalValue =0; 
    _theTotalValue.forEach((_key, _value) { 
    if(_value ==null){ 
       _resquestTotalValue = 0; 
    }else { 
      _resquestTotalValue = _value; 
    }
   }); 
   return _resquestTotalValue ; 
}


// recuperation le prix total d'un task stocker dans le tableau 
Future<void> getFinalTotalDebit(int id, int nbr) async{ 
  Database _db = await database() ; 
  List<Map<String, dynamic>> value = await _db.rawQuery("SELECT total FROM tasks WHERE id=$id");  
  Map<String, dynamic> _theTotalValue = value[0]; 
    int _resquestTotalValue =0; 
    _theTotalValue.forEach((_key, _value) { 
    if(_value ==null){ 
       _resquestTotalValue = 0; 
    }else { 
      _resquestTotalValue = _value; 
    }
   }); 

  _resquestTotalValue -= nbr*2 ; 

    await _db.rawUpdate(" UPDATE tasks SET total='$_resquestTotalValue 'where id = '$id'");}

// recuperation le prix total d'un task stocker dans le tableau 
Future<void> getFinalTotalCredit(int id, int nbr) async{ 
  Database _db = await database() ; 
  List<Map<String, dynamic>> value = await _db.rawQuery("SELECT total FROM tasks WHERE id=$id");  
  Map<String, dynamic> _theTotalValue = value[0]; 
    int _resquestTotalValue =0; 
    _theTotalValue.forEach((_key, _value) { 
    if(_value ==null){ 
       _resquestTotalValue = 0; 
    }else { 
      _resquestTotalValue = _value; 
    }
   }); 

  _resquestTotalValue += nbr*2 ; 

    await _db.rawUpdate(" UPDATE tasks SET total='$_resquestTotalValue 'where id = '$id'");}





Future<int> getEtatTodo(int id) async{ 
  Database _db = await database() ; 
  List<Map<String, dynamic>> value = await _db.rawQuery("SELECT etat FROM todo WHERE id=$id");  
  Map<String, dynamic> _theEtatValue = value[0]; 
    int _resquestEtatValue =0; 
    _theEtatValue.forEach((_key, _value) { 
    if(_value ==null){ 
       _resquestEtatValue = 0; 
    }else { 
      _resquestEtatValue = _value; 
    }
   }); 
   return _resquestEtatValue ; 
}




Future<List> getTodoShare(int taskId) async{ 
  Database _db  = await database(); 

  List<Map<String, Object?>> todoMap = await _db.rawQuery("SELECT title FROM todo WHERE taskId=$taskId"); 
  List _theList = []; 
  for(var i  in  todoMap){ 
    _theList.add(i.values.toString()); 
  }
  print(_theList.runtimeType); 
    return _theList; 

}


Future<List<Todo>> getTodo(int taskId) async{ 
  Database _db  = await database(); 

  List<Map<String,dynamic>> todoMap = await _db.rawQuery("SELECT * FROM todo WHERE taskId=$taskId"); 
  print(todoMap); 
  return List.generate(todoMap.length, (index) { 
    return Todo( id: todoMap[index]['id'] , taskId:  todoMap[index]['taskId'], title:  todoMap[index]['title'], price:  todoMap[index]['price'] , etat:  todoMap[index]['etat']); 
  }); 
}



Future<void> updateTodoEtat(int id , int etat) async{ 
  Database _db = await database() ; 
  await _db.rawUpdate("UPDATE todo SET etat='$etat 'where id = '$id'"); 
}

Future<void> updateTastStatus(int id , int status) async{ 
  Database _db = await database() ; 
  await _db.rawUpdate("UPDATE tasks SET status='$status 'where id = '$id'"); 
}

Future<int> getStatus(int id) async{ 
  Database _db = await database() ; 
  List<Map<String, dynamic>> value = await _db.rawQuery("SELECT status FROM tasks WHERE id=$id");  
  Map<String, dynamic> _theTotalValue = value[0]; 
    int _resquestTotalValue =0; 
    _theTotalValue.forEach((_key, _value) { 
    if(_value ==null){ 
       _resquestTotalValue = 0; 
    }else { 
      _resquestTotalValue = _value; 
    }
   }); 
   return _resquestTotalValue ; 
}

Future<int> getCount(int id) async{ 
  Database _db = await database() ; 
 List<Map<String, Object?>> number = await _db.rawQuery("SELECT COUNT(*) FROM todo where taskId=$id"); 
  Map<String, dynamic> _tempNumber = number[0]; 
    int _resquestTempNumber =0; 
    _tempNumber.forEach((_key, _value) { 
    if(_value ==null){ 
       _resquestTempNumber = 0; 
    }else { 
      _resquestTempNumber = _value; 
    }
   }); 
   return _resquestTempNumber ; 
}

Future<void> updateTodoPrice(int id , int price) async{ 
  Database _db = await database() ; 
 await _db.rawUpdate(" UPDATE todo SET price='$price 'where id = '$id'");
}


Future<int> getCountTask() async{ 
  Database _db = await database() ; 
 List<Map> result =  await _db.query("tasks"); 
  int _totalTasks = result.length; 
  return _totalTasks; 

}
 

Future<int> getCountTodo() async{ 

   Database _db = await database() ; 
  List<Map> result =  await _db.query("tasks"); 
  int _totalTodo = result.length; 
  return _totalTodo; 
}
 
 
 
 
}
