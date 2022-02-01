import 'package:flutter/material.dart';
import 'package:movie/const/constarts.dart';
class MovieLoading extends StatefulWidget {
  const MovieLoading(
      {Key? key})
      : super(key: key);
  @override
  State<MovieLoading> createState() => _MovieLoadingState();
}

class _MovieLoadingState extends State<MovieLoading> {
  late double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Card(
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
                      height: width / 4,
                      width: width / 2,
                      decoration: const  BoxDecoration(

                          // borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      //     image: DecorationImage(
                      //   //setting the site of the image fetched from the network to fit, means the image will coer the space
                      //   fit: BoxFit.cover,
                      //   //Loading the rando image from the network by currently will be static image
                      //   image: NetworkImage(widget.movieModel.background_image),
                      // )
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 14,
                          width: width/3.5,
                           decoration:  BoxDecoration(
                             borderRadius: const BorderRadius.all(Radius.circular(10), 
                           ),
                          color:  Colors.grey.withOpacity(0.5), 
                        )), 
                        verticalHeight,
                        Row(
                          children: [
                            Container(
                          height: 14,
                          width: width/8,
                           decoration:  BoxDecoration(
                             borderRadius: const BorderRadius.all(Radius.circular(10), 
                           ),
                          color:  Colors.grey.withOpacity(0.5), 
                        )),  
                            Container(
                          height: 14,
                          width: width/8,
                           decoration:  BoxDecoration(
                             borderRadius: const BorderRadius.all(Radius.circular(10), 
                           ),
                          color:  Colors.grey.withOpacity(0.5), 
                        )), 
                            _startWidget()
                          ],
                        ),
                      ],
                    ),
                  )
                ]),
            Positioned(
                top: 0,
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    height: width / 4,
                    width: width / 2,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                          Colors.black.withOpacity(0.6),
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
                top: (width - 40) / 6,
                right: 10,
                child: Center(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  // height: 30,
                  // width: 30,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.purple.withOpacity(0.9)
                          ])),
                  child: Center(
                      child: Row(children: [
                    const Icon(Icons.play_arrow, color: Colors.white),
                    Container(
                          height: 12,
                          width: 100,
                           decoration:  BoxDecoration(
                             borderRadius: const BorderRadius.all(Radius.circular(10), 
                           ),
                          color:  Colors.grey.withOpacity(0.5), 
                        )), 
                  ])),
                ))),
          ])),
        ],
      ),
    );
  }

  _startWidget() {
        return Row(children: const [
          Icon(Icons.star, size: 12, color: Colors.amber),
          Icon(Icons.star, size: 12, color: Colors.amber),
          Icon(Icons.star, size: 12, color: Colors.amber),
          Icon(Icons.star, size: 12, color: Colors.amber),
          Icon(Icons.star, size: 12, color: Colors.amber),
        ]);
  }
}
