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
 
}