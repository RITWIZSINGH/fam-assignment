import 'package:flutter_test/flutter_test.dart';
import 'package:fam_assignment/services/storage_service.dart';

void main() {
  late StorageService storageService;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    storageService = await StorageService.create();
  });

  test('Can dismiss a card', () async {
    const cardId = 1;
    await storageService.dismissCard(cardId);
    expect(storageService.isCardDismissed(cardId), true);
  });

  test('Can remind later for a card', () async {
    const cardId = 1;
    await storageService.remindLater(cardId);
    expect(storageService.isCardRemindLater(cardId), true);
  });

  test('Can clear remind later cards', () async {
    const cardId = 1;
    await storageService.remindLater(cardId);
    await storageService.clearRemindLater();
    expect(storageService.isCardRemindLater(cardId), false);
  });
}