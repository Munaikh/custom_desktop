import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:vrouter/vrouter.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VRouter(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      routes: [
        VWidget(
          path: '/',
          widget: LandPage(),
        ),
        VWidget(
          path: '/desktop',
          widget: HomePage(),
        )
      ],
    );
  }
}

class LandPage extends StatelessWidget {
  const LandPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.vRouter.push(
      '/desktop',
      queryParameters: {'name': 'Abdullah', 'city': 'Kuwait City'},
    );
    return Container();
  }
}

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var time = DateFormat('hh:mm a').format(DateTime.now());
  WeatherFactory wf;
  Weather w;
  Timer timer;

  // Future<void> queryForecast() async {
  //   Weather forecasts = await wf
  //       .currentWeatherByCityName(context.vRouter.queryParameters['city']);
  //   setState(() {
  //     w = forecasts;
  //   });
  // }

  Icon getIcon(String weather) {
    if (weather == 'clear sky') {
      return Icon(
        CupertinoIcons.sun_max,
        color: Colors.white,
        size: 35,
      );
    } else if (weather == 'few clouds') {
      return Icon(
        CupertinoIcons.cloud_sun_fill,
        color: Colors.white,
        size: 35,
      );
    } else if (weather == 'scattered clouds') {
      return Icon(
        CupertinoIcons.cloud,
        color: Colors.white,
        size: 35,
      );
    } else if (weather == 'broken clouds') {
      return Icon(
        CupertinoIcons.cloud_fill,
        color: Colors.white,
        size: 35,
      );
    } else if (weather == 'shower rain') {
      return Icon(
        CupertinoIcons.cloud_heavyrain_fill,
        color: Colors.white,
        size: 35,
      );
    } else if (weather == 'rain') {
      return Icon(
        CupertinoIcons.cloud_rain_fill,
        color: Colors.white,
        size: 35,
      );
    } else if (weather == 'thunderstorm') {
      return Icon(
        CupertinoIcons.cloud_bolt_fill,
        color: Colors.white,
        size: 35,
      );
    } else if (weather == 'snow') {
      return Icon(
        CupertinoIcons.cloud_snow_fill,
        color: Colors.white,
        size: 35,
      );
    } else if (weather == 'mist') {
      return Icon(
        CupertinoIcons.cloud_fog_fill,
        color: Colors.white,
        size: 35,
      );
    } else {
      return Icon(
        CupertinoIcons.cloud,
        color: Colors.white,
        size: 35,
      );
    }
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 5) {
      return 'Evening';
    } else if (hour < 12) {
      return 'Morning';
    } else if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  @override
  void initState() {
    super.initState();
    wf = WeatherFactory("72075cddc28099d40aa742a42d5e52e7");
    // queryForecast();
    timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer t) => setState(() {
        time = DateFormat('hh:mm a').format(DateTime.now());
      }),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> queryForecast() async {
      Weather forecasts = await wf
          .currentWeatherByCityName(context.vRouter.queryParameters['city']);
      setState(() {
        w = forecasts;
      });
    }

    queryForecast();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/3189407.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      'Good ${greeting()}, ${context.vRouter.queryParameters['name']}.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'SF Pro Display'),
                    ),
                  ),
                  Container(
                    child: Text(
                      'It\'s $time.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'SF Pro Display'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 20,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: getIcon(
                      '${w.weatherDescription == null ? '' : w.weatherDescription}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'It\'ll be ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'SF Pro Display'),
                        ),
                        TextSpan(
                          text:
                              '${w.weatherDescription != null ? w.weatherDescription : ''} ',
                          style: TextStyle(
                              color: Color(0xffF7BE69),
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'SF Pro Display'),
                        ),
                        TextSpan(
                          text: 'today.',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'SF Pro Display'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
