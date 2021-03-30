import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techzombie_api/src/models/posts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyPost _allPostsRef;
  bool _loading = true;
  int _counter = 0;
  @override
  void initState() {
    MyPost.getAllPosts().then((value) {
      setState(() {
        _allPostsRef = value;
        _loading = false;
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity > 8) {
            setState(() {
              _counter--;
              if (_counter == -1) {
                _counter = _allPostsRef.posts.length - 1;
              }
            });
          } else if (details.primaryVelocity < -8) {
            setState(() {
              _counter++;
              if (_counter == _allPostsRef.posts.length) {
                _counter = 0;
              }
            });
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Center(child: Image.asset('assets/logo.png')),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0,bottom: 20.0),
                child: Center(child: Text(_loading? 'Loading': _allPostsRef.posts[_counter].title,textAlign: TextAlign.center, style: TextStyle(fontSize: 20,color: Colors.redAccent),)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon(Icons.arrow_back,color: Colors.redAccent,), onPressed: () {

                  },),
                  _loading? CircularProgressIndicator() : ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: _allPostsRef.posts[_counter].thumbnail,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.arrow_forward,color: Colors.redAccent,), onPressed: () {

                  },),
                ],
              ),
              Flexible(    ////text- context
                flex: 6,
                child: Container(child: _loading? CircularProgressIndicator() : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(_loading? 'Loading' : removeAllHtmlTags(_allPostsRef.posts[_counter].content), textAlign: TextAlign.center, style: TextStyle(fontSize: 15,color: Colors.white)),
                  ),
                ),)
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _counter++;
                if (_counter >= _allPostsRef.posts.length) {
                  _counter = 0;
                }
              });
            },
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.navigate_next,color: Colors.black,size: 40,),
          ),
        ),
      ),
    );
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );

    return htmlText.replaceAll(exp, '');
  }

}
