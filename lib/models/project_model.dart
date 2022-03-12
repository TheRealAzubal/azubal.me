import 'package:flutter/material.dart';

class Project {
  // ignore: non_constant_identifier_names
  String avatar_url;
  String name;
  String description;
  // ignore: non_constant_identifier_names
  String html_url;

  // ignore: non_constant_identifier_names
  Project(
      // ignore: non_constant_identifier_names
      {@required this.avatar_url,
      @required this.name,
      @required this.description,
      // ignore: non_constant_identifier_names
      this.html_url});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      avatar_url: json['avatar_url'],
      name: json['name'],
      description: json['description'],
      html_url: json['html_url'],
    );
  }
}
