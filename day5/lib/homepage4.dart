import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import '../consts.dart';

class HomePage4 extends StatefulWidget {
  const HomePage4({super.key});

  @override
  State<HomePage4> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage4> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;
  bool _isLoading = true;
  String _errorMessage = '';
  String _userName = '';  // Variable to store the user's name
  String _enteredCity = '';  // Variable to store the city entered by the user

  @override
  void initState() {
    super.initState();
    _fetchWeatherData('Rajkot'); // Default city on startup
  }

  Future<void> _fetchWeatherData(String city) async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      Weather weather = await _wf.currentWeatherByCityName(city);

      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to fetch weather data. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red, size: 50),
            SizedBox(height: 20),
            Text(_errorMessage, style: TextStyle(fontSize: 18, color: Colors.red)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _fetchWeatherData(_enteredCity),
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           // _userNameInput(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            _cityInput(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
            _locationHeader(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.08),
            _dateTimeInfo(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
            _weatherIcon(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            _currentTemp(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            _extraInfo(),
          ],
        ),
      ),
    );
  }

  // Widget _userNameInput() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: TextField(
  //             decoration: InputDecoration(
  //               labelText: 'Enter your name',
  //               border: OutlineInputBorder(),
  //             ),
  //             onChanged: (value) {
  //               setState(() {
  //                 _userName = value;  // Update the name as the user types
  //               });
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _cityInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _enteredCity = value;  // Update the city as the user types
                });
              },
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              if (_enteredCity.isNotEmpty) {
                _fetchWeatherData(_enteredCity); // Fetch weather data for the entered city
              }
            },
            child: Icon(Icons.search),  // Button with search icon
          ),
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(
              "  ${DateFormat("d.m.y").format(now)}",
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 90,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              Text(
                "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              Text(
                "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
