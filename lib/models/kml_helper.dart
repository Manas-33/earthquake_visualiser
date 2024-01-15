import 'package:earthquake_visualiser/models/flyto.dart';
import 'package:xml/xml.dart';

class KmlHelper {
  FlyToView getFlyToDetails(String kmlString) {
    var document = XmlDocument.parse(kmlString);

    var lookAtElement = document.findAllElements('LookAt').first;
    var longitude =
        double.parse(lookAtElement.findElements('longitude').first.text);
    var latitude =
        double.parse(lookAtElement.findElements('latitude').first.text);
    var heading =
        double.parse(lookAtElement.findElements('heading').first.text);
    var tilt = double.parse(lookAtElement.findElements('tilt').first.text);
    var range = double.parse(lookAtElement.findElements('range').first.text);

    print('Longitude: $longitude');
    print('Latitude: $latitude');
    print('Heading: $heading');
    print('Tilt: $tilt');
    print('Range: $range');

    return FlyToView(
        longitude: longitude,
        latitude: latitude,
        range: range,
        tilt: tilt,
        heading: heading);
  }
}
