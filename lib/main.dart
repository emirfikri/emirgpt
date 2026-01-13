import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/export_blocs.dart';
import 'core/network/api_client.dart';
import 'repository/export_repository.dart';
import 'views/export_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => ChatCubit(ChatRepository(ApiClient())),
        child: const ChatPage(),
      ),
    );
  }
}
