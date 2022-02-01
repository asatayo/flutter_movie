import 'package:dio/dio.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/pages/dashboard.dart';
import 'package:movie/pages/details.dart';

var options = BaseOptions(
  baseUrl: 'https://yts.mx/api/v2', //Base url for the server
  connectTimeout:
      20000, // The time for trial before sending the timeout message
  receiveTimeout:
      3000, // The time for which th client side will be checked before the server terminate the request
);

Future<List<MovieModel>> getMoviews() async {
// creating the option istance;
//USE TRY  AND CATCH WHENT THE RESULTS IS INVETABLE
  try {
    //finding the page count;
    //if we are fetching twenty contents on each page then to get the next
    // page number length/constant + 1
    int page = (movieLists.length / 20).round() + 1;

    //here is a dio initiatlization with options parameter passed
    Dio dio = Dio(options);
    Response response = await dio.get('/list_movies.json?limit=20&&page=$page');
    var list = response.data['data']['movies'] as List;
    //get the moviews and assign them to another array list so as to maintain the current list
    List<MovieModel> fetchedMovies =
        list.map((e) => MovieModel.fromJson(e)).toList();
    //add the moview list the main arrayList of movies
    movieLists.addAll(fetchedMovies);
    // ignore: empty_catches
  } catch (ex) {}

  //finished loading more
  isLoadingMore = false;
  //return the movies list to the future in the builder to render view.
  return Future.value(movieLists);
}

//Task almost repeated althogh this fetches the related genres
Future<List<MovieModel>> getRelatedMovies(int page, String genre) async {
// creating the option istance;
//USE TRY  AND CATCH WHENT THE RESULTS IS INVETABLE
  try {
    int page = (relatedMovieLists.length / 20).round() + 1;
    //here is a dio initiatlization with options parameter passed
    Dio dio = Dio(options);
    Response response =
        await dio.get('/list_movies.json?limit=20&&page=$page&&genre=$genre');
    var list = response.data['data']['movies'] as List;
    //get the moviews and assign them to another array list so as to maintain the current list
    List<MovieModel> fetchedMovies =
        list.map((e) => MovieModel.fromJson(e)).toList();
    //add the moview list the main arrayList of movies
    relatedMovieLists.addAll(fetchedMovies);
    // ignore: empty_catches
  } catch (ex) {}
  //return the movies list to the future in the builder to render view.
  return Future.value(relatedMovieLists);
}
