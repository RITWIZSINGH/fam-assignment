import 'package:flutter/material.dart';
import '../models/card_group.dart';
import '../services/api_service.dart';
import 'card_group_widget.dart';

class ContextualCardContainer extends StatefulWidget {
  const ContextualCardContainer({Key? key}) : super(key: key);

  @override
  _ContextualCardContainerState createState() => _ContextualCardContainerState();
}

class _ContextualCardContainerState extends State<ContextualCardContainer> {
  final ApiService _apiService = ApiService();
  late Future<List<CardGroup>> _cardGroupsFuture;

  @override
  void initState() {
    super.initState();
    _loadCardGroups();
  }

  void _loadCardGroups() {
    _cardGroupsFuture = _apiService.fetchContextualCards();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _loadCardGroups();
        });
      },
      child: FutureBuilder<List<CardGroup>>(
        future: _cardGroupsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No cards available'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final cardGroup = snapshot.data![index];
              return CardGroupWidget(cardGroup: cardGroup);
            },
          );
        },
      ),
    );
  }
}