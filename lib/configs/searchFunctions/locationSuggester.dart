import 'package:uber_clone/configs/locationRequests/requestAssistant.dart';
import 'package:uber_clone/models/placePredictions.dart';

class LocationSuggester {
  static Future<List<PlacePredictions>> locationSuggester(String placeName) async {
    List<PlacePredictions> _list=[];
    if (placeName.length > 1) {
      String _autoCompleteUrl =
          "https://api.opencagedata.com/geocode/v1/json?q=$placeName&key=fde6f1133f604872844f2d8856dbbf62&countrycode=IN";
      var _response = await RequestAssistant.getRequest(_autoCompleteUrl);
      if (_response == "Failed") return _list;
      if (_response["status"]["message"] == "OK") {
        var _predictions = _response["results"];
        var _placesList = (_predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();
        _list=_placesList;
      }
    }
    return _list;
  }
}
