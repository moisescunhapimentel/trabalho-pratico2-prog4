import 'package:flutter/material.dart';
import 'package:trabalho2/widgets/visible_text_widget.dart';

class MapEntryViewWidget extends StatelessWidget {
  final MapEntry<String, String?> mapEntry;

  const MapEntryViewWidget({super.key, required this.mapEntry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: VisibleWidget(
        visible: mapEntry.value != null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${mapEntry.key}:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(mapEntry.value ?? ''),
          ],
        ),
      ),
    );
  }
}
