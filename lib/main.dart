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
    // Get screen size for responsive calculations
    final size = MediaQuery.of(context).size;

    // Calculate responsive values
    final appBarHeight = size.height * 0.08; // 8% of screen height
    final logoHeight = size.height * 0.04; // 4% of screen height
    final titleFontSize = size.width * 0.055; // ~16px on 354.28px width
    final appBarElevation = size.width * 0.003; // ~1px on 354.28px width
    final contentPadding = size.width * 0.045; // ~16px on 354.28px width

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'fampay',
                style: TextStyle(
                  color: const Color(0xff494e4c),
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                ),
              ),
              SizedBox(
                  width: size.width * 0.006), // Space between text and logo
              SvgPicture.asset(
                'assets/fampay_logo.svg',
                height: logoHeight,
                fit: BoxFit.contain,
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: appBarElevation,
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: contentPadding,
                    ),
                    child: ContextualCardContainer(
                      storageService: storageService,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
