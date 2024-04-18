import 'package:admob_flutter/admob_flutter.dart';
import 'package:codix/modals/provider.dart';
import 'package:codix/screens/Start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => WordPressProvider(),
      child: const MaterialApp(
        home: Start(),
      ),
    ),
  );
}
