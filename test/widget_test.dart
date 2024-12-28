import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fam_assignment/main.dart';
import 'package:fam_assignment/services/storage_service.dart';

void main() {
  late StorageService storageService;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    storageService = await StorageService.create();
  });

  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(storageService: storageService));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}