class PlacePredictions {
  String? type, road, subUrb, city, postcode,formatted;
  double? latitude=0.0,longitude=0.0;
  PlacePredictions(
      {this.type, this.road, this.subUrb, this.city, this.postcode,this.formatted,this.latitude,this.longitude});
  PlacePredictions.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> jsonComponents = json["components"];
    Map<String, dynamic> jsonBounds = json["bounds"]["northeast"];
    this.type = jsonComponents[jsonComponents["_type"]]!=null?jsonComponents[jsonComponents["_type"]]:" ";
    this.road=jsonComponents["road"]!=null?jsonComponents["road"]:" ";
    this.subUrb=jsonComponents["suburb"]!=null?jsonComponents["suburb"]:" ";
    this.city=jsonComponents["city"]!=null?jsonComponents["city"]:" ";
    this.postcode=jsonComponents["postcode"]!=null?jsonComponents["postcode"]:" ";
    this.formatted=json["formatted"];
    this.latitude=jsonBounds["lat"];
    this.longitude=jsonBounds["lng"];
  }
}
