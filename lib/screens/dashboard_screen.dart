import 'package:flutter/material.dart';
import 'package:interview_test/models/quote.dart';
import 'package:interview_test/services/api_calls_service.dart';
import 'package:interview_test/services/firebase_service.dart';

class DashboardScreen extends StatefulWidget {
  final String userName;
  const DashboardScreen({super.key, required this.userName});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Quote? quote;
  
  @override
  void initState() {
    super.initState();
    APICallService().getQuote().then((value) {
      setState(() {
        quote = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, ${widget.userName}!'),
        actions: [
          IconButton(
            onPressed: () async {
              await AppFirebaseService().logoutUser();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(quote?.content ?? 'Loading quote...', style: TextStyle(fontSize: 24, color: Colors.green),),
              SizedBox(height: 24),
              Align(alignment: Alignment.bottomRight, child: Text(quote?.author ?? 'Loading author...', style: TextStyle(fontSize: 16, color: Colors.red)  ,))],
            
          ),
        ),
      ),
    );
  }
}