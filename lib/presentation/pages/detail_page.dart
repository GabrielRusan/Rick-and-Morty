import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/favorite_character_status_bloc/favorite_character_status_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/get_character_by_id_bloc/get_character_by_id_bloc.dart';
import 'package:rick_and_morty/styles/colors.dart';
import 'package:rick_and_morty/styles/text_styles.dart';

class DetailPage extends StatefulWidget {
  final int id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    context.read<GetCharacterByIdBloc>().add(FetchCharacterById(id: widget.id));
    context
        .read<FavoriteCharacterStatusBloc>()
        .add(LoadFavoriteStatus(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ScaffoldMessenger(
        child: Scaffold(
      body: BlocListener<FavoriteCharacterStatusBloc,
          FavoriteCharacterStatusState>(
        listener: (context, state) {
          if (state is SuccessAddCharacter) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is FailAddCharacter) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.message),
                  );
                });
          } else if (state is SuccessRemoveCharacter) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is FailRemoveCharacter) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.message),
                  );
                });
          }
        },
        child: BlocBuilder<GetCharacterByIdBloc, GetCharacterByIdState>(
          builder: (context, state) {
            if (state is GetCharacterByIdLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetCharacterByIdError) {
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
                              .read<GetCharacterByIdBloc>()
                              .add(FetchCharacterById(id: widget.id));
                        },
                        child: const Text('Coba lagi'),
                      ),
                    )
                  ],
                ),
              );
            } else if (state is GetCharacterByIdLoaded) {
              return SafeArea(
                  child: Stack(
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: state.character.image,
                    width: screenWidth,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 48 + 8),
                    child: DraggableScrollableSheet(
                      builder: (context, scrollController) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: kRichBlack,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 16,
                            right: 16,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.character.name,
                                            style: kHeading5,
                                          ),
                                          BlocBuilder<
                                              FavoriteCharacterStatusBloc,
                                              FavoriteCharacterStatusState>(
                                            buildWhen: (previous, current) =>
                                                current
                                                    is FavoriteCharacterStatusLoaded,
                                            builder: (context, statusState) {
                                              if (statusState
                                                  is FavoriteCharacterStatusLoaded) {
                                                final bool isAddedToFavorite =
                                                    statusState
                                                        .isAddedToFavorite;
                                                return ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 16,
                                                                  left: 8),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          backgroundColor:
                                                              kMikadoYellow,
                                                          foregroundColor:
                                                              Colors.black),
                                                  onPressed: () async {
                                                    if (isAddedToFavorite) {
                                                      context
                                                          .read<
                                                              FavoriteCharacterStatusBloc>()
                                                          .add(RemoveFromFavorite(
                                                              character: state
                                                                  .character));
                                                    } else {
                                                      context
                                                          .read<
                                                              FavoriteCharacterStatusBloc>()
                                                          .add(AddToFavorite(
                                                              character: state
                                                                  .character));
                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      isAddedToFavorite
                                                          ? const Icon(
                                                              Icons.check)
                                                          : const Icon(
                                                              Icons.add),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      const Text('Favorite'),
                                                    ],
                                                  ),
                                                );
                                              }
                                              return const SizedBox();
                                            },
                                          )
                                        ],
                                      ),
                                      // BlocBuilder<MovieWatchlistStatusBloc,
                                      //     MovieWatchlistStatusState>(
                                      //   buildWhen: (previous, current) =>
                                      //       current is MovieWatchlistStatusLoaded,
                                      //   builder: (context, state) {
                                      //     if (state is MovieWatchlistStatusLoaded) {
                                      //       final bool isAddedWatchlist =
                                      //           state.isAddedToWatchlist;
                                      //       return ElevatedButton(
                                      //         onPressed: () async {
                                      //           if (isAddedWatchlist) {
                                      //             context
                                      //                 .read<MovieWatchlistStatusBloc>()
                                      //                 .add(RemoveFromWatchlist(
                                      //                     movie: movieDetail));
                                      //           } else {
                                      //             context
                                      //                 .read<MovieWatchlistStatusBloc>()
                                      //                 .add(AddToWatchlist(
                                      //                     movie: movieDetail));
                                      //           }
                                      //         },
                                      //         child: Row(
                                      //           mainAxisSize: MainAxisSize.min,
                                      //           children: [
                                      //             isAddedWatchlist
                                      //                 ? const Icon(Icons.check)
                                      //                 : const Icon(Icons.add),
                                      //             const Text('Watchlist'),
                                      //           ],
                                      //         ),
                                      //       );
                                      //     } else {
                                      //       return const SizedBox();
                                      //     }
                                      //   },
                                      // ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Species',
                                        style: kHeading6,
                                      ),
                                      Text(
                                        state.character.species ?? '-',
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Gender',
                                        style: kHeading6,
                                      ),
                                      Text(
                                        state.character.gender ?? '-',
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Origin',
                                        style: kHeading6,
                                      ),
                                      Text(
                                        state.character.origin.name,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Location',
                                        style: kHeading6,
                                      ),
                                      Text(
                                        state.character.location != null
                                            ? state.character.location!.name
                                            : '-',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  color: Colors.white,
                                  height: 4,
                                  width: 48,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      initialChildSize: 0.6,
                      minChildSize: 0.5,
                      // maxChildSize: 1.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: kRichBlack,
                      foregroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              ));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    ));
  }
}
