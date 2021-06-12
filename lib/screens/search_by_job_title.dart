import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:peek/models/job_model.dart';
import 'package:peek/screens/home.dart';
import 'package:peek/screens/tile.dart';

class SearchByJobTitle extends StatefulWidget {
  const SearchByJobTitle({Key? key}) : super(key: key);

  @override
  _SearchByJobTitleState createState() => _SearchByJobTitleState();
}

class _SearchByJobTitleState extends State<SearchByJobTitle> {
  TextEditingController _textEditingController = TextEditingController();

  final List<Job> filteredList = [];
  HashMap tagsMap = HashMap();

  @override
  void initState() {
    filteredList.addAll(jobsList);
    super.initState();
  }

  void _filterSearchResults (String query) {
    query = query.toLowerCase();

    List<Job> results = [];

    tagsMap.clear();

    if (query.isNotEmpty) {
      jobsList.forEach((job) {
        if (job.jobTitle.toLowerCase().contains(query)) {
          results.add(job);
          for(String tag in job.tags) {
            if(tagsMap.containsKey(tag)) {
              tagsMap[tag] += 1;
            } else {
              tagsMap[tag] = 1;
            }
          }
        }
      });
      setState(() {
        print(tagsMap);
        filteredList.clear();
        filteredList.addAll(results);
      });
    } else {
      setState(() {
        filteredList.clear();
        jobsList.forEach((job) {
          filteredList.add(job);
          for(String tag in job.tags) {
            if(tagsMap.containsKey(tag)) {
              tagsMap[tag] += 1;
            } else {
              tagsMap[tag] = 1;
            }
          }
        });
        print(tagsMap);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea (
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (query) {
                      _filterSearchResults(query);
                    },
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        labelText: "Search by job title",
                        hintText: "Enter a job title",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(

                        )
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return JobTile(job: filteredList[index]);
                    }
                ),
              ],
            ),
          ),
        )
    );
  }
}
