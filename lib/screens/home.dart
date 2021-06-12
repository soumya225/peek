import 'package:flutter/material.dart';
import 'package:peek/screens/search_by_job_skill.dart';
import 'package:peek/screens/search_by_job_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchByJobTitle()));
                },
                child: Text(
                  "Search by title"
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchByJobSkill()));
                },
                child: Text(
                    "Search by skill"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}