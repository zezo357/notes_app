import 'package:flutter/material.dart';
import 'package:notes_app/models/Note.dart';
import 'package:notes_app/models/NotesOperation.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';

class EditScreen extends StatelessWidget{
  final Note note;

  EditScreen(this.note);

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode _node = FocusScopeNode();
    TextEditingController title=TextEditingController();
    TextEditingController Description=TextEditingController();
    title.text=note.title!;
    Description.text=note.description!;
    GlobalKey<FormState> _form = GlobalKey();
    void done(){
      if(_form.currentState!.validate()){
        Provider.of<NotesOperation>(context,listen: false).EditNote(note.title, note.description,title.text, Description.text);
        Navigator.pop(context);
      }
    }
    final validate = ValidationBuilder().minLength(1, 'Length < 1 😟').maxLength(1500).build();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("EditNote"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(

        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: FocusScope(
            node: _node,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                TextFormField(
                  autofocus: true,
                  onEditingComplete: _node.nextFocus,
                  validator: validate,
                  controller: title,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      fontSize: 18,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                    ),

                    border: InputBorder.none,
                    hintText: 'Enter Title',
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white

                    ),

                    labelText: 'title',labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  ),
                  style:  TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white

                  ),
                ),
                Container(
                  height: 10,
                ),
                TextFormField(
                  onEditingComplete:(){ done();},
                  textInputAction: TextInputAction.done,
                  validator: validate,
                  controller: Description,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      fontSize: 18,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                    ),

                    border: InputBorder.none,
                    hintText: 'Enter Description',
                    hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white

                    ),
                    labelText: 'Description',labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),

                  ),
                  style:TextStyle(
                      fontSize: 18,
                      color: Colors.white
                  ),
                ),
                Container(
                  height: 10,
                ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      onPressed: (){done();},
                      color: Colors.white,
                      child: Text('Save Note',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue
                        ),),
                    ),
                    FlatButton(
                      onPressed: (){
                        if(_form.currentState!.validate()){
                        Provider.of<NotesOperation>(context,listen: false).deleteNote(note.title, note.description);

                        Navigator.pop(context);
                      }},
                      color: Colors.white,
                      child: Text('Delete Note',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red
                        ),),
                    ),
                  ],
                )
              ],

            ),
          ),
        ),
      ),
    );
  }
}
