import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peek/models/job_model.dart';

class JobTile extends StatelessWidget {
  final Job job;

  const JobTile({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Company website: ${job.companyWebsite}"),
            Text(job.jobTitle),
            Text("Apply at: ${job.applyUrl}"),
            Text("Skills: ${job.tags.toString()}"),
          ],
        ),
      )
    );
  }
}
