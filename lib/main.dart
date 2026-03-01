import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/routes/app_pages.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import 'package:travel_clothing_club_flutter/utils/stripe_config.dart';
import 'package:travel_clothing_club_flutter/service/fashn_ai_service.dart';

// JKS --> tcc_1122
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables and configuration
  await StripeConfig.initialize();

  // Initialize Fashn.AI with debug printing
  FashnAIService.initialize(apiKey: StripeConfig.fashnAPIKey);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TCC',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: false,
        colorSchemeSeed: AppColors.PRIMARY_COLOR,
      ),
      initialRoute: AppRoutes.getInitialRoute(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
