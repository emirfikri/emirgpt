import '../core/network/resume_matcher_api.dart';

class ResumeMatcherRepository {
  final ResumeMatcherApi api;

  ResumeMatcherRepository(this.api);

  Future<String> match({
    required String resume,
    required String jobDescription,
  }) {
    return api.match(resume: resume, jobDescription: jobDescription);
  }
}
