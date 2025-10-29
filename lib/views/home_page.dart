import 'package:explore_egypt/services/token_storage_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  Future<String?> getToken() async {
    return await TokenStorageServices.getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(getToken().toString())));
  }
}
