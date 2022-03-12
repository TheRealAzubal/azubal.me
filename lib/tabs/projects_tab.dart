import 'package:azubal/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class ProjectsTab extends StatefulWidget {
  @override
  _ProjectTabeState createState() => _ProjectTabeState();
}

class _ProjectTabeState extends State<ProjectsTab> {
  Future<List<Project>> futureProjects;

  Future<List<Project>> fetchGithubRepository() async {
    final response = await http
        .get(Uri.parse('https://api.github.com/users/TheRealAzubal/repos'));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => Project.fromJson(e))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load project');
    }
  }

  @override
  void initState() {
    super.initState();
    futureProjects = fetchGithubRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Project>>(
      future: futureProjects,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
//snapshot.data[index].name

              return Container(
                height: 50,
                child: Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      launchURL(snapshot.data[index].html_url);
                    },
                    child: SizedBox(
                      width: 300,
                      height: 100,
                      child: Text(snapshot.data[index].name),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    ));
  }

  launchURL(var url) async {
    await launch(url);
  }
}
