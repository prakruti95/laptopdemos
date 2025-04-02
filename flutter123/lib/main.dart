import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';  // Import the generated localization file

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _languageCode = 'en';  // Default language is English

  @override
  void initState() {
    super.initState();
    _getSavedLanguage();
  }

  // Get the saved language code from SharedPreferences
  Future<void> _getSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _languageCode = prefs.getString('language') ?? 'en'; // Default to English
    });
  }

  // Save the selected language to SharedPreferences
  Future<void> _setLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    setState(() {
      _languageCode = languageCode;  // Update the language code in state
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(_languageCode),  // Apply the selected language
      supportedLocales: [
        Locale('en', ''),
        Locale('hi', ''),
        Locale('gu', ''),
      ],
      localizationsDelegates: [
        S.delegate, // Generated localization delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: LanguageSelectionScreen(onLanguageChanged: _setLanguage), // Pass callback to update language
    );
  }
}

class LanguageSelectionScreen extends StatelessWidget {
  final Function(String) onLanguageChanged;

  LanguageSelectionScreen({required this.onLanguageChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).languagePrompt),  // Localized string for language prompt
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _setLanguage(context, 'en'),  // Set language to English
            child: Text('English'),
          ),
          ElevatedButton(
            onPressed: () => _setLanguage(context, 'hi'),  // Set language to Hindi
            child: Text('Hindi'),
          ),
          ElevatedButton(
            onPressed: () => _setLanguage(context, 'gu'),  // Set language to Gujarati
            child: Text('Gujarati'),
          ),
        ],
      ),
    );
  }

  // Set the language and navigate to the next screen
  void _setLanguage(BuildContext context, String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    // Immediately update the language
    onLanguageChanged(languageCode);
    // Navigate to the next screen with the updated language
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TrafficRulesScreen()),
    );
  }
}

class TrafficRulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).trafficRule1),  // Localized title
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(S.of(context).trafficRule1),  // Localized content for traffic rules
          Text(S.of(context).trafficRule2),
          Text(S.of(context).trafficRule3),
        ],
      ),
    );
  }
}
