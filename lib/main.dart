import 'package:fetching_api_flutter_with_search/api_service.dart';
import 'package:fetching_api_flutter_with_search/profile_card.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldMessengerState> _messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  List<dynamic> _userIds = [];
  String _searchText = '';

  Future<void> getUserIds() async {
    try {
      final data = await ApiService.fetchUsers();
      setState(() {
        _userIds = data;
      });
    } catch (e) {
      _messengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text(""),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getUserIds();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("USER PROFILES"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              SearchBar(
                leading: const Icon(Icons.search),
                onChanged: (text) {
                  setState(() {
                    _searchText = text;
                  });
                },
              ),
              (_userIds.isNotEmpty)
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: _applyFilter().length,
                        itemBuilder: (context, index) {
                          final user = _applyFilter()[index];
                          return ProfileCard(user: user);
                        },
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          ),
        ),
      ),
    );
  }

  _applyFilter() {
    return _userIds.where((user) {
      return user['name'].toLowerCase().contains(_searchText.toLowerCase());
    }).toList();
  }
}
