import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fam_assignment/widgets/contextual_card_container.dart';
import 'package:fam_assignment/services/storage_service.dart';

void main() {
  late StorageService storageService;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    storageService = await StorageService.create();
  });

  testWidgets('ContextualCardContainer shows loading state', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ContextualCardContainer(storageService: storageService),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('ContextualCardContainer can be refreshed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ContextualCardContainer(storageService: storageService),
    ));

    await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
    await tester.pumpAndSettle();

    expect(find.byType(RefreshIndicator), findsOneWidget);
  });
}