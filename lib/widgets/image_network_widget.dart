import 'package:flutter/material.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String url;
  const ImageNetworkWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return _showContainerError();
    }

    return Image.network(
      url,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return _showContainerError();
      },
    );
  }

  _showContainerError() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: const Center(child: Text('Erro ao carregar imagem')),
    );
  }
}
