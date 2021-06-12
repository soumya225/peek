import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:peek/models/job_model.dart';
import 'package:peek/screens/home.dart';
import 'package:peek/screens/tile.dart';
import 'package:pie_chart/pie_chart.dart';

class SearchByJobTitle extends StatefulWidget {
  const SearchByJobTitle({Key? key}) : super(key: key);

  @override
  _SearchByJobTitleState createState() => _SearchByJobTitleState();
}

class _SearchByJobTitleState extends State<SearchByJobTitle> {
  TextEditingController _textEditingController = TextEditingController();

  final List<Job> filteredList = [];
  Map<String, double> tagsMap = HashMap();

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
              tagsMap[tag] = 1 + tagsMap[tag]!;
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
              tagsMap[tag] = 1 + tagsMap[tag]!;
            } else {
              tagsMap[tag] = 1;
            }
          }
        });
        print(tagsMap);
      });
    }
  }

  Widget _buildPieChart() {
    if(tagsMap.isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
        height: 600,
        child: PieChart(
          dataMap: tagsMap,
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: true,
          ),
        ),
      ),
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
                        Text(
                          "Search by job title",
                          style: TextStyle(
                            fontFamily: "BebasNeue",
                            fontSize: 64.0,
                            color: Theme.of(context).primaryColor
                          ),
                        ),
                        Text(
                          "Find out which skills are currently in demand for a certain job title",
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
                              hintText: "Enter a job title",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius:  BorderRadius.circular(30),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildPieChart(),
                SizedBox(
                  width: 190,
                  height: 16.0,
                  child: Divider(
                    height: 1,
                  ),
                ),
                Text(
                  "List of jobs:",
                  style: TextStyle(
                      fontFamily: "BebasNeue",
                      fontSize: 32.0,
                      color: Theme.of(context).primaryColor
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.all(8.0),
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
