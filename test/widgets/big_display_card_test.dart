import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fam_assignment/widgets/cards/big_display_card.dart';
import 'package:fam_assignment/models/contextual_card.dart';
import 'package:fam_assignment/services/storage_service.dart';

void main() {
  late StorageService storageService;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    storageService = await StorageService.create();
  });

  testWidgets('BigDisplayCard shows formatted title', (WidgetTester tester) async {
    final card = ContextualCard(
      id: 1,
      name: 'Test Card',
      formattedTitle: FormattedText(
        text: 'Test {}',
        entities: [
          Entity(text: 'Title', color: '#000000'),
        ],
        align: 'left',
      ),
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: BigDisplayCard(
          card: card,
          storageService: storageService,
          onAction: () {},
        ),
      ),
    ));

    expect(find.text('Test Title'), findsOneWidget);
  });

  testWidgets('BigDisplayCard shows action buttons on long press', (WidgetTester tester) async {
    final card = ContextualCard(
      id: 1,
      name: 'Test Card',
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: BigDisplayCard(
          card: card,
          storageService: storageService,
          onAction: () {},
        ),
      ),
    ));

    final gesture = await tester.startGesture(const Offset(100, 100));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);

    await gesture.up();
    await tester.pump();
  });
}