import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  // Load the selected language from SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? selectedLanguage = prefs.getString('language_code');

  runApp(MyApp(
    locale: selectedLanguage != null ? Locale(selectedLanguage) : Locale('en'),
  ));
}

class MyApp extends StatelessWidget
{
  final Locale locale;

  MyApp({required this.locale});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Localization Demo',
      locale: locale,
      supportedLocales: [
        Locale('en', ''), // English
        Locale('hi', ''), // Hindi
      ],
      localizationsDelegates: [
        S.delegate, // The generated localization delegate
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selectedLanguage;
  List<String> _languages = ['English', 'Hindi'];

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  // Load the selected language from SharedPreferences
  _loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language_code') ?? 'en';
    });
  }

  // Save the selected language in SharedPreferences
  _saveLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language_code', languageCode);
    setState(() {
      _selectedLanguage = languageCode;
    });
  }

  // Update the app's locale based on the selected language
  void _updateLocale(String language) {
    Locale locale;
    if (language == 'Hindi') {
      locale = Locale('hi');
      _saveLanguage('hi');
    } else {
      locale = Locale('en');
      _saveLanguage('en');
    }
    // Restart the app with the new locale
    MyApp(
      locale: locale,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display localized message
            Text(
              S.of(context).message,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            // Dropdown Button for selecting language
            DropdownButton<String>(
              value: _selectedLanguage == 'en' ? 'English' : 'Hindi',
              onChanged: (String? newValue) {
                setState(() {
                  _updateLocale(newValue!);
                });
              },
              items: _languages.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(S.of(context).select_language),
          ],
        ),
      ),
    );
  }
}
