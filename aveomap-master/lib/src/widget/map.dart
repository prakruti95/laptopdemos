import 'dart:io';

import 'package:aveomap/aveomap.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart' as map_launch;

class MapView extends StatelessWidget {
  const MapView({
    Key? key,
    required this.widget,
    required this.initailCameraPosition,
  }) : super(key: key);

  final AveoMap widget;
  final CameraPosition initailCameraPosition;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      builder: (controller) {
        return Stack(
          children: [
            GoogleMap(
              polylines: widget.polylines ?? {},
              polygons: widget.polygon ?? {},
              mapToolbarEnabled: widget.mapToolbarEnable,
              mapType: widget.mapType,
              onTap: (argument) {
                controller.markerTapped.value = false;
                controller.customInfoWindowController.hideInfoWindow!();
              },
              onMapCreated: (googleController) {
                controller.customInfoWindowController.googleMapController =
                    googleController;
                widget.onMapCreated?.call(googleController);
              },
              onCameraMove: (position) {
                controller.customInfoWindowController.onCameraMove!();
                widget.onCameraMoved?.call(position);
              },
              onCameraIdle: () => widget.onCameraIdle?.call(),
              myLocationEnabled: widget.myLocationEnabled,
              markers: controller.markers,
              myLocationButtonEnabled: widget.myLocationButtonEnabled,
              initialCameraPosition: initailCameraPosition,
              circles: widget.circles ?? {},
            ),
            Obx(
              () => Visibility(
                visible: controller.markerTapped.value &&
                    !kIsWeb &&
                    Platform.isIOS &&
                    widget.mapToolbarEnable,
                child: Positioned(
                  bottom: 20,
                  right: 80,
                  child: GestureDetector(
                    onTap: () {
                      map_launch.MapLauncher.showDirections(
                        mapType: map_launch.MapType.apple,
                        destination: map_launch.Coords(
                            controller.markerPosition.value.latitude,
                            controller.markerPosition.value.longitude),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 38,
                          width: 38,
                          color: Colors.white70,
                          child: const Icon(
                            Icons.directions,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 1,
                          // child: Con,
                        ),
                        Container(
                          height: 38,
                          width: 38,
                          color: Colors.white70,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Image.asset(
                            'assets/apple_map.png',
                            package: 'aveomap',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            CustomInfoWindow(
              controller: controller.customInfoWindowController,
              height: widget.infoWindowHieght ?? 82,
              width: widget.infoWindowwidth ?? 300,
              offset: 50,
            )
          ],
        );
      },
    );
  }
}
