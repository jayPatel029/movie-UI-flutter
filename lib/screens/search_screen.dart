import 'package:flutter/material.dart';
import '../api/api_model.dart';
import '../api/api_service.dart';
import 'details_screen.dart'; // Import your details screen

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";
  final TextEditingController searchController = TextEditingController();
  List<ApiResponse> apiRes = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.keyboard_backspace_rounded,
        //     color: Colors.redAccent,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.redAccent),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    query = value;
                    if (query.isNotEmpty) {
                      getMovie(query);
                    } else {
                      apiRes = [];
                    }
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search for a movie or show...",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Colors.white54),
                  suffixIcon: query.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white54),
                          onPressed: () {
                            setState(() {
                              query = "";
                              searchController.clear();
                              apiRes = [];
                            });
                          },
                        )
                      : null,
                  contentPadding: const EdgeInsets.all(15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : query.isEmpty
                      ? const Center(
                          child: Text(
                            'Search for a movie or show...',
                            style:
                                TextStyle(color: Colors.white54, fontSize: 18),
                          ),
                        )
                      : buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  //////////////////widgets///////////
  Widget buildSearchResults() {
    return apiRes.isEmpty
        ? const Center(
            child: Text(
              'No results found.',
              style: TextStyle(color: Colors.white54, fontSize: 18),
            ),
          )
        : ListView.builder(
            itemCount: apiRes.length,
            itemBuilder: (context, index) {
              Show? show = apiRes[index].show;
              return ListTile(
                leading: show?.image?.medium != null
                    ? Image.network(show!.image!.medium!,
                        width: 50, fit: BoxFit.cover)
                    : const Icon(Icons.movie, color: Colors.redAccent),
                title: Text(
                  show?.name ?? "No Name",
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  if (show != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          show: show,
                          score: apiRes[index].score,
                        ),
                      ),
                    );
                  }
                },
              );
            },
          );
  }

  ////////////api///////////
  void getMovie(String searchQuery) async {
    setState(() {
      isLoading = true;
    });

    try {
      ApiService apiService = ApiService();
      List<ApiResponse> apiResponse = await apiService.getMovie(searchQuery);

      setState(() {
        apiRes = apiResponse;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
