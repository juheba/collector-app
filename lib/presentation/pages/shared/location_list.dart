import 'package:collector/models/item_model.dart';
import 'package:collector/models/location_model.dart';
import 'package:collector/presentation/pages/items/item_detail_page.dart';
import 'package:collector/presentation/pages/items/items_page.dart';
import 'package:collector/presentation/pages/location/location_detail_page.dart';
import 'package:collector/presentation/widgets/item_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LocationsListWidget extends StatefulWidget {
  const LocationsListWidget({
    required this.locations,
    required this.isSelectionModeActive,
    super.key,
  });

  final List<LocationModel> locations;
  final bool isSelectionModeActive;

  @override
  State<LocationsListWidget> createState() => _LocationsListWidgetState();
}

class _LocationsListWidgetState extends State<LocationsListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Prevents ListView from expanding infinitely
      itemCount: widget.locations.length,
      itemBuilder: (context, index) {
        final location = widget.locations[index];

        final locationImage = location.attachment?.attachmentUrl != null
            ? Image.network(
                location.attachment!.attachmentUrl!,
                width: 50,
              )
            : null;

        return Card(
          margin: const EdgeInsets.all(8),
          elevation: 5,
          child: ListTile(
            minVerticalPadding: 24,
            onTap: () => context.goNamed(
              LocationDetailPageWidget.routeName,
              pathParameters: {'id': location.id},
            ),
            leading: locationImage,
            title: Text(
              location.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: (location.description != null)
                ? Text(
                    location.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
          ),
        );
      },
    );
  }
}
