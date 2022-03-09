import 'package:first_flutter_app/flutter_maps/quakes_map_app/util/types_helper.dart';

class Quake {
  String? type;
  Metadata? metadata;
  List<Features>? features;
  List<double>? bbox;

  Quake({this.type, this.metadata, this.features, this.bbox});

  Quake.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }
    bbox = json['bbox'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    data['bbox'] = bbox;
    return data;
  }
}

class Metadata {
  int? generated;
  String? url;
  String? title;
  int? status;
  String? api;
  int? count;

  Metadata({this.generated, this.url, this.title, this.status, this.api, this.count});

  Metadata.fromJson(Map<String, dynamic> json) {
    generated = TypesHelper.toInt(json['generated']);
    url = json['url'];
    title = json['title'];
    status = TypesHelper.toInt(json['status']);
    api = json['api'];
    count = TypesHelper.toInt(json['count']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['generated'] = generated;
    data['url'] = url;
    data['title'] = title;
    data['status'] = status;
    data['api'] = api;
    data['count'] = count;
    return data;
  }
}

class Features {
  String? type;
  Properties? properties;
  Geometry? geometry;
  String? id;

  Features({this.type, this.properties, this.geometry, this.id});

  Features.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    properties = json['properties'] != null ? Properties.fromJson(json['properties']) : null;
    geometry = json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (properties != null) {
      data['properties'] = properties!.toJson();
    }
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class Properties {
  double? mag;
  String? place;
  int? time;
  int? updated;
  int? tz;
  String? url;
  String? detail;
  int? felt;
  double? cdi;
  double? mmi;
  String? alert;
  String? status;
  int? tsunami;
  int? sig;
  String? net;
  String? code;
  String? ids;
  String? sources;
  String? types;
  int? nst;
  double? dmin;
  double? rms;
  int? gap;
  String? magType;
  String? type;
  String? title;

  Properties(
      {this.mag,
      this.place,
      this.time,
      this.updated,
      this.tz,
      this.url,
      this.detail,
      this.felt,
      this.cdi,
      this.mmi,
      this.alert,
      this.status,
      this.tsunami,
      this.sig,
      this.net,
      this.code,
      this.ids,
      this.sources,
      this.types,
      this.nst,
      this.dmin,
      this.rms,
      this.gap,
      this.magType,
      this.type,
      this.title});

  Properties.fromJson(Map<String, dynamic> json) {
    mag = TypesHelper.toDouble(json['mag']);
    place = json['place'];
    time = TypesHelper.toInt(json['time']);
    updated = TypesHelper.toInt(json['updated']);
    tz = TypesHelper.toInt(json['tz']);
    url = json['url'];
    detail = json['detail'];
    felt = TypesHelper.toInt(json['felt']);
    cdi = TypesHelper.toDouble(json['cdi']);
    mmi = TypesHelper.toDouble(json['mmi']);
    alert = json['alert'];
    status = json['status'];
    tsunami = TypesHelper.toInt(json['tsunami']);
    sig = TypesHelper.toInt(json['sig']);
    net = json['net'];
    code = json['code'];
    ids = json['ids'];
    sources = json['sources'];
    types = json['types'];
    nst = TypesHelper.toInt(json['nst']);
    dmin = TypesHelper.toDouble(json['dmin']);
    rms = TypesHelper.toDouble(json['rms']);
    gap = TypesHelper.toInt(json['gap']);
    magType = json['magType'];
    type = json['type'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mag'] = mag;
    data['place'] = place;
    data['time'] = time;
    data['updated'] = updated;
    data['tz'] = tz;
    data['url'] = url;
    data['detail'] = detail;
    data['felt'] = felt;
    data['cdi'] = cdi;
    data['mmi'] = mmi;
    data['alert'] = alert;
    data['status'] = status;
    data['tsunami'] = tsunami;
    data['sig'] = sig;
    data['net'] = net;
    data['code'] = code;
    data['ids'] = ids;
    data['sources'] = sources;
    data['types'] = types;
    data['nst'] = nst;
    data['dmin'] = dmin;
    data['rms'] = rms;
    data['gap'] = gap;
    data['magType'] = magType;
    data['type'] = type;
    data['title'] = title;
    return data;
  }
}

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
