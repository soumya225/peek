import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peek/models/job_model.dart';

class JobTile extends StatelessWidget {
  final Job job;

  const JobTile({Key? key, required this.job}) : super(key: key);

  //TODO: make links clickable

  @override
  Widget build(BuildContext context) {
    String tags = job.tags.toString();

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.0,),
            Text(
              "Company website: ${job.companyWebsite}",
              style: TextStyle(
                color: Theme.of(context).highlightColor
              ),
            ),
            SizedBox(height: 4.0,),
            Text(
              "Apply at: ${job.applyUrl}",
              style: TextStyle(
                  color: Theme.of(context).highlightColor
              ),
            ),
            SizedBox(height: 4.0,),
            Text(
              job.jobTitle.toUpperCase(),
              style: TextStyle(
                fontFamily: "BebasNeue",
                fontSize: 24.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 4.0,),
            Text(
              "Skills: ${tags.substring(1,tags.length-1)}",
              style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.0,),
          ],
        ),
      )
    );
  }
}
