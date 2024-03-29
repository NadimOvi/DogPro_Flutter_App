import 'package:dog_breed/Map/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyBMHTFgIc-_X9A3EuFi7CJEiR8YUNJ08bo';
  static String place = 'atm';
  Future<List<Place>> getPlaces(double lat, double lng) async {
    var response = await http.get(
        Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=$place&rankby=distance&key=$key'));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
