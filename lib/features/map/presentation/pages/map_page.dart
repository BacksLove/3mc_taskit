import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:taks_3mc/core/constants/keys.dart';
import 'package:taks_3mc/core/constants/localized.dart';
import 'package:taks_3mc/core/constants/spacer.dart';
import 'package:taks_3mc/features/map/presentation/bloc/map_bloc.dart';
import 'package:taks_3mc/features/task/presentation/widgets/tasks_carousel.dart';

import 'package:taks_3mc/injection_container.dart' as di;

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    const montrealLocation = LatLng(45.508888, -73.561668);

    final controller = MapController();
    final mapOptions = MapOptions(
      center: montrealLocation,
      zoom: 3,
      enableScrollWheel: true,
    );

    final mapBloc = di.sl<MapBloc>();

    return BlocProvider(
      create: (context) => mapBloc..add(MapLaunchedEvent()),
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(localized(context).yardWork),
            ),
            body: Stack(
              children: [
                FlutterMap(
                  mapController: controller,
                  options: mapOptions,
                  nonRotatedChildren: const [],
                  children: [
                    TileLayer(
                      urlTemplate: mapUrl,
                    ),
                    MarkerLayer(
                      markers: [
                        for (final markerPoint in state.points)
                          Marker(
                            point: markerPoint,
                            width: 50,
                            height: 50,
                            builder: (context) => Center(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.location_pin,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TaskCarousel(tasks: state.tasks),
                      vSpace30,
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
