import 'package:flutter/material.dart';
import '../widgets/navbar.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to Skills Assessment
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Skills Assessment Tapped')),
                );
              },
              child: const Text('Skills Assessment'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to Job Finder
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Job Finder Tapped')),
                );
              },
              child: const Text('Job Finder'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to Career Goal Finder
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Career Goal Finder Tapped')),
                );
              },
              child: const Text('Career Goal Finder'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(currentIndex: 3,),
    );
  }
}

