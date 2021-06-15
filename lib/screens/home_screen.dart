import 'package:flutter/material.dart';
import 'package:notes_app/models/Note.dart';
import 'package:notes_app/models/NotesOperation.dart';
import 'package:notes_app/screens/Edit_Screen.dart';
import 'package:notes_app/screens/add_screen.dart';
import 'package:provider/provider.dart';
 class HomeScreen extends StatelessWidget {
   @override
   Widget build(BuildContext context) {

     Provider.of<NotesOperation>(context,listen: false).ReadDB();
     return Scaffold(
       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
       floatingActionButton: FloatingActionButton(
         onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=> AddScreen()));
         },
         child: Icon(
           Icons.add,
           size:30,
           color: Theme.of(context).scaffoldBackgroundColor,
         ),
         backgroundColor: Colors.white,
       ),

       appBar: AppBar(
         title: Text("NotesHelper" ),
         centerTitle: true,
         elevation: 0,
         backgroundColor: Colors.transparent,
       ),
      body: Consumer<NotesOperation>(
        builder: (context,NotesOperation data,child){
          return ListView.builder(
            itemCount: data.getNotes.length,
            itemBuilder: (context,index){
              return GestureDetector(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  EditScreen(data.getNotes[index])));
              },
                  child: NotesCard(data.getNotes[index])
              );

            }

          );

        }
      ),
     );
   }
 }

class NotesCard extends StatelessWidget {
    final Note note;

    NotesCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
        BoxShadow(
        color: Colors.black,
        offset: Offset(0.0, 1.0), //(x,y)
        blurRadius: 6.0,
      ),
      ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title!,
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),
          ),
          SizedBox(height: 5,),
          Text(
            note.description!,
            style: TextStyle(fontSize: 17,color: Colors.blue),
          )
        ],
      ),
    );
  }
}
