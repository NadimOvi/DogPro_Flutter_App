class NearByLocationModel {
  List<Null>? htmlAttributions;
  String? nextPageToken;
  List<Results>? results;
  String? status;

  NearByLocationModel(
      {this.htmlAttributions, this.nextPageToken, this.results, this.status});

  NearByLocationModel.fromJson(Map<String, dynamic> json) {
    /*if (json['html_attributions'] != null) {
      htmlAttributions = <Null>[];
      json['html_attributions'].forEach((v) {
        htmlAttributions!.add(new Null.fromJson(v));
      });
    }*/
    nextPageToken = json['next_page_token'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  /*  if (this.htmlAttributions != null) {
      data['html_attributions'] =
          this.htmlAttributions!.map((v) => v.toJson()).toList();
    }*/
    data['next_page_token'] = this.nextPageToken;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Results {
  String? businessStatus;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  bool? permanentlyClosed;
  List<Photos>? photos;
  String? placeId;
  PlusCode? plusCode;
/*  double? rating;*/
  String? reference;
  String? scope;
  List<String>? types;
  int? userRatingsTotal;
  String? vicinity;
  OpeningHours? openingHours;

  Results(
      {this.businessStatus,
        this.geometry,
        this.icon,
        this.iconBackgroundColor,
        this.iconMaskBaseUri,
        this.name,
        this.permanentlyClosed,
        this.photos,
        this.placeId,
        this.plusCode,
        /*this.rating,*/
        this.reference,
        this.scope,
        this.types,
        this.userRatingsTotal,
        this.vicinity,
        this.openingHours});

  Results.fromJson(Map<String, dynamic> json) {
    businessStatus = json['business_status'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    name = json['name'];
    permanentlyClosed = json['permanently_closed'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    plusCode = json['plus_code'] != null
        ? new PlusCode.fromJson(json['plus_code'])
        : null;
    /*rating = json['rating'];*/
    reference = json['reference'];
    scope = json['scope'];
    types = json['types'].cast<String>();
    userRatingsTotal = json['user_ratings_total'];
    vicinity = json['vicinity'];
    openingHours = json['opening_hours'] != null
        ? new OpeningHours.fromJson(json['opening_hours'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_status'] = this.businessStatus;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    data['icon'] = this.icon;
    data['icon_background_color'] = this.iconBackgroundColor;
    data['icon_mask_base_uri'] = this.iconMaskBaseUri;
    data['name'] = this.name;
    data['permanently_closed'] = this.permanentlyClosed;
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['place_id'] = this.placeId;
    if (this.plusCode != null) {
      data['plus_code'] = this.plusCode!.toJson();
    }
    /*data['rating'] = this.rating;*/


    data['reference'] = this.reference;
    data['scope'] = this.scope;
    data['types'] = this.types;
    data['user_ratings_total'] = this.userRatingsTotal;
    data['vicinity'] = this.vicinity;
    if (this.openingHours != null) {
      data['opening_hours'] = this.openingHours!.toJson();
    }
    return data;
  }
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    viewport = json['viewport'] != null
        ? new Viewport.fromJson(json['viewport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.viewport != null) {
      data['viewport'] = this.viewport!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? new Location.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? new Location.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.northeast != null) {
      data['northeast'] = this.northeast!.toJson();
    }
    if (this.southwest != null) {
      data['southwest'] = this.southwest!.toJson();
    }
    return data;
  }
}

class Photos {
  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  Photos({this.height, this.htmlAttributions, this.photoReference, this.width});

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['html_attributions'] = this.htmlAttributions;
    data['photo_reference'] = this.photoReference;
    data['width'] = this.width;
    return data;
  }
}

class PlusCode {
  String? compoundCode;
  String? globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compound_code'] = this.compoundCode;
    data['global_code'] = this.globalCode;
    return data;
  }
}

class OpeningHours {
  bool? openNow;

  OpeningHours({this.openNow});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open_now'] = this.openNow;
    return data;
  }
}
