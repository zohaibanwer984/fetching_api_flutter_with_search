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
  List<dynamic> _userIds = [];

  Future<void> getUserIds() async {
    try {
      final data = await ApiService.fetchUsers();
      setState(() {
        _userIds = data;
      });
    } catch (e) {
      print(e);
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("USER PROFILES"),
        ),
        body: (_userIds.isNotEmpty)
            ? ListView.builder(
                itemCount: _userIds.length,
                itemBuilder: (context, index) {
                  final user = _userIds[index];
                  return ProfileCard(user: user);
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
