import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:peek/models/job_model.dart';
import 'package:peek/screens/parallax_element.dart';
import 'package:peek/screens/search_by_job_skill.dart';
import 'package:peek/screens/search_by_job_title.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final List<Job> jobsList = [];


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double rateTwo = 0;
  double rateThree = 0;
  double rateFour = 0;
  double rateFive = 0;
  double rateSix = 0;
  double rateSeven = 0;

  double? top;

  String query = """
    query GetJobs {
    jobs {
      title
      company {
        websiteUrl
      }
      applyUrl
      tags {
        name
      }
    }
  }
  """;

  Widget _buildQuery(){
    double _screenWidth = MediaQuery.of(context).size.width;

    final _buttonStyle = ElevatedButton.styleFrom(
      onPrimary: Theme.of(context).cardColor,
      primary: Theme.of(context).highlightColor,
      minimumSize: Size(
          _screenWidth/2,_screenWidth/20
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      textStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
      )
    );

    return Query(
      options: QueryOptions(
        document: gql(query),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
      builder: (QueryResult result, { refetch, fetchMore }) {
        if(result.hasException)
          return Center(child: Text(result.exception.toString()));

        if(result.isLoading)
          return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SpinKitFadingFour(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor
                ),
              )
          );

        if(result.data == null) return Center(child: Text("No data found"));

        List jobs = result.data!['jobs'];

        for(var job in jobs) {
          final tags = job["tags"];
          List<String> tagsList = [];

          for(var tag in tags) {
            tagsList.add(tag["name"].toString().toLowerCase());
          }

          Job newJob = Job(
            jobTitle: job["title"],
            tags: tagsList,
            companyWebsite: job["company"]["websiteUrl"],
            applyUrl: job["applyUrl"],
          );

          if(!jobsList.contains(newJob)) jobsList.add(newJob);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0,),
            ElevatedButton(
              child: Text(
                "Search by job title",
                style: TextStyle(
                  fontSize: _screenWidth/50
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchByJobTitle()));
              },
              style: _buttonStyle,
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
              child: Text(
                "Search by job skill",
                style: TextStyle(
                    fontSize: _screenWidth/50
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchByJobSkill()));
              },
              style: _buttonStyle,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    jobsList.clear();

    return Scaffold(
      body: NotificationListener(
        onNotification: (v) {
          if (v is ScrollUpdateNotification) {
            setState(() {
              rateSeven -= v.scrollDelta! / 1.5;
              rateSix -= v.scrollDelta! / 1.5;
              rateFive -= v.scrollDelta! / 2.5;
              rateFour -= v.scrollDelta! / 3.5;
              rateThree -= v.scrollDelta! / 4.5;
              rateTwo -= v.scrollDelta! / 5.5;
            });
          } return true;
        },
        child: Stack(
          children: [
            Container(
              color: Theme.of(context).backgroundColor,
            ),

            ParallaxElement(top: rateTwo, image: "2"),
            ParallaxElement(top: rateThree, image: "5"),
            ParallaxElement(top: rateFour, image: "3"),
            ParallaxElement(top: rateFive, image: "4"),
            ParallaxElement(top: rateSix, image: "6"),
            ParallaxElement(top: rateSeven, image: "7"),

            ListView(
              children: <Widget>[
                Container(
                  height: _screenWidth/1.5,
                  color: Colors.transparent,
                ),
                Container(
                  color: Color(0xff94A1C8),
                  width: double.infinity,
                  padding: EdgeInsets.all(64.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "images/logo.png",
                        width: _screenWidth/5,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "An Aspiring Dev's Companion",
                        style: TextStyle(
                          fontFamily: "BebasNeue",
                          fontSize: _screenWidth/10,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        "Get valuable insight into the current developer job market.",
                        style: TextStyle(
                          fontSize: _screenWidth/35,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                      _buildQuery(),
                      Container(
                        height: 300,
                        color: Colors.transparent,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

