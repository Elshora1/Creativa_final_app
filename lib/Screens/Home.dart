import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> movies = [];

  Future<void> fetchMovies() async {
    var response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=7f4b94007c44bda8e96b49456f05b955'),
    );
    if (response.statusCode == 200) {
      setState(() {
        movies = json.decode(response.body)['results'];
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: GridView.builder(
        itemCount: movies.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movies[index]['poster_path']}',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(movies[index]['title']),
              ],
            ),
          );
        },
      ),
    );
  }
}
