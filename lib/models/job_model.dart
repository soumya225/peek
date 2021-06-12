class Job {
  String jobTitle;
  String companyWebsite;
  String applyUrl;
  List<String> tags;

  Job({required this.jobTitle,
    required this.companyWebsite,
    required this.applyUrl,
    required this.tags});

  /*
  @override
  bool operator ==(Object other) {
    return (other is Job
        && this.jobTitle == other.jobTitle
        && this.applyUrl == other.applyUrl
        && this.tags == other.tags
        && this.companyWebsite == other.companyWebsite
    );
  }

  @override
  int get hashCode => hash4(companyWebsite, jobTitle, applyUrl, tags); //import quiver to use hash4
  */
}