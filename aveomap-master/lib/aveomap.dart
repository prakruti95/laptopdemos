library aveomap;

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:aveomap/src/widget/map.dart';
import 'package:http/http.dart';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'dart:ui' as ui;

import 'package:google_maps_flutter/google_maps_flutter.dart';
export 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:map_launcher/map_launcher.dart' as map_launch;

part 'src/widget/aveomap_widget.dart';
part 'src/controller/map_controller.dart';
part 'src/model/marker_model.dart';
part 'src/model/position.dart';
part 'src/model/suggestions.dart';
part 'src/model/place.dart';
part 'src/repository/repo.dart';
part 'src/widget/triangle_clipper.dart';
part 'src/utils/aveomap_utils.dart';
part 'src/utils/session_uuid.dart';
part 'src/service/map_api.dart';
