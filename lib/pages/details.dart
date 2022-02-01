import 'package:flutter/material.dart';
import 'package:movie/const/constarts.dart';
import 'package:movie/http/movies.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/widgets/movie_loading.dart';
import 'package:movie/widgets/ratings.dart';
import 'package:movie/widgets/single_movie.dart';
import 'package:video_player/video_player.dart';

List<MovieModel> relatedMovieLists = [];
int page = 1;

//Details appliation class statefull
// ignore: must_be_immutable
class Details extends StatefulWidget {
  static const routeName = '/details';
  MovieModel? movieModel;
  Details({Key? key, this.movieModel}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

//Application state Details mimiking the main dasboard for state mabnagement
class _DetailsState extends State<Details> {
//declaration of the app height and width
  late double width, height;

  late VideoPlayerController _controller;

  late Future<List<MovieModel>> futureRelatedMovies;

  final ScrollController _scrollController = ScrollController();
    bool _expanded = false;
    bool isPlayed = false;

  //app build method fo shwing the main UI to the user screen
  @override
  Widget build(BuildContext context) {
// assign the value to height and width using the mediaquery (GIVES the general view of the application)
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
        //Safe area for definning the used aread with a custom  padding and margin for the application
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text(widget.movieModel!.title),
            ),
            //Body with a single child scroll view because we want all items to scrolled under one view
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _playingVideo(),
                  _movieDetails(),
                  _relatedMovies(),
                  _loading(),
                ],
              ),
            )));
  }

  @override
  void initState() {
    //adding the scroll lister to the init state so as check if the user has scolled the the b
    //of the page

    _scrollController.addListener(_pageScrollLister);
    page = 1;
    futureRelatedMovies =
        getRelatedMovies(page, widget.movieModel!.genres.first);
    relatedMovieLists.clear();
    //calling the movies from the server

    super.initState();
  }

  //expandable view to show the movie details

  _movieDetails() {

    return Container(
            margin: const EdgeInsets.all(0),
            color: Colors.white,
            child: ExpansionPanelList(
           elevation: 0,
            animationDuration: const Duration(milliseconds: 500),
            children: [
              ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text(widget.movieModel!.title, style: const TextStyle(color: Colors.black),),
                    );
                  },
                  body: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movieModel!.title,
                              overflow: TextOverflow.ellipsis,
                              style: styleMovieTitle,
                            ),
                            verticalHeight,
                            Row(
                              children: [
                                const Text(
                                  "Ratings ",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  widget.movieModel!.rating.toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Ratings(ratings: widget.movieModel!.rating)
                              ],
                            ),
                            verticalHeight, 
                             Text(
                              widget.movieModel!.descriptionFull,
                              // overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16),
                            ),
                            verticalHeight
                          ],
                        ),
                      ),
                isExpanded: _expanded,
                canTapOnHeader: true,
                backgroundColor: Colors.white
              )
            ], 
             dividerColor: Colors.grey,
            expansionCallback: (panelIndex, isExpanded) {
              _expanded = !_expanded;
              setState(() {
 
              });
            },
            )
              );
   
  }

  _playVideo() {
    try {
      isPlayed = true;
      _controller = VideoPlayerController.network(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {
            _controller.play();
            
          });
        });
    } catch (ex) {
      // print(ex);
    }
  }

  _pageScrollLister() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
      } else {
        setState(() {
          _initPage();
          futureRelatedMovies =
              getRelatedMovies(page, widget.movieModel!.genres.first);
        });
      }
    }
  }

  _loading() {
    return const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: SizedBox(
            child: CircularProgressIndicator(),
          ),
        ));
  }

  _playingVideo() {
    return Stack(children: [
      Container(
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          height: 200,
          width: width,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            image: DecorationImage(
                //setting the site of the image fetched from the network to fit, means the image will coer the space
                fit: BoxFit.cover,
                //Loading the rando image from the network by currently will be static image
                image:
                    NetworkImage(widget.movieModel!.backgroundImageOriginal)),
          ),
          child: isPlayed
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container()),
      Positioned(
          top: 150,
          child: SizedBox(
              width: width,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.movieModel!.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 20, fontFamily: 'Muli'),
                  )))),
      Positioned(
          top: 0,
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              height: 200,
              width: width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.purple.withOpacity(0.3)
                  ])))),
      Positioned(
          top: 80,
          left: width / 2 - 20,
          child: Center(
              child: InkWell(
                  onTap: () {
                    _playVideo();
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.purple.withOpacity(0.8)
                            ])),
                    child: const Icon(Icons.play_arrow,
                        size: 30, color: Colors.white),
                  )))),
    ]);
  }

  _relatedMovies() {
    return RefreshIndicator(
      onRefresh: _refreshed,
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: relatedMovieLists.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? 3
                      : 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: (1 / 1),
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return InkWell(
                      onTap: () {
                        setState(() {
                          widget.movieModel = relatedMovieLists[index];
                          page = 1;
                          futureRelatedMovies = getRelatedMovies(
                              page, widget.movieModel!.genres.first);
                        });
                      },
                      child: MoviewAdapter(
                        movieModel: relatedMovieLists[index],
                      ));
                });
          } else {
            return GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(2),
              crossAxisCount: 2,
              children: List.generate(10, (index) => const MovieLoading()),
            );
          }
        },
        future: futureRelatedMovies,
      ),
    );
  }

  Future<void> _refreshed() async {
    setState(() {
      page = 1;
      futureRelatedMovies =
          getRelatedMovies(page, widget.movieModel!.genres.first);
    });
  }

  _initPage() {
    page = (relatedMovieLists.length / 20).round() + 1;
  }
}
