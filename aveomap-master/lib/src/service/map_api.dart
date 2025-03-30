part of '../../aveomap.dart';

class MapApi {
  static String apiKey = '';
  static const String STATUS_OK = "ok";

  static Future<List<Suggestion>> fetchSuggestions(
    String input,
    String lang,
    String sessionToken,
  ) async {
    // components=country:ch& :https://developers.google.com/maps/documentation/places/web-service/autocomplete#components
    //lang : https://developers.google.com/maps/faq#languagesupport
    // type: https://developers.google.com/maps/documentation/places/web-service/supported_types
    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&key=$apiKey&sessiontoken=$sessionToken');
    final response = await Client().get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        List<Suggestion> data = [];
        (result['predictions'] as List).forEach((element) {
          data.add(Suggestion.fromJson(element));
        });
        return data;
      } else if (result['status'] == 'ZERO_RESULTS') {
        return [];
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  static Future<void> getPlaceDetailFromId(
      String placeId, String sessionToken) async {
    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken');
    final response = await Client().get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        // build result
        // final place = Place();
        // components.forEach((c) {
        //   final List type = c['types'];
        //   if (type.contains('street_number')) {
        //     place.streetNumber = c['long_name'];
        //   }
        //   if (type.contains('route')) {
        //     place.street = c['long_name'];
        //   }
        //   if (type.contains('locality')) {
        //     place.city = c['long_name'];
        //   }
        //   if (type.contains('postal_code')) {
        //     place.zipCode = c['long_name'];
        //   }
        // });
        // return place;
      }
      // throw Exception(result['error_message']);
    } else {
      // throw Exception('Failed to fetch suggestion');
    }
  }

  static Future<Place?> getPlace(String placeId, String sessionToken) async {
    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey&sessiontoken=$sessionToken');
    final response = await Client().get(request);
    if (response.statusCode == 200) {
      Place place = Place.fromJson(json.decode(response.body));
      return place;
    }
  }

  static List<AveoMarker> markersInArialRadius(
      {LatLng? center,
      required double radius,
      required List<AveoMarker> markers}) {
    List<AveoMarker> allowed = [];
    for (AveoMarker coodinate in markers) {
      double distance = Geolocator.distanceBetween(
          center!.latitude,
          center.longitude,
          coodinate.position.latitude,
          coodinate.position.longitude);
      if (distance <= radius) {
        allowed.add(coodinate);
      }
    }
    return allowed;
  }

  // static Future<List<AveoMarker>> markersInOnRoadRadius(
  //     {required LatLng center,
  //     required List<AveoMarker> markers,
  //     required double radius,
  //     TravelMode travelMode = TravelMode.driving,
  //     List<PolylineWayPoint> wayPoints = const [],
  //     bool avoidHighways = false,
  //     bool avoidTolls = false,
  //     bool avoidFerries = false,
  //     bool optimizeWaypoints = false}) async {
  //  Future<List<PolylineResult>> result = Future.wait<PolylineResult>(
  //     markers.map((e) => getRouteBetweenCoordinates(center, LatLng(e.position.latitude, e.position.longitude), travelMode, wayPoints, avoidHighways, avoidTolls, avoidFerries, optimizeWaypoints)).toList()
  //   );

  // }

  static Future<PolylineResult> getRouteBetweenCoordinates(
      {required LatLng origin,
      required LatLng destination,
      TravelMode travelMode = TravelMode.driving,
      List<PolylineWayPoint> wayPoints = const [],
      bool avoidHighways = false,
      bool avoidTolls = false,
      bool avoidFerries = false,
      bool optimizeWaypoints = false}) async {
    PolylineResult result = PolylineResult();
    var params = {
      "origin": "${origin.latitude},${origin.longitude}",
      "destination": "${destination.latitude},${destination.longitude}",
      "mode": travelMode.name,
      "avoidHighways": "$avoidHighways",
      "avoidFerries": "$avoidFerries",
      "avoidTolls": "$avoidTolls",
      "key": apiKey,
    };
    if (wayPoints.isNotEmpty) {
      List wayPointsArray = [];
      wayPoints.forEach((point) => wayPointsArray.add(point.location));
      String wayPointsString = wayPointsArray.join('|');
      if (optimizeWaypoints) {
        wayPointsString = 'optimize:true|$wayPointsString';
      }
      params.addAll({"waypoints": wayPointsString});
    }
    Uri uri =
        Uri.https("maps.googleapis.com", "maps/api/directions/json", params);

    // print('GOOGLE MAPS URL: ' + url);
    var response = await Client().get(uri);
    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      result.status = parsedJson["status"];
      if (parsedJson["status"]?.toLowerCase() == STATUS_OK &&
          parsedJson["routes"] != null &&
          parsedJson["routes"].isNotEmpty) {
        result.points = decodeEncodedPolyline(
            parsedJson["routes"][0]["overview_polyline"]["points"]);
      } else {
        result.errorMessage = parsedJson["error_message"];
      }
    }
    return result;
  }

  ///decode the google encoded string using Encoded Polyline Algorithm Format
  /// for more info about the algorithm check https://developers.google.com/maps/documentation/utilities/polylinealgorithm
  ///
  ///return [List]
  static List<LatLng> decodeEncodedPolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      LatLng p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }
}

class LocationBias {
  const LocationBias();
}

class MapCircle extends LocationBias {
  final LatLng latLng;
  final int radius;
  final bool strictBounds;

  const MapCircle(
      {required this.latLng, required this.radius, this.strictBounds = false})
      : super();

  @override
  String toString() {
    return '&location=${latLng.latitude}%2C${latLng.longitude}&radius=$radius&strictbounds=$strictBounds';
  }
}

class MapRectangle extends LocationBias {
  final LatLng southWest;
  final LatLng northEast;

  const MapRectangle({required this.southWest, required this.northEast})
      : super();

  @override
  String toString() {
    return '';
  }
}

enum TravelMode { driving, bicycling, transit, walking }

class PolylineWayPoint {
  /// the location of the waypoint,
  /// You can specify waypoints using the following values:
  /// --- Latitude/longitude coordinates (lat/lng): an explicit value pair. (-34.92788%2C138.60008 comma, no space),
  /// --- Place ID: The unique value specific to a location. This value is only available only if
  ///     the request includes an API key or Google Maps Platform Premium Plan client ID (ChIJGwVKWe5w44kRcr4b9E25-Go
  /// --- Address string (Charlestown, Boston,MA)
  /// ---
  String location;

  /// is a boolean which indicates that the waypoint is a stop on the route,
  /// which has the effect of splitting the route into two routes
  bool stopOver;

  PolylineWayPoint({required this.location, this.stopOver = true});

  @override
  String toString() {
    if (stopOver) {
      return location;
    } else {
      return "via:$location";
    }
  }
}

class PolylineResult {
  /// the api status retuned from google api
  ///
  /// returns OK if the api call is successful
  String? status;

  /// list of decoded points
  List<LatLng> points;

  /// the error message returned from google, if none, the result will be empty
  String? errorMessage;

  PolylineResult({this.status, this.points = const [], this.errorMessage = ""});
}
