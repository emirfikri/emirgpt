abstract class HomeMainState {
  final int currentIndex;
  const HomeMainState(this.currentIndex);
}

class HomeInitial extends HomeMainState {
  const HomeInitial() : super(0);
}

class HomeChangeState extends HomeMainState {
  const HomeChangeState(int currentIndex) : super(currentIndex);
}

class HomeLoading extends HomeMainState {
  const HomeLoading(int currentIndex) : super(currentIndex);
}
