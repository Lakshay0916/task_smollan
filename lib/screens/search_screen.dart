// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:lottie/lottie.dart';
//
// import '../providers/show_provider.dart';
// import '../widgets/show_card.dart';
// import '../utils/enums.dart';
// import 'details_screen.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _controller = TextEditingController();
//
//   void _onSearch(String query) {
//     if (query.isNotEmpty) {
//       Provider.of<ShowProvider>(context, listen: false).searchShows(query);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ShowProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Search Shows",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: const Color(0xFFbb4531),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // 🔹 Search TextField
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 hintText: "Search TV Shows...",
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.search),
//                   onPressed: () => _onSearch(_controller.text),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onSubmitted: _onSearch,
//             ),
//           ),
//
//           // 🔹 Search results / loading / empty states
//           Expanded(
//             child: switch (provider.searchState) {
//               UIState.loading => const Center(
//                   child: CircularProgressIndicator(
//                     color: Color(0xFFbb4531),
//                   )),
//               UIState.error => const Center(
//                   child: Text(
//                     "Error fetching search results",
//                     style: TextStyle(fontSize: 16),
//                   )),
//               UIState.success => provider.searchResults.isEmpty
//                   ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Lottie.asset(
//                       'assets/lottie/Empty.json', // <-- replace with your Lottie file path
//                       width: 200,
//                       height: 200,
//                       fit: BoxFit.contain,
//                     ),
//                     const SizedBox(height: 16),
//                     const Text(
//                       "No results found",
//                       style: TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               )
//                   : ListView.builder(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 12, vertical: 8),
//                 itemCount: provider.searchResults.length,
//                 itemBuilder: (context, index) {
//                   final show = provider.searchResults[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 6),
//                     child: ShowCard(
//                       show: show,
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) =>
//                                 DetailsScreen(showId: show.id),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             },
//           )
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../providers/show_provider.dart';
import '../widgets/show_card.dart';
import '../utils/enums.dart';
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  void _onSearch(String query) {
    if (query.isNotEmpty) {
      Provider.of<ShowProvider>(context, listen: false).searchShows(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShowProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search Shows",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFbb4531),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 🔹 Search TextField
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search TV Shows...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _onSearch(_controller.text),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: _onSearch,
            ),
          ),

          // 🔹 Search results / loading / empty states
          Expanded(
            child: switch (provider.searchState) {
            // 🔹 Loading state with Lottie
              UIState.loading => Center(
                child: Lottie.asset(
                  'assets/lottie/Loading.json', // <-- your loading Lottie file
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),

            // 🔹 Error state
              UIState.error => const Center(
                  child: Text(
                    "Error fetching search results",
                    style: TextStyle(fontSize: 16),
                  )),

            // 🔹 Success state
              UIState.success => provider.searchResults.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lottie/Empty.json', // <-- your no-results Lottie file
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "No results found",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                itemCount: provider.searchResults.length,
                itemBuilder: (context, index) {
                  final show = provider.searchResults[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: ShowCard(
                      show: show,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailsScreen(showId: show.id),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            },
          )
        ],
      ),
    );
  }
}
