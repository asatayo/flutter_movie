import 'package:flutter/material.dart';
import 'package:movie/const/constarts.dart';
import 'package:movie/pages/dashboard.dart';
import 'package:movie/pages/details.dart';
import 'package:movie/pages/splash.dart';

//Main method for the flutter iniatilization where flutter sdk takes the contro
//to execute either ios/android
void main() {
  runApp(const MyApp());
}

//Main class for the App runner
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //rendering method, reposponsbile at bulding the widgets
  //to the user screen.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      //Application title
      title: 'Movie App',
      theme: ThemeData(
        //Application theme, this defines the general view of the a;;
        // 1. Language
        // 2. Colors
        // 3. Fonts                                         
        // 4. Others related to ui
        // primarySwatch: primaryColor,
        primaryColor: primaryColor,
        appBarTheme: appBarTheme,
        backgroundColor: primaryBackground, 
        iconTheme: const IconThemeData(color: Colors.white)
      ),
      
      //Page routes
      // Using Navigation.push..... is good but doest work for browsers
      // The option is to use PushNamed...
      //You can simple use onGenerateRoute if you will pass data to pages or 
      //Use the Routes when you dont pass the data
         onGenerateRoute: (settings) {
    // If you push the PassArguments route
 

 //Switch case to check variabele settings wich receives the app routr settings
  switch (settings.name) {
    case Dashboard.routeName:
          return MaterialPageRoute(
                builder: (context) {
                  return const Dashboard();
                },
              );
      case Details.routeName:
       final args = settings.arguments as Details;
              return MaterialPageRoute(
                builder: (context) {
                  return Details(
                    movieModel: args.movieModel,
                  );
                },
              );

    default:
  }
 
         }, 
      home:  const Splash(),
    );
  }
}
