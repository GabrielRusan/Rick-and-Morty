import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/all_characters_bloc/all_characters_bloc.dart';
import 'package:rick_and_morty/presentation/pages/home_page.dart';
import 'package:rick_and_morty/styles/colors.dart';
import 'package:rick_and_morty/styles/text_styles.dart';
import 'package:rick_and_morty/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllCharactersBloc>(
          create: (_) => di.locator<AllCharactersBloc>(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            colorScheme: kColorScheme,
            primaryColor: kRichBlack,
            scaffoldBackgroundColor: kRichBlack,
            textTheme: kTextTheme,
          ),
          home: const HomePage()),
    );
  }
}
