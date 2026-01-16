import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/export_blocs.dart';
import 'core/app_router.dart';
import 'core/network/export_api.dart';
import 'repository/export_repository.dart';
import 'views/export_pages.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// EmirGPT Chat
        BlocProvider(create: (_) => ChatCubit(ChatRepository(ApiClient()))),

        /// Resume Matcher
        BlocProvider(
          create: (_) =>
              ResumeMatcherCubit(ResumeMatcherRepository(ResumeMatcherApi())),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        // initialRoute: '/',
        routerConfig: router,
      ),
    );
  }
}
