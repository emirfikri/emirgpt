import 'export_pages.dart';
import 'package:flutter/material.dart';

import '../blocs/export_blocs.dart';

class HomeMainPage extends StatelessWidget {
  const HomeMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeMainCubit(),
      child: BlocBuilder<HomeMainCubit, HomeMainState>(
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(state.currentIndex),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                context.read<HomeMainCubit>().changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const BookingPage();
      case 1:
        return const BookingListPage();
      default:
        return const BookingPage();
    }
  }
}
