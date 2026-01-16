import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/export_repository.dart';
import 'resume_matcher_state.dart';

class ResumeMatcherCubit extends Cubit<ResumeMatcherState> {
  final ResumeMatcherRepository repository;

  ResumeMatcherCubit(this.repository) : super(ResumeMatcherInitial());

  Future<void> matchResume({
    required String resume,
    required String jobDescription,
  }) async {
    emit(ResumeMatcherLoading());

    try {
      final result = await repository.match(
        resume: resume,
        jobDescription: jobDescription,
      );

      emit(ResumeMatcherSuccess(result));
    } catch (e) {
      emit(ResumeMatcherError(e.toString()));
    }
  }
}
