// To parse this JSON data, do
//
//     final treanding = treandingFromMap(jsonString);

import 'dart:convert';

import 'models.dart';

class TreandingRespomse {
  TreandingRespomse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory TreandingRespomse.fromJson(String str) =>
      TreandingRespomse.fromMap(json.decode(str));

  factory TreandingRespomse.fromMap(Map<String, dynamic> json) =>
      TreandingRespomse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

      


      

}
