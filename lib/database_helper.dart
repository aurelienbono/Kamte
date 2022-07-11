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
    await db.execute( '''CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)''');
    await db.execute('''CREATE TABLE todo(id INTEGER PRIMARY KEY,taskId  INTEGER, title TEXT, isDone INTEGER)''');
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
    return Task( id: taskMap[index]['id'], title:taskMap[index]['title'] , description: taskMap[index]['description'] ); 
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
  await _db.rawDelete("DELETE FROM  todo  WHERE id = '$id'");

  
}




// c'est a changer 
Future<void> updateTaskDescription(int id , String description) async{ 
  Database _db = await database() ; 
  await _db.rawUpdate("UPDATE tasks SET description='$description 'where id = '$id'");
  
}


Future<List<Todo>> getTodo(int taskId) async{ 
  Database _db  = await database(); 

  List<Map<String,dynamic>> todoMap = await _db.rawQuery("SELECT * FROM todo WHERE taskId=$taskId"); 
  return List.generate(todoMap.length, (index) { 
    return Todo( id: todoMap[index]['id'] , taskId:  todoMap[index]['taskId'], title:  todoMap[index]['title'], isDone:  todoMap[index]['isDone'] ); 
  }); 
}
 
}