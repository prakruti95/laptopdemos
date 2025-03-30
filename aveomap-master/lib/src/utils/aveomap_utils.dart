part of '../../aveomap.dart';

class AveoMapUtils {
  Future<Uint8List> getBytesFromAsset(String path,BuildContext context) async {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: pixelRatio.round() * 30
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  /// This Function [checkIfValidMarker] works for check the touchEvent you clicked on map that is exist on polygons or not
  ///
  /// This function will be called onTap of GoogleMap and will return True/False.

  bool checkIfValidMarker(LatLng tap, List<LatLng> vertices) {
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (_rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }

    ///  odd = inside, even = outside;
    return ((intersectCount % 2) == 1);
  }

  bool _rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      /// a and b can't both be above or below pt.y, and a or
      return false;
      /// b must be east of pt.x
    }

    /// Rise over run
    double m = (aY - bY) / (aX - bX);
    /// y = mx + b
    double bee = (-aX) * m + aY;
    /// algebra is neat!
    double x = (pY - bee) / m;

    return x > pX;
  }
}
