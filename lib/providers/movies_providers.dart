import 'package:app03_peliculas/models/credits_response.dart';
import 'package:app03_peliculas/models/movie.dart';
import 'package:app03_peliculas/models/movies_popular.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/now_playing_response.dart';

class MoviesProvider extends ChangeNotifier {

  String _apiKey = '5e9a9b80d8465e66e13e4d729ee6ad51';
  String _dbUrl = 'api.themoviedb.org';
  String _language = 'es-MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  
  Map<int, List<Cast>> movieCast = {};

  MoviesProvider() {
    this.getInfoPelis();
    this.getPopularPelis();
  }

  Future <String> _getJsonData(endPoint, [int page= 1]) async {
    var url = Uri.https(_dbUrl, endPoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

  getInfoPelis() async{
    var url = Uri.https(_dbUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }  

  getPopularPelis() async{
    var url = Uri.https(_dbUrl, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future <List<Cast>>getMovieCast(int movieId) async {
    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

}