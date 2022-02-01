import 'package:flutter/material.dart';
import 'package:movie/const/constarts.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/widgets/ratings.dart';

class MoviewAdapter extends StatefulWidget {
  final MovieModel movieModel;
  const MoviewAdapter(
      {Key? key, required this.movieModel})
      : super(key: key);
  @override
  State<MoviewAdapter> createState() => _MoviewAdapterState();
}

class _MoviewAdapterState extends State<MoviewAdapter> {
  late double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return  Card(
          // color: Colors.amber.withOpacity(0.6),
          child: Column(
            children: [
              Expanded(
                  child: Stack(children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 0),
                          height: height / 6.5,
                          width: width / 2,
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                              image: DecorationImage(
                            //setting the site of the image fetched from the network to fit, means the image will coer the space
                            fit: BoxFit.cover,
                            //Loading the rando image from the network by currently will be static image
                            image:
                                NetworkImage(widget.movieModel.backgroundImage),
                          ))),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movieModel.title,
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
                                  widget.movieModel.rating.toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                               Ratings(ratings: widget.movieModel.rating)
                              ],
                            ),
                          ],
                        ),
                      )
                    ]),
                Positioned(
                    top: 0,
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 0),
                        height: height / 6.5,
                        width: width / 2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.purple.withOpacity(0.3)
                            ])))),

                //  Positioned(
                //   top: (width - 40) / 4,
                //   right: 0,
                //   child:Center(child: Container(
                //       margin: const EdgeInsets.symmetric(
                //           vertical: 0, horizontal: 0),
                //       height: 30,
                //       width: 30,
                //       decoration:  BoxDecoration(
                //         borderRadius: const BorderRadius.all(Radius.circular(50)),
                //         gradient: LinearGradient(
                //           begin: Alignment.bottomCenter,
                //           end: Alignment.topCenter,
                //     colors: [Colors.black.withOpacity(0.9), Colors.purple.withOpacity(0.9)])
                // ),
                // child: const Center(child: Icon(Icons.play_arrow, color: Colors.white ),),
                // ))),

                Positioned(
                    top: height / 10,
                    right: 10,
                    child: Center(
                        child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      // height: 30,
                      // width: 30,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.purple.withOpacity(0.9)
                              ])),
                      child: Center(
                          child: Row(children: [
                        const Icon(Icons.play_arrow,
                            size: 15, color: Colors.white),
                        Text("${widget.movieModel.runtime.toString()} min",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12)),
                      ])),
                    ))),
              ])),
            ],
          ),
        );
  }
}

