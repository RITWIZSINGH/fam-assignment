import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/contextual_card_container.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storageService = await StorageService.create();

  runApp(MyApp(storageService: storageService));
}

class MyApp extends StatelessWidget {
  final StorageService storageService;

  const MyApp({
    Key? key,
    required this.storageService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FamPay Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: MyHomePage(storageService: storageService),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final StorageService storageService;

  const MyHomePage({
    Key? key,
    required this.storageService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'fampay',
              style: TextStyle(
                  color: Color(0xff494e4c), fontWeight: FontWeight.bold),
            ),
            SvgPicture.asset(
              'assets/fampay_logo.svg',
              height: 30,
              fit: BoxFit.contain,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ContextualCardContainer(storageService: storageService),
            ),
          ],
        ),
      ),
    );
  }
}
