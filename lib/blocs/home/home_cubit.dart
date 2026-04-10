import 'package:emirgpt/blocs/export_blocs.dart';

class HomeMainCubit extends Cubit<HomeMainState> {
  HomeMainCubit() : super(const HomeInitial());

  void changeIndex(int index) {
    emit(HomeChangeState(index, state.showBottomNav));
  }

  void toggleBottomNav(bool show) {
    emit(HomeChangeState(state.currentIndex, show));
  }
}
