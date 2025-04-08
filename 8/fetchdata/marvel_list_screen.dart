import 'package:flutter/material.dart';
import 'marvel_character.dart';
import 'api_service.dart';

class MarvelListScreen extends StatelessWidget {
  const MarvelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Marvel Characters")),
      body: FutureBuilder<List<MarvelCharacter>>(
        future: fetchMarvelCharacters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          final characters = snapshot.data!;
          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return ListTile(
                leading: Image.network(character.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                title: Text(character.name),
                subtitle: Text(character.realName),
              );
            },
          );
        },
      ),
    );
  }
}
