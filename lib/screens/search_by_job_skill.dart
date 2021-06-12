import 'package:flutter/material.dart';

class SearchByJobSkill extends StatefulWidget {
  const SearchByJobSkill({Key? key}) : super(key: key);

  @override
  _SearchByJobSkillState createState() => _SearchByJobSkillState();
}

class _SearchByJobSkillState extends State<SearchByJobSkill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("Search by job skill"),
      ),
    );
  }
}
