import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/constants/routes.dart';
import 'package:rick_and_morty/domain/entities/character.dart';
import 'package:rick_and_morty/presentation/blocs/all_characters_bloc/all_characters_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/favorite_character_status_bloc/favorite_character_status_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/get_character_by_id_bloc/get_character_by_id_bloc.dart';
import 'package:rick_and_morty/presentation/pages/detail_page.dart';
import 'package:rick_and_morty/presentation/pages/favorite_page.dart';
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
        BlocProvider<GetCharacterByIdBloc>(
          create: (_) => di.locator<GetCharacterByIdBloc>(),
        ),
        BlocProvider<FavoriteCharacterStatusBloc>(
          create: (_) => di.locator<FavoriteCharacterStatusBloc>(),
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
        home: const HomePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case Routes.homePage:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case Routes.favoritePage:
              return MaterialPageRoute(builder: (_) => const FavoritePage());
            case Routes.detailPage:
              final int id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => DetailPage(
                  id: id,
                ),
                settings: settings,
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
