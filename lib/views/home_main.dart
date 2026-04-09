import 'package:flutter/rendering.dart';

import 'export_pages.dart';
import 'package:flutter/material.dart';

import '../blocs/export_blocs.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({Key? key}) : super(key: key);

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  late ScrollController _scrollController;
  bool _showBottomNav = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final direction = _scrollController.position.userScrollDirection;

    if (direction == ScrollDirection.reverse && _showBottomNav) {
      setState(() => _showBottomNav = false);
    } else if (direction == ScrollDirection.forward && !_showBottomNav) {
      setState(() => _showBottomNav = true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeMainCubit(),
      child: BlocBuilder<HomeMainCubit, HomeMainState>(
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(state.currentIndex),
            bottomNavigationBar: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _showBottomNav ? kBottomNavigationBarHeight : 0,
              child: Wrap(
                children: [
                  SizedBox(
                    height: _showBottomNav ? kBottomNavigationBarHeight : 0,
                    child: BottomNavigationBar(
                      currentIndex: state.currentIndex,
                      onTap: (index) {
                        _showBottomNav = true;
                        context.read<HomeMainCubit>().changeIndex(index);
                      },
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'Home',
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return BookingChatPage(scrollController: _scrollController);
      case 1:
        return BookingListPage(scrollController: _scrollController);
      default:
        return BookingChatPage(scrollController: _scrollController);
    }
  }
}
