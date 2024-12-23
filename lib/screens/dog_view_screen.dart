import 'package:flutter/material.dart';
import 'package:trabalho2/providers/dog_provider.dart';
import 'package:provider/provider.dart';
import 'package:trabalho2/widgets/breed_view_widget.dart';
import 'package:trabalho2/widgets/image_network_widget.dart';

class DogViewScreen extends StatelessWidget {
  const DogViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Consumer<DogProvider>(
              builder: (context, dogProvider, child) {
                if (dogProvider.currentDog == null) {
                  return const Center(
                    child: Text('Nenhum pet foi selecionado'),
                  );
                }

                return FutureBuilder(
                  future: dogProvider.loadBreedsInCurrentDogIfNotExists(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            'Erro ao carregar imagem e as informações do pet'),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.hasError) {
                        return Center(
                          child: Text(snapshot.data!.error!),
                        );
                      } else {
                        return ImageNetworkWidget(
                            url: dogProvider.currentDog?.dogImage?.url ?? '');
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              },
            ),
            Consumer<DogProvider>(
              builder: (context, dogProvider, child) {
                if (dogProvider.currentDog != null &&
                    (dogProvider.currentDog!.breeds?.isEmpty ?? false)) {
                  return Center(
                    child: Text(
                      'Não há informações sobre o pet no banco de dados.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: dogProvider.currentDog?.breeds?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(children: [
                        MapEntryViewWidget(
                          mapEntry: MapEntry('Nome',
                              dogProvider.currentDog?.breeds?[index].name),
                        ),
                        MapEntryViewWidget(
                          mapEntry: MapEntry(
                              'Temperamento',
                              dogProvider
                                  .currentDog?.breeds?[index].temperament),
                        ),
                        MapEntryViewWidget(
                          mapEntry: MapEntry('Origem',
                              dogProvider.currentDog?.breeds?[index].origin),
                        ),
                        MapEntryViewWidget(
                          mapEntry: MapEntry('Espectativa de vida',
                              dogProvider.currentDog?.breeds?[index].lifeSpan),
                        ),
                        MapEntryViewWidget(
                          mapEntry: MapEntry(
                              'Wikipedia Url',
                              dogProvider
                                  .currentDog?.breeds?[index].wikipediaUrl),
                        ),
                      ]),
                    );
                  },
                );
              },
            ),
          ]
              .map(
                (e) => Flexible(child: e),
              )
              .toList(),
        ),
      ),
    );
  }
}
