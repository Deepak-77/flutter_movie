import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_movie/models/movie.dart';


class MovieService{


  static Future<List<Movie>> getMovieCategory({required int page , required String apiPath}) async{
    final dio = Dio();
    try{
      final response = await dio.get(apiPath, queryParameters: {
        'language': 'en-US',
        'api_key': 'f96680eb8364d4d08d2f32715420f015',
        'page': page
      });

      final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
      return data;

    }on DioError catch (err){
      print(err);
      return [];
    }
  }

  static  Future<List<Movie>> searchMovies({required int page , required String apiPath, required String query}) async{
    final dio = Dio();
    try{
      final response = await dio.get(apiPath, queryParameters: {
        'language': 'en-US',
        'api_key': 'f96680eb8364d4d08d2f32715420f015',
        'page': page,
        'query': query
      });
      if((response.data['results'] as List).isEmpty){
        final data = [Movie(
            title: 'no-data',
            overview: '', poster_path: '', release_date: '', vote_average: '')];
        return data;
      }else{
        final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
        return data;
      }


    }on DioError catch (err){
      print(err);
      return [];
    }
  }






}