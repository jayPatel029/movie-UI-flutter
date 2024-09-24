import 'dart:convert';

// Main Response Class
class ApiResponse {
  final double? score;
  final Show? show;

  ApiResponse({this.score, this.show});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      score: json['score']?.toDouble(),
      show: json['show'] != null ? Show.fromJson(json['show']) : null,
    );
  }

  @override
  String toString() {
    return 'ApiResponse(score: $score, show: $show)';
  }
}

// Show Class
class Show {
  final int? id;
  final String? url;
  final String? name;
  final String? type;
  final String? language;
  final List<String>? genres;
  final String? status;
  final int? runtime;
  final int? averageRuntime;
  final String? premiered;
  final String? ended;
  final String? officialSite;
  final Schedule? schedule;
  final Rating? rating;
  final Network? network;
  final WebChannel? webChannel;
  final ImageM? image;
  final String? summary;

  Show({
    this.id,
    this.url,
    this.name,
    this.type,
    this.language,
    this.genres,
    this.status,
    this.runtime,
    this.averageRuntime,
    this.premiered,
    this.ended,
    this.officialSite,
    this.schedule,
    this.rating,
    this.network,
    this.webChannel,
    this.image,
    this.summary,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      type: json['type'],
      language: json['language'],
      genres: json['genres'] != null ? List<String>.from(json['genres']) : null,
      status: json['status'],
      runtime: json['runtime'],
      averageRuntime: json['averageRuntime'],
      premiered: json['premiered'],
      ended: json['ended'],
      officialSite: json['officialSite'],
      schedule:
          json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null,
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
      network:
          json['network'] != null ? Network.fromJson(json['network']) : null,
      webChannel: json['webChannel'] != null
          ? WebChannel.fromJson(json['webChannel'])
          : null,
      image: json['image'] != null ? ImageM.fromJson(json['image']) : null,
      summary: json['summary'],
    );
  }

  @override
  String toString() {
    return 'Show(id: $id, name: $name, language: $language, genres: $genres, status: $status, rating: $rating, network: $network)';
  }
}

// Schedule Class
class Schedule {
  final String? time;
  final List<String>? days;

  Schedule({this.time, this.days});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      time: json['time'],
      days: json['days'] != null ? List<String>.from(json['days']) : null,
    );
  }

  @override
  String toString() {
    return 'Schedule(time: $time, days: $days)';
  }
}

// Rating Class
class Rating {
  final double? average;

  Rating({this.average});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      average: json['average']?.toDouble(),
    );
  }

  @override
  String toString() {
    return 'Rating(average: $average)';
  }
}

// Network Class
class Network {
  final int? id;
  final String? name;
  final Country? country;
  final String? officialSite;

  Network({this.id, this.name, this.country, this.officialSite});

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      id: json['id'],
      name: json['name'],
      country:
          json['country'] != null ? Country.fromJson(json['country']) : null,
      officialSite: json['officialSite'],
    );
  }

  @override
  String toString() {
    return 'Network(id: $id, name: $name, country: $country, officialSite: $officialSite)';
  }
}

// Country Class
class Country {
  final String? name;
  final String? code;
  final String? timezone;

  Country({this.name, this.code, this.timezone});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      code: json['code'],
      timezone: json['timezone'],
    );
  }

  @override
  String toString() {
    return 'Country(name: $name, code: $code, timezone: $timezone)';
  }
}

// WebChannel Class
class WebChannel {
  final int? id;
  final String? name;
  final String? officialSite;

  WebChannel({this.id, this.name, this.officialSite});

  factory WebChannel.fromJson(Map<String, dynamic> json) {
    return WebChannel(
      id: json['id'],
      name: json['name'],
      officialSite: json['officialSite'],
    );
  }

  @override
  String toString() {
    return 'WebChannel(id: $id, name: $name, officialSite: $officialSite)';
  }
}

// Image Class
class ImageM {
  final String? medium;
  final String? original;

  ImageM({this.medium, this.original});

  factory ImageM.fromJson(Map<String, dynamic> json) {
    return ImageM(
      medium: json['medium'],
      original: json['original'],
    );
  }

  @override
  String toString() {
    return 'Image(medium: $medium, original: $original)';
  }
}

// Parsing JSON list of ApiResponse
List<ApiResponse> parseApiResponse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<ApiResponse>((json) => ApiResponse.fromJson(json)).toList();
}
