// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:task_smollan/providers/show_provider.dart';
// import 'package:task_smollan/utils/enums.dart';
// import 'package:task_smollan/widgets/show_card.dart';
// import 'package:task_smollan/widgets/loading_widget.dart';
// import 'package:task_smollan/widgets/empty_widget.dart';
// import 'details_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ShowProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Shows"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               provider.loadHomeShows(provider.currentFilter);
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // 🔹 Filter buttons
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: FilterCategory.values.map((filter) {
//                 return ChoiceChip(
//                   label: Text(filter.name),
//                   selected: provider.currentFilter == filter,
//                   onSelected: (_) {
//                     provider.loadHomeShows(filter);
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//
//           // 🔹 Show list
//           Expanded(
//             child: switch (provider.homeState) {
//               UIState.loading => const LoadingWidget(),
//               UIState.error => const Center(child: Text("Error loading shows")),
//               UIState.success => provider.homeShows.isEmpty
//                   ? const EmptyWidget(message: "No shows available")
//                   : NotificationListener<ScrollNotification>(
//                 onNotification: (scrollInfo) {
//                   if (scrollInfo.metrics.pixels ==
//                       scrollInfo.metrics.maxScrollExtent) {
//                     provider.loadNextPage();
//                   }
//                   return true;
//                 },
//                 child: ListView.builder(
//                   itemCount: provider.homeShows.length +
//                       (provider.isLoadingMore ? 1 : 0),
//                   itemBuilder: (context, index) {
//                     if (index == provider.homeShows.length) {
//                       return const Padding(
//                         padding: EdgeInsets.all(16),
//                         child: Center(
//                             child: CircularProgressIndicator()),
//                       );
//                     }
//                     final show = provider.homeShows[index];
//                     return ShowCard(
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
//                     );
//                   },
//                 ),
//               ),
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_smollan/providers/show_provider.dart';
import 'package:task_smollan/utils/enums.dart';
import 'package:task_smollan/widgets/show_card.dart';
import 'package:task_smollan/widgets/loading_widget.dart';
import 'package:task_smollan/widgets/empty_widget.dart';
import '../providers/theme_provider.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShowProvider>(context);

    return Scaffold(

      appBar: AppBar(
        elevation: 2,
        backgroundColor: const Color(0xFFbb4531),

        title: const Text(
          "Shows",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          // 🔹 Dark/Light mode toggle
          IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).isDark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          // 🔹 Refresh button
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black87),
            onPressed: () {
              provider.loadHomeShows(provider.currentFilter);
            },
          ),
        ],
      ),

      body: Column(
        children: [
      Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: FilterCategory.values.map((filter) {
                return ChoiceChip(
                  label: Text(filter.name),
                  selected: provider.currentFilter == filter,
                  onSelected: (_) {
                    provider.loadHomeShows(filter);
                  },
                );
              }).toList(),
            ),
          ),

          // 🔹 Show list
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                provider.loadHomeShows(provider.currentFilter);
              },
              child: switch (provider.homeState) {
                UIState.loading => const LoadingWidget(),
                UIState.error => const Center(
                    child: Text(
                      "Error loading shows",
                      style: TextStyle(fontSize: 16),
                    )),
                UIState.success => provider.homeShows.isEmpty
                    ? const EmptyWidget(message: "No shows available")
                    : NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                      provider.loadNextPage();
                    }
                    return true;
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: provider.homeShows.length + (provider.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == provider.homeShows.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final show = provider.homeShows[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: ShowCard(
                          show: show,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsScreen(showId: show.id),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

