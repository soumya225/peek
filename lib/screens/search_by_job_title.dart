import 'package:flutter/material.dart';

class SearchByJobTitle extends StatefulWidget {
  const SearchByJobTitle({Key? key}) : super(key: key);

  @override
  _SearchByJobTitleState createState() => _SearchByJobTitleState();
}

class _SearchByJobTitleState extends State<SearchByJobTitle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("Search by job title"),
      ),
    );
  }
}
