import 'package:flutter/material.dart';
import 'package:movie/const/constarts.dart';
import 'package:movie/http/movies.dart';
import 'package:movie/models/movie_model.dart';
import 'package:movie/pages/details.dart';
import 'package:movie/widgets/movie_loading.dart';
import 'package:movie/widgets/single_movie.dart';

List<MovieModel> movieLists = [];
  bool isLoadingMore = false;
//Dashboard appliation class statefull
class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

//Application state dashboard mimiking the main dasboard for state mabnagement
class _DashboardState extends State<Dashboard> {
//declaration of the app height and width
  late double width, height;
  late Future<List<MovieModel>> futureMovies;
  final ScrollController _scrollController = ScrollController();
  //app build method fo shwing the main UI to the user screen
  @override
  Widget build(BuildContext context) {
// assign the value to height and width using the mediaquery (GIVES the general view of the application)
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
        //Safe area for definning the used aread with a custom  padding and margin for the application
        child: Scaffold(
            //Body with a single child scroll view because we want all items to scrolled under one view
            body: SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          _headerImage(),
          _moviesView(),
          _loading(),
        ],
      ),
    )));
  }

  @override
  void initState() {
    //adding the scroll lister to the init state so as check if the user has scolled the the b
    //of the _pagenation
    _scrollController.addListener(__pagenationScrollLister);
    futureMovies = getMoviews();
    movieLists.clear();
    //calling the movies from the server

    super.initState();
  }

  __pagenationScrollLister() {
    //Listen to the page scroll of the user has scrolled the page
    if (_scrollController.position.atEdge) {
      //check of the view of the scroll instance is a the end 
      //The edge can be top or bottom
      if (_scrollController.position.pixels != 0 && movieLists.isNotEmpty) {

        //check if the age is != 0 and there is some contents inside the show load more progress
          setState(() {
            isLoadingMore = true; 
          futureMovies = getMoviews();
        });
      }
    }
  }

  _loading() {
    return  Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: SizedBox(
            child: isLoadingMore? const CircularProgressIndicator(): Container(),
          ),
        ));
  }

  _headerImage() {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        height: 200,
        width: width,
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          image: DecorationImage(
              //setting the site of the image fetched from the network to fit, means the image will coer the space
              fit: BoxFit.cover,
              //Loading the rando image from the network by currently will be static image
              image: NetworkImage(
                  'http://filmstarfacts.com/wp-content/uploads/2017/04/Movies_Logo_500x281.jpg')),
        ),
      ),
      Positioned(
          top: 150,
          child: SizedBox(
              width: width,
              child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "The ripository of your best movies in Tanzania and Outiside",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
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
    ]);
  }

  _moviesView() {
    return RefreshIndicator(
      onRefresh: _refreshed,
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (movieLists.isNotEmpty) {
              return GridView.builder(
                     
                    itemCount:movieLists.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.landscape ? 3: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      childAspectRatio: (1 / 1),
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index,) {
                          MovieModel movieModel = movieLists[index];
                           return  InkWell(
                             onTap: (){
                              
                          Navigator.pushNamed(context, Details.routeName,
                              arguments: Details(
                                movieModel: movieModel,
                              ));
        
                             },
                             child: MoviewAdapter(
                        movieModel: movieModel,

                      ));
                
                });
            } else {
              //In case there will be no data show the message to client
              return Card(child:SizedBox(height: height - 300, 
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                   Icon(Icons.file_download_off,size: 50, color: primaryColor, ), 
                  verticalHeight,
                  Text("No moviews availble",style: styleMovieTitle, ), 
                   verticalHeight,
                  Card(
                    color: primaryColor,
                    child: Padding(padding: EdgeInsets.all(20),
                    child: Text('You are not able to see the movies list becasue of the internet connection or movies have been moved to other destination', style: styleDescriptionWhite,),
                    ),
                    
                  )
                  ],
              ))));
            }
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
        future: futureMovies,
      ),
    );
  }

  Future<void> _refreshed() async {
    setState(() {
      futureMovies = getMoviews();
    });
  }
}
