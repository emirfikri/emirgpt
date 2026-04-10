import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../blocs/export_blocs.dart';

class HomeMainPage extends StatefulWidget {
  final Widget child;

  const HomeMainPage({super.key, required this.child});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final direction = _scrollController.position.userScrollDirection;
    final currentState = context.read<HomeMainCubit>().state;

    if (direction == ScrollDirection.reverse && currentState.showBottomNav) {
      context.read<HomeMainCubit>().toggleBottomNav(false);
    } else if (direction == ScrollDirection.forward &&
        !currentState.showBottomNav) {
      context.read<HomeMainCubit>().toggleBottomNav(true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToTab(BuildContext context, int index) {
    context.read<HomeMainCubit>().toggleBottomNav(true);
    context.read<HomeMainCubit>().changeIndex(index);

    switch (index) {
      case 0:
        context.go('/home/chat');
        break;
      case 1:
        context.go('/home/bookings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BlocBuilder<HomeMainCubit, HomeMainState>(
        builder: (context, state) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: state.showBottomNav ? kBottomNavigationBarHeight : 0,
            child: Wrap(
              children: [
                SizedBox(
                  height: state.showBottomNav ? kBottomNavigationBarHeight : 0,
                  child: BottomNavigationBar(
                    currentIndex: state.currentIndex,
                    onTap: (index) => _navigateToTab(context, index),
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.chat_bubble_outline),
                        label: 'Chat',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.list_alt),
                        label: 'Bookings',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
