import 'package:flutter/material.dart';
import 'package:trabalho2/providers/dog_provider.dart';
import 'package:provider/provider.dart';
import 'package:trabalho2/screens/dog_view_screen.dart';
import 'package:trabalho2/widgets/image_network_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CuteDogs'),
      ),
      body: FutureBuilder(
        future: context.read<DogProvider>().loadMoreDogsIfEmpty(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar imagens'),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.hasError) {
              return Center(
                child: Text(snapshot.data!.error!),
              );
            }

            return Consumer<DogProvider>(
              builder: (_, dogProvider, child) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  itemCount: dogProvider.dogs.length,
                  itemBuilder: (context, index) {
                    final dogImageUrl = dogProvider.dogs[index].dogImage?.url;

                    dogProvider.loadMoreDogsIfLimitReached(index);

                    return GridTile(
                      child: GestureDetector(
                        onTap: () {
                          dogProvider.selectDog(index: index);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DogViewScreen(),
                              ));
                        },
                        child: Container(
                            child: dogImageUrl == null
                                ? const Center(
                                    child: Icon(Icons.pets,
                                        size: 50, color: Colors.blue),
                                  )
                                : ImageNetworkWidget(url: dogImageUrl)),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
