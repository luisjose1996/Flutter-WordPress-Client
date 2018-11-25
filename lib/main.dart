import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/app2.dart';
import 'src/pages/instagramPage.dart';
//import 'src/pages/getCategories.dart';
//import 'src/pages/kurdistan-cat.dart';
import 'src/pages/kurdistanCat.dart';
import 'src/pages/grngCat.dart';
import 'src/widgets/listViews.dart';

void main() {


  runApp(MaterialApp(

    theme: ThemeData( // adding a theme

    brightness: Brightness.dark, //changing the theme to dark
        primaryColor: Colors.lightBlue[900], // color change for links 
        accentColor: Colors.cyan[600], // i dont know 
        fontFamily: 'NotoSansArabic' ,
        tabBarTheme: TabBarTheme(
        
        ),
        iconTheme: IconThemeData(

        ),
                
        
      
      ) ,
      
      
      home: HawalnirHome2(), // it will go and get app.dart then it will go to  HawalnirHome() from hawalnir-home.dart
      routes: <String , WidgetBuilder> {
        '/GrngCat': (BuildContext context) => new GrngCat(),
        '/KrdCat' : (BuildContext context) => new KrdCat(),
        '/InstaPage' : (BuildContext context) => new InstaPage(), //7
        //'/Tmplist' : (BuildContext context) => new ListViewPosts(),
      },
      
    
  ));
}




