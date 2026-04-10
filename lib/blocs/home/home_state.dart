abstract class HomeMainState {
  final int currentIndex;
  final bool showBottomNav;
  const HomeMainState(this.currentIndex, this.showBottomNav);
}

class HomeInitial extends HomeMainState {
  const HomeInitial() : super(0, true);
}

class HomeChangeState extends HomeMainState {
  const HomeChangeState(int currentIndex, bool showBottomNav)
    : super(currentIndex, showBottomNav);
}

class HomeLoading extends HomeMainState {
  const HomeLoading(int currentIndex, bool showBottomNav)
    : super(currentIndex, showBottomNav);
}
