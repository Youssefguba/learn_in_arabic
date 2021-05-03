import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_in_arabic/shared/network/youtube.dart';

import 'home/home.dart';
import 'splash/splash.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    YoutubeRepository _youtubeRepository = YoutubeRepository();

    return MultiBlocProvider(
      providers: [
        /// Youtube Blocs
        BlocProvider(create: (_) => ProgrammingContentBloc(_youtubeRepository)),
        BlocProvider(create: (_) => MediaContentBloc(_youtubeRepository)),
        BlocProvider(create: (_) => BusinessContentBloc(_youtubeRepository)),
      ],
      child: MaterialApp(
        title: 'Learn In Arabic',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
