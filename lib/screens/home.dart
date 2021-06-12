import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:peek/models/job_model.dart';
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

  @override
  Widget build(BuildContext context) {
    jobsList.clear();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Query(
            options: QueryOptions(
              document: gql(query),
              fetchPolicy: FetchPolicy.networkOnly,
            ),
            builder: (QueryResult result, { refetch, fetchMore }) {
              if(result.hasException)
                return Center(child: Text(result.exception.toString()));

              if(result.isLoading)
                return Center(
                  child: SpinKitFadingFour(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor
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

                //TODO check if this works
                if(!jobsList.contains(newJob)) jobsList.add(newJob);
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text("Search by job title"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchByJobTitle()));
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextButton(
                      child: Text("Search by job skill"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchByJobSkill()));
                      },
                    ),
                  ],
                ),
              );
            },
          )
        ),
      ),
    );
  }
}

