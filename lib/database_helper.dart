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
    await db.execute( '''CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, total INTEGER DEFAULT 0)''');
    await db.execute('''CREATE TABLE todo(id INTEGER PRIMARY KEY,taskId  INTEGER, title TEXT, price INTEGER , etat INTEGER DEFAULT 0 )''');
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

  List<Map<String,dynamic>> taskMap = await _db.query('tasks'); 
  return List.generate(taskMap.length, (index) { 
    return Task( id: taskMap[index]['id'], title:taskMap[index]['title'] , total: taskMap[index]['total'] ); 
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

// Cette fonction servira de lister la nombre de todo 
// Future<void> listTodo() async{ 
//   Database _db = await database() ; 
//   await _db.rawUpdate("UPDATE tasks SET description='$description 'where id = '$id'");
  
// }

// c'est a changer 
// Future<void> updateTaskPriceTotal(int id , int priceTotal) async{ 
//   Database _db = await database() ; 
//   // List<Map<String, Object?>> value = await _db.rawQuery("SELECT total FROM tasks WHERE taskId=$id"); 
//   await _db.rawUpdate(" UPDATE tasks SET total='$priceTotal 'where id = '$id'");
  
// }

Future<void> updateTaskPriceTotal(int id , int priceTotal) async{ 
  Database _db = await database() ; 
  List<Map<String, dynamic>> value = await _db.rawQuery("SELECT total FROM tasks WHERE id=$id"); 
  Map<String, dynamic> theNew = value[0]; 
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
  await _db.rawUpdate(" UPDATE tasks SET total='$_resquestValue 'where id = '$id'");
 
}

Future<void> updateTaskRetrait(int id,int ma_value) async{ 
  Database _db = await database() ; 
  List<Map<String, dynamic>> value = await _db.rawQuery("SELECT total FROM tasks WHERE id=$id"); 

  Map<String, dynamic> _theTotalValue = value[0]; 
  print(_theTotalValue); 

  int _resquestTotalValue =0; 
  _theTotalValue.forEach((_key, _value) { 
    if(_value ==null){ 
       _resquestTotalValue = 0; 
    }else { 
      _resquestTotalValue = _value; 
    }
   }); 
     print("Avant la soustractionn "); 
     print(_resquestTotalValue);


      _resquestTotalValue -= ma_value;  
      print("Apres la soustractionn "); 
      print(_resquestTotalValue);

       print("La difference des deux valeurs : $_resquestTotalValue"); 
       await _db.rawUpdate(" UPDATE tasks SET total='$_resquestTotalValue 'where id = '$id'");
}


Future<List<Todo>> getTodo(int taskId) async{ 
  Database _db  = await database(); 

  List<Map<String,dynamic>> todoMap = await _db.rawQuery("SELECT * FROM todo WHERE taskId=$taskId"); 
  return List.generate(todoMap.length, (index) { 
    return Todo( id: todoMap[index]['id'] , taskId:  todoMap[index]['taskId'], title:  todoMap[index]['title'], price:  todoMap[index]['price'] , etat:  todoMap[index]['etat']); 
  }); 
}

Future<void> updateTadoEtat(int id , int etat) async{ 
  Database _db = await database() ; 
  await _db.rawUpdate("UPDATE todo SET etat='$etat 'where id = '$id'"); 
}
 
}
