import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:movie_api_quad/screens/search_screen.dart';

import '../api/api_model.dart';
import '../api/api_service.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ApiResponse> apiRes = [];
  bool isLoading = true;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo bottom navbar
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              "Netflix",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Text(
              " Clone",
              style: TextStyle(color: Colors.redAccent, fontSize: 15),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Popular Shows",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  buildHorizontalMovieList(apiRes),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Trending Now",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  buildHorizontalMovieList(apiRes),
                ],
              ),
            ),
    );
  }

  /////////////!widgets//////////////
  Widget buildHorizontalMovieList(List<ApiResponse> movies) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          ApiResponse apiResponse = movies[index];
          Show? show = apiResponse.show;
          String? imageUrl = show?.image?.medium;
          double? score = apiResponse.score ?? 0.0;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          show: show!,
                          score: score,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width > 600 ? 200 : 150,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(imageUrl ?? ""),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {}),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Show Title
                SizedBox(
                  width: MediaQuery.of(context).size.width > 600 ? 200 : 150,
                  child: Text(
                    show?.name ?? "No Name",
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ///////////!api//////
  void getMovie() async {
    ApiService apiService = ApiService();
    List<ApiResponse> apiResponse = await apiService.getMovie("all");

    setState(() {
      apiRes = apiResponse;
      isLoading = false;
    });
  }

  // void onBottomTap(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   if (_selectedIndex == 1) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => SearchScreen()),
  //     ).then((value) {
  //       setState(() {
  //         _selectedIndex = 0;
  //       });
  //     });
  //   }
  // }
}
