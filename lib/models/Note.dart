import 'package:flutter/material.dart';
class Note{
  String? title;
  String? description;

  Note(this.title, this.description);

  Map<String, dynamic> toMap() {
    return {
      'Title': title,
      'Description': description,
    };

  }
  void Print(){
    print("title "+title!+" 0000 "+"description "+description!);

  }
}