
class Job {
  String jobTitle;
  String companyWebsite;
  String applyUrl;
  List<String> tags;

  Job({required this.jobTitle,
    required this.companyWebsite,
    required this.applyUrl,
    required this.tags});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    return other is Job
        && this.jobTitle == other.jobTitle
        && this.applyUrl == other.applyUrl
        && this.tags == other.tags
        && this.companyWebsite == other.companyWebsite
      ;
  }

  @override
  int get hashCode => jobTitle.hashCode
      + applyUrl.hashCode
      + companyWebsite.hashCode
      + tags.hashCode;

  @override
  String toString() {
    return """
      $companyWebsite,
      $jobTitle,
      $applyUrl,
      ${tags.toString()}
    """;
  }

}