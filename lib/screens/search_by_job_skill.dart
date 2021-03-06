import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:peek/models/job_model.dart';
import 'package:peek/screens/home.dart';
import 'package:peek/screens/tile.dart';

class SearchByJobSkill extends StatefulWidget {
  const SearchByJobSkill({Key? key}) : super(key: key);

  @override
  _SearchByJobSkillState createState() => _SearchByJobSkillState();
}

class _SearchByJobSkillState extends State<SearchByJobSkill> {
  TextEditingController _textEditingController = TextEditingController();

  final List<Job> filteredList = [];
  HashMap jobTitleMap = HashMap();

  @override
  void initState() {
    filteredList.addAll(jobsList);
    super.initState();
  }

  void _filterSearchResults (String query) {
    query = query.toLowerCase();

    List<Job> results = [];

    jobTitleMap.clear();

    if (query.isNotEmpty) {
      jobsList.forEach((job) {
        if (job.tags.contains(query)) {
          results.add(job);
          if(jobTitleMap.containsKey(job.jobTitle)) {
            jobTitleMap[job.jobTitle] += 1;
          } else {
            jobTitleMap[job.jobTitle] = 1;
          }
        }
      });
      setState(() {
        print(jobTitleMap);
        filteredList.clear();
        filteredList.addAll(results);
      });
    } else {
      setState(() {
        filteredList.clear();
        jobsList.forEach((job) {
          filteredList.add(job);
          if(jobTitleMap.containsKey(job.jobTitle)) {
            jobTitleMap[job.jobTitle] += 1;
          } else {
            jobTitleMap[job.jobTitle] = 1;
          }
        });
        print(jobTitleMap);
      });
    }
  }

  Widget _buildList() {
    if(filteredList.length == 0)
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("No relevant jobs found"),
      );
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return JobTile(job: filteredList[index]);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).highlightColor,
        body: SafeArea (
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_left_rounded,
                              size: 32.0,
                            )
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Text(
                          "Search by job skill",
                          style: TextStyle(
                              fontFamily: "BebasNeue",
                              fontSize: 64.0,
                              color: Theme.of(context).primaryColor
                          ),
                        ),
                        Text(
                          "Find out which job titles require a certain skill",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).highlightColor,
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        TextField(
                          onSubmitted: (query) {
                            _filterSearchResults(query);
                          },
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Enter a job skill (e.g. javascript, frontend, etc.)",
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                            filled: true,
                            fillColor: Theme.of(context).highlightColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                              ),
                              borderRadius:  BorderRadius.circular(30),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).highlightColor,
                              ),
                              borderRadius:  BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 190,
                  height: 16.0,
                ),
                Text(
                  "List of relevant jobs:",
                  style: TextStyle(
                      fontFamily: "BebasNeue",
                      fontSize: 32.0,
                      color: Theme.of(context).primaryColor
                  ),
                ),
                _buildList(),
              ],
            ),
          ),
        )
    );
  }
}
