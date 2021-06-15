import 'package:flutter/material.dart';
import 'package:notes_app/models/Note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesOperation extends ChangeNotifier{
  List<Note> _notes =[];

  List<Note> get getNotes{
    return _notes;
  }



  void addNewNotes(String? title, String? description){
    Note note=Note(title, description);
    _notes.add(note);
    UpdateDB();
    ReadDB();
    notifyListeners();

  }
  Future<void> EditNote(String? title_old, String? description_old,String title, String description) async {
    _notes.clear();
    deleteNote(title_old, description_old);//from database
    addNewNotes(title, description);//added to notes
    UpdateDB();
    ReadDB();
    notifyListeners();
  }
  Future<void> deleteNote(String? title, String? description) async {
    Note note=Note(title, description);
    Future<Database> database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
        join(await getDatabasesPath(), 'Note_database.db'),
        onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
    "CREATE TABLE Notes(Title TEXT, Description TEXT,PRIMARY KEY (Title, Description))",
    );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,

    );
    final db = await database;
    List<String?> values=[];
    values.add(note.title);
    values.add(note.description);
    await db.delete(
    'Notes',
    // Use a `where` clause to delete a specific dog.
    where: "Title = ? AND Description = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs:values
    );
    ReadDB();
    notifyListeners();
  }


    Future<void> UpdateDB() async {
      Future<Database> database = openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'Note_database.db'),
        onCreate: (db, version) {
          // Run the CREATE TABLE statement on the database.
          return db.execute(
            "CREATE TABLE Notes(Title TEXT, Description TEXT,PRIMARY KEY (Title, Description))",
          );
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 1,

      );

      // Get a reference to the database.
      final Database db = await database;

      // Insert the Dog into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same dog is inserted twice.
      //
      // In this case, replace any previous data.
      _notes.forEach((element) async {
        await db.insert(
        'Notes',
          element.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );});
    }
    Future<void> ReadDB() async {
      Future<Database> database = openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'Note_database.db'),
        onCreate: (db, version) {
          // Run the CREATE TABLE statement on the database.
          return db.execute(
            "CREATE TABLE Notes(Title TEXT, Description TEXT,PRIMARY KEY (Title, Description))",
          );
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 1,

      );

      // Get a reference to the database.
      final Database db = await database;

      // Query the table for all The Notes.
      final List<Map<String, dynamic>> maps = await db.query('Notes');

      // Convert the List<Map<String, dynamic> into a List<Note>.
      _notes.clear();
      _notes = List.generate(maps.length, (i) {
        return Note(
          maps[i]['Title'],
          maps[i]['Description'],
        );
      });
      //_notes.forEach((element) {element.Print();});
      notifyListeners();
    }


  }


