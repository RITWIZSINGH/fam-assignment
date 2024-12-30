import 'package:flutter/material.dart';
import '../models/card_group.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import 'card_group_widget.dart';

class ContextualCardContainer extends StatefulWidget {
  final StorageService storageService;

  const ContextualCardContainer({
    super.key,
    required this.storageService,
  });

  @override
  State<ContextualCardContainer> createState() => _ContextualCardContainerState();
}

class _ContextualCardContainerState extends State<ContextualCardContainer> {
  final ApiService _apiService = ApiService();
  late Future<List<CardGroup>> _cardGroupsFuture;

  @override
  void initState() {
    super.initState();
    _loadCardGroups();
    widget.storageService.clearRemindLater();
  }

  void _loadCardGroups() {
    _cardGroupsFuture = _apiService.fetchContextualCards();
  }

  List<CardGroup> _filterCards(List<CardGroup> cardGroups) {
    return cardGroups.map((group) {
      final filteredCards = group.cards.where((card) {
        return !widget.storageService.isCardDismissed(card.id) &&
               !widget.storageService.isCardRemindLater(card.id);
      }).toList();

      return CardGroup(
        id: group.id,
        name: group.name,
        designType: group.designType,
        cardType: group.cardType,
        cards: filteredCards,
        isScrollable: group.isScrollable,
        height: group.height,
        isFullWidth: group.isFullWidth,
        slug: group.slug,
        level: group.level,
      );
    }).where((group) => group.cards.isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _loadCardGroups();
          });
        },
        child: Stack(
          children: [
            FutureBuilder<List<CardGroup>>(
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

                final filteredGroups = _filterCards(snapshot.data!);
                
                return ListView.builder(
                  itemCount: filteredGroups.length,
                  itemBuilder: (context, index) {
                    final cardGroup = filteredGroups[index];
                    return CardGroupWidget(
                      cardGroup: cardGroup,
                      storageService: widget.storageService,
                      onCardAction: () => setState(() {}),
                    );
                  },
                );
              },
            ),
            
          ],
        ),
      ),
    );
  }
}