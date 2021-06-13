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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Breakdown of skills:",
              style: TextStyle(
                  fontFamily: "BebasNeue",
                  fontSize: 32.0,
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),
          Text(
            "This pie chart describes how many relevant jobs (i.e. jobs with the entered keyword in the job title) look for each skill"
          ),
          SizedBox(height: 8.0,),
          Container(
            height: MediaQuery.of(context).size.width < 900 ? null : 600,
            child: PieChart(
              dataMap: tagsMap,
              legendOptions: LegendOptions(
                legendPosition: MediaQuery.of(context).size.width < 900 ? LegendPosition.bottom : LegendPosition.right
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    if(filteredList.length == 0)
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("No relevant jobs found"),
      );
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
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
                _buildPieChart(),
                SizedBox(
                  width: 190,
                  height: 16.0,
                  child: Divider(
                    height: 1,
                  ),
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
