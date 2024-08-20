import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/constants/routes.dart';
import 'package:rick_and_morty/presentation/blocs/all_characters_bloc/all_characters_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    context.read<AllCharactersBloc>().add(FetchAllCharacters());
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<AllCharactersBloc>().add(FetchAllCharacters());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rick and Morty'),
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        body:
            Expanded(child: BlocBuilder<AllCharactersBloc, AllCharactersState>(
          builder: (context, state) {
            if (state.status == AllCharactersStatus.initial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == AllCharactersStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Terjadi Kesalahan!'),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: FloatingActionButton(
                        onPressed: () {
                          context
                              .read<AllCharactersBloc>()
                              .add(FetchAllCharacters());
                        },
                        child: const Text('Coba lagi'),
                      ),
                    )
                  ],
                ),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 215),
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final character = state.characters[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.detailPage,
                        arguments: character.id);
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: character.image,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        character.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        character.origin.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
              itemCount: state.characters.length,
            );
          },
        )));
  }
}
