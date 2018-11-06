import 'package:flutter/material.dart';
import 'widgets/hawalnir-home.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HawalnirHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HawalnirHomeState();
}

class HawalnirHomeState extends State {
  // Base URL for our wordpress API
  final String apiUrl = "http://ehawal.com/wp-json/wp/v2/";
  //final String catUrl = "http://ehawal.com/wp-json/wp/v2/categories"; //trying to fetch categories
  // Empty list for our posts
  List posts;
                             

  
  //List categories; // added for categories
  // Function to fetch list of posts
  Future<String> getPosts() async {
    var res = await http.get(Uri.encodeFull(apiUrl + "posts?_embed&per_page=100"),
        headers: {"Accept": "application/json"});

   // var resCat = await http.get(Uri.encodeFull(apiUrl + "posts?_embed"), //getting categories 
   //     headers: {"Accept": "application/json"});

    // fill our posts list with results and update state
    setState(() {
      var resBody = json.decode(res.body);
      posts = resBody;

     // var resCatBody = json.decode(res.body);
     // categories = resCatBody;
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return new Directionality(
        //where i add Dictio for rtl  entire home page , i wraped every thing into this
        textDirection: TextDirection.rtl, // RTL
        child: new Scaffold(
          // Scaffold az a Child, it takes only one child
          appBar: AppBar(
              title: Text("هه‌واڵنێر"), backgroundColor: Colors.blueAccent),
          body: ListView.builder(
            //itemExtent: 10.0 ,
            //addAutomaticKeepAlives: true,
            itemCount: posts == null ? 0 : posts.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Card(
                    
                    child: Column(
                      children: <Widget>[
                          
                        new FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: posts[index]["featured_media"] == 0
                              ? 'images/placeholder.png'
                              : posts[index]["_embedded"]["wp:featuredmedia"][0]
                                  ["source_url"],
                        ),

                        new ListTile(
                          title:Text(posts[index]["author"].toString()) , //trying to fetch authors name
                        ),



                        new Padding(
                          padding: EdgeInsets.all(5.0),
                          child: new ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) =>
                                      new HawalnirPost(post: posts[index]),
                                ),
                              ); 
                            
                            },
                            title: new Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: new Text(
                                    posts[index]["title"]["rendered"]),
                                    
                                    ),
                         
                             
                             subtitle: new Text(    // here i disabled subtitle
                             posts[index]["excerpt"]["rendered"].replaceAll(new RegExp(r'<[^>]*>'), '') //contetn is a object so how to use a array or string 
                            ),
                            


                          ),
                        ),
                        new ButtonTheme.bar(
                          child: new ButtonBar(
                            children: <Widget>[

                            


                              IconButton(
                                icon: Icon(Icons.save),
                                splashColor: Colors.blueAccent[200],
                                color: Colors.blueGrey,
                                tooltip: 'پاشكه‌وت كردنی بابه‌ت',
                                onPressed: () {
                                  setState(() {});
                                }, // add +1 to the database
                              ),
                              
                              
                              IconButton(
                                icon: Icon(Icons.favorite),
                                splashColor: Colors.redAccent,
                                color: Colors.blueGrey,
                                tooltip: 'په‌سه‌ند كردن',
                                onPressed: () {
                                  setState(() {});
                                }, // add +1 to the database
                              ),
                              
                              
                              
                              IconButton(
                                icon: Icon(Icons.share),
                                color: Colors.blueGrey,
                                tooltip: 'بو هاورێكانت بنێره‌',
                                onPressed: () {
                                  setState(() {});
                                }, // Standard share for whatsapp + google + faccebook + twitter
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}
