import 'package:flutter_movie/models/movie_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

final movieProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider());

class MovieProvider extends StateNotifier<MovieState>{
  MovieProvider() : super(MovieState.initState()){
    getData();
  }


  Future<void> getData() async{
    List<Movie> _movies = [];
    if(state.searchText.isEmpty){
      _movies = await MovieService.getMovieCategory(page: state.page, apiPath: state.apiPath);
    }else{
      _movies = await MovieService.searchMovies(page: state.page, apiPath: state.apiPath, query: state.searchText);
    }

    state = state.copyWith(
        movies:  [...state.movies, ..._movies]
    );

  }

  void updateCategory(String apiPath){
    state =  state.copyWith(
        movies: [],
        searchText: '',
        apiPath: apiPath
    );
    getData();
  }

  void searchMovie(String searchText){
    state =  state.copyWith(
        movies: [],
        searchText: searchText,
        apiPath: Api.searchMovie
    );
    getData();
  }



}