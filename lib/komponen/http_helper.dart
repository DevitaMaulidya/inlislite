import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:moviedb/model/movie.dart';

class HttpHelper{
  final String urlKey = 'api_key=a8ecd5bb64d3111cf2e7e7e64274fce2';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-us';
  final String urlSearchBase = 'https://api.themoviedb.org/3/movie?'
      'api_key=a8ecd5bb64d3111cf2e7e7e64274fce2';

  Future<String> getUpcoming() async{
    final Uri upcoming =
      Uri.parse(urlBase + urlUpcoming + urlKey + urlLanguage);
    http.Response result = await http.get(
        upcoming,
        headers: {'Authorization': 'Bearer a8ecd5bb64d3111cf2e7e7e64274fce2'},
    );
    if(result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      return responseBody;
    }
    else {
      return '{}';
    }
  }

  Future<List> getupComingAsList() async {
    final Uri upcoming =
      Uri.parse(urlBase + urlUpcoming + urlKey + urlLanguage);
    http.Response result = await http.get(
        upcoming,
        headers: {'Authorization': 'Bearer a8ecd5bb64d3111cf2e7e7e64274fce2'},
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponseBody = json.decode(result.body);
      final movieObjects = jsonResponseBody['results'];
      List movies = movieObjects.map((json) => Movie.fromJson(json)).toList();

      return movies;
    }
    else {
      return [];
    }
  }

  Future<List> findMovies(String title) async {
    final Uri query = Uri.parse(urlSearchBase + title);
    http.Response hasilCari = await http.get(query);
    if (hasilCari.statusCode == HttpStatus.ok) {
      final jsonResponseBody = json.decode(hasilCari.body);
      final movieObjects = jsonResponseBody['results'];
      List movies = movieObjects.map((json) => Movie.fromJson(json)).toList();

      return movies;
    } else{
      return [];
    }
  }
}