import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/favorite_characters_bloc/favorite_characters_bloc.dart';
import 'package:rick_and_morty/presentation/widgets/character_card.dart';
import 'package:rick_and_morty/utils/utils.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<FavoriteCharacterBloc>().add(FetchFavoriteCharacters());
  }

  @override
  void initState() {
    context.read<FavoriteCharacterBloc>().add(FetchFavoriteCharacters());
    super.initState();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Characters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<FavoriteCharacterBloc, FavoriteCharacterState>(
          builder: (context, state) {
            if (state is FavoriteCharacterLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FavoriteCharacterHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final character = state.result[index];
                  return CharacterCard(character);
                },
                itemCount: state.result.length,
              );
            } else if (state is FavoriteCharacterEmpty) {
              return const Center(
                child: Text('There Is No Favorite Character Here Yet!'),
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('An Error Occured :('),
              );
            }
          },
        ),
      ),
    );
  }
}
