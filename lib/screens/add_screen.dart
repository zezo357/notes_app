import 'package:flutter/material.dart';
import 'package:notes_app/models/NotesOperation.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';

class AddScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    String? TitleText;
    String? DescriptionText;
    final FocusScopeNode _node = FocusScopeNode();
    final validate = ValidationBuilder().minLength(1, 'Length < 1 😟').maxLength(1500).build();
    GlobalKey<FormState> _form = GlobalKey();
    void done(){
      if(_form.currentState!.validate()) {
        Provider.of<NotesOperation>(context, listen: false)
            .addNewNotes(TitleText, DescriptionText);

        Navigator.pop(context);
      }
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("AddNote"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
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
                    labelText: 'Title',labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  ),
                  style:  TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white

                  ),
                  onChanged: (value){
                    TitleText=value;
                  },
                ),
                Container(
                  height: 10,
                ),
                TextFormField(

                  onEditingComplete:(){done();},
                  textInputAction: TextInputAction.done,
                  validator: validate,
                  onChanged: (value){
                    DescriptionText=value;
                  },
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

                    labelText: 'Description',labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                    border: InputBorder.none,
                    hintText: 'Enter Description',
                    hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white

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
                FlatButton(
                  onPressed: (){done();},
                  color: Colors.white,
                  child: Text('Add Note',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue
                  ),),
                )
              ],

            ),
          ),
        ),
      ),
    );
  }
}
