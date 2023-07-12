import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:taks_3mc/core/constants/keys.dart';
import 'package:taks_3mc/core/constants/localized.dart';
import 'package:taks_3mc/core/constants/spacer.dart';
import 'package:taks_3mc/features/home/presentation/bloc/home_bloc.dart';
import 'package:taks_3mc/features/task/presentation/widgets/tasks_carousel.dart';

import 'package:taks_3mc/injection_container.dart' as di;
import 'package:taks_3mc/core/route/routes.dart' as route;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = di.sl<HomeBloc>();

    return BlocProvider(
      create: (context) => homeBloc..add(HomeInitEvent()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      homeBloc.add(HomeInitEvent());
                    },
                    child: ListTile(
                      leading: const Icon(Icons.location_pin),
                      title: Text(state.userLocation.isEmpty
                          ? localized(context).noLocation
                          : state.userLocation),
                    ),
                  ),
                  vSpace15,
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, route.createTaskPage);
                      },
                      child: Text(localized(context).createTask),
                    ),
                  ),
                  vSpace30,
                  SizedBox(
                    height: 100,
                    child: Stack(
                      children: [
                        FlutterMap(
                          options: MapOptions(),
                          children: [
                            TileLayer(
                              urlTemplate: mapUrl,
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, route.mapPage);
                            },
                            child: ListTile(
                              leading: const Icon(Icons.map),
                              title: Text(localized(context).taskAround),
                              trailing: const Icon(Icons.chevron_right),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(localized(context).taskForYou),
                  TaskCarousel(tasks: state.tasks),
                  vSpace30,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
