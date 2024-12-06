import 'package:collector/app.dart';
import 'package:collector/auth/auth_service.dart';
import 'package:collector/data/persistence/hive/hive_database_service.dart';
import 'package:flutter/foundation.dart'; // Import foundation to use kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();

  // Use kIsWeb to determine the platform
  if (kIsWeb) {
    await Hive.initFlutter();
    await HiveDatabaseService.initializeHive();
  } else {
    // For non-web platforms (like Android)
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }

  await AuthService().loadWebCredentials(); // Load web credentials

  runApp(const App());
}
