
import 'package:movie/models/torent_model.dart';

class MovieModel {
  final int id;
  final String url;
  final String imdbCode;
  final String title;
  final String titleEnglish;
  final String titleLong;
  final String slug;
  final int year;
  final double rating;
  final int runtime;
  final String summary;
  final String descriptionFull;
  final String synopsis;
  final String ytTrailerCode;
  final String language;
  final String mpaRating;
  final String backgroundImage;
  final String backgroundImageOriginal;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final String state;
  final String dateUploaded;
  final int dateUploadedUnix;
  late List<Torrent> torrents;
  late List<String> genres;

  MovieModel(
      {required this.id,
      required this.url,
      required this.imdbCode,
      required this.title,
      required this.titleEnglish,
      required this.titleLong,
      required this.slug,
      required this.year,
      required this.rating,
      required this.runtime,
      required this.summary,
      required this.descriptionFull,
      required this.synopsis,
      required this.ytTrailerCode,
      required this.language,
      required this.mpaRating,
      required this.backgroundImage,
      required this.backgroundImageOriginal,
      required this.smallCoverImage,
      required this.mediumCoverImage,
      required this.largeCoverImage,
      required this.state,
      required this.dateUploaded,
      required this.dateUploadedUnix,
      required this.genres,
      required this.torrents});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    List<String> genres = [];
    List<Torrent> torrents = [];
    var torrentLists = json["torrents"] as List;

    torrents = torrentLists.map((e) => Torrent.fromJson(e)).toList();
    var genresLists = json["genres"] as List;
   //adding the genres to array list using freach. 
    for (var data in genresLists) {
       genres.add(data);
    }
    return MovieModel(
        torrents: torrents,
        genres: genres,
        id: json['id'],
        url: json['url'],
        imdbCode: json['imdb_code'],
        title: json['title'],
        titleEnglish: json['title_english'],
        titleLong: json['title_long'],
        slug: json['slug'],
        year: json['year'],
        rating: double.parse(json['rating'].toString()),
        runtime: json['runtime'],
        summary: json['summary'],
        descriptionFull: json['description_full'],
        synopsis: json['synopsis'],
        ytTrailerCode: json['yt_trailer_code'],
        language: json['language'],
        mpaRating: json['mpa_rating'],
        backgroundImage: json['background_image'],
        backgroundImageOriginal: json['background_image_original'],
        smallCoverImage: json['small_cover_image'],
        mediumCoverImage: json['medium_cover_image'],
        largeCoverImage: json['large_cover_image'],
        state: json['state'],
        dateUploaded: json['date_uploaded'],
        dateUploadedUnix: json['date_uploaded_unix']);
  }
}
