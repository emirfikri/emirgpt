abstract class ResumeMatcherState {}

class ResumeMatcherInitial extends ResumeMatcherState {}

class ResumeMatcherLoading extends ResumeMatcherState {}

class ResumeMatcherSuccess extends ResumeMatcherState {
  final String result;

  ResumeMatcherSuccess(this.result);
}

class ResumeMatcherError extends ResumeMatcherState {
  final String message;

  ResumeMatcherError(this.message);
}
