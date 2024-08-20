import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/blocs/search_character_bloc/search_character_bloc.dart';
import 'package:rick_and_morty/presentation/widgets/character_card.dart';
import 'package:rick_and_morty/styles/text_styles.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Characters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context
                    .read<SearchCharacterBloc>()
                    .add(OnQueryChanged(query: query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchCharacterBloc, SearchCharacterState>(
              builder: (context, state) {
                if (state is SearchCharacterLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is SearchCharacterHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = state.result[index];
                        return CharacterCard(movie);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchCharacterEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        'No Character Found!',
                        key: Key('empty'),
                      ),
                    ),
                  );
                } else {
                  return const Expanded(
                    key: Key('initial'),
                    child: SizedBox(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
