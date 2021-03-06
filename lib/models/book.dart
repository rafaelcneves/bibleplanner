import 'dart:convert';

import 'package:bibleplanner/models/abbrev.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Future<List<Book>> fetchBooks() async {
  final response = await rootBundle.loadString('assets/data/books.json');

  // Use the compute function to run parseBooks in a separate isolate.
  // return rootBundle.loadString('assets/data/books.json');
  return compute(parseBooks, response);
}

// A function that converts a response body into a List<Book>.
List<Book> parseBooks(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Book>((json) => Book.fromJson(json)).toList();
}

class Book {
  Abbrev abbrev;
  String author;
  int chapters;
  String group;
  String name;
  String testament;

  Book(
      {this.abbrev,
      this.author,
      this.chapters,
      this.group,
      this.name,
      this.testament});

  Book.fromJson(Map<String, dynamic> json) {
    abbrev =
        json['abbrev'] != null ? new Abbrev.fromJson(json['abbrev']) : null;
    author = json['author'];
    chapters = json['chapters'];
    group = json['group'];
    name = json['name'];
    testament = json['testament'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.abbrev != null) {
      data['abbrev'] = this.abbrev.toJson();
    }
    data['author'] = this.author;
    data['chapters'] = this.chapters;
    data['group'] = this.group;
    data['name'] = this.name;
    data['testament'] = this.testament;
    return data;
  }
}
